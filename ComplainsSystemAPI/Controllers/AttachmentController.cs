using ComplaintManagement.Access.Models;
using ComplaintManagement.Business.DTOs.Attachments;
using ComplaintManagement.Business.Interfaces;
using ComplaintManagement.Business.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.IO;
using System.Net.Mime;
using System.Security.Claims;

namespace ComplainsSystemAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class AttachmentController : ControllerBase
    {
        private IAttachmentService _attachmentService;
        private IComplaintService _ComplaintService;
        public AttachmentController(IAttachmentService attachmentService, IComplaintService ComplaintService)
        {
           _attachmentService = attachmentService;
           _ComplaintService = ComplaintService;
        }
        [HttpPost("Uploade/{complainId:int}")]
        public async Task<IActionResult> SaveImageAsync(int complainId, IFormFile imageFile, IAuthorizationService authorizationService)
        {
            if (imageFile == null || imageFile.Length == 0 || complainId < 1)
                return BadRequest(new { message = "Invalid file or complaint ID." });

            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            // Whitelist file extensions
            var extension = Path.GetExtension(imageFile.FileName)?.ToLowerInvariant();
            var allowedExtensions = new[] { ".jpg", ".jpeg", ".png", ".pdf", ".webp" };
            if (string.IsNullOrEmpty(extension) || !allowedExtensions.Contains(extension))
            {
                return BadRequest(new { message = "Invalid file type. Allowed formats: JPG, JPEG, PNG, PDF, WEBP." });
            }

            // File size limit: 10 MB
            const long maxFileSize = 10 * 1024 * 1024;
            if (imageFile.Length > maxFileSize)
            {
                return BadRequest(new { message = "File size exceeds the 10 MB limit." });
            }

            var comp = await _ComplaintService.GetByIdAsync(complainId);
            if (comp == null)
            {
                return NotFound(new { message = "Complaint not found." });
            }

            var authResult = await authorizationService.AuthorizeAsync(
                User,
                comp.UserId,
                "OwnerOrAdminOrSuper");

            if (!authResult.Succeeded)
                return Forbid(); // 403

            var folderPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/Images");
            CreateAttachmentDto dto = new CreateAttachmentDto();
            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }
            dto.FileSize = imageFile.Length;
            

            // File Content/MIME type (e.g., "image/png", "application/pdf")
            dto.FileType = imageFile.ContentType;

            // Secure GUID filename + extension
            var safeName = Guid.NewGuid().ToString();

            var finalName = safeName + extension;
            dto.FileName = finalName;

            var filePath = Path.Combine(folderPath, finalName);
            dto.FilePath = filePath;
            dto.ComplaintId = complainId;
            using (var stream = new FileStream(filePath, FileMode.Create))
            {
                await imageFile.CopyToAsync(stream);
            }
            await _attachmentService.CreateAsync(GetCurrentUserId(), dto);

            return Ok(new
            {
                FileName = dto.FileName,
                FileSizeBytes = dto.FileSize,
                ContentType = dto.FileType
            });
        }



        [HttpGet("GetImagePath/{complainID:int}")]
        public async Task<IActionResult> GetImagePath(int complainID, IAuthorizationService authorizationService)
        {
            if (complainID < 1)
                return BadRequest();

            var comp = await _ComplaintService.GetByIdAsync(complainID);
            if (comp == null)
                return NotFound(new { message = "Complaint not found." });

            var authResult = await authorizationService.AuthorizeAsync(
                User,
                comp.UserId,
                "OwnerOrAdminOrSuper");

            if (!authResult.Succeeded)
                return Forbid(); // 403

            var attachmentDto = await _attachmentService.GetByComplaintAsync(complainID);
            if (attachmentDto == null || attachmentDto.Count == 0)
                return NotFound(new { message = "No attachments found." });

            string fileName = attachmentDto[0].FileName;
            string path = Path.Combine(
                Directory.GetCurrentDirectory(),
                "wwwroot",
                "Images",
                fileName);

            if (!System.IO.File.Exists(path))
            {
                return NotFound("Image Not Found");
            }

            string imageUrl =
                $"{Request.Scheme}://{Request.Host}/Images/{fileName}";

            return Ok(imageUrl);
        }

        private int GetCurrentUserId()
        {
            string? userId =
                User.FindFirstValue(
                    ClaimTypes.NameIdentifier);

            if (string.IsNullOrWhiteSpace(userId))
            {
                return 0;
            }

            return int.TryParse(
                userId,
                out int id)
                    ? id
                    : 0;
        }

    }
}

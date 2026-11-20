using ComplaintManagement.Access.Models;
using ComplaintManagement.Business.DTOs.Assignments;
using ComplaintManagement.Business.DTOs.Complaints;
using ComplaintManagement.Business.Interfaces;
using ComplaintManagement.Business.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;
using System.Security.Claims;

namespace ComplainsSystemAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize]
    public class ComplaintsController : ControllerBase
    {
        private readonly IComplaintService _complaintService;
        private readonly IAssignmentService _AssignmentcomplaintService;
        private readonly IUserService _userService;
        private readonly ILogger<ComplaintsController> _logger;
        public ComplaintsController(
            IComplaintService complaintService,IAssignmentService Assignment, IUserService userService, ILogger<ComplaintsController> logger)
        {
            _complaintService = complaintService;
            _AssignmentcomplaintService = Assignment;
            _userService = userService;
            _logger = logger;
        }


        // =====================================================
        // GET: api/complaints
        // =====================================================

        [HttpGet("All")]
        [Authorize(Roles = "SuperAdmin")]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult> GetAll()
        {
            int currentUserId = GetCurrentUserId();

            if (currentUserId <= 0)
            {
                return Unauthorized(new
                {
                    message = "Invalid user identity."
                });
            }

          

            var complaints =
                await _complaintService.GetAllAsync();

            return Ok(complaints);
        }




        [HttpGet("AllByUserID/{ID:int}")]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult> GetAllbyUserID(int ID, IAuthorizationService authorizationService)
        {
            int currentUserId = GetCurrentUserId();

            if (currentUserId <= 0)
            {
                return Unauthorized(new
                {
                    message = "Invalid user identity."
                });
            }

            var authResult = await authorizationService.AuthorizeAsync(
       User,
       ID,
       "OwnerOrSuperAdmin");

            if (!authResult.Succeeded)
                return Forbid(); // 403




           

            var complaints =
                await _complaintService.GetByUserAsync(ID);

            return Ok(complaints);
        }

        // =====================================================
        // GET: api/complaints/{id}
        // =====================================================

        [HttpGet("FindBy/{id:int}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult> GetById(int id, IAuthorizationService authorizationService)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid complaint ID."
                });
            }

            int currentUserId = GetCurrentUserId();

            if (currentUserId <= 0)
            {
                return Unauthorized(new
                {
                    message = "Invalid user identity."
                });
            }

            

            var complaint =
                await _complaintService.GetByIdAsync(id);

            if (complaint == null)
            {
                return NotFound(new
                {
                    message = "Complaint not found."
                });
            }
            var authResult = await authorizationService.AuthorizeAsync(
                User,
                complaint.UserId,
                "OwnerOrAdminOrSuper");

            if (!authResult.Succeeded)
            {
                _logger.LogError(
      "User with ID {UserId} Forbiden from Access A complaint that he do not create",
      currentUserId);

                
                return Forbid(); // 403
            }


            return Ok(complaint);
        }


        // =====================================================
        // POST: api/complaints
        // =====================================================

        [HttpPost("Create")]
        [Authorize(Roles = "User,Admin,SuperAdmin")]
        [EnableRateLimiting("CreateInApiLimiter")]


        public async Task<IActionResult> Create(
            [FromBody] CreateComplaintDto dto)
        {
            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            int currentUserId = GetCurrentUserId();

            if (currentUserId <= 0)
            {
                return Unauthorized(new
                {
                    message = "Invalid user identity."
                });
            }

            try
            {
                int complaintId =
                    await _complaintService.CreateAsync(
                        currentUserId,
                        dto);

                var complaint =
                    await _complaintService.GetByIdAsync(complaintId);

                return CreatedAtAction(nameof(GetById),
                    new
                    {
                        id = complaintId
                    },
                    complaint);
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new
                {
                    message = ex.Message
                });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new
                {
                    message = ex.Message
                });
            }
            catch (UnauthorizedAccessException)
            {
                return Forbid();
            }
            catch (Microsoft.EntityFrameworkCore.DbUpdateException)
            {
                return BadRequest(new
                {
                    message = "Invalid reference: category, priority, or department does not exist."
                });
            }
        }


        // =====================================================
        // PUT: api/complaints/{id}
        // =====================================================

        [HttpPut("Update/{id:int}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult> Update(
            int id,
            [FromBody] CreateComplaintDto dto, IAuthorizationService authorizationService)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid complaint ID."
                });
            }

            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            int currentUserId = GetCurrentUserId();

            if (currentUserId <= 0)
            {
                return Unauthorized(new
                {
                    message = "Invalid user identity."
                });
            }

            try
            {
                var existingComplaint = await _complaintService.GetByIdAsync(id);
                if (existingComplaint == null)
                {
                    return NotFound(new
                    {
                        message = "Complaint not found."
                    });
                }

                var authResult = await authorizationService.AuthorizeAsync(
                     User,
                     existingComplaint.UserId,
                     "OwnerOrSuperAdmin");

                if (!authResult.Succeeded)
                    return Forbid(); // 403

                bool isSuperAdmin = User.IsInRole("SuperAdmin");
                bool result =
                    await _complaintService.UpdateAsync(id, currentUserId, dto, isSuperAdmin);

                if (!result)
                {
                    return NotFound(new
                    {
                        message = "Complaint not found."
                    });
                }

                var complaint =
                    await _complaintService.GetByIdAsync(id);

                return Ok(complaint);
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new
                {
                    message = ex.Message
                });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new
                {
                    message = ex.Message
                });
            }
            catch (UnauthorizedAccessException)
            {
                return Forbid();
            }
            catch (Microsoft.EntityFrameworkCore.DbUpdateException)
            {
                return BadRequest(new
                {
                    message = "Invalid reference: category, priority, or department does not exist."
                });
            }
        }


        // =====================================================
        // PATCH: api/complaints/{id}/assign
        // =====================================================

        [HttpPatch("assign")]
        [Authorize(Roles = "SuperAdmin")]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult> Assign(
            [FromBody] CreateAssignmentDto dto)
        {
            if (dto.ComplaintId <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid complaint ID."
                });
            }
            if (dto.AssignedToUserId <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid User ID."
                });
            }

            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            try
            {
                int currentUserId = GetCurrentUserId();
                if (currentUserId <= 0)
                {
                    return Unauthorized(new
                    {
                        message = "Invalid user identity."
                    });
                }

                var existingComplaint = await _complaintService.GetByIdAsync(dto.ComplaintId);
                if (existingComplaint == null)
                {
                    return NotFound(new
                    {
                        message = "Complaint not found."
                    });
                }

                var assignedUser = await _userService.GetByIdAsync(dto.AssignedToUserId);
                if (assignedUser == null)
                {
                    return NotFound(new
                    {
                        message = "Assigned user not found."
                    });
                }

                int result =
                    await _AssignmentcomplaintService.CreateAsync(currentUserId, dto);

                if (result <= 0)
                {
                    return BadRequest(new
                    {
                        message = "Failed to assign complaint."
                    });
                }

                // If currently New (Status 1), transition to In Progress (Status 2) upon assignment
                if (existingComplaint.StatusId == 1)
                {
                    await _complaintService.UpdateStatusAsync(dto.ComplaintId, 2, currentUserId);
                }

                return NoContent();
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new
                {
                    message = ex.Message
                });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new
                {
                    message = ex.Message
                });
            }
            catch (UnauthorizedAccessException)
            {
                return Forbid();
            }
            catch (Microsoft.EntityFrameworkCore.DbUpdateException)
            {
                return BadRequest(new
                {
                    message = "Invalid reference: category, priority, or department does not exist."
                });
            }
        }


        // =====================================================
        // PATCH: api/complaints/{id}/status
        // =====================================================

        [HttpPatch("{id:int}/status")]
        [Authorize(Roles = "Admin,SuperAdmin")]
        //[EnableRateLimiting("GeneralApiLimiter")]
        public async Task<IActionResult> ChangeStatus(
            int id,
            [FromBody] UpdateComplaintStatusDto dto)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid complaint ID."
                });
            }

            if (dto.StatusId <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid status ID."
                });
            }

            if (!ModelState.IsValid)
            {
                return ValidationProblem(ModelState);
            }

            try
            {
                int currentUserId = GetCurrentUserId();
                if (currentUserId <= 0)
                {
                    return Unauthorized(new
                    {
                        message = "Invalid user identity."
                    });
                }

                var existingComplaint = await _complaintService.GetByIdAsync(id);
                if (existingComplaint == null)
                {
                    return NotFound(new
                    {
                        message = "Complaint not found."
                    });
                }

                if (existingComplaint.StatusId == dto.StatusId)
                {
                    return BadRequest(new
                    {
                        message = "Complaint is already in the specified status."
                    });
                }

                bool result =
                    await _complaintService.UpdateStatusAsync(id, dto.StatusId, currentUserId);

                if (!result)
                {
                    return BadRequest(new
                    {
                        message = "Failed to update complaint status."
                    });
                }
           

                return NoContent();
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new
                {
                    message = ex.Message
                });
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new
                {
                    message = ex.Message
                });
            }
            catch (UnauthorizedAccessException)
            {
                return Forbid();
            }
            catch (Microsoft.EntityFrameworkCore.DbUpdateException)
            {
                return BadRequest(new
                {
                    message = "Invalid reference: category, priority, or department does not exist."
                });
            }
        }


        // =====================================================
        // DELETE: api/complaints/{id}
        // =====================================================

        [HttpDelete("{id:int}")]
        [Authorize(Roles = "User,Admin,SuperAdmin")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [EnableRateLimiting("GeneralApiLimiter")]
        public async Task<IActionResult> Delete(int id)
        {
            if (id <= 0)
            {
                return BadRequest(new
                {
                    message = "Invalid complaint ID."
                });
            }

            int currentUserId = GetCurrentUserId();
            if (currentUserId <= 0)
            {
                return Unauthorized(new
                {
                    message = "User is not authenticated."
                });
            }

            string userRole = GetCurrentUserRole();

            try
            {
                bool deleted = await _complaintService.DeleteAsync(id, currentUserId, userRole);
                if (!deleted)
                {
                    return NotFound(new
                    {
                        message = "Complaint not found or already deleted."
                    });
                }

                return NoContent();
            }
            catch (UnauthorizedAccessException ex)
            {
                return StatusCode(StatusCodes.Status403Forbidden, new
                {
                    message = ex.Message
                });
            }
            catch (InvalidOperationException ex)
            {
                return Conflict(new
                {
                    message = ex.Message
                });
            }
            catch (Exception)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, new
                {
                    message = "An error occurred while deleting the complaint."
                });
            }
        }


        // =====================================================
        // GET CURRENT USER ID
        // =====================================================

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


        // =====================================================
        // GET CURRENT USER ROLE
        // =====================================================

        private string GetCurrentUserRole()
        {
            return User.FindFirstValue(
                       ClaimTypes.Role)
                   ?? string.Empty;
        }
    }
}
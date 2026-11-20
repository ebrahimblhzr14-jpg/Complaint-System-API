using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
using ComplaintManagement.Business.DTOs.Complaints;
using ComplaintManagement.Business.Interfaces;
using Microsoft.Extensions.Logging;
using System.Security.Claims;

namespace ComplaintManagement.Business.Services
{
    public class ComplaintService : IComplaintService
    {
        private readonly IComplaintsRepository _repository;
        private readonly ILogger<ComplaintService> _logger;

       

        public ComplaintService(ILogger<ComplaintService> logger,
            IComplaintsRepository repository)
        {
            _repository = repository;
            _logger = logger;

        }

        public async Task<int> CreateAsync(
            int userId,
            CreateComplaintDto dto)
        {
            _logger.LogInformation(
    "Creating complaint for user {UserId}",
    userId);
            ValidateComplaint(dto);

            Complaint complaint = new Complaint
            {
                UserId = userId,
                CategoryId = dto.CategoryId,
                DepartmentId = dto.DepartmentId,
                PriorityId = dto.PriorityId,

                // New complaint
                StatusId = 1,

                Title = dto.Title.Trim(),
                Description = dto.Description.Trim()
            };

            int comID = await _repository.CreateAsync(
                complaint);
            if (comID > 0)
            {
                _logger.LogInformation(
        "Complaint {ComplaintId} created successfully for user {UserId}",
        comID,
        userId);
                return comID;

            }

            return 0;
        }

        public async Task<IEnumerable<ComplaintDto>>
            GetAllAsync()
        {
            
            var complaints =
                await _repository.GetAllAsync();
         

            return complaints.Select(MapToDto);
        }

        public async Task<ComplaintDto?> GetByIdAsync(
            int id)
        {
            var complaint =
                await _repository.GetByIdAsync(id);
            if(complaint == null)
            {
                _logger.LogWarning(
    "Complaint {ComplaintId} was not found",
    id);
            }

            return complaint == null
                ? null
                : MapToDto(complaint);
        }

        public async Task<IEnumerable<ComplaintDto>>
            GetByUserAsync(int userId)
        {
            _logger.LogInformation(
"all complaint for user {UserId}",
userId);
            var complaints =
                await _repository.GetByUserAsync(userId);

            return complaints.Select(MapToDto);
        }

        public async Task<bool> UpdateAsync(
            int id,
            int userId,
            CreateComplaintDto dto,
            bool isSuperAdmin = false)
        {
            ValidateComplaint(dto);

            var complaint =
                await _repository.GetByIdAsync(id);

            if (complaint == null)
                return false;

            // Ownership check (SuperAdmin override)
            if (complaint.UserId != userId && !isSuperAdmin)
                throw new UnauthorizedAccessException(
                    "You can only update your own complaint.");

            complaint.CategoryId = dto.CategoryId;
            complaint.DepartmentId = dto.DepartmentId;
            complaint.PriorityId = dto.PriorityId;
            complaint.Title = dto.Title.Trim();
            complaint.Description = dto.Description.Trim();

            return await _repository.UpdateAsync(
                complaint);
        }

        public async Task<bool> DeleteAsync(
            int id,
            int userId,
            string userRole)
        {
            var complaint =
                await _repository.GetByIdAsync(id);

            if (complaint == null)
                return false;

            bool isStaff = string.Equals(userRole, "Admin", StringComparison.OrdinalIgnoreCase) ||
                           string.Equals(userRole, "SuperAdmin", StringComparison.OrdinalIgnoreCase);

            if (!isStaff)
            {
                // Regular User can only delete their own complaint
                if (complaint.UserId != userId)
                {
                    throw new UnauthorizedAccessException(
                        "You can only delete your own complaint.");
                }

                // Regular User can only delete when status is "New" (StatusId == 1)
                if (complaint.StatusId != 1)
                {
                    throw new InvalidOperationException(
                        "You can only delete a complaint while it is in 'New' status.");
                }
            }

            return await _repository.DeleteAsync(id, userId);
        }

        public async Task<bool> UpdateStatusAsync(
            int complaintId,
            int statusId,
            int userId)
        {
            return await _repository.UpdateStatusAsync(
                complaintId,
                statusId,
                userId);
        }

        private static void ValidateComplaint(
            CreateComplaintDto dto)
        {
            if (string.IsNullOrWhiteSpace(dto.Title))
                throw new ArgumentException(
                    "Complaint title is required.");

            if (string.IsNullOrWhiteSpace(dto.Description))
                throw new ArgumentException(
                    "Complaint description is required.");

            if (dto.CategoryId <= 0)
                throw new ArgumentException(
                    "Invalid category.");

            if (dto.PriorityId <= 0)
                throw new ArgumentException(
                    "Invalid priority.");
        }
       
        private static ComplaintDto MapToDto(
            Complaint complaint)
        {
            return new ComplaintDto
            {
                Id = complaint.Id,

                UserId = complaint.UserId,
                UserName = complaint.UserName,

                CategoryId = complaint.CategoryId,
                CategoryName = complaint.CategoryName,

                DepartmentId = complaint.DepartmentId,
                DepartmentName = complaint.DepartmentName,

                StatusId = complaint.StatusId,
                StatusName = complaint.StatusName,

                PriorityId = complaint.PriorityId,
                PriorityName = complaint.PriorityName,

                Title = complaint.Title,
                Description = complaint.Description,

                CreatedAt = complaint.CreatedAt,
                UpdatedAt = complaint.UpdatedAt,
                ResolvedAt = complaint.ResolvedAt,
                ClosedAt = complaint.ClosedAt
            };
        }
    }
}
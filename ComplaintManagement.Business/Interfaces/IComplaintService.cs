using ComplaintManagement.Business.DTOs.Complaints;

namespace ComplaintManagement.Business.Interfaces
{
    public interface IComplaintService
    {
        Task<int> CreateAsync(
            int userId,
            CreateComplaintDto dto);

        Task<IEnumerable<ComplaintDto>> GetAllAsync();

        Task<ComplaintDto?> GetByIdAsync(int id);

        Task<IEnumerable<ComplaintDto>> GetByUserAsync(
            int userId);

        Task<bool> UpdateAsync(
            int id,
            int userId,
            CreateComplaintDto dto,
            bool isSuperAdmin = false);

        Task<bool> DeleteAsync(
            int id,
            int userId,
            string userRole);

        Task<bool> UpdateStatusAsync(
            int complaintId,
            int statusId,
            int userId);
    }
}
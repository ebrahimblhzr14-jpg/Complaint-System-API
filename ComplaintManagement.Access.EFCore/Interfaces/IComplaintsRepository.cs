using ComplaintManagement.Access.Models;

namespace ComplaintManagement.Access.Interfaces
{
    public interface IComplaintsRepository
    {
        Task<int> CreateAsync(Complaint complaint);

        Task<IEnumerable<Complaint>> GetAllAsync();

        Task<Complaint?> GetByIdAsync(int id);

        Task<IEnumerable<Complaint>> GetByUserAsync(int userId);

        Task<bool> UpdateAsync(Complaint complaint);

        Task<bool> DeleteAsync(int id, int? userId = null);

        Task<bool> UpdateStatusAsync(
            int complaintId,
            int statusId,
            int userId);
    }
}
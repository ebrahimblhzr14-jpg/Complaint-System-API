using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class ComplaintsRepository : IComplaintsRepository
{
    private readonly StoredProcedureExecutor _sp;
    public ComplaintsRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(Complaint complaint) => _sp.ExecuteIdAsync("sp_Complaints_Create",
        SqlParameters.Int("@UserId", complaint.UserId), SqlParameters.Int("@CategoryId", complaint.CategoryId),
        SqlParameters.NullableInt("@DepartmentId", complaint.DepartmentId), SqlParameters.Int("@StatusId", complaint.StatusId),
        SqlParameters.Int("@PriorityId", complaint.PriorityId), SqlParameters.NVarChar("@Title", complaint.Title, 200),
        SqlParameters.NVarChar("@Description", complaint.Description));
    public async Task<IEnumerable<Complaint>> GetAllAsync() => await _sp.QueryAsync<Complaint>("sp_Complaints_GetAll");
    public Task<Complaint?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<Complaint>("sp_Complaints_GetById", SqlParameters.Int("@Id", id));
    public async Task<IEnumerable<Complaint>> GetByUserAsync(int userId) => await _sp.QueryAsync<Complaint>("sp_Complaints_GetByUser", SqlParameters.Int("@UserId", userId));
    public async Task<bool> UpdateAsync(Complaint complaint) => await _sp.ExecuteAsync("sp_Complaints_Update",
        SqlParameters.Int("@Id", complaint.Id), SqlParameters.Int("@CategoryId", complaint.CategoryId),
        SqlParameters.NullableInt("@DepartmentId", complaint.DepartmentId), SqlParameters.Int("@PriorityId", complaint.PriorityId),
        SqlParameters.NVarChar("@Title", complaint.Title, 200), SqlParameters.NVarChar("@Description", complaint.Description)) > 0;
    public async Task<bool> DeleteAsync(int id, int? userId = null) => await _sp.ExecuteAsync("sp_Complaints_Delete", SqlParameters.Int("@Id", id), SqlParameters.NullableInt("@UserId", userId)) > 0;
    public async Task<bool> UpdateStatusAsync(int complaintId, int statusId, int userId) => await _sp.ExecuteAsync("sp_Complaints_UpdateStatus",
        SqlParameters.Int("@ComplaintId", complaintId), SqlParameters.Int("@StatusId", statusId), SqlParameters.Int("@UserId", userId)) > 0;
}

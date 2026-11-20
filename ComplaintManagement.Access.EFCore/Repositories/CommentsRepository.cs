using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class CommentsRepository : ICommentsRepository
{
    private readonly StoredProcedureExecutor _sp;
    public CommentsRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(ComplaintComment comment) => _sp.ExecuteIdAsync("sp_Comments_Create", SqlParameters.Int("@ComplaintId", comment.ComplaintId), SqlParameters.Int("@UserId", comment.UserId), SqlParameters.NVarChar("@Comment", comment.Comment));
    public async Task<IEnumerable<ComplaintComment>> GetByComplaintAsync(int complaintId) => await _sp.QueryAsync<ComplaintComment>("sp_Comments_GetByComplaint", SqlParameters.Int("@ComplaintId", complaintId));
    public Task<ComplaintComment?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<ComplaintComment>("sp_Comments_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(ComplaintComment comment) => await _sp.ExecuteAsync("sp_Comments_Update", SqlParameters.Int("@Id", comment.Id), SqlParameters.NVarChar("@Comment", comment.Comment)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Comments_Delete", SqlParameters.Int("@Id", id)) > 0;
}

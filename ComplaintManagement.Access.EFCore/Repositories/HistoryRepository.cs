using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class ComplaintHistoryRepository : IComplaintHistoryRepository
{
    private readonly StoredProcedureExecutor _sp;
    public ComplaintHistoryRepository(StoredProcedureExecutor sp) => _sp = sp;
    public async Task<IEnumerable<ComplaintHistory>> GetByComplaintIdAsync(int complaintId) => await _sp.QueryAsync<ComplaintHistory>("sp_ComplaintHistory_GetByComplaintId", SqlParameters.Int("@ComplaintId", complaintId));
    public Task<ComplaintHistory?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<ComplaintHistory>("sp_ComplaintHistory_GetById", SqlParameters.Int("@Id", id));
    public Task<int> CreateAsync(ComplaintHistory history) => _sp.ExecuteIdAsync("sp_ComplaintHistory_Create", SqlParameters.Int("@ComplaintId", history.ComplaintId), SqlParameters.NullableInt("@UserId", history.UserId), SqlParameters.NVarChar("@Action", history.Action, 100), SqlParameters.NVarChar("@OldValue", history.OldValue, 500), SqlParameters.NVarChar("@NewValue", history.NewValue, 500), SqlParameters.NVarChar("@Description", history.Description, 1000));
}

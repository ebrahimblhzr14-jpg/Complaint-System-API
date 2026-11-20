using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class AssignmentsRepository : IAssignmentsRepository
{
    private readonly StoredProcedureExecutor _sp;
    public AssignmentsRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(ComplaintAssignment assignment) => _sp.ExecuteIdAsync("sp_Assignments_Create", SqlParameters.Int("@ComplaintId", assignment.ComplaintId), SqlParameters.Int("@AssignedToUserId", assignment.AssignedToUserId), SqlParameters.Int("@AssignedByUserId", assignment.AssignedByUserId), SqlParameters.NVarChar("@Notes", assignment.Notes, 500));
    public async Task<IEnumerable<ComplaintAssignment>> GetAllAsync() => await _sp.QueryAsync<ComplaintAssignment>("sp_Assignments_GetAll");
    public Task<ComplaintAssignment?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<ComplaintAssignment>("sp_Assignments_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(ComplaintAssignment assignment) => await _sp.ExecuteAsync("sp_Assignments_Update", SqlParameters.Int("@Id", assignment.Id), SqlParameters.Int("@AssignedToUserId", assignment.AssignedToUserId), SqlParameters.NullableDateTime2("@UnassignedAt", assignment.UnassignedAt), SqlParameters.NVarChar("@Notes", assignment.Notes, 500)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Assignments_Delete", SqlParameters.Int("@Id", id)) > 0;
}

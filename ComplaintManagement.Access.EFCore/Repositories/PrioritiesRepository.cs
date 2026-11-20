using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class PrioritiesRepository : IPrioritiesRepository
{
    private readonly StoredProcedureExecutor _sp;
    public PrioritiesRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(Priority priority) => _sp.ExecuteIdAsync("sp_Priorities_Create", SqlParameters.NVarChar("@Name", priority.Name, 50), SqlParameters.Int("@Level", priority.Level));
    public async Task<IEnumerable<Priority>> GetAllAsync() => await _sp.QueryAsync<Priority>("sp_Priorities_GetAll");
    public Task<Priority?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<Priority>("sp_Priorities_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(Priority priority) => await _sp.ExecuteAsync("sp_Priorities_Update", SqlParameters.Int("@Id", priority.Id), SqlParameters.NVarChar("@Name", priority.Name, 50), SqlParameters.Int("@Level", priority.Level)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Priorities_Delete", SqlParameters.Int("@Id", id)) > 0;
    public async Task<bool> ActivateAsync(int id) => await _sp.ExecuteAsync("sp_Priorities_Activate", SqlParameters.Int("@Id", id)) > 0;
    public async Task<bool> DeactivateAsync(int id) => await _sp.ExecuteAsync("sp_Priorities_Deactivate", SqlParameters.Int("@Id", id)) > 0;
}

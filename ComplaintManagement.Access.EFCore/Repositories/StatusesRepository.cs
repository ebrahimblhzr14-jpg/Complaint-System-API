using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class StatusesRepository : IStatusesRepository
{
    private readonly StoredProcedureExecutor _sp;
    public StatusesRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(ComplaintStatus status) => _sp.ExecuteIdAsync("sp_Statuses_Create", SqlParameters.NVarChar("@Name", status.Name, 50));
    public async Task<IEnumerable<ComplaintStatus>> GetAllAsync() => await _sp.QueryAsync<ComplaintStatus>("sp_Statuses_GetAll");
    public Task<ComplaintStatus?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<ComplaintStatus>("sp_Statuses_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(ComplaintStatus status) => await _sp.ExecuteAsync("sp_Statuses_Update", SqlParameters.Int("@Id", status.Id), SqlParameters.NVarChar("@Name", status.Name, 50)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Statuses_Delete", SqlParameters.Int("@Id", id)) > 0;
    public async Task<bool> ActivateAsync(int id) => await _sp.ExecuteAsync("sp_Statuses_Activate", SqlParameters.Int("@Id", id)) > 0;
    public async Task<bool> DeactivateAsync(int id) => await _sp.ExecuteAsync("sp_Statuses_Deactivate", SqlParameters.Int("@Id", id)) > 0;
}

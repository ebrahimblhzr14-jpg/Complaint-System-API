using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class RolesRepository : IRolesRepository
{
    private readonly StoredProcedureExecutor _sp;
    public RolesRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(Role role) => _sp.ExecuteIdAsync("sp_Roles_Create", SqlParameters.NVarChar("@Name", role.Name, 50));
    public async Task<IEnumerable<Role>> GetAllAsync() => await _sp.QueryAsync<Role>("sp_Roles_GetAll");
    public Task<Role?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<Role>("sp_Roles_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(Role role) => await _sp.ExecuteAsync("sp_Roles_Update", SqlParameters.Int("@Id", role.Id), SqlParameters.NVarChar("@Name", role.Name, 50)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Roles_Delete", SqlParameters.Int("@Id", id)) > 0;
}

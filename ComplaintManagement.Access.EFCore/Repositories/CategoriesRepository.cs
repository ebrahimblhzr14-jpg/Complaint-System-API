using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class CategoriesRepository : ICategoriesRepository
{
    private readonly StoredProcedureExecutor _sp;
    public CategoriesRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(ComplaintCategory category) => _sp.ExecuteIdAsync("sp_Categories_Create", SqlParameters.NVarChar("@Name", category.Name, 100), SqlParameters.NVarChar("@Description", category.Description, 500));
    public async Task<IEnumerable<ComplaintCategory>> GetAllAsync() => await _sp.QueryAsync<ComplaintCategory>("sp_Categories_GetAll");
    public Task<ComplaintCategory?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<ComplaintCategory>("sp_Categories_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(ComplaintCategory category) => await _sp.ExecuteAsync("sp_Categories_Update", SqlParameters.Int("@Id", category.Id), SqlParameters.NVarChar("@Name", category.Name, 100), SqlParameters.NVarChar("@Description", category.Description, 500), SqlParameters.Bit("@IsActive", category.IsActive)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Categories_Delete", SqlParameters.Int("@Id", id)) > 0;
    public async Task<bool> ActivateAsync(int id) => await _sp.ExecuteAsync("sp_Categories_Activate", SqlParameters.Int("@Id", id)) > 0;
    public async Task<bool> DeactivateAsync(int id) => await _sp.ExecuteAsync("sp_Categories_Deactivate", SqlParameters.Int("@Id", id)) > 0;
}

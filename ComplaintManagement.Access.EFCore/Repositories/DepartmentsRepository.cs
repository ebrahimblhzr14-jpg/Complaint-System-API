using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class DepartmentsRepository : IDepartmentsRepository
{
    private readonly StoredProcedureExecutor _sp;
    public DepartmentsRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(Department department) => _sp.ExecuteIdAsync("sp_Departments_Create", SqlParameters.NVarChar("@Name", department.Name, 100), SqlParameters.NVarChar("@Description", department.Description, 500));
    public async Task<IEnumerable<Department>> GetAllAsync() => await _sp.QueryAsync<Department>("sp_Departments_GetAll");
    public Task<Department?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<Department>("sp_Departments_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(Department department) => await _sp.ExecuteAsync("sp_Departments_Update", SqlParameters.Int("@Id", department.Id), SqlParameters.NVarChar("@Name", department.Name, 100), SqlParameters.NVarChar("@Description", department.Description, 500), SqlParameters.Bit("@IsActive", department.IsActive)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Departments_Delete", SqlParameters.Int("@Id", id)) > 0;
}

using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;

namespace ComplaintManagement.Access.Repositories;

public sealed class UsersRepository : IUsersRepository
{
    private readonly StoredProcedureExecutor _sp;
    public UsersRepository(StoredProcedureExecutor sp) => _sp = sp;

    public Task<int> CreateAsync(User user) => _sp.ExecuteIdAsync("sp_Users_Create",
        SqlParameters.NVarChar("@Name", user.Name, 100), SqlParameters.NVarChar("@Email", user.Email, 255),
        SqlParameters.NVarChar("@PasswordHash", user.PasswordHash, 500), SqlParameters.NVarChar("@Phone", user.Phone, 30),
        SqlParameters.Int("@RoleId", user.RoleId));

    public async Task<IEnumerable<User>> GetAllAsync() => await _sp.QueryAsync<User>("sp_Users_GetAll");
    public Task<User?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<User>("sp_Users_GetById", SqlParameters.Int("@Id", id));
    public Task<User?> GetByEmailAsync(string email) => _sp.QuerySingleOrDefaultAsync<User>("sp_Users_GetByEmail", SqlParameters.NVarChar("@Email", email, 255));

    public async Task<bool> UpdateAsync(User user) => await _sp.ExecuteAsync("sp_Users_Update",
        SqlParameters.Int("@Id", user.Id), SqlParameters.NVarChar("@Name", user.Name, 100),
        SqlParameters.NVarChar("@Email", user.Email, 255), SqlParameters.NVarChar("@Phone", user.Phone, 30),
        SqlParameters.Int("@RoleId", user.RoleId), SqlParameters.Bit("@IsActive", user.IsActive)) > 0;

    public async Task<bool> PutDepartmentAsync(int UserID, int DepID) => await _sp.ExecuteAsync("sp_Users_PutDepartment",
        SqlParameters.Int("@Id", UserID), SqlParameters.Int("@DepID", DepID)) > 0;

    public async Task<bool> UpdatePasswordAsync(int id, string passwordHash) => await _sp.ExecuteAsync("sp_Users_UpdatePassword",
        SqlParameters.Int("@Id", id), SqlParameters.NVarChar("@PasswordHash", passwordHash, 500)) > 0;

    // Retained for callers that used the concrete repository; it is not part of IUsersRepository.
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Users_Delete", SqlParameters.Int("@Id", id)) > 0;

    public async Task<bool> DeactivateAsync(int id) => await _sp.ExecuteAsync("sp_Users_Deactivate", SqlParameters.Int("@Id", id)) > 0;
    public async Task<bool> ActivateAsync(int id) => await _sp.ExecuteAsync("sp_Users_Activate", SqlParameters.Int("@Id", id)) > 0;
}

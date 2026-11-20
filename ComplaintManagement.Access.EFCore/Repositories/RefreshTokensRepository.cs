using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class RefreshTokensRepository : IRefreshTokensRepository
{
    private readonly StoredProcedureExecutor _sp;
    public RefreshTokensRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(RefreshToken refreshToken) => _sp.ExecuteIdAsync("sp_RefreshTokens_Create", SqlParameters.Int("@UserId", refreshToken.UserId), SqlParameters.NVarChar("@Token", refreshToken.Token, 500), SqlParameters.DateTime2("@ExpiresAt", refreshToken.ExpiresAt));
    public Task<RefreshToken?> GetByTokenAsync(string token) => _sp.QuerySingleOrDefaultAsync<RefreshToken>("sp_RefreshTokens_GetByToken", SqlParameters.NVarChar("@Token", token, 500));
    public async Task<bool> RevokeAsync(int id) => await _sp.ExecuteAsync("sp_RefreshTokens_Revoke", SqlParameters.Int("@Id", id)) > 0;
}

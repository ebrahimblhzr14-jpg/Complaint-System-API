using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class AttachmentsRepository : IAttachmentsRepository
{
    private readonly StoredProcedureExecutor _sp;
    public AttachmentsRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(ComplaintAttachment attachment) => _sp.ExecuteIdAsync("sp_Attachments_Create", SqlParameters.Int("@ComplaintId", attachment.ComplaintId), SqlParameters.Int("@UploadedByUserId", attachment.UploadedByUserId), SqlParameters.NVarChar("@FileName", attachment.FileName, 255), SqlParameters.NVarChar("@FilePath", attachment.FilePath, 500), SqlParameters.NVarChar("@FileType", attachment.FileType, 100), SqlParameters.BigInt("@FileSize", attachment.FileSize));
    public async Task<IEnumerable<ComplaintAttachment>> GetByComplaintAsync(int complaintId) => await _sp.QueryAsync<ComplaintAttachment>("sp_Attachments_GetByComplaint", SqlParameters.Int("@ComplaintId", complaintId));
    public Task<ComplaintAttachment?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<ComplaintAttachment>("sp_Attachments_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(ComplaintAttachment attachment) => await _sp.ExecuteAsync("sp_Attachments_Update", SqlParameters.Int("@Id", attachment.Id), SqlParameters.NVarChar("@FileName", attachment.FileName, 255), SqlParameters.NVarChar("@FilePath", attachment.FilePath, 500), SqlParameters.NVarChar("@FileType", attachment.FileType, 100), SqlParameters.BigInt("@FileSize", attachment.FileSize)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Attachments_Delete", SqlParameters.Int("@Id", id)) > 0;
}

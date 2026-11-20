using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class FeedbackRepository : IFeedbackRepository
{
    private readonly StoredProcedureExecutor _sp;
    public FeedbackRepository(StoredProcedureExecutor sp) => _sp = sp;
    public Task<int> CreateAsync(ComplaintFeedback feedback) => _sp.ExecuteIdAsync("sp_Feedback_Create", SqlParameters.Int("@ComplaintId", feedback.ComplaintId), SqlParameters.Int("@UserId", feedback.UserId), SqlParameters.Int("@Rating", feedback.Rating), SqlParameters.NVarChar("@Comment", feedback.Comment, 1000));
    public async Task<IEnumerable<ComplaintFeedback?>> GetByComplaintAsync(int complaintId) => (await _sp.QueryAsync<ComplaintFeedback>("sp_Feedback_GetByComplaint", SqlParameters.Int("@ComplaintId", complaintId))).Cast<ComplaintFeedback?>();
    public Task<ComplaintFeedback?> GetByIdAsync(int id) => _sp.QuerySingleOrDefaultAsync<ComplaintFeedback>("sp_Feedback_GetById", SqlParameters.Int("@Id", id));
    public async Task<bool> UpdateAsync(ComplaintFeedback feedback) => await _sp.ExecuteAsync("sp_Feedback_Update", SqlParameters.Int("@Id", feedback.Id), SqlParameters.Int("@Rating", feedback.Rating), SqlParameters.NVarChar("@Comment", feedback.Comment, 1000)) > 0;
    public async Task<bool> DeleteAsync(int id) => await _sp.ExecuteAsync("sp_Feedback_Delete", SqlParameters.Int("@Id", id)) > 0;
}

using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Models;
namespace ComplaintManagement.Access.Repositories;
public sealed class DashboardRepository : IDashboardRepository
{
    private readonly StoredProcedureExecutor _sp;
    public DashboardRepository(StoredProcedureExecutor sp) => _sp = sp;
    public async Task<DashboardSummary> GetSummaryAsync() => await _sp.QuerySingleOrDefaultAsync<DashboardSummary>("sp_Dashboard_Summary") ?? new DashboardSummary();
    public async Task<IEnumerable<ComplaintsByStatus>> GetComplaintsByStatusAsync() => await _sp.QueryAsync<ComplaintsByStatus>("sp_Dashboard_ComplaintsByStatus");
    public async Task<IEnumerable<ComplaintsByPriority>> GetComplaintsByPriorityAsync() => await _sp.QueryAsync<ComplaintsByPriority>("sp_Dashboard_ComplaintsByPriority");
    public async Task<IEnumerable<ComplaintsByCategory>> GetComplaintsByCategoryAsync() => await _sp.QueryAsync<ComplaintsByCategory>("sp_Dashboard_ComplaintsByCategory");
}

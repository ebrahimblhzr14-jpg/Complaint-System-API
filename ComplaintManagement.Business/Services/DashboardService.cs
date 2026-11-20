using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Business.DTOs.Dashboard;
using ComplaintManagement.Business.Interfaces;

namespace ComplaintManagement.Business.Services
{
    public class DashboardService : IDashboardService
    {
        private readonly IDashboardRepository
            _dashboardRepository;

        public DashboardService(
            IDashboardRepository dashboardRepository)
        {
            _dashboardRepository =
                dashboardRepository;
        }


        // ================================================
        // Summary
        // ================================================

        public async Task<ComplaintSummaryDto>
            GetSummaryAsync()
        {
            var summary =
                await _dashboardRepository
                    .GetSummaryAsync();

            return new ComplaintSummaryDto
            {
                TotalComplaints =
                    summary.TotalComplaints ?? 0,

                PendingComplaints =
                    summary.PendingComplaints ?? 0,

                InProgressComplaints =
                    summary.InProgressComplaints ?? 0,

                ResolvedComplaints =
                    summary.ResolvedComplaints ?? 0,

                ClosedComplaints =
                    summary.ClosedComplaints ?? 0,

                RejectedComplaints =
                    summary.RejectedComplaints ?? 0
            };
        }


        // ================================================
        // By Status
        // ================================================

        public async Task<
            IEnumerable<ComplaintsByStatusDto>>
            GetComplaintsByStatusAsync()
        {
            var result =
                await _dashboardRepository
                    .GetComplaintsByStatusAsync();

            return result.Select(x =>
                new ComplaintsByStatusDto
                {
                    Id = x.Id,

                    Name = x.Name,

                    ComplaintCount =
                        x.ComplaintCount
                });
        }


        // ================================================
        // By Priority
        // ================================================

        public async Task<
            IEnumerable<ComplaintsByPriorityDto>>
            GetComplaintsByPriorityAsync()
        {
            var result =
                await _dashboardRepository
                    .GetComplaintsByPriorityAsync();

            return result.Select(x =>
                new ComplaintsByPriorityDto
                {
                    Id = x.Id,

                    Name = x.Name,

                    ComplaintCount =
                        x.ComplaintCount
                });
        }


        // ================================================
        // By Category
        // ================================================

        public async Task<
            IEnumerable<ComplaintsByCategoryDto>>
            GetComplaintsByCategoryAsync()
        {
            var result =
                await _dashboardRepository
                    .GetComplaintsByCategoryAsync();

            return result.Select(x =>
                new ComplaintsByCategoryDto
                {
                    Id = x.Id,

                    Name = x.Name,

                    ComplaintCount =
                        x.ComplaintCount
                });
        }
    }
}
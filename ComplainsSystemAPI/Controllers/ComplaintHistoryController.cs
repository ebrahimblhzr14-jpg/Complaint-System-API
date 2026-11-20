using ComplaintManagement.Business.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.RateLimiting;

namespace ComplaintManagement.API.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize(Roles = "SuperAdmin")]

    public class ComplaintHistoryController
        : ControllerBase
    {
        private readonly IComplaintHistoryService
            _historyService;

        public ComplaintHistoryController(
            IComplaintHistoryService historyService)
        {
            _historyService =
                historyService;
        }


        // =====================================================
        // GET:
        // api/complaints/{complaintId}/history
        // =====================================================

        [HttpGet]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult>
            GetByComplaint(int complaintId)
        {
            if (complaintId <= 0)
            {
                return BadRequest(new
                {
                    message =
                        "Invalid complaint ID."
                });
            }

            try
            {
                var history =
                    await _historyService
                        .GetByComplaintIdAsync(
                            complaintId);

                return Ok(history);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new
                {
                    message = ex.Message
                });
            }
        }


        // =====================================================
        // GET:
        // api/complaints/{complaintId}/history/{historyId}
        // =====================================================

        [HttpGet("{historyId:int}")]
        [EnableRateLimiting("GeneralApiLimiter")]

        public async Task<IActionResult>
            GetById(
                int complaintId,
                int historyId)
        {
            if (complaintId <= 0 ||
                historyId <= 0)
            {
                return BadRequest(new
                {
                    message =
                        "Invalid complaint or history ID."
                });
            }

            try
            {
                var history =
                    await _historyService
                        .GetByIdAsync(historyId);

                if (history == null)
                {
                    return NotFound(new
                    {
                        message =
                            "History record not found."
                    });
                }

                // Make sure this history record
                // actually belongs to this complaint.

                if (history.ComplaintId !=
                    complaintId)
                {
                    return NotFound(new
                    {
                        message =
                            "History record not found."
                    });
                }

                return Ok(history);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new
                {
                    message = ex.Message
                });
            }
        }
    }
}
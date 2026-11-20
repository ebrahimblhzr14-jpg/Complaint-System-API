using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Complaints
{
    public class UpdateComplaintStatusDto
    {
        [Required]
        [Range(1, 5, ErrorMessage = "StatusId must be between 1 and 5.")]
        public int StatusId { get; set; }
    }
}

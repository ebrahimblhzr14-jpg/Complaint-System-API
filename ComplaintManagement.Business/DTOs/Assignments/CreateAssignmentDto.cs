using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Assignments
{
    public class CreateAssignmentDto
    {
        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "ComplaintId must be greater than 0.")]
        public int ComplaintId { get; set; }

        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "AssignedToUserId must be greater than 0.")]
        public int AssignedToUserId { get; set; }

        [StringLength(1000, ErrorMessage = "Notes cannot exceed 1000 characters.")]
        public string? Notes { get; set; }
    }
}

using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Feedback
{
    public class UpdateFeedbackDto
    {
        [Required]
        [Range(1, 5, ErrorMessage = "Rating must be between 1 and 5.")]
        public int Rating { get; set; }

        [StringLength(1000, ErrorMessage = "Comment cannot exceed 1000 characters.")]
        public string? Comment { get; set; }
    }
}

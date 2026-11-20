using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Comments
{
    public class CreateCommentDto
    {
        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "ComplaintId must be greater than 0.")]
        public int ComplaintId { get; set; }

        [Required]
        [StringLength(2000, MinimumLength = 1, ErrorMessage = "Comment cannot be empty or exceed 2000 characters.")]
        public string Comment { get; set; } = string.Empty;
    }
}

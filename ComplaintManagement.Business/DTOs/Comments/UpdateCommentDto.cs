using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Comments
{
    public class UpdateCommentDto
    {
        [Required]
        [StringLength(2000, MinimumLength = 1, ErrorMessage = "Comment cannot be empty or exceed 2000 characters.")]
        public string Comment { get; set; } = string.Empty;
    }
}

using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Complaints
{
    public class UpdateComplaintDto
    {
        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "CategoryId must be greater than 0.")]
        public int CategoryId { get; set; }

        public int? DepartmentId { get; set; }

        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "PriorityId must be greater than 0.")]
        public int PriorityId { get; set; }

        [Required]
        [StringLength(200, MinimumLength = 3, ErrorMessage = "Title must be between 3 and 200 characters.")]
        public string Title { get; set; } = string.Empty;

        [Required]
        [StringLength(4000, MinimumLength = 5, ErrorMessage = "Description must be between 5 and 4000 characters.")]
        public string Description { get; set; } = string.Empty;
    }
}

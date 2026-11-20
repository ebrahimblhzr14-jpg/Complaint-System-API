using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Priorities
{
    public class CreatePriorityDto
    {
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Priority name must be between 2 and 100 characters.")]
        public string Name { get; set; } = string.Empty;

        [Range(1, 10, ErrorMessage = "Level must be between 1 and 10.")]
        public int Level { get; set; }
    }
}

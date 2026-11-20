using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Statuses
{
    public class UpdateStatusDto
    {
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Status name must be between 2 and 100 characters.")]
        public string Name { get; set; } = string.Empty;
    }
}

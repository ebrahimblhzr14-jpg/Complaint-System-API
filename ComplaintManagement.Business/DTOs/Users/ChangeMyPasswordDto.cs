using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Users
{
    public class ChangeMyPasswordDto
    {
        [Required]
        public string CurrentPassword { get; set; } = string.Empty;

        [Required]
        [MinLength(8, ErrorMessage = "Password must be at least 8 characters.")]
        public string NewPassword { get; set; } = string.Empty;
    }
}

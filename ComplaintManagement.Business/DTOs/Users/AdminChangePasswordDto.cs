using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Users
{
    public class AdminChangePasswordDto
    {
        [Required]
        [MinLength(8, ErrorMessage = "Password must be at least 8 characters.")]
        public string NewPassword { get; set; } = string.Empty;
    }
}

using System.ComponentModel.DataAnnotations;

namespace ComplaintManagement.Business.DTOs.Users
{
    public class UpdateUserDto
    {
        [Required]
        [StringLength(100, MinimumLength = 2, ErrorMessage = "Name must be between 2 and 100 characters.")]
        public string Name { get; set; } = string.Empty;

        [Required]
        [EmailAddress(ErrorMessage = "Invalid email address.")]
        [StringLength(150, ErrorMessage = "Email cannot exceed 150 characters.")]
        public string Email { get; set; } = string.Empty;

        [StringLength(20, ErrorMessage = "Phone cannot exceed 20 characters.")]
        public string? Phone { get; set; }

        [Range(1, 3, ErrorMessage = "RoleId must be between 1 and 3.")]
        public int RoleId { get; set; }

        public bool IsActive { get; set; }
    }
}

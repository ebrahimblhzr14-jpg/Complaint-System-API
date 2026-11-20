namespace ComplaintManagement.Access.EFCore.Entities;

public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string PasswordHash { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public int RoleId { get; set; }
    public bool IsActive { get; set; }
    public DateTime CreatedAt { get; set; }
    public int? DepartmentId { get; set; }

    public Role Role { get; set; } = null!;
    public Department? Department { get; set; }
    public ICollection<Complaint> Complaints { get; set; } = new List<Complaint>();
    public ICollection<ComplaintAssignment> AssignedTo { get; set; } = new List<ComplaintAssignment>();
    public ICollection<ComplaintAssignment> AssignedBy { get; set; } = new List<ComplaintAssignment>();
    public ICollection<ComplaintAttachment> Attachments { get; set; } = new List<ComplaintAttachment>();
    public ICollection<ComplaintComment> Comments { get; set; } = new List<ComplaintComment>();
    public ICollection<ComplaintFeedback> Feedback { get; set; } = new List<ComplaintFeedback>();
    public ICollection<ComplaintHistory> History { get; set; } = new List<ComplaintHistory>();
    public ICollection<RefreshToken> RefreshTokens { get; set; } = new List<RefreshToken>();
}

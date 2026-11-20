namespace ComplaintManagement.Access.EFCore.Entities;

public class Complaint
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public int CategoryId { get; set; }
    public int? DepartmentId { get; set; }
    public int StatusId { get; set; }
    public int PriorityId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
    public DateTime? ResolvedAt { get; set; }
    public DateTime? ClosedAt { get; set; }
    public bool IsDeleted { get; set; }

    public User User { get; set; } = null!;
    public ComplaintCategory Category { get; set; } = null!;
    public Department? Department { get; set; }
    public ComplaintStatus Status { get; set; } = null!;
    public Priority Priority { get; set; } = null!;
    public ICollection<ComplaintAssignment> Assignments { get; set; } = new List<ComplaintAssignment>();
    public ICollection<ComplaintAttachment> Attachments { get; set; } = new List<ComplaintAttachment>();
    public ICollection<ComplaintComment> Comments { get; set; } = new List<ComplaintComment>();
    public ICollection<ComplaintFeedback> Feedback { get; set; } = new List<ComplaintFeedback>();
    public ICollection<ComplaintHistory> History { get; set; } = new List<ComplaintHistory>();
}

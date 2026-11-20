namespace ComplaintManagement.Access.EFCore.Entities;

public class ComplaintHistory
{
    public int Id { get; set; }
    public int ComplaintId { get; set; }
    public int UserId { get; set; }
    public string Action { get; set; } = string.Empty;
    public string? OldValue { get; set; }
    public string? NewValue { get; set; }
    public DateTime CreatedAt { get; set; }
    public string? Description { get; set; }

    public Complaint Complaint { get; set; } = null!;
    public User User { get; set; } = null!;
}

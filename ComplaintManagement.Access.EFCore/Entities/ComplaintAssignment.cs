namespace ComplaintManagement.Access.EFCore.Entities;

public class ComplaintAssignment
{
    public int Id { get; set; }
    public int ComplaintId { get; set; }
    public int AssignedToUserId { get; set; }
    public int AssignedByUserId { get; set; }
    public DateTime AssignedAt { get; set; }
    public DateTime? UnassignedAt { get; set; }
    public string? Notes { get; set; }

    public Complaint Complaint { get; set; } = null!;
    public User AssignedToUser { get; set; } = null!;
    public User AssignedByUser { get; set; } = null!;
}

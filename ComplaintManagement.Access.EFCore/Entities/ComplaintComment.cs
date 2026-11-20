namespace ComplaintManagement.Access.EFCore.Entities;

public class ComplaintComment
{
    public int Id { get; set; }
    public int ComplaintId { get; set; }
    public int UserId { get; set; }
    public string Comment { get; set; } = string.Empty;
    public DateTime CreatedAt { get; set; }

    public Complaint Complaint { get; set; } = null!;
    public User User { get; set; } = null!;
}

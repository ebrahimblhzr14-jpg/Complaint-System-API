namespace ComplaintManagement.Access.EFCore.Entities;

public class Department
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string? Description { get; set; }
    public bool IsActive { get; set; }

    public ICollection<Complaint> Complaints { get; set; } = new List<Complaint>();
    public ICollection<User> Users { get; set; } = new List<User>();
}

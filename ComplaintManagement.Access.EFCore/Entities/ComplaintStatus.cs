namespace ComplaintManagement.Access.EFCore.Entities;

public class ComplaintStatus
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public bool? IsActive { get; set; }

    public ICollection<Complaint> Complaints { get; set; } = new List<Complaint>();
}

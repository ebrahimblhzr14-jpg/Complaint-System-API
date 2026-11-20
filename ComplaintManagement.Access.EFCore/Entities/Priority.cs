namespace ComplaintManagement.Access.EFCore.Entities;

public class Priority
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public int Level { get; set; }
    public bool? IsActive { get; set; }

    public ICollection<Complaint> Complaints { get; set; } = new List<Complaint>();
}

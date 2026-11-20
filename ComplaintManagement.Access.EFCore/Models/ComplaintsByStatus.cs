namespace ComplaintManagement.Access.Models
{
    public class ComplaintsByStatus
    {
        public int StatusId { get; set; }
        public int Id => StatusId;

        public string StatusName { get; set; } = string.Empty;
        public string Name => StatusName;

        public int ComplaintCount { get; set; }
    }
}

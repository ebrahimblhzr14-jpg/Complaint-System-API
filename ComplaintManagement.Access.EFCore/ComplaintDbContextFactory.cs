using ComplaintManagement.Access.EFCore.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;

namespace ComplaintManagement.Access.EFCore;

public sealed class ComplaintDbContextFactory
    : IDesignTimeDbContextFactory<ComplaintDbContext>
{
    public ComplaintDbContext CreateDbContext(string[] args)
    {
        var connectionString =
            Environment.GetEnvironmentVariable("COMPLAINTS_DB_CONNECTION")
            ?? "Server=(localdb)\\MSSQLLocalDB;Database=ComplaintManagementDB;Trusted_Connection=True;TrustServerCertificate=True;";

        var options = new DbContextOptionsBuilder<ComplaintDbContext>()
            .UseSqlServer(connectionString)
            .Options;

        return new ComplaintDbContext(options);
    }
}

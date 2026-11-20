using ComplaintManagement.Access.EFCore.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;

namespace ComplaintManagement.Access.EFCore.Migrations;

[DbContext(typeof(ComplaintDbContext))]
public sealed class ComplaintDbContextModelSnapshot : ModelSnapshot
{
    protected override void BuildModel(ModelBuilder modelBuilder)
    {
        modelBuilder.HasAnnotation("ProductVersion", "8.0.22");
        ComplaintDbContext.ConfigureModel(modelBuilder);
    }
}

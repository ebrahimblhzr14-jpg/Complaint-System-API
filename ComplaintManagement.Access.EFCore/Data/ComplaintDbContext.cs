using ComplaintManagement.Access.EFCore.Entities;
using Microsoft.EntityFrameworkCore;

namespace ComplaintManagement.Access.EFCore.Data;

public class ComplaintDbContext : DbContext
{
    public ComplaintDbContext(DbContextOptions<ComplaintDbContext> options) : base(options) { }

    public DbSet<Complaint> Complaints => Set<Complaint>();
    public DbSet<ComplaintAssignment> ComplaintAssignments => Set<ComplaintAssignment>();
    public DbSet<ComplaintAttachment> ComplaintAttachments => Set<ComplaintAttachment>();
    public DbSet<ComplaintCategory> ComplaintCategories => Set<ComplaintCategory>();
    public DbSet<ComplaintComment> ComplaintComments => Set<ComplaintComment>();
    public DbSet<ComplaintFeedback> ComplaintFeedback => Set<ComplaintFeedback>();
    public DbSet<ComplaintHistory> ComplaintHistory => Set<ComplaintHistory>();
    public DbSet<ComplaintStatus> ComplaintStatuses => Set<ComplaintStatus>();
    public DbSet<Department> Departments => Set<Department>();
    public DbSet<Priority> Priorities => Set<Priority>();
    public DbSet<RefreshToken> RefreshTokens => Set<RefreshToken>();
    public DbSet<Role> Roles => Set<Role>();
    public DbSet<User> Users => Set<User>();

    protected override void OnModelCreating(ModelBuilder modelBuilder) => ConfigureModel(modelBuilder);

    // Shared by DbContext and ModelSnapshot so future migrations can compare the model.
    public static void ConfigureModel(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Complaint>(e =>
        {
            e.ToTable("Complaints"); e.HasKey(x => x.Id);
            e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Title).HasMaxLength(200).IsRequired();
            e.Property(x => x.Description).IsRequired();
            e.Property(x => x.CreatedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.Property(x => x.UpdatedAt).HasColumnType("datetime2");
            e.Property(x => x.ResolvedAt).HasColumnType("datetime2");
            e.Property(x => x.ClosedAt).HasColumnType("datetime2");
            e.Property(x => x.IsDeleted).HasDefaultValue(false);
            e.HasOne(x => x.User).WithMany(x => x.Complaints).HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Complaints_Users");
            e.HasOne(x => x.Category).WithMany(x => x.Complaints).HasForeignKey(x => x.CategoryId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Complaints_Categories");
            e.HasOne(x => x.Department).WithMany(x => x.Complaints).HasForeignKey(x => x.DepartmentId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Complaints_Departments");
            e.HasOne(x => x.Status).WithMany(x => x.Complaints).HasForeignKey(x => x.StatusId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Complaints_Statuses");
            e.HasOne(x => x.Priority).WithMany(x => x.Complaints).HasForeignKey(x => x.PriorityId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Complaints_Priorities");
        });
        modelBuilder.Entity<ComplaintAssignment>(e =>
        {
            e.ToTable("ComplaintAssignments"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.AssignedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.Property(x => x.UnassignedAt).HasColumnType("datetime2"); e.Property(x => x.Notes).HasMaxLength(500);
            e.HasOne(x => x.Complaint).WithMany(x => x.Assignments).HasForeignKey(x => x.ComplaintId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Assignments_Complaints");
            e.HasOne(x => x.AssignedToUser).WithMany(x => x.AssignedTo).HasForeignKey(x => x.AssignedToUserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Assignments_AssignedTo");
            e.HasOne(x => x.AssignedByUser).WithMany(x => x.AssignedBy).HasForeignKey(x => x.AssignedByUserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Assignments_AssignedBy");
        });
        modelBuilder.Entity<ComplaintAttachment>(e =>
        {
            e.ToTable("ComplaintAttachments"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.FileName).HasMaxLength(255).IsRequired(); e.Property(x => x.FilePath).HasMaxLength(500).IsRequired();
            e.Property(x => x.FileType).HasMaxLength(100); e.Property(x => x.UploadedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.HasOne(x => x.Complaint).WithMany(x => x.Attachments).HasForeignKey(x => x.ComplaintId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Attachments_Complaints");
            e.HasOne(x => x.UploadedByUser).WithMany(x => x.Attachments).HasForeignKey(x => x.UploadedByUserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Attachments_Users");
        });
        modelBuilder.Entity<ComplaintCategory>(e =>
        {
            e.ToTable("ComplaintCategories"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Name).HasMaxLength(100).IsRequired(); e.Property(x => x.Description).HasMaxLength(500);
            e.Property(x => x.IsActive).HasDefaultValue(true); e.HasIndex(x => x.Name).IsUnique();
        });
        modelBuilder.Entity<ComplaintComment>(e =>
        {
            e.ToTable("ComplaintComments"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Comment).IsRequired(); e.Property(x => x.CreatedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.HasOne(x => x.Complaint).WithMany(x => x.Comments).HasForeignKey(x => x.ComplaintId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Comments_Complaints");
            e.HasOne(x => x.User).WithMany(x => x.Comments).HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Comments_Users");
        });
        modelBuilder.Entity<ComplaintFeedback>(e =>
        {
            e.ToTable("ComplaintFeedback"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Comment).HasMaxLength(1000); e.Property(x => x.CreatedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.ToTable(t => t.HasCheckConstraint("CK_Feedback_Rating", "[Rating] >= (1) AND [Rating] <= (5)"));
            e.HasOne(x => x.Complaint).WithMany(x => x.Feedback).HasForeignKey(x => x.ComplaintId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Feedback_Complaints");
            e.HasOne(x => x.User).WithMany(x => x.Feedback).HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Feedback_Users");
        });
        modelBuilder.Entity<ComplaintHistory>(e =>
        {
            e.ToTable("ComplaintHistory"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Action).HasMaxLength(100).IsRequired(); e.Property(x => x.OldValue).HasMaxLength(500);
            e.Property(x => x.NewValue).HasMaxLength(500); e.Property(x => x.Description).HasMaxLength(1000);
            e.Property(x => x.CreatedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.HasOne(x => x.Complaint).WithMany(x => x.History).HasForeignKey(x => x.ComplaintId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_History_Complaints");
            e.HasOne(x => x.User).WithMany(x => x.History).HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_History_Users");
        });
        modelBuilder.Entity<ComplaintStatus>(e =>
        {
            e.ToTable("ComplaintStatuses"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Name).HasMaxLength(50).IsRequired(); e.HasIndex(x => x.Name).IsUnique();
        });
        modelBuilder.Entity<Department>(e =>
        {
            e.ToTable("Departments"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Name).HasMaxLength(100).IsRequired(); e.Property(x => x.Description).HasMaxLength(500);
            e.Property(x => x.IsActive).HasDefaultValue(true); e.HasIndex(x => x.Name).IsUnique();
            e.HasMany(x => x.Users).WithOne(x => x.Department).HasForeignKey(x => x.DepartmentId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Users_Departments");
        });
        modelBuilder.Entity<Priority>(e =>
        {
            e.ToTable("Priorities"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Name).HasMaxLength(50).IsRequired(); e.HasIndex(x => x.Name).IsUnique(); e.HasIndex(x => x.Level).IsUnique();
        });
        modelBuilder.Entity<RefreshToken>(e =>
        {
            e.ToTable("RefreshTokens"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Token).HasMaxLength(500).IsRequired(); e.HasIndex(x => x.Token).IsUnique().HasDatabaseName("IX_RefreshTokens_Token");
            e.Property(x => x.ExpiresAt).HasColumnType("datetime2"); e.Property(x => x.RevokedAt).HasColumnType("datetime2");
            e.Property(x => x.CreatedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.HasOne(x => x.User).WithMany(x => x.RefreshTokens).HasForeignKey(x => x.UserId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_RefreshTokens_Users");
        });
        modelBuilder.Entity<Role>(e =>
        {
            e.ToTable("Roles"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Name).HasMaxLength(50).IsRequired(); e.HasIndex(x => x.Name).IsUnique();
        });
        modelBuilder.Entity<User>(e =>
        {
            e.ToTable("Users"); e.HasKey(x => x.Id); e.Property(x => x.Id).UseIdentityColumn();
            e.Property(x => x.Name).HasMaxLength(100).IsRequired(); e.Property(x => x.Email).HasMaxLength(255).IsRequired();
            e.Property(x => x.PasswordHash).HasMaxLength(500).IsRequired(); e.Property(x => x.Phone).HasMaxLength(30);
            e.HasIndex(x => x.Email).IsUnique(); e.Property(x => x.DepartmentId).HasColumnName("DepartmentID"); e.Property(x => x.IsActive).HasDefaultValue(true);
            e.Property(x => x.CreatedAt).HasColumnType("datetime2").HasDefaultValueSql("(getutcdate())");
            e.HasOne(x => x.Role).WithMany(x => x.Users).HasForeignKey(x => x.RoleId).OnDelete(DeleteBehavior.NoAction).HasConstraintName("FK_Users_Roles");
        });
    }
}

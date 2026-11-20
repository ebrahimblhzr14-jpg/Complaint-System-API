using System.Reflection;
using System.Text.RegularExpressions;
using ComplaintManagement.Access.EFCore.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;

namespace ComplaintManagement.Access.EFCore.Migrations;

[DbContext(typeof(ComplaintDbContext))]
[Migration("202611060001_InitialCreate")]
public sealed class InitialCreate : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        var assembly = Assembly.GetExecutingAssembly();
        const string resourceName = "ComplaintManagement.Access.EFCore.StoredProcedures.ComplaintManagementDB.Schema.sql";
        using var stream = assembly.GetManifestResourceStream(resourceName)
            ?? throw new InvalidOperationException($"Embedded SQL resource '{resourceName}' was not found.");
        using var reader = new StreamReader(stream);
        var script = reader.ReadToEnd();

        // SQL Server's GO is a client-side batch separator, not T-SQL.
        foreach (var batch in Regex.Split(script, @"(?im)^\s*GO\s*(?:--.*)?$"))
        {
            var sql = batch.Trim();
            if (sql.Length > 0)
                migrationBuilder.Sql(sql);
        }
    }

    protected override void BuildTargetModel(ModelBuilder modelBuilder) => ComplaintDbContext.ConfigureModel(modelBuilder);

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_UpdatePassword]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_PutDepartment]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_GetByEmail]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_Deactivate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Users_Activate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Statuses_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Statuses_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Statuses_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Statuses_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Statuses_Deactivate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Statuses_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Statuses_Activate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Roles_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Roles_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Roles_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Roles_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Roles_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_RefreshTokens_RevokeByToken]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_RefreshTokens_Revoke]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_RefreshTokens_GetByToken]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_RefreshTokens_GetActiveByUser]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_RefreshTokens_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Priorities_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Priorities_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Priorities_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Priorities_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Priorities_Deactivate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Priorities_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Priorities_Activate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_History_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_History_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Feedback_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Feedback_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Feedback_GetByComplaint]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Feedback_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Feedback_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Departments_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Departments_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Departments_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Departments_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Departments_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Dashboard_Summary]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Dashboard_ComplaintsByStatus]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Dashboard_ComplaintsByPriority]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Dashboard_ComplaintsByDepartment]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Dashboard_ComplaintsByCategory]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Complaints_UpdateStatus]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Complaints_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Complaints_GetByUser]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Complaints_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Complaints_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Complaints_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Complaints_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_ComplaintHistory_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_ComplaintHistory_GetByComplaintId]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_ComplaintHistory_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Comments_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Comments_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Comments_GetByComplaint]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Comments_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Comments_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Categories_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Categories_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Categories_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Categories_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Categories_Deactivate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Categories_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Categories_Activate]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Attachments_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Attachments_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Attachments_GetByComplaint]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Attachments_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Attachments_Create]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Assignments_Update]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Assignments_GetById]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Assignments_GetAll]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Assignments_Delete]");
        migrationBuilder.Sql("DROP PROCEDURE IF EXISTS [dbo].[sp_Assignments_Create]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[ComplaintAssignments]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[ComplaintAttachments]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[ComplaintComments]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[ComplaintFeedback]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[ComplaintHistory]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[Complaints]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[RefreshTokens]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[ComplaintCategories]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[ComplaintStatuses]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[Departments]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[Priorities]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[Roles]");
        migrationBuilder.Sql("DROP TABLE IF EXISTS [dbo].[Users]");
    }
}

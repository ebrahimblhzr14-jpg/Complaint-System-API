using ComplaintManagement.Access.EFCore.Data;
using ComplaintManagement.Access.EFCore.Infrastructure;
using ComplaintManagement.Access.Interfaces;
using ComplaintManagement.Access.Repositories;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;

namespace ComplaintManagement.Access.EFCore;

public static class DependencyInjection
{
    public static IServiceCollection AddComplaintDataAccess(this IServiceCollection services, string connectionString)
    {
        services.AddDbContext<ComplaintDbContext>(options => options.UseSqlServer(connectionString));
        services.AddScoped<StoredProcedureExecutor>(provider => new StoredProcedureExecutor(provider.GetRequiredService<ComplaintDbContext>()));

        services.AddScoped<IUsersRepository, UsersRepository>();
        services.AddScoped<IRolesRepository, RolesRepository>();
        services.AddScoped<IDepartmentsRepository, DepartmentsRepository>();
        services.AddScoped<ICategoriesRepository, CategoriesRepository>();
        services.AddScoped<IStatusesRepository, StatusesRepository>();
        services.AddScoped<IPrioritiesRepository, PrioritiesRepository>();
        services.AddScoped<IComplaintsRepository, ComplaintsRepository>();
        services.AddScoped<IAssignmentsRepository, AssignmentsRepository>();
        services.AddScoped<IAttachmentsRepository, AttachmentsRepository>();
        services.AddScoped<ICommentsRepository, CommentsRepository>();
        services.AddScoped<IFeedbackRepository, FeedbackRepository>();
        services.AddScoped<IComplaintHistoryRepository, ComplaintHistoryRepository>();
        services.AddScoped<IRefreshTokensRepository, RefreshTokensRepository>();
        services.AddScoped<IDashboardRepository, DashboardRepository>();
        return services;
    }
}

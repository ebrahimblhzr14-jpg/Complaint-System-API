# Complaint Management System - Backend API

ASP.NET Core 8 Web API for the **Shakowa (شكوى)** Complaint Management System.

## Architecture Overview

The backend follows a layered, decoupled architecture structured into three projects:

```
├── ComplainsSystemAPI/                # API & Presentation Layer
│   ├── Controllers/                   # RESTful API Endpoints
│   ├── Middleware/                    # Exception handling & custom middleware
│   ├── Program.cs                     # Application entry point & DI configuration
│   └── appsettings.json               # Application configuration
├── ComplaintManagement.Business/      # Business Logic Layer
│   ├── Services/                      # Core business rules & logic
│   ├── DTOs/                          # Data Transfer Objects
│   └── Security/                      # Password hashing & JWT helpers
├── ComplaintManagement.Access.EFCore/ # Data Access Layer
│   ├── Data/                          # EF Core DbContext & Stored Procedure mappings
│   ├── Entities/                      # Database models / Entities
│   └── Repositories/                  # Repository pattern implementations
├── ComplaintsDB_Schema.sql            # Complete SQL Server schema & stored procedures
├── Dockerfile                         # Multi-stage Docker build for deployment (Render, etc.)
└── .dockerignore
```

## Features

- **Role-Based Access Control (RBAC):** Admin, Supervisor, and standard User permissions.
- **Complaint Lifecycle Management:** Create, Track, Review, Resolve, Close, Reopen, and Delete with strict backend permission checks.
- **JWT Bearer Authentication:** Secure stateless authentication with customizable token expiration.
- **Stored Procedures & EF Core:** High-performance database operations combining Entity Framework Core with optimized SQL stored procedures.
- **Structured Logging:** Serilog integration supporting Console, rolling File logs, and Seq sinks.
- **Swagger / OpenAPI:** Interactive API documentation in development mode.
- **Docker Ready:** Multi-stage build with dynamic `$PORT` binding for cloud hosting platforms like Render.

## Prerequisites

- [.NET 8.0 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [Microsoft SQL Server](https://www.microsoft.com/sql-server) (2019 or later / Azure SQL)

## Getting Started

### 1. Database Setup
Execute `ComplaintsDB_Schema.sql` in SQL Server Management Studio (SSMS) or Azure Data Studio to create the `ComplaintManagementDB` database, tables, relationships, and stored procedures.

### 2. Configuration
Update the connection string in `ComplainsSystemAPI/appsettings.json`:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=YOUR_SERVER;Database=ComplaintManagementDB;User Id=YOUR_USER;Password=YOUR_PASSWORD;TrustServerCertificate=True;"
}
```

Or set the environment variable:
```bash
ConnectionStrings__DefaultConnection="Server=YOUR_SERVER;Database=ComplaintManagementDB;User Id=YOUR_USER;Password=YOUR_PASSWORD;TrustServerCertificate=True;"
```

### 3. Run Locally
```bash
cd ComplainsSystemAPI
dotnet restore
dotnet run
```
The API will start locally. Access Swagger UI at `https://localhost:7143/swagger` (or configured port).

## Docker Build & Deployment

### Build the Image
```bash
docker build -t complaint-system-api .
```

### Run the Container
```bash
docker run -p 8080:8080 -e ConnectionStrings__DefaultConnection="Server=...;Database=ComplaintManagementDB;..." complaint-system-api
```

This Dockerfile is configured for deployment on cloud platforms like **Render**, binding dynamically to `0.0.0.0:${PORT:-8080}`.

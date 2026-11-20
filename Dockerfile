# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy project files for caching layer
COPY ["ComplainsSystemAPI/ComplainsSystemAPI.csproj", "ComplainsSystemAPI/"]
COPY ["ComplaintManagement.Business/ComplaintManagement.Business.csproj", "ComplaintManagement.Business/"]
COPY ["ComplaintManagement.Access.EFCore/ComplaintManagement.Access.EFCore.csproj", "ComplaintManagement.Access.EFCore/"]

# Restore dependencies
RUN dotnet restore "ComplainsSystemAPI/ComplainsSystemAPI.csproj"

# Copy full source
COPY . .

# Build and Publish
WORKDIR "/src/ComplainsSystemAPI"
RUN dotnet publish "ComplainsSystemAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
EXPOSE 8080

ENV ASPNETCORE_ENVIRONMENT=Production
ENV ASPNETCORE_FORWARDEDHEADERS_ENABLED=true

COPY --from=build /app/publish .

# Dynamic port binding to 0.0.0.0 using Render's $PORT
ENTRYPOINT ["sh", "-c", "dotnet ComplainsSystemAPI.dll --urls http://0.0.0.0:${PORT:-8080}"]

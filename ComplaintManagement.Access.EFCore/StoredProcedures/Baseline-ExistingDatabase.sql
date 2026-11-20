/*
    DANGER: Run this ONLY after comparing the existing database schema with
    ComplaintDbContext and confirming that all 13 tables, columns, indexes,
    constraints and relationships already match the InitialCreate migration.

    This does NOT create or modify application tables. It tells EF Core that
    migration 202611060001_InitialCreate has already been applied.
    Back up the database first.
*/
IF OBJECT_ID(N'[dbo].[Users]', N'U') IS NULL
    THROW 51000, 'Users table was not found. This does not look like the existing ComplaintManagement database.', 1;

IF OBJECT_ID(N'[dbo].[Complaints]', N'U') IS NULL
    THROW 51001, 'Complaints table was not found. Baseline was not recorded.', 1;

IF OBJECT_ID(N'[dbo].[__EFMigrationsHistory]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[__EFMigrationsHistory]
    (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL,
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;

IF NOT EXISTS
(
    SELECT 1 FROM [dbo].[__EFMigrationsHistory]
    WHERE [MigrationId] = N'202611060001_InitialCreate'
)
BEGIN
    INSERT INTO [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion])
    VALUES (N'202611060001_InitialCreate', N'8.0.22');
END;

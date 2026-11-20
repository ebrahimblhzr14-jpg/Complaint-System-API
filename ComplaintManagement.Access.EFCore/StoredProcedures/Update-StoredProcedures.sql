-- Apply this script to an EXISTING ComplaintManagementDB to synchronize stored procedures.
-- It does not create/drop tables or change table data.
-- Run in SQL Server Management Studio; GO is a batch separator.

/* =========================================
   Assignment - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Assignments_Create]
    @ComplaintId INT,
    @AssignedToUserId INT,
    @AssignedByUserId INT,
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO ComplaintAssignments
    (
        ComplaintId,
        AssignedToUserId,
        AssignedByUserId,
        Notes
    )
    VALUES
    (
        @ComplaintId,
        @AssignedToUserId,
        @AssignedByUserId,
        @Notes
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/* =========================================
   Assignment - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Assignments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintAssignments
    WHERE Id = @Id;
END;
GO

/* =========================================
   Assignment - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Assignments_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        A.Id,
        A.ComplaintId,

        A.AssignedToUserId,
        U1.Name AS AssignedToUserName,

        A.AssignedByUserId,
        U2.Name AS AssignedByUserName,

        A.AssignedAt,
        A.UnassignedAt,
        A.Notes

    FROM ComplaintAssignments A

    INNER JOIN Users U1
        ON A.AssignedToUserId = U1.Id

    INNER JOIN Users U2
        ON A.AssignedByUserId = U2.Id

    ORDER BY A.AssignedAt DESC;
END;
GO

/* =========================================
   Assignment - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Assignments_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        A.Id,
        A.ComplaintId,

        A.AssignedToUserId,
        U1.Name AS AssignedToUserName,

        A.AssignedByUserId,
        U2.Name AS AssignedByUserName,

        A.AssignedAt,
        A.UnassignedAt,
        A.Notes

    FROM ComplaintAssignments A

    INNER JOIN Users U1
        ON A.AssignedToUserId = U1.Id

    INNER JOIN Users U2
        ON A.AssignedByUserId = U2.Id

    WHERE A.Id = @Id;
END;
GO

/* =========================================
   Assignment - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Assignments_Update]
    @Id INT,
    @AssignedToUserId INT,
    @UnassignedAt DATETIME2 = NULL,
    @Notes NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintAssignments
    SET
        AssignedToUserId = @AssignedToUserId,
        UnassignedAt = @UnassignedAt,
        Notes = @Notes

    WHERE Id = @Id;
END;
GO

/* =========================================
   Attachments - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Attachments_Create]
    @ComplaintId INT,
    @UploadedByUserId INT,
    @FileName NVARCHAR(255),
    @FilePath NVARCHAR(500),
    @FileType NVARCHAR(100) = NULL,
    @FileSize BIGINT = NULL
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO ComplaintAttachments
    (
        ComplaintId,
        UploadedByUserId,
        FileName,
        FilePath,
        FileType,
        FileSize
    )
    VALUES
    (
        @ComplaintId,
        @UploadedByUserId,
        @FileName,
        @FilePath,
        @FileType,
        @FileSize
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/* =========================================
   Attachments - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Attachments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintAttachments
    WHERE Id = @Id;
END;
GO

/* =========================================
   Attachments - GET BY COMPLAINT
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Attachments_GetByComplaint]
    @ComplaintId INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        A.Id,
        A.ComplaintId,
        A.UploadedByUserId,
        U.Name AS UploadedByUserName,
        A.FileName,
        A.FilePath,
        A.FileType,
        A.FileSize,
        A.UploadedAt

    FROM ComplaintAttachments A

    INNER JOIN Users U
        ON A.UploadedByUserId = U.Id

    WHERE A.ComplaintId = @ComplaintId

    ORDER BY A.UploadedAt DESC;
END;
GO

/* =========================================
   Attachments - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Attachments_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        A.Id,
        A.ComplaintId,
        A.UploadedByUserId,
        U.Name AS UploadedByUserName,
        A.FileName,
        A.FilePath,
        A.FileType,
        A.FileSize,
        A.UploadedAt

    FROM ComplaintAttachments A

    INNER JOIN Users U
        ON A.UploadedByUserId = U.Id

    WHERE A.Id = @Id;
END;
GO

/* =========================================
   Attachments - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Attachments_Update]
    @Id INT,
    @FileName NVARCHAR(255),
    @FilePath NVARCHAR(500),
    @FileType NVARCHAR(100),
    @FileSize BIGINT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintAttachments
    SET
        FileName = @FileName,
        FilePath = @FilePath,
        FileType = @FileType,
        FileSize = @FileSize

    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Categories_Activate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintCategories
    SET IsActive = 1
    WHERE Id = @Id;

   
END;
GO

/* =========================================
   Categories - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Categories_Create]
    @Name NVARCHAR(100),
    @Description NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO ComplaintCategories
    (
        Name,
        Description
    )
    VALUES
    (
        @Name,
        @Description
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Categories_Deactivate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintCategories
    SET IsActive = 0
    WHERE Id = @Id;

    
END;
GO

/* =========================================
   Categories - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Categories_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintCategories
    WHERE Id = @Id;
END;
GO

/* =========================================
   Categories - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Categories_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name,
        Description,
        IsActive
    FROM ComplaintCategories
    ORDER BY Id DESC;
END;
GO

/* =========================================
   Categories - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Categories_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name,
        Description,
        IsActive
    FROM ComplaintCategories
    WHERE Id = @Id;
END;
GO

/* =========================================
   Categories - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Categories_Update]
    @Id INT,
    @Name NVARCHAR(100),
    @Description NVARCHAR(500),
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintCategories
    SET
        Name = @Name,
        Description = @Description,
        IsActive = @IsActive
    WHERE Id = @Id;
END;
GO

/* =========================================
   Comments - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Comments_Create]
    @ComplaintId INT,
    @UserId INT,
    @Comment NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO ComplaintComments
    (
        ComplaintId,
        UserId,
        Comment
    )
    VALUES
    (
        @ComplaintId,
        @UserId,
        @Comment
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/* =========================================
   Comments - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Comments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintComments
    WHERE Id = @Id;
END;
GO

/* =========================================
   Comments - GET BY COMPLAINT
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Comments_GetByComplaint]
    @ComplaintId INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        C.Id,
        C.ComplaintId,
        C.UserId,
        U.Name AS UserName,
        C.Comment,
        C.CreatedAt

    FROM ComplaintComments C

    INNER JOIN Users U
        ON C.UserId = U.Id

    WHERE C.ComplaintId = @ComplaintId

    ORDER BY C.CreatedAt ASC;
END;
GO

/* =========================================
   Comments - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Comments_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        C.Id,
        C.ComplaintId,
        C.UserId,
        U.Name AS UserName,
        C.Comment,
        C.CreatedAt

    FROM ComplaintComments C

    INNER JOIN Users U
        ON C.UserId = U.Id

    WHERE C.Id = @Id;
END;
GO

/* =========================================
   Comments - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Comments_Update]
    @Id INT,
    @Comment NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintComments
    SET Comment = @Comment
    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_ComplaintHistory_Create]
    @ComplaintId INT,
    @UserId INT = NULL,
    @Action NVARCHAR(100),
    @OldValue NVARCHAR(500) = NULL,
    @NewValue NVARCHAR(500) = NULL,
    @Description NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO ComplaintHistory
    (
        ComplaintId,
        UserId,
        Action,
        OldValue,
        NewValue,
        Description,
        CreatedAt
    )
    VALUES
    (
        @ComplaintId,
        @UserId,
        @Action,
        @OldValue,
        @NewValue,
        @Description,
        GETDATE()
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_ComplaintHistory_GetByComplaintId]
    @ComplaintId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        ComplaintId,
        UserId,
        Action,
        OldValue,
        NewValue,
        Description,
        CreatedAt
    FROM ComplaintHistory
    WHERE ComplaintId = @ComplaintId
    ORDER BY CreatedAt DESC, Id DESC;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_ComplaintHistory_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Id,
        ComplaintId,
        UserId,
        Action,
        OldValue,
        NewValue,
        Description,
        CreatedAt
    FROM ComplaintHistory
    WHERE Id = @Id;
END;
GO

/* =========================================
   Complaints - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Complaints_Create]
    @UserId INT,
    @CategoryId INT,
    @DepartmentId INT = NULL,
    @StatusId INT,
    @PriorityId INT,
    @Title NVARCHAR(200),
    @Description NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO Complaints
    (
        UserId,
        CategoryId,
        DepartmentId,
        StatusId,
        PriorityId,
        Title,
        Description
    )
    VALUES
    (
        @UserId,
        @CategoryId,
        @DepartmentId,
        @StatusId,
        @PriorityId,
        @Title,
        @Description
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Complaints_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Complaints
    SET
        IsDeleted = 1,
        UpdatedAt = GETUTCDATE()
    WHERE Id = @Id;
END;
GO

/* =========================================
   Complaints - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Complaints_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        C.Id,
        C.Title,
        C.Description,

        C.UserId,
        U.Name AS UserName,

        C.CategoryId,
        CAT.Name AS CategoryName,

        C.DepartmentId,
        D.Name AS DepartmentName,

        C.StatusId,
        S.Name AS StatusName,

        C.PriorityId,
        P.Name AS PriorityName,

        C.CreatedAt,
        C.UpdatedAt,
        C.ResolvedAt,
        C.ClosedAt

    FROM Complaints C

    INNER JOIN Users U
        ON C.UserId = U.Id

    INNER JOIN ComplaintCategories CAT
        ON C.CategoryId = CAT.Id

    LEFT JOIN Departments D
        ON C.DepartmentId = D.Id

    INNER JOIN ComplaintStatuses S
        ON C.StatusId = S.Id

    INNER JOIN Priorities P
        ON C.PriorityId = P.Id

    ORDER BY C.CreatedAt DESC;
END;
GO

/* =========================================
   Complaints - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Complaints_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        C.Id,
        C.Title,
        C.Description,

        C.UserId,
        U.Name AS UserName,

        C.CategoryId,
        CAT.Name AS CategoryName,

        C.DepartmentId,
        D.Name AS DepartmentName,

        C.StatusId,
        S.Name AS StatusName,

        C.PriorityId,
        P.Name AS PriorityName,

        C.CreatedAt,
        C.UpdatedAt,
        C.ResolvedAt,
        C.ClosedAt

    FROM Complaints C

    INNER JOIN Users U
        ON C.UserId = U.Id

    INNER JOIN ComplaintCategories CAT
        ON C.CategoryId = CAT.Id

    LEFT JOIN Departments D
        ON C.DepartmentId = D.Id

    INNER JOIN ComplaintStatuses S
        ON C.StatusId = S.Id

    INNER JOIN Priorities P
        ON C.PriorityId = P.Id

    WHERE C.Id = @Id;
END;
GO

/* =========================================
   Complaints - GET BY USER
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Complaints_GetByUser]
    @UserId INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        C.Id,
        C.Title,
        C.Description,

        CAT.Name AS CategoryName,
        D.Name AS DepartmentName,
        S.Name AS StatusName,
        P.Name AS PriorityName,

        C.CreatedAt,
        C.UpdatedAt,
        C.ResolvedAt,
        C.ClosedAt

    FROM Complaints C

    INNER JOIN ComplaintCategories CAT
        ON C.CategoryId = CAT.Id

    LEFT JOIN Departments D
        ON C.DepartmentId = D.Id

    INNER JOIN ComplaintStatuses S
        ON C.StatusId = S.Id

    INNER JOIN Priorities P
        ON C.PriorityId = P.Id

    WHERE C.UserId = @UserId

    ORDER BY C.CreatedAt DESC;
END;
GO

/* =========================================
   Complaints - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Complaints_Update]
    @Id INT,
    @CategoryId INT,
    @DepartmentId INT = NULL,
    @PriorityId INT,
    @Title NVARCHAR(200),
    @Description NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Complaints
    SET
        CategoryId = @CategoryId,
        DepartmentId = @DepartmentId,
        PriorityId = @PriorityId,
        Title = @Title,
        Description = @Description,
        UpdatedAt = GETUTCDATE()

    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Complaints_UpdateStatus]
    @ComplaintId INT,
    @StatusId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT OFF;

    -- 1. Validate target status exists in ComplaintStatuses
    IF NOT EXISTS (SELECT 1 FROM ComplaintStatuses WHERE Id = @StatusId)
    BEGIN
        RETURN 0;
    END

    -- 2. Fetch current status of the complaint
    DECLARE @OldStatusId INT;

    SELECT @OldStatusId = StatusId
    FROM Complaints
    WHERE Id = @ComplaintId AND IsDeleted = 0;

    -- 3. If complaint does not exist, return 0 (not found)
    IF @OldStatusId IS NULL
    BEGIN
        RETURN 0;
    END

    -- 4. If same status, do nothing (prevent fake history entry)
    IF @OldStatusId = @StatusId
    BEGIN
        RETURN 0;
    END

    -- 5. Atomic transaction for update and history log
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Complaints
        SET
            StatusId = @StatusId,
            UpdatedAt = GETUTCDATE(),

            -- ResolvedAt: Set when transitioning to Status 4 (مرفوضة / Resolved), cleared on reopening (1 or 2)
            ResolvedAt =
                CASE
                    WHEN @StatusId = 4
                        THEN ISNULL(ResolvedAt, GETUTCDATE())
                    WHEN @StatusId IN (1, 2)
                        THEN NULL
                    ELSE ResolvedAt
                END,

            -- ClosedAt: Set when transitioning to Status 3 (مغلقة) or 4, cleared on reopening (1 or 2)
            ClosedAt =
                CASE
                    WHEN @StatusId IN (3, 4)
                        THEN ISNULL(ClosedAt, GETUTCDATE())
                    WHEN @StatusId IN (1, 2)
                        THEN NULL
                    ELSE ClosedAt
                END

        WHERE Id = @ComplaintId;

        INSERT INTO ComplaintHistory
        (
            ComplaintId,
            UserId,
            Action,
            OldValue,
            NewValue,
            CreatedAt
        )
        VALUES
        (
            @ComplaintId,
            @UserId,
            'Status Changed',
            CAST(@OldStatusId AS NVARCHAR(50)),
            CAST(@StatusId AS NVARCHAR(50)),
            GETUTCDATE()
        );

        COMMIT TRANSACTION;
        RETURN 1;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Dashboard_ComplaintsByCategory]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        Cg.Id,
        Cg.Name,
        COUNT(C.Id) AS ComplaintCount

    FROM ComplaintCategories Cg

    LEFT JOIN Complaints C
        ON Cg.Id = C.CategoryId

    GROUP BY
        Cg.Id,
        Cg.Name

    ORDER BY
        ComplaintCount DESC;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Dashboard_ComplaintsByDepartment]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        D.Id,
        D.Name,
        COUNT(C.Id) AS ComplaintCount

    FROM Departments D

    LEFT JOIN Complaints C
        ON D.Id = C.DepartmentId

    GROUP BY
        D.Id,
        D.Name

    ORDER BY ComplaintCount DESC;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Dashboard_ComplaintsByPriority]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        P.Id,
        P.Name,
        P.Level,
        COUNT(C.Id) AS ComplaintCount

    FROM Priorities P

    LEFT JOIN Complaints C
        ON P.Id = C.PriorityId

    GROUP BY
        P.Id,
        P.Name,
        P.Level

    ORDER BY
        P.Level DESC;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Dashboard_ComplaintsByStatus]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        S.Id AS StatusId,
        S.Name AS StatusName,
        COUNT(C.Id) AS ComplaintCount

    FROM ComplaintStatuses S

    LEFT JOIN Complaints C
        ON S.Id = C.StatusId

    GROUP BY
        S.Id,
        S.Name

    ORDER BY S.Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Dashboard_Summary]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        ISNULL(COUNT(*), 0) AS TotalComplaints,

        ISNULL(SUM(CASE
            WHEN C.StatusId = 1 OR S.Name IN ('Pending', 'New', N'جديدة', N'معلقة')
            THEN 1 ELSE 0
        END), 0) AS PendingComplaints,

        ISNULL(SUM(CASE
            WHEN C.StatusId = 2 OR S.Name IN ('In Progress', 'InProgress', N'قيد المعالجة')
            THEN 1 ELSE 0
        END), 0) AS InProgressComplaints,

        ISNULL(SUM(CASE
            WHEN C.StatusId = 4 OR S.Name IN ('Resolved', 'Rejected', N'محلولة', N'مرفوضة')
            THEN 1 ELSE 0
        END), 0) AS ResolvedComplaints,

        ISNULL(SUM(CASE
            WHEN C.StatusId = 3 OR S.Name IN ('Closed', N'مغلقة')
            THEN 1 ELSE 0
        END), 0) AS ClosedComplaints

    FROM Complaints C
    INNER JOIN ComplaintStatuses S
        ON C.StatusId = S.Id;
END;
GO

/* =========================================
   Departments - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Departments_Create]
    @Name NVARCHAR(100),
    @Description NVARCHAR(500) = NULL
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO Departments
    (
        Name,
        Description
    )
    VALUES
    (
        @Name,
        @Description
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/* =========================================
   Departments - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Departments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Departments
    WHERE Id = @Id;
END;
GO

/* =========================================
   Departments - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Departments_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name,
        Description,
        IsActive
    FROM Departments
    ORDER BY Id DESC;
END;
GO

/* =========================================
   Departments - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Departments_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name,
        Description,
        IsActive
    FROM Departments
    WHERE Id = @Id;
END;
GO

/* =========================================
   Departments - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Departments_Update]
    @Id INT,
    @Name NVARCHAR(100),
    @Description NVARCHAR(500),
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Departments
    SET
        Name = @Name,
        Description = @Description,
        IsActive = @IsActive
    WHERE Id = @Id;
END;
GO

/* =========================================
   Feedback - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Feedback_Create]
    @ComplaintId INT,
    @UserId INT,
    @Rating INT,
    @Comment NVARCHAR(1000) = NULL
AS
BEGIN
    SET NOCOUNT off;

    IF @Rating < 1 OR @Rating > 5
    BEGIN
        THROW 50001, 'Rating must be between 1 and 5.', 1;
    END;

    INSERT INTO ComplaintFeedback
    (
        ComplaintId,
        UserId,
        Rating,
        Comment
    )
    VALUES
    (
        @ComplaintId,
        @UserId,
        @Rating,
        @Comment
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/* =========================================
   Feedback - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Feedback_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintFeedback
    WHERE Id = @Id;
END;
GO

/* =========================================
   Feedback - GET BY COMPLAINT
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Feedback_GetByComplaint]
    @ComplaintId INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        F.Id,
        F.ComplaintId,
        F.UserId,
        U.Name AS UserName,
        F.Rating,
        F.Comment,
        F.CreatedAt

    FROM ComplaintFeedback F

    INNER JOIN Users U
        ON F.UserId = U.Id

    WHERE F.ComplaintId = @ComplaintId;
END;
GO

/* =========================================
   Feedback - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Feedback_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        F.Id,
        F.ComplaintId,
        F.UserId,
        U.Name AS UserName,
        F.Rating,
        F.Comment,
        F.CreatedAt

    FROM ComplaintFeedback F

    INNER JOIN Users U
        ON F.UserId = U.Id

    WHERE F.Id = @Id;
END;
GO

/* =========================================
   Feedback - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Feedback_Update]
    @Id INT,
    @Rating INT,
    @Comment NVARCHAR(1000)
AS
BEGIN
    SET NOCOUNT off;

    IF @Rating < 1 OR @Rating > 5
    BEGIN
        THROW 50002, 'Rating must be between 1 and 5.', 1;
    END;

    UPDATE ComplaintFeedback
    SET
        Rating = @Rating,
        Comment = @Comment
    WHERE Id = @Id;
END;
GO

/* =========================================
   History - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_History_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintHistory
    WHERE Id = @Id;
END;
GO

/* =========================================
   History - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_History_Update]
    @Id INT,
    @Action NVARCHAR(100),
    @OldValue NVARCHAR(500),
    @NewValue NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintHistory
    SET
        Action = @Action,
        OldValue = @OldValue,
        NewValue = @NewValue

    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Priorities_Activate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Priorities
    SET IsActive = 1
    WHERE Id = @Id;

   
END;
GO

/* =========================================
   Priorities - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Priorities_Create]
    @Name NVARCHAR(50),
    @Level INT
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO Priorities
    (
        Name,
        Level
    )
    VALUES
    (
        @Name,
        @Level
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Priorities_Deactivate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Priorities
    SET IsActive = 0
    WHERE Id = @Id;

END;
GO

/* =========================================
   Priorities - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Priorities_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Priorities
    WHERE Id = @Id;
END;
GO

/* =========================================
   Priorities - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Priorities_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name,
        Level
    FROM Priorities
    ORDER BY Level;
END;
GO

/* =========================================
   Priorities - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Priorities_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name,
        Level
    FROM Priorities
    WHERE Id = @Id;
END;
GO

/* =========================================
   Priorities - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Priorities_Update]
    @Id INT,
    @Name NVARCHAR(50),
    @Level INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Priorities
    SET
        Name = @Name,
        Level = @Level
    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RefreshTokens_Create]
    @UserId INT,
    @Token NVARCHAR(500),
    @ExpiresAt DATETIME2
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO RefreshTokens
    (
        UserId,
        Token,
        ExpiresAt
    )
    VALUES
    (
        @UserId,
        @Token,
        @ExpiresAt
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RefreshTokens_GetActiveByUser]
    @UserId INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        UserId,
        Token,
        ExpiresAt,
        RevokedAt,
        CreatedAt
    FROM RefreshTokens
    WHERE UserId = @UserId
      AND RevokedAt IS NULL
      AND ExpiresAt > GETUTCDATE()
    ORDER BY CreatedAt DESC;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RefreshTokens_GetByToken]
    @Token NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        UserId,
        Token,
        ExpiresAt,
        RevokedAt,
        CreatedAt
    FROM RefreshTokens
    WHERE Token = @Token;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RefreshTokens_Revoke]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE RefreshTokens
    SET RevokedAt = GETUTCDATE()
    WHERE Id = @Id
      AND RevokedAt IS NULL;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RefreshTokens_RevokeByToken]
    @Token NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT off;

    UPDATE RefreshTokens
    SET RevokedAt = GETUTCDATE()
    WHERE Token = @Token
      AND RevokedAt IS NULL;
END;
GO

/* =========================================
   Roles - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Roles_Create]
    @Name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO Roles (Name)
    VALUES (@Name);

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/* =========================================
   Roles - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Roles_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Roles
    WHERE Id = @Id;
END;
GO

/* =========================================
   Roles - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Roles_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name
    FROM Roles
    ORDER BY Id;
END;
GO

/* =========================================
   Roles - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Roles_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name
    FROM Roles
    WHERE Id = @Id;
END;
GO

/* =========================================
   Roles - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Roles_Update]
    @Id INT,
    @Name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Roles
    SET Name = @Name
    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Statuses_Activate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintStatuses
    SET IsActive = 1
    WHERE Id = @Id;


END;
GO

/* =========================================
   Statuses - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Statuses_Create]
    @Name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO ComplaintStatuses (Name)
    VALUES (@Name);

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Statuses_Deactivate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintStatuses
    SET IsActive = 0
    WHERE Id = @Id;


END;
GO

/* =========================================
   Statuses - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Statuses_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintStatuses
    WHERE Id = @Id;
END;
GO

/* =========================================
   Statuses - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Statuses_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        Id,
        Name
    FROM ComplaintStatuses
    ORDER BY Id;
END;
GO

/* =========================================
   Statuses - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Statuses_GetById]
    @Id INT
AS
BEGIN
   SET NOCOUNT off;

    SELECT
        Id,
        Name
    FROM ComplaintStatuses
    WHERE Id = @Id;
END;
GO

/* =========================================
   Statuses - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Statuses_Update]
    @Id INT,
    @Name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintStatuses
    SET Name = @Name
    WHERE Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_Activate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Users
    SET IsActive = 1
    WHERE Id = @Id
      AND IsActive = 0;

    SELECT @@ROWCOUNT AS RowsAffected;
END;
GO

/* =========================================
   Users - CREATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_Create]
    @Name NVARCHAR(100),
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(500),
    @Phone NVARCHAR(30) = NULL,
    @RoleId INT
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO Users
    (
        Name,
        Email,
        PasswordHash,
        Phone,
        RoleId
    )
    VALUES
    (
        @Name,
        @Email,
        @PasswordHash,
        @Phone,
        @RoleId
    );

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_Deactivate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Users
    SET IsActive = 0
    WHERE Id = @Id
      AND IsActive = 1;

    SELECT @@ROWCOUNT AS RowsAffected;
END;
GO

/* =========================================
   Users - DELETE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Users
    WHERE Id = @Id;
END;
GO

/* =========================================
   Users - GET ALL
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_GetAll]
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        U.Id,
        U.Name,
        U.Email,
        U.Phone,
        U.RoleId,
        R.Name AS RoleName,
        U.IsActive,
        U.CreatedAt
    FROM Users U
    INNER JOIN Roles R
        ON U.RoleId = R.Id
    ORDER BY U.Id DESC;
END;
GO

/* =========================================
   Users - GET BY EMAIL
   Useful for Login
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_GetByEmail]
    @Email NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        U.Id,
        U.Name,
        U.Email,
        U.PasswordHash,
        U.Phone,
        U.RoleId,
        R.Name AS RoleName,
        U.IsActive,
        U.CreatedAt
    FROM Users U
    INNER JOIN Roles R
        ON U.RoleId = R.Id
    WHERE U.Email = @Email;
END;
GO

/* =========================================
   Users - GET BY ID
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_GetById]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    SELECT
        U.Id,
        U.Name,
        U.Email,
        U.Phone,
        U.RoleId,
        R.Name AS RoleName,
        U.IsActive,
        U.CreatedAt
    FROM Users U
    INNER JOIN Roles R
        ON U.RoleId = R.Id
    WHERE U.Id = @Id;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_PutDepartment]
    @Id INT,
    @DepID int
AS
BEGIN
    SET NOCOUNT OFF;

    UPDATE Users
    SET
        DepartmentID=@DepID
    WHERE Id = @Id;
END;
GO

/* =========================================
   Users - UPDATE
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_Update]
    @Id INT,
    @Name NVARCHAR(100),
    @Email NVARCHAR(255),
    @Phone NVARCHAR(30),
    @RoleId INT,
    @IsActive BIT
AS
BEGIN
    SET NOCOUNT OFF;

    UPDATE Users
    SET
        Name = @Name,
        Email = @Email,
        Phone = @Phone,
        RoleId = @RoleId,
        IsActive = @IsActive
    WHERE Id = @Id;
END;
GO

/* =========================================
   Users - UPDATE PASSWORD
   ========================================= */

CREATE OR ALTER PROCEDURE [dbo].[sp_Users_UpdatePassword]
    @Id INT,
    @PasswordHash NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT OFF;

    UPDATE Users
    SET PasswordHash = @PasswordHash
    WHERE Id = @Id;
END;
GO

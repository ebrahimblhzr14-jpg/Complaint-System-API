CREATE TABLE [dbo].[ComplaintAssignments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[AssignedToUserId] [int] NOT NULL,
	[AssignedByUserId] [int] NOT NULL,
	[AssignedAt] [datetime2](7) NOT NULL,
	[UnassignedAt] [datetime2](7) NULL,
	[Notes] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ComplaintAttachments]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ComplaintAttachments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[UploadedByUserId] [int] NOT NULL,
	[FileName] [nvarchar](255) NOT NULL,
	[FilePath] [nvarchar](500) NOT NULL,
	[FileType] [nvarchar](100) NULL,
	[FileSize] [bigint] NULL,
	[UploadedAt] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ComplaintCategories]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ComplaintCategories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ComplaintComments]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ComplaintComments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Comment] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ComplaintFeedback]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ComplaintFeedback](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Comment] [nvarchar](1000) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ComplaintHistory]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ComplaintHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ComplaintId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[Action] [nvarchar](100) NOT NULL,
	[OldValue] [nvarchar](500) NULL,
	[NewValue] [nvarchar](500) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[Description] [nvarchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Complaints]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Complaints](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CategoryId] [int] NOT NULL,
	[DepartmentId] [int] NULL,
	[StatusId] [int] NOT NULL,
	[PriorityId] [int] NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[ResolvedAt] [datetime2](7) NULL,
	[ClosedAt] [datetime2](7) NULL,
	[IsDeleted] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  Table [dbo].[ComplaintStatuses]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ComplaintStatuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Departments]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Departments](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Priorities]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Priorities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Level] [int] NOT NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Level] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[RefreshTokens]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RefreshTokens](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[Token] [nvarchar](500) NOT NULL,
	[ExpiresAt] [datetime2](7) NOT NULL,
	[RevokedAt] [datetime2](7) NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Roles]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Users]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[PasswordHash] [nvarchar](500) NOT NULL,
	[Phone] [nvarchar](30) NULL,
	[RoleId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[DepartmentID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_PADDING ON
GO

/****** Object:  Index [IX_RefreshTokens_Token]    Script Date: 06/11/2026 4:10:48 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_RefreshTokens_Token] ON [dbo].[RefreshTokens]
(
	[Token] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ComplaintAssignments] ADD  DEFAULT (getutcdate()) FOR [AssignedAt]
GO

ALTER TABLE [dbo].[ComplaintAttachments] ADD  DEFAULT (getutcdate()) FOR [UploadedAt]
GO

ALTER TABLE [dbo].[ComplaintCategories] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[ComplaintComments] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[ComplaintFeedback] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[ComplaintHistory] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Complaints] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Complaints] ADD  DEFAULT ((0)) FOR [IsDeleted]
GO

ALTER TABLE [dbo].[Departments] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[RefreshTokens] ADD  CONSTRAINT [DF_RefreshTokens_CreatedAt]  DEFAULT (getutcdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dbo].[Users] ADD  DEFAULT (getutcdate()) FOR [CreatedAt]
GO

ALTER TABLE [dbo].[ComplaintAssignments]  WITH CHECK ADD  CONSTRAINT [FK_Assignments_AssignedBy] FOREIGN KEY([AssignedByUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[ComplaintAssignments] CHECK CONSTRAINT [FK_Assignments_AssignedBy]
GO

ALTER TABLE [dbo].[ComplaintAssignments]  WITH CHECK ADD  CONSTRAINT [FK_Assignments_AssignedTo] FOREIGN KEY([AssignedToUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[ComplaintAssignments] CHECK CONSTRAINT [FK_Assignments_AssignedTo]
GO

ALTER TABLE [dbo].[ComplaintAssignments]  WITH CHECK ADD  CONSTRAINT [FK_Assignments_Complaints] FOREIGN KEY([ComplaintId])
REFERENCES [dbo].[Complaints] ([Id])
GO

ALTER TABLE [dbo].[ComplaintAssignments] CHECK CONSTRAINT [FK_Assignments_Complaints]
GO

ALTER TABLE [dbo].[ComplaintAttachments]  WITH CHECK ADD  CONSTRAINT [FK_Attachments_Complaints] FOREIGN KEY([ComplaintId])
REFERENCES [dbo].[Complaints] ([Id])
GO

ALTER TABLE [dbo].[ComplaintAttachments] CHECK CONSTRAINT [FK_Attachments_Complaints]
GO

ALTER TABLE [dbo].[ComplaintAttachments]  WITH CHECK ADD  CONSTRAINT [FK_Attachments_Users] FOREIGN KEY([UploadedByUserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[ComplaintAttachments] CHECK CONSTRAINT [FK_Attachments_Users]
GO

ALTER TABLE [dbo].[ComplaintComments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Complaints] FOREIGN KEY([ComplaintId])
REFERENCES [dbo].[Complaints] ([Id])
GO

ALTER TABLE [dbo].[ComplaintComments] CHECK CONSTRAINT [FK_Comments_Complaints]
GO

ALTER TABLE [dbo].[ComplaintComments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[ComplaintComments] CHECK CONSTRAINT [FK_Comments_Users]
GO

ALTER TABLE [dbo].[ComplaintFeedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Complaints] FOREIGN KEY([ComplaintId])
REFERENCES [dbo].[Complaints] ([Id])
GO

ALTER TABLE [dbo].[ComplaintFeedback] CHECK CONSTRAINT [FK_Feedback_Complaints]
GO

ALTER TABLE [dbo].[ComplaintFeedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[ComplaintFeedback] CHECK CONSTRAINT [FK_Feedback_Users]
GO

ALTER TABLE [dbo].[ComplaintHistory]  WITH CHECK ADD  CONSTRAINT [FK_History_Complaints] FOREIGN KEY([ComplaintId])
REFERENCES [dbo].[Complaints] ([Id])
GO

ALTER TABLE [dbo].[ComplaintHistory] CHECK CONSTRAINT [FK_History_Complaints]
GO

ALTER TABLE [dbo].[ComplaintHistory]  WITH CHECK ADD  CONSTRAINT [FK_History_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[ComplaintHistory] CHECK CONSTRAINT [FK_History_Users]
GO

ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaints_Categories] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[ComplaintCategories] ([Id])
GO

ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaints_Categories]
GO

ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaints_Departments] FOREIGN KEY([DepartmentId])
REFERENCES [dbo].[Departments] ([Id])
GO

ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaints_Departments]
GO

ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaints_Priorities] FOREIGN KEY([PriorityId])
REFERENCES [dbo].[Priorities] ([Id])
GO

ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaints_Priorities]
GO

ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaints_Statuses] FOREIGN KEY([StatusId])
REFERENCES [dbo].[ComplaintStatuses] ([Id])
GO

ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaints_Statuses]
GO

ALTER TABLE [dbo].[Complaints]  WITH CHECK ADD  CONSTRAINT [FK_Complaints_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[Complaints] CHECK CONSTRAINT [FK_Complaints_Users]
GO

ALTER TABLE [dbo].[RefreshTokens]  WITH CHECK ADD  CONSTRAINT [FK_RefreshTokens_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO

ALTER TABLE [dbo].[RefreshTokens] CHECK CONSTRAINT [FK_RefreshTokens_Users]
GO

ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Departments] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([Id])
GO

ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Departments]
GO

ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO

ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO

ALTER TABLE [dbo].[ComplaintFeedback]  WITH CHECK ADD  CONSTRAINT [CK_Feedback_Rating] CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO

ALTER TABLE [dbo].[ComplaintFeedback] CHECK CONSTRAINT [CK_Feedback_Rating]
GO

/****** Object:  StoredProcedure [dbo].[sp_Assignments_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Assignment - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Assignments_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Assignments_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Assignment - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Assignments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintAssignments
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Assignments_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Assignment - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Assignments_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Assignments_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Assignment - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Assignments_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Assignments_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Assignment - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Assignments_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Attachments_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Attachments - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Attachments_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Attachments_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Attachments - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Attachments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintAttachments
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Attachments_GetByComplaint]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Attachments - GET BY COMPLAINT
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Attachments_GetByComplaint]
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

/****** Object:  StoredProcedure [dbo].[sp_Attachments_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Attachments - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Attachments_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Attachments_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Attachments - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Attachments_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Categories_Activate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Categories_Activate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintCategories
    SET IsActive = 1
    WHERE Id = @Id;

   
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Categories_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Categories - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Categories_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Categories_Deactivate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Categories_Deactivate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintCategories
    SET IsActive = 0
    WHERE Id = @Id;

    
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Categories_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Categories - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Categories_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintCategories
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Categories_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Categories - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Categories_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Categories_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Categories - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Categories_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Categories_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Categories - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Categories_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Comments_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Comments - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Comments_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Comments_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Comments - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Comments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintComments
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Comments_GetByComplaint]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Comments - GET BY COMPLAINT
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Comments_GetByComplaint]
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

/****** Object:  StoredProcedure [dbo].[sp_Comments_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Comments - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Comments_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Comments_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Comments - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Comments_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_ComplaintHistory_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_ComplaintHistory_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_ComplaintHistory_GetByComplaintId]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_ComplaintHistory_GetByComplaintId]
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

/****** Object:  StoredProcedure [dbo].[sp_ComplaintHistory_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_ComplaintHistory_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Complaints_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Complaints - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Complaints_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Complaints_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Complaints_Delete]
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

/****** Object:  StoredProcedure [dbo].[sp_Complaints_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Complaints - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Complaints_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Complaints_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Complaints - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Complaints_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Complaints_GetByUser]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Complaints - GET BY USER
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Complaints_GetByUser]
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

/****** Object:  StoredProcedure [dbo].[sp_Complaints_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Complaints - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Complaints_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Complaints_UpdateStatus]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Complaints_UpdateStatus]
    @ComplaintId INT,
    @StatusId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT off;

    DECLARE @OldStatusId INT;

    SELECT @OldStatusId = StatusId
    FROM Complaints
    WHERE Id = @ComplaintId;

    UPDATE Complaints
    SET
        StatusId = @StatusId,
        UpdatedAt = GETUTCDATE(),

        ResolvedAt =
            CASE
                WHEN @StatusId = 4
                    THEN GETUTCDATE()
                ELSE ResolvedAt
            END,

        ClosedAt =
            CASE
                WHEN @StatusId = 5
                    THEN GETUTCDATE()
                ELSE ClosedAt
            END

    WHERE Id = @ComplaintId;

    INSERT INTO ComplaintHistory
    (
        ComplaintId,
        UserId,
        Action,
        OldValue,
        NewValue
    )
    VALUES
    (
        @ComplaintId,
        @UserId,
        'Status Changed',
        CAST(@OldStatusId AS NVARCHAR(50)),
        CAST(@StatusId AS NVARCHAR(50))
    );
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Dashboard_ComplaintsByCategory]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Dashboard_ComplaintsByCategory]
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

/****** Object:  StoredProcedure [dbo].[sp_Dashboard_ComplaintsByDepartment]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Dashboard_ComplaintsByDepartment]
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

/****** Object:  StoredProcedure [dbo].[sp_Dashboard_ComplaintsByPriority]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Dashboard_ComplaintsByPriority]
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

/****** Object:  StoredProcedure [dbo].[sp_Dashboard_ComplaintsByStatus]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Dashboard_ComplaintsByStatus]
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

/****** Object:  StoredProcedure [dbo].[sp_Dashboard_Summary]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Dashboard_Summary]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        COUNT(*) AS TotalComplaints,

        SUM(CASE
            WHEN S.Name = 'Pending'
            THEN 1 ELSE 0
        END) AS PendingComplaints,

        SUM(CASE
            WHEN S.Name = 'In Progress'
            THEN 1 ELSE 0
        END) AS InProgressComplaints,

        SUM(CASE
            WHEN S.Name = 'Resolved'
            THEN 1 ELSE 0
        END) AS ResolvedComplaints,

        SUM(CASE
            WHEN S.Name = 'Closed'
            THEN 1 ELSE 0
        END) AS ClosedComplaints

    FROM Complaints C

    INNER JOIN ComplaintStatuses S
        ON C.StatusId = S.Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Departments_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Departments - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Departments_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Departments_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Departments - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Departments_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Departments
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Departments_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Departments - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Departments_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Departments_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Departments - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Departments_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Departments_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Departments - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Departments_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Feedback_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Feedback - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Feedback_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Feedback_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Feedback - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Feedback_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintFeedback
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Feedback_GetByComplaint]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Feedback - GET BY COMPLAINT
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Feedback_GetByComplaint]
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

/****** Object:  StoredProcedure [dbo].[sp_Feedback_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Feedback - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Feedback_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Feedback_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Feedback - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Feedback_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_History_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   History - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_History_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintHistory
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_History_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   History - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_History_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Priorities_Activate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Priorities_Activate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Priorities
    SET IsActive = 1
    WHERE Id = @Id;

   
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Priorities_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Priorities - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Priorities_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Priorities_Deactivate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Priorities_Deactivate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE Priorities
    SET IsActive = 0
    WHERE Id = @Id;

END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Priorities_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Priorities - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Priorities_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Priorities
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Priorities_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Priorities - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Priorities_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Priorities_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Priorities - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Priorities_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Priorities_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Priorities - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Priorities_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_RefreshTokens_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_RefreshTokens_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_RefreshTokens_GetActiveByUser]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_RefreshTokens_GetActiveByUser]
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

/****** Object:  StoredProcedure [dbo].[sp_RefreshTokens_GetByToken]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_RefreshTokens_GetByToken]
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

/****** Object:  StoredProcedure [dbo].[sp_RefreshTokens_Revoke]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_RefreshTokens_Revoke]
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

/****** Object:  StoredProcedure [dbo].[sp_RefreshTokens_RevokeByToken]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_RefreshTokens_RevokeByToken]
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

/****** Object:  StoredProcedure [dbo].[sp_Roles_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Roles - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Roles_Create]
    @Name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO Roles (Name)
    VALUES (@Name);

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Roles_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Roles - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Roles_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Roles
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Roles_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Roles - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Roles_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Roles_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Roles - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Roles_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Roles_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Roles - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Roles_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Statuses_Activate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Statuses_Activate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintStatuses
    SET IsActive = 1
    WHERE Id = @Id;


END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Statuses_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Statuses - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Statuses_Create]
    @Name NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT off;

    INSERT INTO ComplaintStatuses (Name)
    VALUES (@Name);

    SELECT CAST(SCOPE_IDENTITY() AS INT) AS Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Statuses_Deactivate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Statuses_Deactivate]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    UPDATE ComplaintStatuses
    SET IsActive = 0
    WHERE Id = @Id;


END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Statuses_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Statuses - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Statuses_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM ComplaintStatuses
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Statuses_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Statuses - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Statuses_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Statuses_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Statuses - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Statuses_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Statuses_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Statuses - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Statuses_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_Activate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Users_Activate]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_Create]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Users - CREATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Users_Create]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_Deactivate]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[sp_Users_Deactivate]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_Delete]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Users - DELETE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Users_Delete]
    @Id INT
AS
BEGIN
    SET NOCOUNT off;

    DELETE FROM Users
    WHERE Id = @Id;
END;
GO

/****** Object:  StoredProcedure [dbo].[sp_Users_GetAll]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Users - GET ALL
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Users_GetAll]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_GetByEmail]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Users - GET BY EMAIL
   Useful for Login
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Users_GetByEmail]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_GetById]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Users - GET BY ID
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Users_GetById]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_PutDepartment]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create  PROCEDURE [dbo].[sp_Users_PutDepartment]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_Update]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Users - UPDATE
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Users_Update]
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

/****** Object:  StoredProcedure [dbo].[sp_Users_UpdatePassword]    Script Date: 06/11/2026 4:10:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =========================================
   Users - UPDATE PASSWORD
   ========================================= */

CREATE   PROCEDURE [dbo].[sp_Users_UpdatePassword]
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

ALTER DATABASE [ComplaintManagementDB] SET  READ_WRITE

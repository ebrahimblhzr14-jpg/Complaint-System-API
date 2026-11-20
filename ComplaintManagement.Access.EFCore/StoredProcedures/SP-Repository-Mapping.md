# خريطة Stored Procedures الحالية

هذه الخريطة مستخرجة من أسماء الإجراءات في ملفات Repositories ومن ملف SQL المرفق. لا تعني أن كل إجراء غير مستخدم غير ضروري؛ هي فقط توضح ما ظهر في الكود الحالي.

### `AssignmentsRepository`

`sp_Assignments_Create`, `sp_Assignments_Delete`, `sp_Assignments_GetAll`, `sp_Assignments_GetById`, `sp_Assignments_Update`

### `AttachmentsRepository`

`sp_Attachments_Create`, `sp_Attachments_Delete`, `sp_Attachments_GetByComplaint`, `sp_Attachments_GetById`, `sp_Attachments_Update`

### `CategoriesRepository`

`sp_Categories_Activate`, `sp_Categories_Create`, `sp_Categories_Deactivate`, `sp_Categories_Delete`, `sp_Categories_GetAll`, `sp_Categories_GetById`, `sp_Categories_Update`

### `CommentsRepository`

`sp_Comments_Create`, `sp_Comments_Delete`, `sp_Comments_GetByComplaint`, `sp_Comments_GetById`, `sp_Comments_Update`

### `ComplaintsRepository`

`sp_Complaints_Create`, `sp_Complaints_Delete`, `sp_Complaints_GetAll`, `sp_Complaints_GetById`, `sp_Complaints_GetByUser`, `sp_Complaints_Update`, `sp_Complaints_UpdateStatus`

### `DashboardRepository`

`sp_Dashboard_ComplaintsByCategory`, `sp_Dashboard_ComplaintsByPriority`, `sp_Dashboard_ComplaintsByStatus`, `sp_Dashboard_Summary`

### `DepartmentsRepository`

`sp_Departments_Create`, `sp_Departments_Delete`, `sp_Departments_GetAll`, `sp_Departments_GetById`, `sp_Departments_Update`

### `FeedbackRepository`

`sp_Feedback_Create`, `sp_Feedback_Delete`, `sp_Feedback_GetByComplaint`, `sp_Feedback_GetById`, `sp_Feedback_Update`

### `HistoryRepository`

`sp_ComplaintHistory_Create`, `sp_ComplaintHistory_GetByComplaintId`, `sp_ComplaintHistory_GetById`

### `PrioritiesRepository`

`sp_Priorities_Activate`, `sp_Priorities_Create`, `sp_Priorities_Deactivate`, `sp_Priorities_Delete`, `sp_Priorities_GetAll`, `sp_Priorities_GetById`, `sp_Priorities_Update`

### `RefreshTokensRepository`

`sp_RefreshTokens_Create`, `sp_RefreshTokens_GetByToken`, `sp_RefreshTokens_Revoke`

### `RolesRepository`

`sp_Roles_Create`, `sp_Roles_Delete`, `sp_Roles_GetAll`, `sp_Roles_GetById`, `sp_Roles_Update`

### `StatusesRepository`

`sp_Statuses_Activate`, `sp_Statuses_Create`, `sp_Statuses_Deactivate`, `sp_Statuses_Delete`, `sp_Statuses_GetAll`, `sp_Statuses_GetById`, `sp_Statuses_Update`

### `UsersRepository`

`sp_Users_Activate`, `sp_Users_Create`, `sp_Users_Deactivate`, `sp_Users_Delete`, `sp_Users_GetAll`, `sp_Users_GetByEmail`, `sp_Users_GetById`, `sp_Users_PutDepartment`, `sp_Users_Update`, `sp_Users_UpdatePassword`

### إجراءات موجودة في SQL ولم تظهر في استدعاءات Repositories الحالية

`sp_Dashboard_ComplaintsByDepartment`, `sp_History_Delete`, `sp_History_Update`, `sp_RefreshTokens_GetActiveByUser`, `sp_RefreshTokens_RevokeByToken`

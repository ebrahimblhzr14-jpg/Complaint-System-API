# Database schema inventory

Source file: `ComplaintsDB_Schema.sql`

- Database name inside source script: `ComplaintManagementDB`
- Tables: 13
- Foreign-key constraints: 19
- Stored procedures: 83
- Procedures referenced by the current 14 repositories: 78
- Procedures not referenced by those repositories: 5
- Views/functions/triggers: none found in the supplied script.

## Tables

- `ComplaintAssignments`
- `ComplaintAttachments`
- `ComplaintCategories`
- `ComplaintComments`
- `ComplaintFeedback`
- `ComplaintHistory`
- `Complaints`
- `ComplaintStatuses`
- `Departments`
- `Priorities`
- `RefreshTokens`
- `Roles`
- `Users`

## Foreign keys

- `ComplaintAssignments.AssignedByUserId` → `Users.Id`
- `ComplaintAssignments.AssignedToUserId` → `Users.Id`
- `ComplaintAssignments.ComplaintId` → `Complaints.Id`
- `ComplaintAssignments.ComplaintId` → `Complaints.Id`
- `ComplaintAttachments.UploadedByUserId` → `Users.Id`
- `ComplaintAttachments.ComplaintId` → `Complaints.Id`
- `ComplaintComments.UserId` → `Users.Id`
- `ComplaintComments.ComplaintId` → `Complaints.Id`
- `ComplaintFeedback.UserId` → `Users.Id`
- `ComplaintFeedback.ComplaintId` → `Complaints.Id`
- `ComplaintHistory.UserId` → `Users.Id`
- `ComplaintHistory.CategoryId` → `ComplaintCategories.Id`
- `Complaints.DepartmentId` → `Departments.Id`
- `Complaints.PriorityId` → `Priorities.Id`
- `Complaints.StatusId` → `ComplaintStatuses.Id`
- `Complaints.UserId` → `Users.Id`
- `Complaints.UserId` → `Users.Id`
- `RefreshTokens.DepartmentID` → `Departments.Id`
- `Users.RoleId` → `Roles.Id`

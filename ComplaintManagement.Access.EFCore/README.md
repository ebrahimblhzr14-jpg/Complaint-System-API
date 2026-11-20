# ComplaintManagement.Access.EFCore (.NET 8)

تم تحويل طبقة الوصول إلى البيانات إلى EF Core 8 مع الإبقاء على Stored Procedures الحالية.

## ما الذي تغير؟
- أضيف `ComplaintDbContext` وكيانات EF Core وتهيئة العلاقات والقيود باستخدام Fluent API.
- تم تحويل Repositories الأربعة عشر إلى الاعتماد على `StoredProcedureExecutor` بدلاً من `SqlConnectionFactory` و`SqlDataReader`.
- تستخدم عمليات القراءة `Database.SqlQueryRaw<T>` في EF Core 8 لإرجاع Models/DTOs غير مسجلة ككيانات.
- تستخدم عمليات التعديل والحذف `Database.ExecuteSqlRawAsync`.
- تمرر كل القيم كـ `SqlParameter`، ولا يتم دمج قيم المستخدم داخل نص SQL.
- تسجيل جميع الـRepositories في `AddComplaintDataAccess`.
- Migration `InitialCreate` تنشئ الجداول والعلاقات والإجراءات المخزنة عند إنشاء قاعدة جديدة.

## تسجيل الخدمات في API
```csharp
builder.Services.AddComplaintDataAccess(
    builder.Configuration.GetConnectionString("DefaultConnection")!);
```

## إنشاء قاعدة جديدة
```powershell
dotnet ef migrations list --project ComplaintManagement.Access.EFCore
 dotnet ef database update --project ComplaintManagement.Access.EFCore
```

يجب أن يكون `DefaultConnection` موجهاً إلى قاعدة جديدة غير موجودة، أو إلى قاعدة فارغة مخصصة لهذا المشروع.

## اعتماد قاعدة موجودة دون إعادة إنشاء الجداول
لا تشغل `Update-Database` على قاعدة الإنتاج الحالية قبل عمل نسخة احتياطية ومراجعة الـschema. الـInitialCreate هنا ليست baseline فارغة تلقائياً؛ يجب إنشاء baseline migration مخصصة (أو تعديل سجل `__EFMigrationsHistory` بعد مقارنة schema بدقة) حتى لا يحاول EF إنشاء الجداول الموجودة.

## ملاحظات مهمة قبل النشر
1. يوجد تعارض في المخطط الأصلي: `ComplaintHistory.UserId` غير قابل لـNULL بينما `sp_ComplaintHistory_Create` يسمح بتمرير NULL. لم أغير المخطط أو الإجراء تلقائياً. يجب حسم السياسة: جعل العمود nullable وإعادة ضبط FK، أو منع NULL في الإجراء.
2. بعض Repositories الأصلية كانت تعتمد على `ExecuteNonQuery` لمعرفة نجاح العملية. تم الحفاظ على السلوك المنطقي عبر عدد الصفوف المتأثرة الذي يعيده `ExecuteSqlRawAsync`. اختبر عمليات التفعيل/التعطيل والحذف على نسخة من قاعدة البيانات؛ بعض الإجراءات التي تحتوي `SELECT @@ROWCOUNT` قد تحتاج استخدام نتيجة الإجراء بدلاً من rows affected إذا اختلفت إعدادات `SET NOCOUNT`.
3. Models الموجودة في `Models` تستخدم لنتائج Stored Procedures وقد تحتوي حقولاً مشتقة مثل `RoleName` و`UserName`. وهي منفصلة عن كيانات EF Core في `Entities`.
4. يجب التحقق من أسماء الأعمدة التي ترجعها كل Stored Procedure ومطابقتها مع خصائص الـModel، خصوصاً نتائج Dashboard وComplaint وAssignment وAttachment.
5. لا أستطيع تأكيد نجاح `dotnet build` أو تنفيذ Migration على SQL Server في هذه البيئة؛ نفّذ الاختبار محلياً على Visual Studio 2022 أو باستخدام .NET 8 SDK.

## التحقق محلياً
```powershell
dotnet restore
dotnet build
```
ثم اختبر كل Repository على قاعدة اختبار مستنسخة، لا على قاعدة الإنتاج مباشرة.

### Existing database (do not recreate tables)
1. Take a full backup.
2. Compare all 13 existing tables, 19 foreign keys, indexes, defaults and column types with `ComplaintDbContext.ConfigureModel` and `ComplaintManagementDB.Schema.sql`.
3. Run `StoredProcedures/Update-StoredProcedures.sql` in the existing database. It updates the 83 procedures without dropping tables or data. It also makes identity return values consistently return an `INT AS Id` for EF Core materialization.
4. Only after the schema comparison succeeds, run `StoredProcedures/Baseline-ExistingDatabase.sql` once. This records `202611060001_InitialCreate` in `__EFMigrationsHistory` without running the table-creation migration.
5. After that, future migrations can be applied normally with `dotnet ef database update`.

**Do not run the baseline script against a different schema or a newly created database.** It does not validate every column and constraint; that comparison is a required manual step.

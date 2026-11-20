using Microsoft.Data.SqlClient;
using System.Data;

namespace ComplaintManagement.Access.EFCore.Infrastructure;

internal static class SqlParameters
{
    public static SqlParameter Int(string name, int value) => new(name, SqlDbType.Int) { Value = value };
    public static SqlParameter NullableInt(string name, int? value) => new(name, SqlDbType.Int) { Value = (object?)value ?? DBNull.Value };
    public static SqlParameter Bit(string name, bool value) => new(name, SqlDbType.Bit) { Value = value };
    public static SqlParameter BigInt(string name, long? value) => new(name, SqlDbType.BigInt) { Value = (object?)value ?? DBNull.Value };
    public static SqlParameter DateTime2(string name, DateTime value) => new(name, SqlDbType.DateTime2) { Value = value };
    public static SqlParameter NullableDateTime2(string name, DateTime? value) => new(name, SqlDbType.DateTime2) { Value = (object?)value ?? DBNull.Value };
    public static SqlParameter NVarChar(string name, string? value, int size = -1) => new(name, SqlDbType.NVarChar, size) { Value = (object?)value ?? DBNull.Value };
}

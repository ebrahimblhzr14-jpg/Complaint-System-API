using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;

namespace ComplaintManagement.Access.EFCore.Infrastructure;

/// <summary>Runs the existing SQL Server stored procedures through EF Core's Database API.</summary>
public sealed class StoredProcedureExecutor
{
    private readonly DbContext _db;
    public StoredProcedureExecutor(DbContext db) => _db = db;

    private static string BuildCommand(string procedureName, SqlParameter[] parameters)
    {
        if (string.IsNullOrWhiteSpace(procedureName) || procedureName.Any(c => !(char.IsLetterOrDigit(c) || c == '_')))
            throw new ArgumentException("Invalid stored procedure name.", nameof(procedureName));
        var args = string.Join(", ", parameters.Select(p => p.ParameterName));
        return args.Length == 0 ? $"EXEC [dbo].[{procedureName}]" : $"EXEC [dbo].[{procedureName}] {args}";
    }

    public async Task<List<T>> QueryAsync<T>(string procedureName, params SqlParameter[] parameters) where T : class
    {
        try
        {
            return await _db.Database.SqlQueryRaw<T>(BuildCommand(procedureName, parameters), parameters.Cast<object>().ToArray()).ToListAsync();
        }
        catch (Exception ex) when (ex is InvalidOperationException || ex is InvalidCastException)
        {
            // Fallback: Read using DbDataReader when stored procedure result set omits columns mapped on the model class or contains type mismatches (e.g. Decimal SCOPE_IDENTITY to Int32)
            return await QueryViaReaderAsync<T>(procedureName, parameters);
        }
    }

    private async Task<List<T>> QueryViaReaderAsync<T>(string procedureName, SqlParameter[] parameters) where T : class
    {
        var conn = _db.Database.GetDbConnection();
        var wasClosed = conn.State == ConnectionState.Closed;
        if (wasClosed)
        {
            await conn.OpenAsync();
        }

        try
        {
            using var cmd = conn.CreateCommand();
            cmd.CommandText = BuildCommand(procedureName, parameters);
            foreach (var p in parameters)
            {
                var clone = cmd.CreateParameter();
                clone.ParameterName = p.ParameterName;
                clone.Value = p.Value ?? DBNull.Value;
                cmd.Parameters.Add(clone);
            }

            using var reader = await cmd.ExecuteReaderAsync();
            var props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance)
                .Where(p => p.CanWrite)
                .ToDictionary(p => p.Name, p => p, StringComparer.OrdinalIgnoreCase);

            var list = new List<T>();
            while (await reader.ReadAsync())
            {
                var item = Activator.CreateInstance<T>();
                for (int i = 0; i < reader.FieldCount; i++)
                {
                    var name = reader.GetName(i);
                    if (props.TryGetValue(name, out var prop) && !reader.IsDBNull(i))
                    {
                        var val = reader.GetValue(i);
                        var targetType = Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType;
                        prop.SetValue(item, Convert.ChangeType(val, targetType));
                    }
                }
                list.Add(item);
            }
            return list;
        }
        finally
        {
            if (wasClosed)
            {
                await conn.CloseAsync();
            }
        }
    }

    public async Task<T?> QuerySingleOrDefaultAsync<T>(string procedureName, params SqlParameter[] parameters) where T : class
    {
        var rows = await QueryAsync<T>(procedureName, parameters);
        return rows.SingleOrDefault();
    }

    public Task<int> ExecuteAsync(string procedureName, params SqlParameter[] parameters)
        => _db.Database.ExecuteSqlRawAsync(BuildCommand(procedureName, parameters), parameters.Cast<object>().ToArray());

    public async Task<int> ExecuteIdAsync(string procedureName, params SqlParameter[] parameters)
    {
        var conn = _db.Database.GetDbConnection();
        var wasClosed = conn.State == ConnectionState.Closed;
        if (wasClosed)
        {
            await conn.OpenAsync();
        }

        try
        {
            using var cmd = conn.CreateCommand();
            cmd.CommandText = BuildCommand(procedureName, parameters);
            foreach (var p in parameters)
            {
                var clone = cmd.CreateParameter();
                clone.ParameterName = p.ParameterName;
                clone.Value = p.Value ?? DBNull.Value;
                cmd.Parameters.Add(clone);
            }

            var scalar = await cmd.ExecuteScalarAsync();
            if (scalar == null || scalar is DBNull)
                return 0;

            return Convert.ToInt32(scalar);
        }
        finally
        {
            if (wasClosed)
            {
                await conn.CloseAsync();
            }
        }
    }

    public sealed class IdResult { public int Id { get; set; } }
}

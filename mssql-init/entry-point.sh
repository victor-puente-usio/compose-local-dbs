
#!/bin/bash
# Start SQL Server in background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to be ready
sleep 30

# Run initialization script
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "$MSSQL_SA_PASSWORD" -i /docker-entrypoint-initdb.d/init.sql

# Keep container running
wait

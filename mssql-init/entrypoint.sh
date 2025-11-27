#!/bin/bash
# ...existing code...
/opt/mssql/bin/sqlservr &

# Wait until SQL Server accepts connections
until /opt/mssql-tools18/bin/sqlcmd -S "tcp:localhost,1433;TrustServerCertificate=yes" -U SA -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; do
  sleep 1
done

# Run initialization script (trust server certificate)
# note: pass the TrustServerCertificate option in the server string
/opt/mssql-tools18/bin/sqlcmd -S "tcp:localhost,1433;TrustServerCertificate=yes" -U SA -P "$MSSQL_SA_PASSWORD" -i /docker-entrypoint-initdb.d/init.sql

wait
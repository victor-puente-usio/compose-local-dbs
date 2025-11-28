
#!/bin/bash
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
echo "***** Waiting for SQL Server to start 10s"
sleep 10

# Wait until SQL Server accepts connections
echo "****** Attemtping to connect"
until /opt/mssql-tools18/bin/sqlcmd -C -S localhost,1433 -U SA -P "$MSSQL_SA_PASSWORD" -Q "SELECT 1" >/dev/null 2>&1; do
  sleep 1
done

echo "***** Connected" 

# Run initialization script
echo "***** Running init script"

/opt/mssql-tools18/bin/sqlcmd -C -S localhost,1433 -U SA -P "$MSSQL_SA_PASSWORD" -i /docker-entrypoint-initdb.d/init.sql 

wait

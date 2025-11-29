
# Used to genereate the new key and cert
openssl req -x509 -nodes -newkey rsa:2048 -subj "/CN=localhost" -keyout ./mssql.key -out ./mssql.pem -days 365
# Used to convert to pfx
openssl pkcs12 -export -out mssql-cert.pfx -inkey ./mssql.key -in ./mssql.pem -certfile ca.crt
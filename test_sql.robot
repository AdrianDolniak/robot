*** Settings ***
Library  DatabaseLibrary

*** Variables ***
${dbapiModuleName}   psycopg2
${dbName}   adi
${dbUsername}   adi
${dbPassword}   adi!
${dbHost}   /var/run/postgresql
${dbPort}   5432

*** Test Cases ***
Verify That Table Exist
    Connecting Database



*** Keywords ***
Connecting Database
    Connect To Database   ${dbapiModuleName}  ${dbName}   ${dbUsername}   ${dbPassword}   ${dbHost}   ${dbPort}

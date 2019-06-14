*** Settings ***
Library  DatabaseLibrary

*** Variables ***
${dbapiModuleName}   psycopg2
${dbName}   MyDatabase
${dbUsername}   adi
${dbPassword}   adi!
${dbHost}   /var/run/postgresql
${dbPort}   5432

*** Test Cases ***
Testing PostgreSQL Database
    [Setup]   Connect
    Check If Table Exists
    Check Row Count
    Check Row In Database
    [Teardown]   Disconnect

*** Keywords ***
Connect
    Connect To Database   ${dbapiModuleName}  ${dbName}   ${dbUsername}   ${dbPassword}   ${dbHost}   ${dbPort}

Disconnect
    Disconnect From Database

Check If Table Exists
    Table Must Exist  numbers

Check Row Count
    Row Count Is Equal To X   SELECT * FROM numbers   5

Check Row In Database
    Check If Exists In Database   SELECT number_id FROM numbers WHERE number=1

*** Settings ***
Library   SSHLibrary

*** Variables ***
${MESSAGE}   Hello world again and again!
${REM_HOST}   localhost
${REM_USERNAME}   adi
${REM_PASSWORD}   adi!

*** Test Cases ***
Print On Screen A Message
    Log To Console  Hello world!

Print On Screen A Message With Keyword
    Print   Hello world again!

Print On Screen A Message With Keyword And Variable
    Print   ${MESSAGE}

Verify Connection With Remote Host
    [Setup]  Open Connection And Log In
    Verify
    [Teardown]  Close Connection

Verify That Number Of Cores Is 4
    [Setup]  Open Connection And Log In
    Processors
    [Teardown]  Close Connection

Verify That I Am Logged On Host
    [Setup]  Open Connection And Log In
    Hostname
    [Teardown]  Close Connection

Verify That There Is Internet Connection
    [Setup]  Open Connection And Log In
    Ping
    [Teardown]  Close Connection

*** Keywords ***
Print
    [Arguments]   ${text}
    Log To Console   ${text}

Open Connection And Log In
    Open Connection   ${REM_HOST}
    Login   ${REM_USERNAME}   ${REM_PASSWORD}

Verify
    ${rc}=   Execute Command   uname -a
    Should Contain   ${rc}   adi-vmware

Processors
    ${rc}=   Execute Command   nproc
    Should Be Equal   ${rc}   4

Hostname
    ${rc}=   Execute Command   hostname
    Should Contain   ${rc}   adi-vmware

Ping
    ${rc}=   Execute Command   ping -c1 8.8.8.8
    Should Contain   ${rc}   1 received
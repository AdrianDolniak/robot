*** Settings ***
Library   SSHLibrary
Library  SeleniumLibrary

*** Variables ***
${MESSAGE}   Hello world again and again!
${REM_HOST}   localhost
${REM_USERNAME}   adi
${REM_PASSWORD}   adi!
${SERVER}   www.wp.pl
${BROWSER}   Firefox
${DELAY}   0
${VALID USER}   testerwsb_t1
${VALID PASSWORD}   adam1234
${LOGIN URL}  https://profil.wp.pl/login.html?zaloguj=poczta
${LOGIN PAGE}   Poczta - Najlepsza Poczta, największe załączniki - WP
${LOGIN XPATH}   //*[@id="login"]
${PASSWORD XPATH}   //*[@id="password"]
${BUTTON}   //*[@id="btnSubmit"]

*** Test Cases ***
Print On Screen A Message
    Log To Console  Hello world!

Print On Screen A Message With Keyword
    Print   Hello world again!

Print On Screen A Message With Keyword And Variable
    Print   ${MESSAGE}

Verify Connection With Remote Host
    Open Connection And Log In
    Verify
    Close Connection

Verify That Number Of Cores Is 4
    Open Connection And Log In
    Processors
    Close Connection

Verify That I Am Logged On Host
    Open Connection And Log In
    Hostname
    Close Connection

Verify That There Is Internet Connection
    Open Connection And Log In
    Ping
    Close Connection

Verify That There Is A Word "Odebrane" On Page
    Open Browser To Login Page
    Wait For DOM
    Input User Name   ${VALID USER}
    Input Password   ${VALID PASSWORD}
    Submit Credentials
    Verify Received
    Take Screenshot
    Close Browser

Invalid Password Logging
    Open Browser To Login Page
    Wait For DOM
    Input User Name   ${VALID USER}
    Input Password   invalid
    Submit Credentials
    Verify Invalid Password
    Take Screenshot
    Close Browser


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

Close Connection
    Close All Connections

Open Browser To Login Page
    Open Browser   ${LOGIN URL}   ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed   ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    ${LOGIN PAGE}

Input User Name
    [Arguments]   ${username}
    Input Text   ${LOGIN XPATH}   ${username}

Input Password
    [Arguments]   ${password}
    Input Text   ${PASSWORD XPATH}   ${password}

Submit Credentials
    Click Button   ${BUTTON}

Verify Received
    Page Should Contain   Odebrane

Verify Invalid Password
    Page Should Contain   Niestety podany login lub hasło jest błędne.

Take Screenshot
    Capture Page Screenshot   filename=seleniumscreenshot-{index}.png

Wait For DOM
    Set Selenium Implicit Wait   10

Close Browser
    Close All Browsers
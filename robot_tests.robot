*** Settings ***
Library   SSHLibrary
Library  SeleniumLibrary

*** Variables ***
${MESSAGE}   Witaj!
${REM_HOST}   localhost
${REM_USERNAME}   adi
${REM_PASSWORD}   adi!
${SERVER}   www.wp.pl
${BROWSER}   Firefox
${DELAY}   0
${VALID USER}   testerwsb_t1
${VALID PASSWORD}   adam1234
${LOGIN URL}  https://profil.wp.pl/login.html?zaloguj=poczta
${LOGIN XPATH}   //*[@id="login"]
${PASSWORD XPATH}   //*[@id="password"]
${BUTTON}   //*[@id="btnSubmit"]

*** Test Cases ***
Print Text On Screen
    Log To Console  Hello world!

Print Text On Screen With Keyword
    Print   Hello world again!

Print Text On Screen With Keyword And Variable
    Print   ${MESSAGE}

Sprawdzenie czy nawiazano polaczenie ze zdalnym komputerem
    Open Connection And Log In
    Verify
    Close Connection

Sprawdzenie czy liczba procesorow jest rowna 4
    Open Connection And Log In
    Processors
    Close Connection

Sprawdzenie cz jestesmy zalogowani na hoscie
    Open Connection And Log In
    Hostname
    Close Connection

Sprawdzenie czy mamy polaczenie z internetem
    Open Connection And Log In
    Ping
    Close Connection

Otwarcie przegladarki i zalogowanie sie na poczte i sprawdzenie odebrane
    Open Browser To Login Page
    Poczekaj
    Input User Name   ${VALID USER}
    Input Password   ${VALID PASSWORD}
    Nacisniecie zaloguj
    Sprawdzenie Odebrane
    Zrzut Ekranu
    Zamkniecie Przegladarki

Otwarcie przegladarki, logowanie "wrong password"
    Open Browser To Login Page
    Poczekaj
    Input User Name   ${VALID USER}
    Input Password   invalid
    Nacisniecie zaloguj
    Sprawdzenie informacji o blednym hasle
    Zrzut Ekranu
    Zamkniecie Przegladarki


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

Input User Name
    [Arguments]   ${username}
    Input Text   ${LOGIN XPATH}   ${username}

Input Password
    [Arguments]   ${password}
    Input Text   ${PASSWORD XPATH}   ${password}

Nacisniecie zaloguj
    Click Button   ${BUTTON}

Sprawdzenie Odebrane
    Page Should Contain   Odebrane

Sprawdzenie informacji o blednym hasle
    Page Should Contain   Niestety podany login lub hasło jest błędne.

Zrzut Ekranu
    Capture Page Screenshot   filename=seleniumscreenshot-{index}.png

Poczekaj
    Set Selenium Implicit Wait   10

Zamkniecie Przegladarki
    Close All Browsers
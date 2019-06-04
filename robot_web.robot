*** Settings ***
Library  SeleniumLibrary

*** Variables ***
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
    Set Screenshot Directory   /home/adi/PycharmProjects/robot/Screenshots
    Capture Page Screenshot   filename=seleniumscreenshot-{index}.png

Wait For DOM
    Set Selenium Implicit Wait   10

Close Browser
    Close All Browsers
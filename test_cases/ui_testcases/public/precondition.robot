*** Settings ***
Resource         ../../../config/beta_setting.robot

*** Variables ***
${BTN_LOGIN}         xpath=//a[contains(text(),'Log In')]
${BTN_HOMEPAGE}      xpath=//img[@alt='TECHDesign Logo']
${BTN_AGREE_COOKIE}  xpath=//button[@id='agreeCookie']
${BTN_POPUP_LOGIN}   xpath=//button[contains(.,'LOG IN')]
${BTN_HEADER_USER}   xpath=//i[@id='headerUser']
${UI_LOGIN}          xpath=//span[contains(.,'Log In')]
${INPUT_ACCOUNT}     xpath=//input[@id='mat-input-0']
${INPUT_PASSWORD}    xpath=//input[@id='mat-input-1']

*** Keywords ***
Open Browser To Page
    Open Browser    ${HOST}    ${BROWSER}
    click button    ${BTN_AGREE_COOKIE}
    wait until element is visible  ${BTN_LOGIN}


Welcome Page Should Be Open
    Title Should Be    Accelerate your hardware development - TECHDesign

Login By
    [Arguments]    ${account}    ${password}
    click element    ${BTN_LOGIN}
    wait until element is visible  ${UI_LOGIN}
    click element    ${INPUT_ACCOUNT}
    input text    ${INPUT_ACCOUNT}    ${account}
    click element    ${INPUT_PASSWORD}
    input password    ${INPUT_PASSWORD}    ${password}
    click element  ${BTN_POPUP_LOGIN}
    wait until element is visible  ${BTN_HEADER_USER}


Click Home Page Button
    click element    ${BTN_HOMEPAGE}

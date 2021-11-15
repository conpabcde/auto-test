*** Settings ***
Resource          ../tdc_host.robot
Library           JSONLibrary
Library           String
Library           Collection

*** Variables ***
${path}           /config/getMenu

*** Test Cases ***
Test case1: Get TDC menu
    ${resp}         menu_get              200
    log to console  ${resp.json()}

*** Keywords ***
menu_get
    [Arguments]     ${expectedStatus}
    ${datas}        Create dictionary
    ${header}       Create dictionary
    ${resp}=        request_get           ${path}     ${datas}     ${expectedStatus}     ${header}
    [Return]        ${resp}


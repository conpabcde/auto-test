*** Settings ***
Resource            ../../../tdc_host.robot
Library             JSONLibrary
Library             String

*** Variables ***
${path}             /config/getMenu

*** Test Cases ***
Get TDC menu
    ${resp}         menu_get  200
    log to console  ${resp.json()}

*** Keywords ***
menu_get
    [Arguments]     ${expectedStatus}
    ${datas}        Create dictionary
    ${header}       Create dictionary
    ${resp}         request_get  ${path}  ${datas}  ${expectedStatus}  ${header}
    [Return]        ${resp}

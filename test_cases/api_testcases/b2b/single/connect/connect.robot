*** Settings ***
Resource            ../../../tdc_b2b_host.robot
Library             JSONLibrary
Library             String

*** Variables ***
${path}             /api/v1/connect
@{itemList}         ReturnCode     msg

*** Test Cases ***
Get connect status 200
    ${resp}         connect_get  200  ${b2b_token}
    log to console  ${resp.json()}
    connect data verify  ${resp.json()}

Get connect status 40101 (Unauthenticated)
    ${resp}         connect_get  401  ${b2b_err_token}
    connect error data verify (unauth)  ${resp.json()}

*** Keywords ***
connect_get
    [Arguments]     ${expectedStatus}  ${token}
    ${datas}        Create dictionary
    ${header}       Create dictionary  Authorization=${token}
    ${resp}=        request_get  ${path}  ${datas}  ${expectedStatus}  ${header}
    [Return]        ${resp}

connect data verify
    [Arguments]     ${content}
    ${ReturnCode}   Get Value From Json  ${content}  $..Code
    ${Message}      Get value From Json  ${content}  $..Message
    ${msg}          Get value From Json  ${content}  $..msg
    #Verify 'ReturnCode' is correct or not
    ${Check}        Get from list  ${ReturnCode}  0
    Run keyword and continue on failure  Should be equal as integers  ${Check}  0
    #Verify 'Message' is correct or not
    ${Check}        Get from list  ${Message}  0
    Run keyword and continue on failure  Should be equal as strings  ${Check}  Success

connect error data verify (unauth)
    [Arguments]     ${content}
    ${ReturnCode}   Get Value From Json  ${content}  $..ReturnCode
    ${Message}      Get value From Json  ${content}  $..msg
    #Verify 'ReturnCode' is correct or not
    ${Check}        Get from list  ${ReturnCode}  0
    Should be equal as integers  ${Check}  40101
    #Verify 'Message' is correct or not
    ${Check}        Get from list  ${Message}  0
    Should be equal as strings  ${Check}  Unauthenticated.

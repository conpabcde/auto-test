*** Settings ***
Resource            ./../../../tdc_b2b_host.robot
Resource            ./../../../../../config/beta_setting.robot
Library             JSONLibrary
Library             String

*** Variables ***
${path}             /api/v1/connect
@{itemList}         ReturnCode     msg

*** Test Cases ***
Test case1: Get connect status 200
    ${resp}         connect_get             200              ${B2B_TOKEN}
    log to console  ${resp.json()}
    connect_data_verify                     ${resp.json()}

Test case2: Get connect status 40101 (Unauthenticated)
    ${resp}         connect_get             401              ${B2B_ERR_TOKEN}
    connect_error_data_verify_(unauth)         ${resp.json()}



*** Keywords ***
connect_get
    [Arguments]     ${expectedStatus}       ${token}
    ${datas}        Create dictionary
    ${header}       Create dictionary       Authorization=${token}
    ${resp}=        request_get             ${path}   ${datas}    ${expectedStatus}    ${header}
    [Return]        ${resp}

connect_data_verify
    [Arguments]     ${content}
    ${ReturnCode}   Get Value From Json     ${content}      $..Code
    ${Message}      Get value From Json     ${content}      $..Message
    ${msg}          Get value From Json     ${content}      $..msg
    #Verify 'ReturnCode' is correct or not
    ${Check}        Get from list           ${ReturnCode}   0
    Run keyword and continue on failure     Should be equal as integers   ${Check}    0
    #Verify 'Message' is correct or not
    ${Check}        Get from list           ${Message}      0
    Run keyword and continue on failure     Should be equal as strings   ${Check}    Success

connect_error_data_verify_(unauth)
    [Arguments]     ${content}
    ${ReturnCode}   Get Value From Json     ${content}      $..ReturnCode
    ${Message}      Get value From Json     ${content}      $..msg
    #Verify 'ReturnCode' is correct or not
    ${Check}        Get from list           ${ReturnCode}   0
    Should be equal as integers             ${Check}        40101
    #Verify 'Message' is correct or not
    ${Check}        Get from list           ${Message}      0
    Should be equal as strings              ${Check}        Unauthenticated.

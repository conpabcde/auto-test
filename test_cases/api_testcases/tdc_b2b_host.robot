*** Settings ***
Resource             ./resources/Public/http_request.robot
Resource             ../../config/beta_setting.robot

*** Variables ***
#${host}              https://b2bapi-beta.techdesignlink.com
#${host}              https://ssr.tdc.com

*** Keywords ***
request_get
    [Arguments]      ${path}    ${datas}    ${expectedStatus}    ${headers}=None    ${cookies}=None
    ${params}=       create dictionary
    ${resp}=         _http_get    ${b2b_host}    ${path}    ${datas}    ${expectedStatus}    ${params}    ${headers}    ${cookies}
    [Return]         ${resp}

*** Keywords ***
request_post
    [Arguments]      ${path}    ${datas}    ${expectedStatus}    ${headers}=None    ${cookies}=None
    ${params}=       create dictionary
    ${resp}=         _http_post   ${b2b_host}    ${path}    ${datas}    ${expectedStatus}    ${params}    ${headers}     ${cookies}
    [Return]         ${resp}

#*** Test Cases ***
#check request get
#    ${header}=      create dictionary      Authorization=${token}
#    ${datas}        create dictionary
#    ${expected_status}    set variable  200
#    ${resp}=        request_get      ${path}     ${datas}     ${expected_status}      ${header}
#    log to console  ${resp.json()}

#check request post
#    ${header}=      create dictionary      Authorization=${token}
#    ${resp}=        request_post      ${path}    ${datas}      ${header}
#    log to console  ${resp.json()}

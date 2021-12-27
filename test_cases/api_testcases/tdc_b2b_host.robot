*** Settings ***
Resource            ./resources/Public/http_request.robot

*** Keywords ***
request_get
    [Arguments]     ${path}  ${datas}  ${expected_status}  ${headers}=None  ${cookies}=None
    ${params}       create dictionary
    ${resp}         _http_get  ${b2b_host}  ${path}  ${datas}  ${expected_status}  ${params}  ${headers}  ${cookies}
    [Return]        ${resp}

*** Keywords ***
request_post
    [Arguments]     ${path}  ${datas}  ${expected_status}  ${headers}=None  ${cookies}=None
    ${params}       create dictionary
    ${resp}         _http_post  ${b2b_host}  ${path}  ${datas}  ${expected_status}  ${params}  ${headers}  ${cookies}
    [Return]        ${resp}

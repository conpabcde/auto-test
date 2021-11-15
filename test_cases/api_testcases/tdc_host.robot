*** Settings ***
Resource            ./resources/Public/http_request.robot

*** Variables ***
${host}            https://beta.techdesignlink.com


*** Keywords ***
request_get
    [Arguments]     ${path}    ${datas}  ${expectedStatus}  ${headers}=None    ${cookies}=None
    ${params}=      create dictionary
    ${resp}=        _http_get    ${host}    ${path}    ${datas}    ${expectedStatus}    ${params}    ${headers}    ${cookies}
    [Return]        ${resp}

*** Keywords ***
request_post
    [Arguments]     ${path}    ${datas}   ${expectedStatus}   ${headers}=None    ${cookies}=None
    ${params}=      create dictionary
    ${resp}=        _http_post   ${host}    ${path}    ${datas}    ${expectedStatus}    ${params}    ${headers}    ${cookies}
    [Return]        ${resp}


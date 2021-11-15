*** Settings ***
Resource            ../../../tdc_host.robot
Resource            ../../../../../config/beta_setting.robot
Documentation       Suite description
Library             String

*** Variables ***
${path}             /sys/login
@{itemList}         ReturnCode     msg
${account}          jojo1@tdc.com
${password}         111111

*** Test Cases ***
Test case1: Login successful
    ${resp}         login                   200    ${account}    ${password}    true    +8
    log to console  ${resp.json()}

*** Keywords ***
login
    [Arguments]     ${expectedStatus}    ${aacount}    ${password}    ${remember}    ${timezone}
    ${datas}        create dictionary    email=${account}    password=${password}    remember=${remember}    timezone=${timezone}
    #${header}       create dictionary
    ${resp}=        request_post         ${path}     ${datas}     ${expectedStatus}     #${header}
    [Return]        ${resp}

connect_post
    [Arguments]     ${expectedStatus}       ${datas}
    ${header}       Create dictionary
    ${resp}         request_post            ${path}   ${datas}    ${expectedStatus}    #${header}
    [Return]        ${resp}

change_data
    [Arguments]     ${datas}
    #append to list  ${result}              ${datas}
    ${result}       convert to string      ${datas}
    ${result}       Replace String         ${result}      '           "
    [Return]        ${result}

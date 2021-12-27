*** Settings ***
Documentation       utility tool for handling data, popular function using.
Library             JSONLibrary
Library             String
Library             DatabaseLibrary

*** Keywords ***
convert data for html router
    [Documentation]  convert the data to json format for post or get api.
    [Arguments]     ${data_str}
    log to console  Start to convert data ${data_str} for html router.
    ${data}         convert to string  ${data_str}
    ${data}         replace string  ${data}  '  "
    log to console  Next step.
    [Return]        ${data}

get database content
    [Documentation]  use the sql syntax to get the database one value
    [Arguments]     ${query_str}
    log to console  Start to get database content ${query_str}.
    connect to database  pymysql  ${db_database}  ${db_username}  ${db_password}  ${db_host}  ${db_port}
    @{result}       query  ${query_str}  False  True
    log to console  Next step.
    [Return]        ${result}

change value to boolean
    [Documentation]  change value to boolean, 1:True ; 0:False
    [Arguments]     ${value}
    log to console  Start to change value to boolean
    ${result}       set variable  ${None}
    ${result}       return from keyword if  ${value}==1  ${True}
    ${result}       return from keyword if  ${value}==0  ${False}
    [Return]        ${result}

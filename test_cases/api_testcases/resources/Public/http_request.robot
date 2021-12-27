*** Settings ***
Library             RequestsLibrary
Library             Collections
Library             String
Resource            ../../../../config/env_config.robot

*** Keywords ***
_http_get
    [Arguments]     ${host}  ${path}  ${datas}  ${expected_status}  ${params}=${EMPTY}  ${headers}=None  ${cookies}=None
    ...  ${timeout}=30
    #set header of request
    ${header_dict}  create dictionary  Content-Type=application/json
    run keyword if  ${headers}==${None}  log to console  not add header
    ...  ELSE  add_header  ${headers}  ${header_dict}
    #set cookie
    ${cookie_dict}  create dictionary
    run keyword if  ${cookies}==${None}  Log  not add cookie
    ...  ELSE  add_cookies  ${cookies}  ${cookie_dict}
    # create session
    create session  tdc  ${host}  timeout=${timeout}  cookies=${cookie_dict}
    # send GET request
    ${resp}         get on session  tdc  ${path}  headers=${header_dict}  params=${params}
    ...  expected_status=${expected_status}
    [Return]        ${resp}

*** Keywords ***
_http_post
    [Arguments]     ${host}  ${path}  ${datas}  ${expected_status}  ${params}=${EMPTY}  ${headers}=None  ${cookies}=None
    ...  ${timeout}=30
    #set header of request
    ${header_dict}  create dictionary  Content-Type=application/json
    run keyword if  ${headers}==${None}  Log to console  not add header
    ...  ELSE  add_header  ${headers}  ${header_dict}
    #set cookies
    ${cookie_dict}  create dictionary
    run keyword if  ${cookies}==${None}  Log  not add cookies
    ...  ELSE  add_cookies  ${cookies}  ${cookie_dict}
    #set session
    create session  tdc  ${host}  timeout=${timeout}  cookies=${cookie_dict}
    #send the request
    log to console  ${datas}
    ${resp}         post on session  tdc  ${path}  data=${datas}  headers=${header_dict}  params=${params}
    ...  expected_status=${expected_status}
    [Return]        ${resp}

*** Keywords ***
add_cookies
    [Arguments]     ${cookies}  ${cookie_dict}
    [Documentation]    *set to handle cookie*
    @{cookie_list}  split string  ${cookies}  ;
    ${cookie_split}  create list
    FOR  ${cookie}  IN  @{cookie_list}
        run keyword if  ${cookie}==${None}  Exit For Loop
        ${cookie_split}  split string  ${cookie}
    END
    set to dictionary  ${cookie_dict}  ${cookie_split}[0]=${cookie_split}[1]

*** Keywords ***
add_header
    [Arguments]     ${dict1}    ${dict2}
    [Documentation]  *iterate dict1, and make dict1 value add in dict2*
    log             add header from user in request
    ${items}        get dictionary items  ${dict1}
    FOR  ${index}  ${key}  ${value}  IN ENUMERATE  @{items}
        set to dictionary  ${dict2}  ${key}=${value}
    END

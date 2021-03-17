*** Settings ***
Library          RequestsLibrary
Library          Collections
Library          String

*** Keywords ***
_Get_Request
    [Arguments]    ${host}    ${path}    ${datas}  ${expected_status}   ${params}=${EMPTY}   ${headers}=None      ${cookies}=None    ${timeout}=30
    #set encoding
    #Evaluate    reload(sys)    sys
    #Evaluate    sys.setdefaultencoding("utf-8")    sys
    #set header of request
    ${header_dict}    Create Dictionary   Content-Type=application/json
    Run keyword if    ${headers}==${None}    log to console    not add header
    ...    ELSE    add_header    ${headers}    ${header_dict}
    #set cookie
    ${cookie_dict}    Create dictionary
    Run keyword if    ${cookies}==${None}    Log    not add cookie
    ...    ELSE    add_cookies    ${cookies}    ${cookie_dict}
    # create session
    Create Session    tdc    ${host}    timeout=${timeout}    cookies=${cookie_dict}
    # send GET request
    ${resp}=     GET On Session  tdc    ${path}     headers=${header_dict}    params=${params}    expected_status=${expected_status}
    [Return]    ${resp}

*** Keywords ***
_Post_Request
    [Arguments]    ${host}    ${path}    ${datas}   ${expected_status}    ${params}=${EMPTY}    ${headers}=None   ${cookies}=None    ${timeout}=30
    #set endcoding
    #Evaluate    reload(sys)    sys
    #Evaluate    sys.setdefaultendcoding("utf-8")    sys
    #set header of request
    ${header_dict}    create dictionary    Content-Type=application/json
    Run keyword if    ${headers}==${None}    Log to console    not add header
    ...    ELSE    add_header    ${headers}    ${header_dict}
    # ...    ELSE      log to console   solo test
    #set cookies
    ${cookie_dict}    create dictionary
    Run keyword if    ${cookies}==${None}    Log     not add cookies
    ...    ELSE    add_cookies    ${cookies}    ${cookie_dict}
    #set session
    Create Session    tdc    ${host}    timeout=${timeout}    cookies=${cookie_dict}
    #send the request
    ${resp}    post on session    tdc    ${path}    data=${datas}    headers=${header_dict}    params=${params}   expected_status=${expected_status}
    [Return]   ${resp}

*** Keywords ***
add_cookies
    [Arguments]    ${cookies}    ${cookiedict}
    [Documentation]    *set to handle cookie*
    @{cookielist}=    Split String    ${cookies}    ;
    ${cookie_split}    create list
    FOR    ${cookie}    IN    @{cookielist}
           Run Keyword If    ${cookie}==${None}    Exit For Loop
           ${cookie_split}=    Split String    ${cookie}    =
    END
    Set To Dictionary   ${cookiedict}    ${cookie_split}[0]=${cookie_split}[1]

*** Keywords ***
add_header
    [Arguments]    ${dict1}    ${dict2}
    [Documentation]   *iterate dict1, and make dict1 value add in dict2*
    Log     add header from user in request
    ${items}   Get Dictionary Items    ${dict1}
    FOR    ${index}    ${key}    ${value}    IN ENUMERATE    @{items}
           Set To Dictionary    ${dict2}    ${key}=${value}
    END

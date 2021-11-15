*** Settings ***
Library          RequestsLibrary
Library          Collections
Library          String
Library          HttpLibrary.HTTP

*** Keywords ***
_http_get
    [Arguments]    ${host}    ${path}    ${datas}  ${expectedStatus}   ${params}=${EMPTY}   ${headers}=None      ${cookies}=None    ${timeout}=30
    #set encoding
    #Evaluate    reload(sys)    sys
    #Evaluate    sys.setdefaultencoding("utf-8")    sys
    #set header of request
    ${headerDict}    Create Dictionary   Content-Type=application/json
    Run keyword if    ${headers}==${None}    log to console    not add header
    ...    ELSE    add_header    ${headers}    ${headerDict}
    #set cookie
    ${cookieDict}    Create dictionary
    Run keyword if    ${cookies}==${None}    Log    not add cookie
    ...    ELSE    add_cookies    ${cookies}    ${cookieDict}
    # create session
    Create Session    tdc    ${host}    timeout=${timeout}    cookies=${cookieDict}
    # send GET request
    ${resp}=     GET On Session  tdc    ${path}     headers=${headerDict}    params=${params}    expected_status=${expectedStatus}
    [Return]    ${resp}

*** Keywords ***
_http_post
    [Arguments]    ${host}    ${path}    ${datas}   ${expectedStatus}    ${params}=${EMPTY}    ${headers}=None   ${cookies}=None    ${timeout}=30
    #set endcoding
    #Evaluate    reload(sys)    sys
    #Evaluate    sys.setdefaultendcoding("utf-8")    sys
    #set header of request
    ${headerDict}    create dictionary    Content-Type=application/json
    Run keyword if    ${headers}==${None}    Log to console    not add header
    ...    ELSE    add_header    ${headers}    ${headerDict}
    # ...    ELSE      log to console   solo test
    #set cookies
    ${cookieDict}    create dictionary
    Run keyword if    ${cookies}==${None}    Log     not add cookies
    ...    ELSE    add_cookies    ${cookies}    ${cookieDict}
    #set session
    Create Session    tdc    ${host}    timeout=${timeout}    cookies=${cookieDict}
    #send the request
    log to console      ${datas}
    ${resp}    post on session    tdc    ${path}    data=${datas}    headers=${headerDict}    params=${params}   expected_status=${expectedStatus}
    [Return]   ${resp}

*** Keywords ***
add_cookies
    [Arguments]    ${cookies}    ${cookiedict}
    [Documentation]    *set to handle cookie*
    @{cookieList}=    Split String    ${cookies}    ;
    ${cookieSplit}    create list
    FOR    ${cookie}    IN    @{cookieList}
           Run Keyword If    ${cookie}==${None}    Exit For Loop
           ${cookieSplit}=    Split String    ${cookie}    =
    END
    Set To Dictionary   ${cookieDict}    ${cookieSplit}[0]=${cookieSplit}[1]

*** Keywords ***
add_header
    [Arguments]    ${dict1}    ${dict2}
    [Documentation]   *iterate dict1, and make dict1 value add in dict2*
    Log     add header from user in request
    ${items}   Get Dictionary Items    ${dict1}
    FOR    ${index}    ${key}    ${value}    IN ENUMERATE    @{items}
           Set To Dictionary    ${dict2}    ${key}=${value}
    END

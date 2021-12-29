*** Settings ***
Resource            tdc_login_keywords.robot

*** Test Cases ***
buyer login successful
    ${resp}         login  200  ${BUYER_ACCOUNT}  ${BUYER_PASSWORD}  true  +8
    @{result}       get database content  SELECT * FROM users WHERE email = '${BUYER_ACCOUNT}'
    ${data}         convert to dictionary  ${result}[0]
    ${resp_check}   generate user data  ${data}[id]  ${BUYER_NAME}  ${BUYER_ACCOUNT}  +8
    should be equal  ${resp_check}  ${resp.json()}

emarket supplier login successful
    ${resp}         login  200  ${WINBOND_ACCOUNT}  ${WINBOND_PASSWORD}  true  +8
    @{result}       get database content  SELECT * FROM users WHERE email = '${WINBOND_ACCOUNT}'
    ${data}         convert to dictionary  ${result}[0]
    ${supplier}     generate designer status  ${WINBOND_ACCOUNT}
    ${resp_check}   generate user data  ${data}[id]  ${WINBOND_NAME}  ${WINBOND_ACCOUNT}  +8  ${supplier}
    should be equal  ${resp_check}  ${resp.json()}

eservice supplier login successful
    ${resp}         login  200  ${NUVOTON_ESERVICE_ACCOUNT}  ${NUVOTON_ESERVICE_PASSWORD}  true  +8
    @{result}       get database content  SELECT * FROM users WHERE email = '${NUVOTON_ESERVICE_ACCOUNT}'
    ${data}         convert to dictionary  ${result}[0]
    ${supplier}     generate designer status  ${NUVOTON_ESERVICE_ACCOUNT}
    ${resp_check}   generate user data  ${data}[id]  ${NUVOTON_ESERVICE_NAME}  ${NUVOTON_ESERVICE_ACCOUNT}
    ...  +8  ${supplier}
    should be equal  ${resp_check}  ${resp.json()}

login without password
    ${resp}         login  400  ${BUYER_ACCOUNT}  ${EMPTY}  true  +8
    ${resp_check}   generate error respond for less data  True  False  True
    should be equal  ${resp_check}  ${resp.json()}

login without account
    ${resp}         login  400  ${EMPTY}  ${BUYER_PASSWORD}  true  +8
    ${resp_check}   generate error respond for less data  False  True  True
    should be equal  ${resp_check}  ${resp.json()}

login with odd account
    ${resp}         login  400  abcde  ${BUYER_PASSWORD}  true  +8
    ${resp_check}   generate error respond for less data  False  True  True
    should be equal  ${resp_check}  ${resp.json()}

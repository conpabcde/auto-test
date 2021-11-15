*** Settings ***
Resource    ../public/precondition.robot

*** Test Cases ***
Login On Homepage
    Open Browser To Page
    login by    ${BUYER_ACCOUNT}    ${BUYER_PASSWORD}
    Welcome Page Should Be Open
    [Teardown]    Close Browser



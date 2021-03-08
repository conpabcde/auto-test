*** Settings ***
Documentation     Robot Framework Exampl
Resource          ../keywords/param.robot


*** Test Cases ***
Valid Page
    Open Browser To Page
    Welcome Page Should Be Open
    [Teardown]    Close Browser


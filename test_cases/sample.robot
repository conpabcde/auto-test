*** Settings ***
Documentation     Robot Framework Exampl
Resource          ../keywords/param.robot


*** Test Cases ***
Valid Page
    Open Browser To tdc Page
    click button  class = "header-btn header-login"
    Welcome Page Should Be Open
    [Teardown]    Close Browser


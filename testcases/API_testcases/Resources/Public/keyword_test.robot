*** Settings ***
Library      Collections
Library      String
*** Keywords ***
test keywords
    [Arguments]  ${string}
    ${list}=   create list
    @{list}=   split string    ${string}     ;
    [Return]  ${list}
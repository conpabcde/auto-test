*** Settings ***
Library      String
Library      Collections
Resource     ./Resources/Public/keyword_test.robot
Documentation     An example about for loops.

*** Variables ***
@{ROBOTS}=        Bender    Johnny5    Terminator    Robocop
${test}  2
${string}   dfjkd;fdfkl;dfff;efewf;
${dict}

*** Test Cases ***
test keywords
    ${result}=    test keywords    ${string}
    log to console     ${result}

Loop Over A List Of Items And Log Each Of Them
    FOR    ${robot}    IN    @{ROBOTS}
        Log to console  ${robot}
    END

Test if else
    run keyword if     ${test} == 3     log to console  this succefully
    ...    ELSE   log to console  this test fail

Test split string
    ${dict}    create dictionary  name=mike    age=20
    @{list}=   Split string   ${string}  ;
    set to dictionary  ${dict}    ${list}[0]=${list}[1]
    log to console  ${dict}

Test set dict
    ${dict}    create dictionary  name=mike    age=20
    ${list}    create list   fff     dddd
    set to dictionary  ${dict}  ${list}[0] = ${list}[1]
    log to console  ${list}
    log to console  ${dict}


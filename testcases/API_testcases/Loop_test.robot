*** Settings ***
Documentation     An example about for loops.

*** Variables ***
@{ROBOTS}=        Bender    Johnny5    Terminator    Robocop

*** Test Cases ***
Loop Over A List Of Items And Log Each Of Them
    FOR    ${robot}    IN    @{ROBOTS}
        Log to console  ${robot}
    END
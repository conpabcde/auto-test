*** Settings ***
Resource          ../config/beta_setting.robot

*** Keywords ***
Open Browser To Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    BuiltIn.Sleep   ${DELAY}

Welcome Page Should Be Open
    Title Should Be    Accelerate your hardware development - TECHDesign
*** Settings ***
Resource               ../config/env_config.robot

*** Keywords ***
Open Browser To Page
    Open Browser       ${HOST}  ${BROWSER}
    BuiltIn.Sleep      ${DELAY}

Welcome Page Should Be Open
    Title Should Be    Accelerate your hardware development - TECHDesign
*** Settings ***
Resource            ../public/precondition.robot

*** Variables ***
${UI_EMARKET_CONTENT}  xpath=//*[@id="components"]

*** Keywords ***
check the page is emarket homepage
    log to console  Start to check the page is eMarket homepage.
    wait until element is visible  ${UI_EMARKET_CONTENT}
    ${current_url}  get location
    log to console  Next step.

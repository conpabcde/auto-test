*** Settings ***
Resource            ../public/precondition.robot

*** Variables ***
${BTN_SHOP_COMPONENTS}  xpath=//button[contains(.,'SHOP COMPONENTS')]
${BTN_START_PROJECT}  xpath=//button[contains(.,'START PROJECT')]


*** Keywords ***
check the page is tdc homepage
    log to console  Start to check the page is tdc homepage.
    wait until element is visible  ${BTN_SHOP_COMPONENTS}
    wait until element is visible  ${BTN_START_PROJECT}
    ${current_url}  get location
    ${homepage_url}  set variable  ${host}/
    should be equal as strings  ${current_url}  ${homepage_url}
    log to console  Next step.

go to emarket homepage
    log to console  Start to go to eMarket homepage.
    click button    ${BTN_SHOP_COMPONENTS}
    log to console  Next step.

go to eservice homepage
    log to console  Start to go to eservice homepage.
    click button    ${BTN_START_PROJECT}
    log to console  Next step.

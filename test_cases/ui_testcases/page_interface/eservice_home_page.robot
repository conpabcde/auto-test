*** Settings ***
Resource            ../public/precondition.robot
Resource            ../meta_data/meta_data.robot

*** Variables ***
${UI_RFQ}           xpath=//*[contains(.,'Electronic Design & Manufacturing')]
${UI_SOLUTION}      xpath=//*[contains(.,'IoT Solution Marketplace')]
${UI_VIEW_SUPPLIER}  xpath=//*[contains(.,'Verified Suppliers')]
${META_DESCRIPTION_ESERVICE_HOMEPAGE}  xpath=//html/head/meta[19]

*** Keywords ***
check the page is eservice homepage
    log to console  Start to check the page is eservice homepage.
    set selenium timeout  10
    wait until element is visible  ${UI_RFQ}
    wait until element is visible  ${UI_SOLUTION}
    wait until element is visible  ${UI_VIEW_SUPPLIER}
    log to console  Next step.

check meta data of eservice homepage
    log to console  Start to check meta data of eservice homepage.
    ${meta_description}   get element attribute  ${META_DESCRIPTION_ESERVICE_HOMEPAGE}  content
    should be equal  ${meta_description}  ${ESERVICE_HOMEPAGE_META_DESCRIPTION}
    log to console  Next step.

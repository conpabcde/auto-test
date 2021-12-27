*** Settings ***
Resource            ../public/precondition.robot
Test Setup          open browser to tdc web
Test Teardown       close browser

*** Test Cases ***
Scenario: Login On Homepage
     When login by  ${BUYER_ACCOUNT}  ${BUYER_PASSWORD}
     Then welcome page should be open

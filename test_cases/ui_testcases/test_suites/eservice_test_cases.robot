*** Settings ***
Resource            ../page_interface/home_page.robot
Resource            ../page_interface/eservice_home_page.robot
Force Tags          eService
Test Setup          open browser to tdc web
Test Teardown       close browser

*** Test Cases ***
Scenario: eservice homepage check title & meta data
    [Tags]  RAT
     When go to eservice homepage
     Then check the page is eservice homepage
      And check meta data of eservice homepage

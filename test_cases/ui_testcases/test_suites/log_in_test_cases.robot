*** Settings ***
Resource            ../public/precondition.robot
Resource            ../page_interface/home_page.robot
Resource            ../page_interface/emarket_home_page.robot
Force Tags          log in
Test Setup          open browser to tdc web
Test Teardown       close browser

*** Variables ***

*** Test Cases ***
Scenario: register new member
    [tags]  RAT
    Given precondition for register  ${SIGN_UP_ACCOUNT}
     When register by  ${SIGN_UP_NAME}  ${SIGN_UP_ACCOUNT}  ${SIGN_UP_PASSWORD}
     Then welcome page should be open
      And check member in database  ${SIGN_UP_ACCOUNT}

Scenario: newsletter subscribe
    [tags]  RAT
    Given precondition for register  ${SIGN_UP_ACCOUNT}
      And precondition for newsletter  ${SIGN_UP_ACCOUNT}
     Then check the page is tdc homepage
     When go to emarket homepage
     Then check the page is emarket homepage
     When sleep  30
     Then check newsletter dialog is showed
     When become newsletter  ${SIGN_UP_ACCOUNT}
     Then check register dialog is showed
     When become member from newsletter  ${SIGN_UP_NAME}  ${SIGN_UP_PASSWORD}
     Then check the page is emarket homepage

Scenario: sign up on sign up page
    [tags]  RAT
    Given precondition for register  ${SIGN_UP_ACCOUNT}
     When redirect to sign up page  ${SIGN_UP_NAME}  ${SIGN_UP_ACCOUNT}
     Then check the page is register page
     When register on register page by  ${SIGN_UP_NAME}  ${SIGN_UP_ACCOUNT}  ${SIGN_UP_PASSWORD}
     Then welcome page should be open
      And check member in database  ${SIGN_UP_ACCOUNT}

Scenario: login on login page
    [tags]  RAT
     When redirect to login page  ${BUYER_ACCOUNT}
     Then check the page is login page
     When login on login page by  ${BUYER_ACCOUNT}  ${BUYER_PASSWORD}
     Then check the page is tdc homepage

*** Settings ***
Resource            ../../../config/env_config.robot
Library             DatabaseLibrary

*** Variables ***
${BTN_LOGIN}        xpath=//a[contains(text(),'Log In')]
${BTN_HOMEPAGE}     xpath=//img[@alt='TECHDesign Logo']
${BTN_AGREE_COOKIE}  xpath=//button[@id='agreeCookie']
${BTN_POPUP_LOGIN}  xpath=//button[contains(.,'LOG IN')]
${BTN_HEADER_USER}  xpath=//i[@id='headerUser']
${UI_LOGIN}         xpath=//span[contains(.,'Log In')]
${INPUT_ACCOUNT}    xpath=//input[@id='mat-input-0']
${INPUT_PASSWORD}   xpath=//input[@id='mat-input-1']
${BTN_SIGN_UP}      xpath=//button[contains(.,'Sign Up')]
${UI_SIGN_UP}       xpath=//span[contains(.,'Sign Up Now.')]
${INPUT_SIGN_UP_NAME}  xpath=//input[@id='mat-input-0']
${INPUT_SIGN_UP_EMAIL}  xpath=//input[@id='mat-input-1']
${INPUT_SIGN_UP_RETYPE_EMAIL}  xpath=//input[@id='mat-input-4']
${INPUT_SIGN_UP_NEW_PASSWORD}  xpath=//input[@id='mat-input-2']
${INPUT_SIGN_UP_RETYPE_PASSWORD}  xpath=//input[@id='mat-input-3']
${CHECK_AGREE_TERM}  xpath=(//input[@type='checkbox'])[2]
${BTN_POPUP_SIGN_UP}  xpath=//button[contains(.,'SIGN UP')]
${BTN_POPUP_OK}     xpath=//button[contains(.,'OK')]
${UI_POPUP_NEWSLETTER}  xpath=//input[@type='text']
${INPUT_NEWSLETTER}  xpath=//input[@type='text']
${CHECK_NEWSLETTER_AGREE}  xpath=//input[@type='checkbox']
${BTN_NEWSLETER_SUBMIT}  xpath=//button[contains(.,'Subscribe')]
${UI_NEWSLETTER_REGISTER}  xpath=//*[contains(@class, 'newsletter-title ng-scope')]
${INPUT_NEWSLETTER_SIGN_UP_NAME}  xpath=//*[@id="input_0"]
${INPUT_NEWSLETTER_SIGN_UP_PASSWORD}  xpath=//*[@id="input_3"]
${INPUT_NEWSLETTER_SIGN_UP_RETYPE_PASSWORD}  xpath=//*[@id="input_4"]
${BTN_NEWSLETTER_SIGN_UP_SUBMIT}  xpath=//button[contains(.,'SIGN UP')]
${UI_SIGN_UP_PAGE}  xpath=//*[contains(@class, 'main-content container-fluid register-page ng-scope')]
${INPUT_SIGN_UP_PAGE_PASSWORD}  xpath=//*[@id="input_3"]
${INPUT_SIGN_UP_PAGE_RETYPE_PASSWORD}  xpath=//*[@id="input_4"]
${CHECK_SIGN_UP_PAGE_AGREE}  xpath=//input[@type='checkbox']
${BTN_SIGN_UP_PAGE_SUBMIT}  xpath=//button[contains(.,'SIGN UP')]
${UI_LOGIN_PAGE}  xpath=//*[contains(@class, 'login-box flex-view')]
${INPUT_LOGIN_PAGE_ACCOUNT}  xpath=//input[contains(@name, 'email')]
${INPUT_LOGIN_PAGE_PASSWORD}  xpath=//input[contains(@type, 'password')]
${BTN_LOGIN_PAGE_SUBMIT}  xpath=//button[contains(.,'LOG IN')]

*** Keywords ***
Open Browser To TDC Web
    Open Browser    ${HOST}  ${BROWSER}
    click button    ${BTN_AGREE_COOKIE}
    Set Window Size  1440  900
    wait until element is visible  ${BTN_LOGIN}

Welcome Page Should Be Open
    Title Should Be  Accelerate your hardware development - TECHDesign

Login By
    [Arguments]     ${account}  ${password}
    click element   ${BTN_LOGIN}
    wait until element is visible  ${UI_LOGIN}
    click element   ${INPUT_ACCOUNT}
    input text      ${INPUT_ACCOUNT}  ${account}
    click element   ${INPUT_PASSWORD}
    input password  ${INPUT_PASSWORD}  ${password}
    click element   ${BTN_POPUP_LOGIN}
    wait until element is visible  ${BTN_HEADER_USER}

click home page button
    click element   ${BTN_HOMEPAGE}

register by
    [Arguments]     ${name}  ${account}  ${password}
    log to console  Start to register by.
    click element   ${BTN_SIGN_UP}
    wait until element is visible  ${UI_SIGN_UP}
    click element   ${INPUT_SIGN_UP_NAME}
    input text      ${INPUT_SIGN_UP_NAME}  ${name}
    click element   ${INPUT_SIGN_UP_EMAIL}
    input text      ${INPUT_SIGN_UP_EMAIL}  ${account}
    click element   ${INPUT_SIGN_UP_RETYPE_EMAIL}
    input text      ${INPUT_SIGN_UP_RETYPE_EMAIL}  ${account}
    click element   ${INPUT_SIGN_UP_NEW_PASSWORD}
    input text      ${INPUT_SIGN_UP_NEW_PASSWORD}  ${password}
    click element   ${INPUT_SIGN_UP_RETYPE_PASSWORD}
    input text      ${INPUT_SIGN_UP_RETYPE_PASSWORD}  ${password}
    scroll element into view  ${CHECK_AGREE_TERM}
    click element   ${CHECK_AGREE_TERM}
    click element   ${BTN_POPUP_SIGN_UP}
    wait until element is visible  ${BTN_POPUP_OK}
    click element   ${BTN_POPUP_OK}
    wait until element is visible  ${BTN_HEADER_USER}
    log to console  Next step.

precondition for register
    [Documentation]  check account exist in users of database, if yes, delete the data.
    [Arguments]     ${account}
    log to console  Start to delete user in database.
    ${query_str}    convert to string  Select * From users where email = "${account}";
    ${delete_str}   convert to string  Delete From users where email = "${account}";
    delete data     ${query_str}  ${delete_str}
    log to console  Next step.

check member in database
    [Arguments]     ${email}
    log to console  Start to find user in database.
    connect to database  pymysql  ${db_database}  ${db_username}  ${db_password}  ${db_host}  ${db_port}
    ${query_str}    convert to string  Select * From users where email = "${email}";
    @{result}       query  ${query_str}
    should not be empty  ${result}  msg=this member is not saved in database
    disconnect from database
    log to console  Next step.

precondition for newsletter
    [Documentation]  check the user exist in newsletter of database, if yes, delete the data.
    [Arguments]     ${email}
    log to console  Start to delete newsletter in database.
    ${query_str}    convert to string  Select * from tdc_newsletter_subscriber where email = "${email}";
    ${delete_str}   convert to string  Delete from tdc_newsletter_subscriber where email = "${email}";
    delete data     ${query_str}  ${delete_str}
    log to console  Next step.

delete data
    [Arguments]     ${query_str}  ${delete_str}
    log to console  Start to delete data.
    connect to database  pymysql  ${db_database}  ${db_username}  ${db_password}  ${db_host}  ${db_port}
    ${result}       query  ${query_str}
    run keyword if  @{result}!=${None}  execute sql string  ${delete_str}
    disconnect from database
    log to console  Complete to delete data.

check newsletter dialog is showed
    log to console  Start to check newsletter dialog is showed.
    element should be visible  ${UI_POPUP_NEWSLETTER}
    element should be visible  ${INPUT_NEWSLETTER}
    log to console  Next step.

become newsletter
    [Arguments]     ${account}
    log to console  Start to become newsletter.
    click element   ${INPUT_NEWSLETTER}
    input text      ${INPUT_NEWSLETTER}  ${account}
    click element   ${CHECK_NEWSLETTER_AGREE}
    click element   ${BTN_NEWSLETER_SUBMIT}
    click button    ${BTN_NEWSLETER_SUBMIT}
    log to console  Next step.

check register dialog is showed
    log to console  Start to check register dialog is showed.
    wait until element is visible  ${UI_NEWSLETTER_REGISTER}
    wait until element is visible  ${INPUT_NEWSLETTER_SIGN_UP_NAME}
    log to console  Next step.

become member from newsletter
    [Arguments]     ${name}  ${password}
    log to console  Start to become member from newsletter.
    input text      ${INPUT_NEWSLETTER_SIGN_UP_NAME}  ${name}
    click element   ${INPUT_NEWSLETTER_SIGN_UP_PASSWORD}
    input text      ${INPUT_NEWSLETTER_SIGN_UP_PASSWORD}  ${password}
    click element   ${INPUT_NEWSLETTER_SIGN_UP_RETYPE_PASSWORD}
    input text      ${INPUT_NEWSLETTER_SIGN_UP_RETYPE_PASSWORD}  ${password}
    click button    ${BTN_NEWSLETTER_SIGN_UP_SUBMIT}
    wait until element is visible  ${BTN_POPUP_OK}
    click button    ${BTN_POPUP_OK}
    wait until element is visible  ${BTN_HEADER_USER}
    log to console  Next step.

redirect to sign up page
    [Arguments]     ${name}  ${account}
    log to console  Start to redirect to sign up page.
    go to           ${host}/user/signup?name=${name}&email=${account}
    log to console  Next step.

check the page is register page
    log to console  Start to check the page is login page.
    wait until element is visible  ${UI_SIGN_UP_PAGE}
    wait until element is visible  ${INPUT_SIGN_UP_PAGE_PASSWORD}
    wait until element is visible  ${INPUT_SIGN_UP_PAGE_RETYPE_PASSWORD}
    log to console  Next step.

register on register page by
    [Arguments]     ${name}  ${account}  ${password}
    log to console  Start to register on register page.
    click element   ${INPUT_SIGN_UP_PAGE_PASSWORD}
    input text      ${INPUT_SIGN_UP_PAGE_PASSWORD}  ${password}
    click element   ${INPUT_SIGN_UP_PAGE_RETYPE_PASSWORD}
    input text      ${INPUT_SIGN_UP_PAGE_RETYPE_PASSWORD}  ${password}
    click element   ${CHECK_SIGN_UP_PAGE_AGREE}
    click button    ${BTN_SIGN_UP_PAGE_SUBMIT}
    wait until element is visible  ${BTN_POPUP_OK}
    click button    ${BTN_POPUP_OK}
    wait until element is visible  ${BTN_HEADER_USER}
    log to console  Next step.

redirect to login page
    [Arguments]     ${account}
    log to console  Start to redirect to login page.
    go to           ${host}/user/login
    log to console  Next step.

check the page is login page
    log to console  Start to check the page is login page.
    wait until element is visible  ${UI_LOGIN_PAGE}
    wait until element is visible  ${INPUT_LOGIN_PAGE_ACCOUNT}
    wait until element is visible  ${INPUT_LOGIN_PAGE_PASSWORD}
    log to console  Next step.

login on login page by
   [Arguments]     ${account}  ${password}
   log to console  Start to login on login by.
   click element   ${INPUT_LOGIN_PAGE_ACCOUNT}
   input text      ${INPUT_LOGIN_PAGE_ACCOUNT}  ${account}
   click element   ${INPUT_LOGIN_PAGE_PASSWORD}
   input text      ${INPUT_LOGIN_PAGE_PASSWORD}  ${password}
   click button    ${BTN_LOGIN_PAGE_SUBMIT}
   wait until element is visible  ${BTN_HEADER_USER}
   log to console  Next step.

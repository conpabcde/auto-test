*** Settings ***
Resource            ../../tdc_b2b_host.robot
Resource            ../../../../config/beta_setting.robot
Library             ../../../../library/soap_API.py
Library             JSONLibrary
Library             String
Library             SoapLibrary

*** Variables ***
${url}              https://solo2dev.techdesign.com/soap/winbond/TDCProductInfoSync
${path}             /soap/winbond/TDCProductInfoSync
*** Test Cases ***
Test case1: Get connect status 200
    ${resp}         get_tdc_product_info_sync
    verify_get_ack  ${resp}

*** Keywords ***
get_tdc_product_info_sync
    ${resp}         Post Soap API           ${url}
    [Return]        ${resp}

verify_get_ack
    [Arguments]     ${check}
    should be equal as strings    ${check}  ACK


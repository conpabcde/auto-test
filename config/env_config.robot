*** Settings ***
Library             Selenium2Library
Library             String
Library             yaml
Variables           ./env_local_data.yaml

*** Variables ***
${DELAY}            5
${SHORT_DELAY}      1
${BUYER_ACCOUNT}    cfli31@techdesign.com
${BUYER_PASSWORD}   111111
${BUYER_NAME}       wesley
${SIGN_UP_ACCOUNT}  register_tester@tdc.com
${SIGN_UP_PASSWORD}  111111
${SIGN_UP_NAME}     tester
${WINBOND_ACCOUNT}  winbond@techdesign.com
${WINBOND_PASSWORD}  111111
${WINBOND_NAME}     winbond
${NUVOTON_ESERVICE_ACCOUNT}  Nuvoton@techdesign.com
${NUVOTON_ESERVICE_PASSWORD}  111111
${NUVOTON_ESERVICE_NAME}     Nuvoton

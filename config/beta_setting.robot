*** Settings ***
Library              Selenium2Library
Library              String
Library              yaml
Variables            ../env_data.yaml

*** Variables ***
${BROWSER}           Chrome
${DELAY}             5
${SHORT_DELAY}       1
${BUYER_ACCOUNT}     jojo1@tdc.com
${BUYER_PASSWORD}    111111

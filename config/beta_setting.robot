*** Settings ***
Library           Selenium2Library
Library           String

*** Variables ***
${LOGIN URL}        https://solodev.tdc.com
${BROWSER}          Chrome
${DELAY}            5
${SHORT_DELAY}      1
${TOKEN}            Bearer
${ERROR_TOKEN}      Bearer
${BUYER_ACCOUNT}    jojo1@tdc.com
${BUYER_PASSWORD}   111111

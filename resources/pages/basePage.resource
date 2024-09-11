*** Settings ***
Resource    ../../configurations/config.resource


*** Keywords ***
Open "${PAGE_URL}" page
    Open Browser    ${BASE_URL}${PAGE_URL}    ${BROWSER}
    Maximize Browser Window

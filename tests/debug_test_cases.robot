*** Settings ***
Resource    ../resources/pages/practiceFormPage.resource


*** Test Cases ***
Verify that user can access Practice Form
    Open Preactice Form page 
    Input First Name with value   Tin
    Input First Name with value   Nguyen
    Select gender value    Other_
    Log    wait for me check result
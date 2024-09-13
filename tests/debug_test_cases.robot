*** Settings ***
Resource    ../resources/pages/practiceFormPage.resource


*** Test Cases ***
Verify that user can access Practice Form
    Open Preactice Form page 
    # Input First Name with value   Tin
    # Input Last Name with value   Nguyen
    # Input Email with value    tin123456@gmail.com
    # Select gender value    Other
    # Input Mobile number with value     0123456789
    Input Date of Birth with value    12 Oct 2024 
    Log    wait for me check result
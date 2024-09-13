*** Settings ***
Resource    ../resources/pages/practiceFormPage.resource
Resource    ../resources/keywords/utils.resource

*** Test Cases ***
Verify that user can access Practice Form
    Open Preactice Form page 
    # Input First Name with value   Tin
    # Input Last Name with value   Nguyen
    # Input Email with value    tin123456@gmail.com
    # Select gender value    Other
    # Input Mobile number with value     0123456789
    # Input Date of Birth with value    21 March 1999
    # Select subjects    Maths,Arts,asdfasd
    # Select Hobbies    Sports,Music
    Select Picture    Picture_1.png
    Log    wait for me check result

# Debug Test
#     Get day    12 September 2024

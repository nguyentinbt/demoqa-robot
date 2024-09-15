*** Settings ***
Resource    ../resources/keywords/utils.resource
Resource    ../resources/pages/practice_form_page.resource

Test Teardown       Test case Teardown

*** Variables ***
${FIRST_NAME}           Tin
${LAST_NAME}            Nguyen
${EMAIL}                DemoQA.testaccount.001@gmail.com
${GENDER}               Male
${PHONE}                0123456789
${DOD}                  21 March,1999
${SUBJECT}              Maths,Arts
${HOBBIES}              Sports,Music
${PICTURE}              Picture_1.png
${ADDRESS}              Calla Garden, Nguyen Van Linh Street, Binh Chanh District, Ho Chi Minh City, Vietnam
${STATE}                NCR
${CITY}                 Noida

*** Test Cases ***
Verify that user can access Practice Form and fullfill all fields with valide data (Data transfer by variables)
    Open Preactice Form page 
    Input First Name with value   ${FIRST_NAME}
    Input Last Name with value   ${LAST_NAME} 
    Input Email with value    ${EMAIL} 
    Select gender value    ${GENDER} 
    Input Mobile number with value     ${PHONE}
    Input Date of Birth with value    ${DOD} 
    Select subjects    ${SUBJECT} 
    Select Hobbies    ${HOBBIES}
    Select Picture    ${PICTURE}  
    Input Current Address with value    ${ADDRESS} 
    Select State    ${STATE}   
    Select City    ${CITY}
    Click on Submit button
    The confirmation popup should be showed
    The confirmation popup should contains values    ${FIRST_NAME},${LAST_NAME},${EMAIL},${GENDER},${PHONE},${DOD},${STATE},${CITY}

Verify that user can access Practice Form and fullfill all fields with valide data (Data transfer in free text)
    Open Preactice Form page 
    Input First Name with value   Tin
    Input Last Name with value   Nguyen
    Input Email with value    DemoQA.testaccount.003@gmail.com
    Select gender value    Other
    Input Mobile number with value     0123456789
    Input Date of Birth with value    21 March,2000
    Select subjects    Maths,Arts
    Select Hobbies    Sports,Music
    Select Picture    Picture_1.png
    Input Current Address with value    Calla Garden, Nguyen Van Linh Street, Binh Chanh District, Ho Chi Minh City, Vietnam
    Select State    NCR
    Select City    Noida
    Click on Submit button
    The confirmation popup should be showed
    The confirmation popup should contains values    Tin,Nguyen,DemoQA.testaccount.003@gmail.com,Other,0123456789,21 March,2000,NCR,Noida

Verify that Mobile field should shows as required when user submit Practice Form and let Mobile field blank
    Open Preactice Form page 
    Input First Name with value   Tin
    Input Last Name with value   Nguyen
    Input Email with value    DemoQA.testaccount.002@gmail.com
    Select gender value    Female
    # Input Mobile number with value     0123456789
    Input Date of Birth with value    21 March,2000
    Select subjects    Maths,Arts
    Select Hobbies    Sports,Music
    Select Picture    Picture_1.png
    Input Current Address with value    Calla Garden, Nguyen Van Linh Street, Binh Chanh District, Ho Chi Minh City, Vietnam
    Select State    NCR
    Select City    Noida
    Click on Submit button
    Mobile field should shows as required
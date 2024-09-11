*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/utils.resource
Resource    basePage.resource

*** Variables ***
${PAGE_URL}                 /automation-practice-form
${FIRST_NAME_ELE}           id:firstName         
${LAST_NAME_ELE}           id:lastName         
${EMAIL_ELE}           id:userEmail         

*** Keywords ***
Open Preactice Form page 
    Open "${PAGE_URL}" page


Input First Name with value
    [Arguments]    ${firstName}
     Input text to text field    ${FIRST_NAME_ELE}    ${firstName}

Input Last Name with value
    [Arguments]    ${lastName}
     Input text to text field    ${LAST_NAME_ELE}    ${lastName}

Input Email with value
    [Arguments]    ${email}
     Input text to text field    ${EMAIL_ELE}    ${email}

Select gender value 
    [Arguments]    ${gender}
    TRY
        IF    "${gender}" == "Male" or "${gender}" == "Female" or "${gender}" == "Other"
            Click on element contains text    ${gender}
        ELSE
            Fail    Not valid option
        END
    EXCEPT    message
        Fail    message
    END
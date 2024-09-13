*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/utils.resource
Resource    basePage.resource

*** Variables ***
${PAGE_URL}                 /automation-practice-form
${FIRST_NAME_ELE}           id:firstName         
${LAST_NAME_ELE}            id:lastName         
${EMAIL_ELE}                id:userEmail         
${GENDER_ELE}               css:input[name='gender']
${MOBILE_ELE}    id:userNumber

${DOB_ELE}    id:dateOfBirthInput
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
            Scroll to the center of viewport
            Click on the web element    ${GENDER_ELE}\[value='${gender}'] + label
        ELSE
            Fail    Not valid gender option
        END
    EXCEPT    message
        Fail    message
    END

Input Mobile number with value
    [Arguments]    ${number}
    Input text to text field    ${MOBILE_ELE}    ${number}

Input Date of Birth with value
    [Arguments]    ${date}
    [Documentation]    The date of birth have to in format dd MMM YYYY (eg. 12 Sep 2024)
    Clear Text Field    id:dateOfBirth
    Input text to text field    css:.react-datepicker__input-container    ${date}
    # Select Date on datepicker    2020    April    19


Select Date on datepicker
    [Arguments]    ${year}    ${month}    ${day}
    # [Arguments]    ${year}    ${month}    ${day}
    Click on the web element   ${DOB_ELE}
    Click on the web element    class:react-datepicker__year-select
    Click desired text from list     css:.react-datepicker__year-select > option   ${year}
    Click on the web element    class:react-datepicker__month-select
    Click desired text from list     css:.react-datepicker__month-select > option   ${month}
    Click desired text from list     css:.react-datepicker__day   ${day}
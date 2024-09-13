*** Settings ***
Resource    ../../configurations/config.resource
Resource    ../../resources/keywords/utils.resource
Resource    basePage.resource
Library     ../keywords/utilities.py

*** Variables ***
${PAGE_URL}                 /automation-practice-form
${FIRST_NAME_ELE}           id:firstName         
${LAST_NAME_ELE}            id:lastName         
${EMAIL_ELE}                id:userEmail         
${GENDER_ELE}               css:input[name='gender']
${MOBILE_ELE}               id:userNumber
${SUBJECT_ELE}              css:input#subjectsInput
${SUBJECT_SUGGESTION_ELE}              css:.subjects-auto-complete__menu

${DOB_ELE}                  id:dateOfBirthInput
${YEAR_ELE}                 css:.react-datepicker__year-select
${MONTH_ELE}                css:.react-datepicker__month-select
${DAY_ELE}                  css:.react-datepicker__day:not(.react-datepicker__day--outside-month)

${FILE_PATH_ELE}                     ${CURDIR}/../testData/

${HOBBIES_ELE}    css:#hobbiesWrapper label



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
    [Documentation]    The date of birth have to in format "dd mmmm yyyy" (eg. 12 Sep 2024)
    ${year} =     Get year from date string    ${date}
    ${month} =     Get month from date string    ${date}
    ${day} =     Get day from date string    ${date}
    
    #  Expand Datime picker
    Click on the web element   ${DOB_ELE}
   
   # Select Year 
    Click on the web element    ${YEAR_ELE}
    Click desired text from list     ${YEAR_ELE} > option   ${year}

    # Select Month
    Click on the web element    ${MONTH_ELE}
    Click desired text from list     ${MONTH_ELE} > option   ${month}

    # Select day
    Click desired text from list     ${DAY_ELE}   ${day}

Select subjects
    [Arguments]    ${subjects}
    Click on the web element    ${SUBJECT_ELE}
    @{list_subjects} =     Convert String To Array    ${subjects}
    FOR    ${subject_name}    IN    @{list_subjects}
        TRY
            Input Text     ${SUBJECT_ELE}    ${subject_name}
            ${is_suggestion}=    Run Keyword And Return Status    
                                ...    Wait Until Element Contains    ${SUBJECT_SUGGESTION_ELE}     
                                ...    ${subject_name}    
                                ...    ${INTERVAL}   
            IF    '${is_suggestion}' == 'True'
                Press Enter key     ${SUBJECT_ELE}
            ELSE
                Press ESC key 
            END
        EXCEPT    message
            Run Keyword And Continue On Failure    Fail    Subject not match 
        END
    END
  
Select Hobbies    
    [Arguments]    ${hobbies}
    @{list_hobbies} =     Convert String To Array    ${hobbies}
    FOR    ${hobby}    IN    @{list_hobbies}
        Click desired text from list    ${HOBBIES_ELE}    ${hobby}
    END

Select Picture 
    [Arguments]    ${file_name}
    ${path}=    Set Variable    ${FILE_PATH_ELE}/${file_name}
    ${normalized_path}=    Normalize Path    ${path}
    Choose File    css:#uploadPicture    ${normalized_path}

    
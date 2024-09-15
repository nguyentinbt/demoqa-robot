*** Settings ***
Resource    base_page.resource
Library     ../keywords/utilities.py
Resource    ../../configurations/config.resource
Resource    ../test_data/css_style_index.resource
Resource    ../../resources/keywords/utils.resource

*** Variables ***
${PAGE_URL}                            /automation-practice-form
${FIRST_NAME_ELE}                      css:#firstName         
${LAST_NAME_ELE}                       css:#lastName         
${EMAIL_ELE}                           css:#userEmail         
${GENDER_ELE}                          css:input[name='gender']
${MOBILE_ELE}                          css:#userNumber
${SUBJECT_ELE}                         css:input#subjectsInput
${DOB_ELE}                             css:#dateOfBirthInput
${YEAR_ELE}                            css:.react-datepicker__year-select
${MONTH_ELE}                           css:.react-datepicker__month-select
${DAY_ELE}                             css:.react-datepicker__day:not(.react-datepicker__day--outside-month)
${HOBBIES_ELE}                         css:#hobbiesWrapper label
${ADDRESS_ELE}                         css:#currentAddress
${FILE_PATH_ELE}                       ${CURDIR}/../test_data/
${STATE_ELE}                           css:#state input
${CITY_ELE}                            css:#city input
${SUBMIT_BTN}                          css:button#submit
${CONFIRMATION_POPUP_ELE}              css:#example-modal-sizes-title-lg
${CONFIRMATION_POPUP_CONTENT_ELE}      css:.table-responsive
${SUBJECT_SUGGESTION_ELE}              css:.subjects-auto-complete__menu
${PHONE_BORDER_COLOR_SCRIPT}           return window.getComputedStyle(document.querySelector('#userNumber')).borderColor;
${UPLOAD_PICTURE_BTN}                  css:#uploadPicture

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
            Scroll to the center of viewport    ${GENDER_ELE}
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

Get border Color
    [Arguments]    ${field_css_selector}
    ${get_border_script}=     Set Variable    return window.getComputedStyle(document.querySelector('${field_css_selector}')).borderColor;
    ${border_color}=    Execute Javascript    ${get_border_script}
    RETURN    ${border_color}

# Is field highlighted
#     ${get_border_script}=     Set Variable    return window.getComputedStyle(document.querySelector('#userNumber')).borderColor;
#     ${border_color}=    Execute Javascript    ${get_border_script}
#     RETURN    ${border_color}

Is Mobile field shows as required
    ${is_required}=    Is field highlighted    ${MOBILE_ELE}
    RETURN    ${is_required}

Mobile field should shows as required
    ${status}=    Is Mobile field shows as required
    Should Be True    ${status}

Input Date of Birth with value
    [Arguments]    ${date}
    [Documentation]    The date of birth have to in format "dd mmmm,yyyy" (eg. 12 September,2024)
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
                                ...    ${INTERVAL_SHORT}   
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
    ${normalized_path}=    OperatingSystem.Normalize Path    ${path}
    Choose File    ${UPLOAD_PICTURE_BTN}     ${normalized_path}

Input Current Address with value
    [Arguments]    ${address}
     Input text to text field    ${ADDRESS_ELE}    ${address}

Select State
    [Arguments]    ${state_name}
    Input text to text field    ${STATE_ELE}    ${state_name}
    Press Enter key     ${STATE_ELE}

Select City
    [Arguments]    ${city_name}
    Input text to text field    ${CITY_ELE}    ${city_name}
    Press Enter key     ${CITY_ELE}

Click on Submit button
    Scroll to the center of viewport    ${SUBMIT_BTN}
    Click Button    ${SUBMIT_BTN}

The confirmation popup should be showed
    # Element Should Be Visible    ${CONFIRMATION_POPUP_ELE}    ${INTERVAL_MEDIUM}
    Wait Until Element Is Visible    ${CONFIRMATION_POPUP_ELE}
    Element Should Contain    ${CONFIRMATION_POPUP_ELE}    Thanks for submitting the form

# The confirmation popup should contains values
#     [Arguments]    ${value}
    
#     Expect webelement contains text    ${CONFIRMATION_POPUP_CONTENT_ELE}    ${value}
#     # Element Should Contain    ${CONFIRMATION_POPUP_CONTENT_ELE}    ${value}

The confirmation popup should contains values
    [Arguments]    ${values}
    @{list_values} =     Convert String To Array    ${values}
    FOR    ${value}    IN    @{list_values}
        Expect webelement contains text    ${CONFIRMATION_POPUP_CONTENT_ELE}    ${value}
        
    END


Get confirmation popup title
    ${popup_title}=    Get Text    ${CONFIRMATION_POPUP_ELE}
    RETURN    ${popup_title}
*** Settings ***
Library     String
Library     DateTime
Library     Collections
Library     SeleniumLibrary
Library     utilities.py
Resource    ../testData/css_style_index.resource
Resource    ../../configurations/config.resource


*** Variables ***
@{supported_locators}       id:
...                         name:
...                         xpath:
...                         css:
...                         link:
...                         class:
...                         tag:
...                         partial link:
...                         dom:

${web_element_indicator}    selenium.webdriver.remote.webelement.WebElement

*** Keywords ***
Get Suite Name
    RETURN    ${SUITE NAME}

Get Test Case Name
    RETURN    ${TEST NAME}

Get Test Case key
    ${test_case_name}=    Get Test Case Name
    ${is_test_case_name_correct_format}=    Should Match Regexp    ${test_case_name}    .*---.*
    ${tc_parts}=    Split String    ${test_case_name}    ---
    ${first_part}=    Replace String    ${tc_parts}[0]    <    ${EMPTY}
    ${last_part}=    Replace String    ${first_part}    >    ${EMPTY}
    ${key_part}=    Strip String    ${last_part}
    ${is_correct_key}=    Should Match Regexp    ${key_part}    GH-.*
    IF    '${is_correct_key}' == 'None'
        Fatal Error    Test case ID does not exist
    ELSE
        RETURN    ${key_part}
    END

# Stop Execution On Failure
#    [Arguments]    ${condition}
#    IF    ${condition} == True
#    Run Keyword And Return From Test Case    Fail    Test failed
#    END

Get test case status
    RETURN    ${TEST_STATUS}

Get test case message
    RETURN    ${TEST_MESSAGE}

Get current date time
    ${current_time}=    Get Current Date    result_format=%Y-%m-%d %H:%M:%S
    Log    ${current_time}
    RETURN    ${current_time}

Set test case start time
    ${start}=    Get Current Date
    Set Global Variable    ${start}
    RETURN    ${start}

Set test case end time
    ${end}=    Get Current Date
    Set Global Variable    ${end}
    RETURN    ${end}

Get test execution elapsed
    ${end}=    Set test case end time
    ${elapsed_time}=    Subtract Date From Date    ${end}    ${start}
    ${elapsed}=    Evaluate    ${elapsed_time}*1000
    Set Global Variable    ${elapsed}
    RETURN    ${elapsed}

Get Matching String
    [Arguments]    ${actual}    ${expected}
    ${length}=    Set Variable    ${expected.__len__()}
    IF    '${actual}'.startswith('${expected}')
        ${matching_string}=    Evaluate    '${actual}'[:${length}]
    ELSE
        ${matching_string}=    Set Variable    ${matching_string}    ${EMPTY}
    END
    RETURN    ${matching_string}

Is Text Start With
    [Documentation]    Return True if the actual string start with expected
    [Arguments]    ${actual}    ${expected}
    ${result}=    Evaluate    "${actual}".startswith("${expected}")    # Evaluate returns a boolean value
    RETURN    ${result}

Is Text Contains
    [Arguments]    ${actual}    ${expected}
    ${string_variable}=    Convert To String    ${actual}
    ${status}=    Run Keyword And Return Status    Should Contain    ${string_variable}    ${expected}
    RETURN    ${status}

Is supported element locator
    [Documentation]    Return locator value incase the selector start with commonly used locators in Robot Framework:
    ...    id, name, xpath, css, link, class, tag, partial link, dom
    [Arguments]    ${Locator}
    FOR    ${element}    IN    @{supported_locators}
        ${is_contains}=    Is Text Start With    ${Locator}    ${element}
        IF    "${is_contains}" == "True"    RETURN    True
    END

Search and Replace double quotes by single quote
    [Arguments]    ${original_string}
    ${modified_string}=    Replace String    ${original_string}    "    '
    RETURN    ${modified_string}

# ------------------- GET ELEMENT -------------------#

Get element by partial id
    [Documentation]    User can input partial ID to locate element
    [Arguments]    ${id}
    ${element}=    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL_SHORT}
    ...    Get WebElement    css: [id*='${id}']
    RETURN    ${element}

Get element by text
    [Documentation]    User can input partial text to locate element
    [Arguments]    ${text}
    ${element}=    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL_SHORT}
    ...    Get WebElement    xpath: //*[contains(text(), '${text}')]
    RETURN    ${element}

Get Element by locator
    [Documentation]    Returns the WebElement matching the given locator.
    ...    For supported locate, using the build in keyword.
    ...    For unsupported locate, using the custom keyword.
    ...    Keyword will find and return a web element based on specific criteria.
    [Arguments]    ${locator}

    TRY
        ${is_web_element}=    Is web element    ${locator}
        IF    "${is_web_element}" == "True"
            RETURN    ${locator}
        ELSE
            ${locator}=    Search and Replace double quotes by single quote    ${locator}
            ${is_supported_locator}=    Is supported element locator    ${locator}
            IF    "${is_supported_locator}" != "None"
                Wait until expected element is Visible    ${locator}
                ${element}=    Wait Until Keyword Succeeds
                ...    ${RETRY}
                ...    ${INTERVAL_SHORT}
                ...    Get WebElement    ${locator}
                RETURN    ${element}
            ELSE
                TRY
                    ${element}=    Get element by partial id    ${locator}
                    RETURN    ${element}
                EXCEPT
                    ${element}=    Get element by text    ${locator}
                    RETURN    ${element}
                END
            END
        END
    EXCEPT
        Fail    Element with locator ${locator} not found
    END

# ------------------- ACTIONS -------------------#

Click desired text from list
    [Documentation]    User can click on a certain text in a list by providing the list of element locators and the text
    [Arguments]    ${list_selector}    ${text}
    # Wait until element is Visible    ${list_selector}
    Wait Until Page Contains Element    ${list_selector}
    @{elements}=    Get Webelements    ${list_selector}
    FOR    ${element}    IN    @{elements}
        ${element}=    Get Element by locator    ${element}
        ${elem_text}=    Get Text    ${element}
        IF    "${elem_text}" == "${text}"
            Wait Until Keyword Succeeds
            ...    ${RETRY}
            ...    ${INTERVAL_SHORT}
            ...    Click on the web element    ${element}
            RETURN    ${element}
        END
    END

Click on the web element
    [Documentation]    Click on element by provided locator with configured retry
    [Arguments]    ${locator}
    ${element}=    Get Element by locator    ${locator}
    Scroll to the center of viewport    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL_SHORT}
    ...    Click Element    ${element}

Click on the link text
    [Documentation]    Click on element by provided partial link text
    [Arguments]    ${text_link}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL_SHORT}
    ...    Click Link    ${text_link}

Click on element contains text
    [Documentation]    Click on the element contains text
    [Arguments]    ${text}
    ${element}=    Get element by text    ${text}
    Click on the web element    ${element}

Input text to text field
    [Documentation]    Input text to the text field located by the provided locator
    [Arguments]    ${locator}    ${text}
    Wait until expected element is Visible    ${locator}
    ${element}=    Get Element by locator    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL_SHORT}
    ...    Input Text    ${element}    ${text}

Input text to ${field} with ${value}
    # Input Text    css=[ng-reflect-label='${field}'] input    ${value}
    Input Text    ${field}    ${value}

Select radio button by value
    [Arguments]    ${locator}    ${expected_value}
    @{genders}=    Get WebElements    ${locator}
    FOR    ${element}    IN    @{genders}
        ${actual_value}=    Get Element Attribute    ${element}    value
        IF    "${actual_value}" == "${expected_value}"
            Scroll to the center of viewport    ${locator}
            Click on the web element    ${locator}[value='${expected_value}'] 
            RETURN
        END
    END

Clear Text Field
    [Arguments]    ${locator}
    Clear Element Text    ${locator}

# Select option in dropdown menu
#     [Documentation]    Select certain dropdown option by the provided locator and option value
#     [Arguments]    ${locator}    ${expected_item_text}
#     Wait Until Keyword Succeeds
#     ...    ${RETRY}
#     ...    ${INTERVAL_SHORT}
#     ...    Click Element    ${locator}
#     Search and select option    ${expected_item_text}

# ------------------- ASSERTIONS -------------------#

Expect webelement contains text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL_SHORT}
    ...    Element Should Contain    ${locator}    ${expected_text}

Link Should Be Clickable
    [Arguments]    ${locator}

    ${status}=    Run Keyword And Return Status
    ...    Element Should Be Visible    ${locator}

    # Check if link can be clicked
    IF    ${status}
        ${enabled}=    Element Should Be Enabled    ${locator}
    ELSE
        ${enabled}=    Set Variable    ${None}
    END
    RETURN    ${status} and ${enabled}

Is web element
    [Arguments]    ${locator}
    ${is_web_element}=    Is Text Contains    ${locator}    ${web_element_indicator}
    RETURN    ${is_web_element}

# ------------------- CUSTOM WAIT -------------------#

Wait until expected element is Visible
    [Arguments]    ${locator}
    Wait Until Keyword Succeeds
    ...    ${RETRY}
    ...    ${INTERVAL_SHORT}
    ...    Run Keyword And Return Status    Element Should Be Visible    ${locator}

# ------------------- LOGS -------------------#

Stop logging info
    Set Log Level    None

Restore logging info
    Set Log Level    INFO

Scroll to  
    [Documentation]    This keyword to scroll the visual to the inputed value
    [Arguments]    ${horizontal}        ${vertical}
    TRY
        Execute Javascript    window.scrollBy(${horizontal},${vertical})
    EXCEPT
        Run Keyword And Continue On Failure    Fail    Couldn't scroll to the provided value
    END

Scroll to the center of viewport 
    [Arguments]    ${locator}
    [Documentation]    This keyword to scroll the visual to the inputed value. support CSS selector syntax until now
    TRY
        ${is_web_element}=    Is web element    ${locator}
        IF    "${is_web_element}" == "True"
            ${window_height}=    Execute JavaScript    return window.innerHeight / 2;
            Scroll to    0    ${window_height}
            Sleep    ${INTERVAL_SHORT}
            Wait until expected element is Visible    ${locator} 
        ELSE
            ${is_contains}=    Is Text Start With    ${locator}    css
            IF    "${is_contains}" == "True"
                ${querySelector}=    Replace String    ${locator}    css:          ${EMPTY} 
                ${SCROLL_SCRIPT}=     Set Variable    document.querySelector("${querySelector}").scrollIntoView({ behavior: 'smooth', block: 'center' });
                Execute Javascript    ${SCROLL_SCRIPT}  
                Sleep    ${INTERVAL_SHORT}
                Wait until expected element is Visible    ${locator} 
            END             
        END    
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    not supported selecttor
    END


Is field highlighted
    [Arguments]    ${locator}
    TRY
        Scroll to the center of viewport    ${locator}
        ${is_contains}=    Is Text Start With    ${locator}    css
        IF    "${is_contains}" == "True"
            ${querySelector}=    Replace String    ${locator}    css:          ${EMPTY} 
            ${SCROLL_SCRIPT}=     Set Variable    return window.getComputedStyle(document.querySelector("${querySelector}")).borderColor;
            ${border_color}=    Execute Javascript    ${SCROLL_SCRIPT}  
            IF    "${border_color}" == "${RED}"
                RETURN    ${True}
            END
        END             
    EXCEPT    
        Run Keyword And Continue On Failure    Fail    not supported selector
    END


Get year from date string
    [Arguments]    ${string_date}
    ${day}=    Get Day From String    ${string_date}
    ${month}=    Get Month From String    ${string_date}
    ${year}=    Get Year From String    ${string_date}
    RETURN    ${year}

Get month from date string
    [Arguments]    ${string_date}
    ${month}=    Get Month From String    ${string_date}
    RETURN    ${month}    

Get day from date string
    [Arguments]    ${string_date}
     ${day}=    Get Day From String    ${string_date}
    RETURN    ${day}    

Convert String To Array
    [Arguments]    ${string}
    ${array}=    Split String    ${string}    ,
    RETURN    ${array}

Press Enter key
    [Arguments]    ${locator}
    Press Key    ${locator}    \\13
   
Press ESC key
    Press Keys    NONE    ESC
    
Test Suite Setup
    # Create test cycle at folder    Smoke Testing
    Log    This is suite setup

Test Suite Teardown
    # Delete All Sessions
    Log    Suite Teardown

Test case Setup
    Set test case start time

Test case Teardown
    Close Browser
    # Update test case result to Zephyr Scale    
*** Settings ***
Library    Selenium2Library
# Library    SeleniumLibrary
Library    RequestsLibrary

Test Teardown    Run Keywords        
...    Run Keyword If Timeout Occurred    Log    Timeout occurs
...    AND    Close Browser       

*** Variables ***

&{LINK_LIST}        upload_file=https://www.w3schools.com/howto/howto_html_file_upload_button.asp
...                 iframe=https://www.w3schools.com/html/html_iframe.asp
...                 newtab_popout=https://www.encodedna.com/javascript/demo/open-new-window-using-javascript-method.htm
&{FILE_ADDRESS}     fileaddress=C://Users/meimei/Desktop/background/Eren.jpg
${EXPECTED_NAME}    Eren.jpg
${MUST_SCROLL}      content > div.post > p:nth-child(8) > input[type=button]

*** Test Cases ***
    
Test Any API
    Open Browser    https://any-api.com/    chrome
    @{links}=       Get WebElements    class=tag-link 
         
    :FOR    ${item}    IN    @{links}
    \    Click Element    ${item}
    \    ${location}=    Get Location
    \    ${response}=    GET    ${location}    timeout=10
    \    Should Be Equal As Integers    ${response.status_code}    200    This link is active
    # \    
    # \    Should Be True    ${response.status_code} == 200    'This link is active'
    
    # \    Run Keyword If    ${response.status_code} == 200    Log    Pass at ${location}
    # \    ...    ELSE    Log    Pass at ${location}       

Test Upload File
    Open Browser                 &{LINK_LIST}[upload_file]    chrome
    Set Browser Implicit Wait    5
    Input Text                   id=myFile    &{FILE_ADDRESS}[fileaddress]
    ${filename}=    Get Element Attribute    id=myFile    value      
    Should Contain               ${filename}    ${EXPECTED_NAME}          

Test Iframe
    ${text}=    Set Variable    An HTML iframe is used to display a web page within a web page.
    Open Browser                &{LINK_LIST}[iframe]    chrome
    Select Frame                css:#main > div:nth-child(7) > iframe
    Set Browser Implicit Wait    5
    Current Frame Should Not Contain        ${text}   
    Unselect Frame
    Current Frame Should Contain            ${text}    
    
Test New Tab
    ${css}=    Set Variable    content > div.post > p:nth-child(4) > input[type=button]:nth-child(2)
    Open Browser               &{LINK_LIST}[newtab_popout]    chrome
    Scroll Element Into View    css:#${MUST_SCROLL} 
    Click Button                css=#${css}    
    @{tabs}=    Get Window Handles
    Select Window                @{tabs}[1]
    Select Window                @{tabs}[0]

Test Popout Window
    ${css}=    Set Variable    content > div.post > p:nth-child(4) > input[type=button]:nth-child(1)
    ${text}=    Set Variable    A New Popup Window
    Open Browser               &{LINK_LIST}[newtab_popout]    chrome
    Scroll Element Into View    css:#${MUST_SCROLL} 
    Click Button                css=#${css}    
    @{wins}=    Get Window Handles
    Select Window               @{wins}[1]
    ${title_new}=    Get Title
    Select Window               @{wins}[0]
    ${title_cur}=    Get Title
    Should Not Be Equal As Strings    ${title_cur}    ${title_new}    title must be different

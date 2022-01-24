*** Settings ***
Library    Selenium2Library
Variables    ../Resources/MyCustom.py

Test Teardown    Run Keywords    
...    Run Keyword If Test Failed    Capture Page Screenshot 
...    AND    Close Browser  

*** Variables ***
@{VAR_LIST}    IT    QA    DEV    BA    FA
&{VAR_DICT}    name=ngoc    account=ngocttk1
${LOGIN_BUTTON}    css:#u_0_2_8G
*** Test Cases ***
Test01
    ${var_01}=    Call Method    ${validate}    checkDepartment    QA    @{VAR_LIST}
    Should Be True    ${var_01}==True    
    
    ${var_02}=    Call Method    ${validate}    checkInfo    Ngoc    NgocTTK1    &{VAR_DICT}
    Should Be True    ${var_02}==True       

Test02
    Open Browser    https://www.facebook.com/    chrome
    ${var_03}=    Get Text    ${LOGIN_BUTTON}
    Should Be Equal As Strings    ${var_03}    Login    

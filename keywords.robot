*** Settings ***
Library    Browser
Library    Collections
Library    util.py
Variables    locators.py

*** Variables ***


*** Keywords ***

Open Browser and Navigate to google
    Browser.Open Browser        browser=Chromium    headless=false
    Browser.New Page       url=https://www.google.com 
    Sleep   3s

Search from excel
    ${excelvalue}    readexcel
    Log    ${excelvalue}
    ${count}       Get Length   ${excelvalue}
    @{All_Records}=     Create List
    FOR  ${i}    IN RANGE   ${count}
        Browser.Fill Text   id=${searchbox}   txt=${excelvalue}[${i}]
        Browser.Keyboard Key    press    key=Tab
        Browser.Click    xpath=${searchbtn}
        Browser.Take Screenshot
        Browser.Wait For Elements State    xpath=(${googleSearchRecords})[1]
        ${g_results}   Browser.Get Elements   xpath=${googleSearchRecords}
        FOR  ${element}  IN    @{g_results}
           ${text}    Get Text     ${element}
           IF    "${text}" != ""
                Append To List    ${All_Records}    ${text}
            END  
        END
        Click    xpath=${googlelogo}
    END
    Log    ${All_Records}
    [return]   ${All_Records}

Get searched records from google
    @{Record_list}=     Create List
    ${count}   Browser.Get Element Count    xpath=${googleSearchRecords}
    ${index}    Evaluate     0
    FOR  ${i}    IN RANGE    ${count} 
         ${index}    Evaluate    ${index} + 1
        ${record}    Browser.Get Text    xpath=(${googleSearchRecords})[${index}]
        Append To List    ${Record_list}    ${record}
    END
    Log     ${Record_list}
    #[return]    ${Record_list}


Add Searched Records to Excel
    ${exceldata}    Search from excel
    write_to_excel     data=${exceldata}
    
Show records
    @{itemlist}    Create List
    Append To List        ${itemlist}        Get searched records from google
    Log     ${itemlist} 


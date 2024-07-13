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
    FOR  ${i}    IN RANGE   ${count}
        Browser.Fill Text   id=${searchbox}   txt=${excelvalue}[${i}]
        Browser.Keyboard Key    press    key=Tab
        Browser.Click    xpath=${searchbtn}
        Browser.Take Screenshot
        Click    xpath=${googlelogo}
    END

Export searched records to Excel
    


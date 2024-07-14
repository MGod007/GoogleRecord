*** Settings ***
Resource        keywords.robot

*** Test Cases ***
TC01 - Add all the records fetched from google search to excel
    Open Browser and Navigate to google
    Add Searched Records to Excel
    Show records
*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    ../Resources/UserKeywords.robot
Documentation     UI Test Automation


*** Variables ***
${browser}              chrome
${headlessbrowser}      headlesschrome
${browseredge}          Edge

${url}                  https://www.demo.bnz.co.nz/client/

*** Keywords ***


TC1: Verify you can navigate to Payees page using the navigation menu
    [documentation]  This test case verifies Payees page using the navigation menu,
    ...  1. Click ‘Menu’
    ...  2. Click ‘Payees’
    ...  3. Verify Payees page is loaded
    [tags]  UI Test Automation
    open browser    ${url}    ${browser}
    maximize browser window
    Set Browser Implicit Wait    30sec
    #Sleep   10sec
    Click Element    xpath://span[contains(text(),'Menu')]
    Click Element    xpath://span[normalize-space()='Payees']
    SeleniumLibrary.Element Text Should Be       xpath://span[normalize-space()='Payees']    Payees
    Capture Page Screenshot



TC2: Verify you can add new payee in the Payees page
    [documentation]  This test case verifies Payees Addition ,
    ...  1. Navigate to Payees page
    ...  2. Click ‘Add’ button
    ...  3. Enter the payee details (name, account number)
    ...  4. Click ‘Add’ button
    ...  5. ‘Payee added’ message is displayed, and payee is added in the list of payees

    [tags]  UI Test Automation

    TC1: Verify you can navigate to Payees page using the navigation menu
    Set Browser Implicit Wait    30sec
    Click Element    xpath://span[normalize-space()='Add']
    Input Text    xpath://input[@id='ComboboxInput-apm-name']    Keshav
    Click Element    xpath://span[@title='Someone new: Keshav']
    Input Text    xpath://input[@id='apm-bank']    03
    Input Text    xpath://input[@id='apm-branch']    0187
    Input Text    xpath://input[@id='apm-account']    0026306
    Input Text    xpath://input[@id='apm-suffix']    003
    Capture Page Screenshot
    Click Button    xpath://button[contains(@class,'js-submit Button Button--primary')]
    Input Text    xpath://input[@placeholder='Search payees']    Keshav
    Element Text Should Be    xpath://span[@class='js-payee-name']    Keshav
    Capture Page Screenshot
    Close Browser

TC3: Verify payee name is a required field
    [documentation]  This test case verifies Payees page Populate mandatory fields Validate errors
    ...     1. Navigate to Payees page
    ...     2. Click ‘Add’ button
    ...     3. Click ‘Add’ button
    ...     4. Validate errors
    ...     5. Populate mandatory fields
    ...     6. Validate errors are gone

    [tags]  UI Test Automation

    TC1: Verify you can navigate to Payees page using the navigation menu
    Set Browser Implicit Wait    30sec
    Click Element    xpath://span[normalize-space()='Add']
    Click Element    xpath://button[@class='js-submit Button Button--primary Button--disabled']
    Capture Page Screenshot
    Element Text Should Be    xpath://div[@aria-label="'Attention! A problem was found. Please correct the field highlighted below."]    A problem was found. Please correct the field highlighted below.
    Input Text    xpath://input[@id='ComboboxInput-apm-name']    Keshav
    Click Element    xpath://span[@title='Someone new: Keshav']
    Input Text    xpath://input[@id='apm-bank']    03
    Input Text    xpath://input[@id='apm-branch']    0187
    Input Text    xpath://input[@id='apm-account']    0026306
    Input Text    xpath://input[@id='apm-suffix']    003
    Capture Page Screenshot
    Element Should Be Enabled    xpath://button[contains(@class,'js-submit Button Button--primary')]




TC4: Verify that payees can be sorted by name
    [documentation]  This test case Verify list is sorted in ascending order by default and Verify list is sorted in descending order
    ...     1. Navigate to Payees page
    ...     2. Add new payee
    ...     3. Verify list is sorted in ascending order by default
    ...     4. Click Name header
    ...     5. Verify list is sorted in descending order

        [tags]  UI Test Automation

        TC1: Verify you can navigate to Payees page using the navigation menu
        Set Browser Implicit Wait    30sec
        Capture Page Screenshot
        Element Text Should Be    xpath://span[normalize-space()='Auckland Council']    Auckland Council
        Element Text Should Be    xpath://div[@id='js-payee-item-3']//p[@class='Avatar-text js-payee-account'][normalize-space()='01-0001-0000001-001']    01-0001-0000001-001
        Click Element    xpath://h3[@aria-label='Sort by payee name A to Z selected. Select again to reverse order.']//*[name()='svg']
        Capture Page Screenshot
        Element Text Should Be    xpath://span[normalize-space()='VODAFONE NZ LTD (MOBILE)']    VODAFONE NZ LTD (MOBILE)
        Element Text Should Be    xpath://div[@id='js-payee-item-3']//p[@class='Avatar-text js-payee-account'][normalize-space()='01-0001-0000001-001']    01-0001-0000001-001



TC5: Navigate to Payments page
    [documentation]  This test case Verify Transfer $500 from Everyday account to Bills account and validate current balance of Everyday account and Bills account are correct
    ...     1. Navigate to Payments page
    ...     2. Transfer $500 from Everyday account to Bills account
    ...     3. Transfer successful message is displayed
    ...     4. Verify the current balance of Everyday account and Bills account are correct

        [tags]  UI Test Automation
        open browser    ${url}    ${browser}
        maximize browser window
        Set Browser Implicit Wait    30sec
        Click Element    xpath://span[contains(text(),'Menu')]
        Capture Page Screenshot
        Click Element    xpath://span[normalize-space()='Pay or transfer']
        Capture Page Screenshot
        Click Element    xpath://span[normalize-space()='Choose account']
        Capture Page Screenshot
        Sleep    5sec
        Click Element    xpath://p[normalize-space()='Everyday']
        Sleep    5sec
        Click Element    xpath://span[normalize-space()='Choose account, payee, or someone new']
        Sleep    5sec
        Click Element    xpath://span[normalize-space()='Accounts']
        Sleep    5sec
        Click Element    xpath://p[normalize-space()='Bills']
        Capture Page Screenshot
        Input Text    xpath://form[@id='paymentForm']/div[1]/div/span/span/input    $500
        Input Text    xpath://input[@aria-label='Statement details, for payer, particulars']    UITest
        Input Text    xpath://input[@aria-label='Statement details, for payer, code']    002
        Input Text    xpath://input[@aria-label='Statement details, for payer, reference']    UITest
        Click Element    xpath://button[@aria-label='Copy particulars, code, and reference from yours to theirs']
        Click Element    xpath://span[contains(@class,'Language__container')][normalize-space()='Transfer']
        Capture Page Screenshot
       # Element Text Should Be    xpath://div[@id="notification"]/div/span    Transfer successful
        Element Text Should Be    xpath://span[@class='account-balance'][normalize-space()='2,000.00']    2,000.00
        Element Text Should Be    xpath://span[@class='account-balance'][normalize-space()='920.00']    920.00
        Capture Page Screenshot

        Close All Browsers
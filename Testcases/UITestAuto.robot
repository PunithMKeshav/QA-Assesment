*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    ../Resources/UserKeywords.robot
Documentation     UI Test Automation
Suite Teardown      Close All Browsers




*** Test Cases ***
UI Test Automation
     [documentation]  UI Test Automation Using RobotFramework
    TC1: Verify you can navigate to Payees page using the navigation menu
    TC2: Verify you can add new payee in the Payees page
    TC3: Verify payee name is a required field
    TC4: Verify that payees can be sorted by name
    TC5: Navigate to Payments page
    Close All Browsers





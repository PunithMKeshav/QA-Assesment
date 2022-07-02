*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Documentation     API Test Automation


*** Variables ***
${baseurl}          https://jsonplaceholder.typicode.com/users

*** Test Cases ***

TC1: Verify GET Users request
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    ...  Verify that there are 10 users in the results.
    [tags]  API Test Automation
    Create Session  mysession  https://jsonplaceholder.typicode.com  verify=true
    ${response}=  GET On Session  mysession  /users
    Status Should Be  200  ${response}  #Check Status as 200
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Log To Console    ${response.headers}

TC2: Verify GET User request by Id
    [documentation]  This test case verifies that the response code of the GET Request should be 200,
    ...  Verify if user with id8 is Nicholas Runolfsdottir V
    [tags]  API Test Automation
    Create Session  mysession  https://jsonplaceholder.typicode.com  verify=true
    ${response}=  GET On Session  mysession  /users       params=id=8
    Status Should Be  200  ${response}  #Check Status as 200
    ${body}=  Convert To String  ${response.content}
    Should Contain  ${body}  Nicholas Runolfsdottir V
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
    Log To Console    ${response.headers}


TC3: Verify POST Users request
    [documentation]  This test case verifies that the response code of the POST Request should be 200/201,
    ...  Verify that the posted data are showing up in the result

    [tags]  API Test Automation
    Create Session  mysession  https://jsonplaceholder.typicode.com  verify=true
    &{body}=  Create Dictionary  id=10  name=Add User  username=Add.User email=add.user@test.com
    &{header}=  Create Dictionary  Cache-Control=no-cache
    ${response}=  POST On Session  mysession  /users  data=${body}  headers=${header}
    Status Should Be  201  ${response}  #Check Status as 201

    #Check  Response Body
    ${id}=  Get Value From Json  ${response.json()}  id
    ${idFromList}=  Get From List   ${id}  0
    ${idFromListAsString}=  Convert To String  ${idFromList}
    Should be equal As Strings  ${idFromListAsString}  11

    #Check the value of the header Content-Type
    ${getHeaderValue}=  Get From Dictionary  ${response.headers}  Content-Type
    Should be equal  ${getHeaderValue}  application/json; charset=utf-8






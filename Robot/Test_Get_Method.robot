*** Settings ***
Library    RequestsLibrary 
Library    String

*** Variables ***
${URL}    https://jsonplaceholder.typicode.com/users

*** Test Cases ***
Check HTTP Status Code
    ${response}    GET    ${URL}
    Should Be Equal As Strings    ${response.status_code}    200

Check Response Return Type
    ${response}    GET    ${URL}
    ${response}    Set Variable    ${response.json()}
    Should Be String    ${response[0]['name']}
    Should Not Be String    ${response[0]['id']}

Check Response Data Type
    ${response}    GET    ${URL}
    ${response_headers}    Set Variable    ${response.headers}
    Should Be Equal    ${response_headers['Content-Type']}    application/json; charset=utf-8

Check Response Data Size
    ${response}    GET    ${URL}
    ${response}    Set Variable    ${response.json()}
    Length Should Be    ${response}    10
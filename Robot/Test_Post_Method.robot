*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Variables ***
${URL}    https://jsonplaceholder.typicode.com/posts

*** Test Cases ***
Check HTTP Status Code
    ${response}    POST    ${URL}
    Should Be Equal As Strings    ${response.status_code}    201

Check Response Header
    ${response}    POST    ${URL}
    ${response_headers}    Set Variable    ${response.headers}
    Should Be Equal    ${response_headers['Content-Type']}    application/json; charset=utf-8

Check Response match with Request
    ${body}    Convert String to JSON    {"key":"2"}
    ${response}    POST    ${URL}    data=${body}
    ${response}    Set Variable    ${response.json()}
    Should Be Equal    ${response['key']}    2
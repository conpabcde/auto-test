*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         json
Library         OperatingSystem


*** Variables ***
${hostV1}       https://b2bapi-beta.techdesignlink.com
${token}        Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjFiNGZmYTMyMzNjYTRiODFhYTgzNGFlNjdiYmRlMmY1YWE3OTcwNzU3NDQyMWJhYjU4NTQ3ZjI5ZjVkYzViNjMzNzFiZWQ3NzE2MGMyYWMiLCJpYXQiOiIxNjE1MTg5NTMwLjE1NDM2NCIsIm5iZiI6IjE2MTUxODk1MzAuMTU0MzY3IiwiZXhwIjoiMTkzMDcyMjMzMC4xNDg3MzAiLCJzdWIiOiIzNDVhMjEzZS0xZjI4LTExZTctYjY0NC0wMjU4MTExMzRmMTkiLCJzY29wZXMiOltdfQ.AbxeUh_1RuOf0w-50HiChCqm4xaVARkW4rVXYT_s1MRA8kuZIkU5WQzVv8VNPsGQ556cz4Wa1uthGqL_FNiNLQ0aug2IjLgdKKbMeB5uEnR8Wukemciz_Sa87q7I-09pbirpt4NKhs_TN4IkNogzx0xDaiGj72b0oKaCcv-eAjuOq16uj8XPSyuf-8b6ru8tlGbyagMwsolM4Z3gxbTE_k9zGKjgWPq8Yb-ZjJZ753tcV3NZylw31du9i5kZIjYkTI3fBAMlMGd_nG3BcP0lCyOLZygCB610ZAngRT2Sq5SWAlF00LJ-KbFUa8GFJdYqnJxqXNvcGU945BOHjxIGqdHR7CNx-l6zP1pLykbKlN_SpjrqtANOibtxgT9d3feGq_-7cBnG0o00x0WXelkMOQadrQvyDkh1DvxmYH3GAwuC-Ej0V-MlOcWhujUaqBb_je604IKI734dg5oShMv-Ad9iCyojw-fs7JxkIqGA1QkwsM39L5oDVgZsEIWH-ZfsWVX6hUFv9Wf9W6RiVCcWf0YJz2dH7crJg_1peh6V2yNPSSRlvWewHVSuDZDYtOa07nQvxwaqpvblJlxVxAjUz6Q3oRGyfo_C-YWwLwNObY1mXVRlv3cAmQqvKsVM4ULKt3KSbaOZP2NXVY6U8Z3r0g_f0HhFPBzbE6KfymGgeog

*** Test Cases ***
API test:get inventory Info
  Create Session  tdcv1                  ${hostV1}
  ${header}=      create dictionary      Authorization=${token}    Content-Type=application/json
  ${resp}=        GET On Session         tdcv1                     /api/v1/product-inventory     headers=${header}
  log to console  ${resp.json()}

API test:post inventory Info
  Create Session  tdcv1                  ${hostV1}
  ${header}=      create dictionary      Authorization=${token}    Content-Type=application/json
  ${resp}=        Post Request           tdcv1                     /api/v1/product-inventory     headers=${header}
  log to console  ${resp.json()}

*** Settings ***
Documentation     An example about for loops.

*** Variables ***
@{ROBOTS}=        Bender    Johnny5    Terminator    Robocop

*** Test Cases ***
Loop Over A List Of Items And Log Each Of Them
    FOR    ${robot}    IN    @{ROBOTS}
        Log to console  ${robot}
    END
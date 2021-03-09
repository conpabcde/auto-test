*** Settings ***
Library         RequestsLibrary
Library         Collections
Library         json
Library         OperatingSystem
Suite setup     Create Session  typicode  https://jsonplaceholder.typicode.com
Suite teardown  Delete all sessions


*** Test Cases ***
requests: Should have a name and belong to a company with a slogan
  ${resp}=        Get On Session               typicode              /users/1
  Should Be Equal As Integers               ${resp.status_code}   200
  ${name}=        Get From Dictionary       ${resp.json()}        name
  Should Be Equal As Strings                ${name}               Leanne Graham
  ${co}=          Get From Dictionary       ${resp.json()}        company
  ${co_slogan}=   Get From Dictionary       ${co}                 catchPhrase
  Should Be Equal As Strings  ${co_slogan}  Multi-layered client-server neural-net
  ${json}=        Dumps                     ${resp.json()}        indent=${4}
  Log to Console  ${json}

*** Variables ***
${host}      https://beta.techdesignlink.com
${hostV1}    https://b2bapi-beta.techdesignlink.com
${token}     Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNjFiNGZmYTMyMzNjYTRiODFhYTgzNGFlNjdiYmRlMmY1YWE3OTcwNzU3NDQyMWJhYjU4NTQ3ZjI5ZjVkYzViNjMzNzFiZWQ3NzE2MGMyYWMiLCJpYXQiOiIxNjE1MTg5NTMwLjE1NDM2NCIsIm5iZiI6IjE2MTUxODk1MzAuMTU0MzY3IiwiZXhwIjoiMTkzMDcyMjMzMC4xNDg3MzAiLCJzdWIiOiIzNDVhMjEzZS0xZjI4LTExZTctYjY0NC0wMjU4MTExMzRmMTkiLCJzY29wZXMiOltdfQ.AbxeUh_1RuOf0w-50HiChCqm4xaVARkW4rVXYT_s1MRA8kuZIkU5WQzVv8VNPsGQ556cz4Wa1uthGqL_FNiNLQ0aug2IjLgdKKbMeB5uEnR8Wukemciz_Sa87q7I-09pbirpt4NKhs_TN4IkNogzx0xDaiGj72b0oKaCcv-eAjuOq16uj8XPSyuf-8b6ru8tlGbyagMwsolM4Z3gxbTE_k9zGKjgWPq8Yb-ZjJZ753tcV3NZylw31du9i5kZIjYkTI3fBAMlMGd_nG3BcP0lCyOLZygCB610ZAngRT2Sq5SWAlF00LJ-KbFUa8GFJdYqnJxqXNvcGU945BOHjxIGqdHR7CNx-l6zP1pLykbKlN_SpjrqtANOibtxgT9d3feGq_-7cBnG0o00x0WXelkMOQadrQvyDkh1DvxmYH3GAwuC-Ej0V-MlOcWhujUaqBb_je604IKI734dg5oShMv-Ad9iCyojw-fs7JxkIqGA1QkwsM39L5oDVgZsEIWH-ZfsWVX6hUFv9Wf9W6RiVCcWf0YJz2dH7crJg_1peh6V2yNPSSRlvWewHVSuDZDYtOa07nQvxwaqpvblJlxVxAjUz6Q3oRGyfo_C-YWwLwNObY1mXVRlv3cAmQqvKsVM4ULKt3KSbaOZP2NXVY6U8Z3r0g_f0HhFPBzbE6KfymGgeog

*** Test Cases ***
API test: get Menu
  Create Session  tdc                      ${host}
  ${resp}=        GET On Session           tdc                   /config/getMenu       expected_status=200
  ${json}=        Dumps                    ${resp.json()}
  Log to Console  ${json}

API test:get invetory Info
  Create Session  tdcv1                    ${hostV1}
  ${header}=      create dictionary        Authorization=${token}       Content-Type=application/json
  ${resp}=        GET On Session           tdcv1                 /api/v1/product-inventory     headers=${header}
  log to console  ${resp.json()}



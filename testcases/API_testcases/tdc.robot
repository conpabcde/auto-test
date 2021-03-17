*** Settings ***
Resource        ./Resources/Public/http_request.robot

*** Variables ***
#{hostV1}         http://127.0.0.1:9990
${hostV1}        https://b2bapi-beta.techdesignlink.com
${path}          /api/v1/product-inventory
${token}         Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTY4NzVkZTBmNjllMTYxMjNlYzMxN2YyNDUwM2I2YjA0MmQxNmEyODJjYmQ4OTkzYTE2NmJiY2I1MThkMTA4NzM2MWFjMmE2Njk3NzU0YjQiLCJpYXQiOiIxNjE1MjgxMTM0LjA4NjU1MSIsIm5iZiI6IjE2MTUyODExMzQuMDg2NTU1IiwiZXhwIjoiMTkzMDgxMzkzNC4wNzk4ODAiLCJzdWIiOiIzMDdiNDRjYy02YTNhLTExZTgtYTRmYy0wMjU4MTExMzRmMTkiLCJzY29wZXMiOltdfQ.ZjJ3cuBxXmb8v-pa9I-TCjwlJJc1wrm8VyeEFKkyYf8O6dPfNNP9gVwizt8ld4CQ0rh610XF4hqkrikaM41Pnp3XkkJIfO-S4Tg7IxlhzoYct9uP-EAJKcfLH1CriKIBjzmlhLlshZ1lYfGE1u2IO7skvzBDaTI3NJ1jWelZ3wzGbuhJW9BEyh86KV5mIgcxqGiCiO_xYX1B8levNSP3ATb7ZcAnlVbMObi9bGz21N5GTf1bqlQ0w_AEQn_1qa-Vd5UHumSzcIKlOidJQigt0u8PpzquzoNTCpVtZsyUfDpr4Vct4SYcXmOaHVYroIYy3yonpA8q5uHyIDPZd_CjEtloKmD1Px1rCxM7uw9d-lLKcK1rtV58DDU4RqCtqLl-hqQ-jC5S1r9NnHCE23snPKlk84kxmMdbHX5-iZ1IyfCkT45yP6hIoRB-25q4bb17cBqAINPjj7TaPhIfL1bqT0QW3yKdzB2w7g5owwklCWG6PtC0zd1paJuzgYXwcYr0Ti8cQMDSoLbuGLhU31NZe0WD1hLDwTrC1j9E9q0jBvrIGo5j7kVvgz0cDG_s_ejOdfBhCNy-mbF7KgKc5ueYlpUb0BH7j98922ffWdus_DfTD67uFyx7QBSo731yiuGhW4o58Z48kU1RUr8Lq4gWN8m4Q7i4v76QnsGq1qj95IQ
#${datas}          [{"part_no": "ISD1620BSYI", "supplier_part_no": "I1620BSYI**Esolo", "packing_name": "Cut Tape", "warehouse_name": "PF4", "qty": 48, "reserved_qty": 0}]


*** Keywords ***
request_get
    [Arguments]     ${path}    ${datas}  ${expected_status}  ${headers}=None    ${cookies}=None
    ${params}=      create dictionary
    ${resp}=        _Get_Request    ${hostV1}    ${path}   ${datas}    ${expected_status}    ${params}    ${headers}     ${cookies}
    [Return]        ${resp}

*** Keywords ***
request_post
    [Arguments]    ${path}    ${datas}   ${expected_status}   ${headers}=None    ${cookies}=None
    ${params}=     create dictionary
    ${resp}=       _Post_Request    ${hostV1}    ${path}    ${datas}   ${expected_status}    ${params}    ${headers}      ${cookies}
    [Return]       ${resp}

#*** Test Cases ***
#check request get
#    ${header}=      create dictionary      Authorization=${token}
#    ${datas}        create dictionary
#    ${expected_status}    set variable  200
#    ${resp}=        request_get      ${path}     ${datas}     ${expected_status}      ${header}
#    log to console  ${resp.json()}

#check request post
#    ${header}=      create dictionary      Authorization=${token}
#    ${resp}=        request_post      ${path}    ${datas}      ${header}
#    log to console  ${resp.json()}

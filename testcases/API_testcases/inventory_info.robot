*** Settings ***
Library          RequestsLibrary
Library          Collections
Library          json
Library          OperatingSystem

*** Variables ***
${hostV1}        https://b2bapi-beta.techdesignlink.com
${token}         Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTY4NzVkZTBmNjllMTYxMjNlYzMxN2YyNDUwM2I2YjA0MmQxNmEyODJjYmQ4OTkzYTE2NmJiY2I1MThkMTA4NzM2MWFjMmE2Njk3NzU0YjQiLCJpYXQiOiIxNjE1MjgxMTM0LjA4NjU1MSIsIm5iZiI6IjE2MTUyODExMzQuMDg2NTU1IiwiZXhwIjoiMTkzMDgxMzkzNC4wNzk4ODAiLCJzdWIiOiIzMDdiNDRjYy02YTNhLTExZTgtYTRmYy0wMjU4MTExMzRmMTkiLCJzY29wZXMiOltdfQ.ZjJ3cuBxXmb8v-pa9I-TCjwlJJc1wrm8VyeEFKkyYf8O6dPfNNP9gVwizt8ld4CQ0rh610XF4hqkrikaM41Pnp3XkkJIfO-S4Tg7IxlhzoYct9uP-EAJKcfLH1CriKIBjzmlhLlshZ1lYfGE1u2IO7skvzBDaTI3NJ1jWelZ3wzGbuhJW9BEyh86KV5mIgcxqGiCiO_xYX1B8levNSP3ATb7ZcAnlVbMObi9bGz21N5GTf1bqlQ0w_AEQn_1qa-Vd5UHumSzcIKlOidJQigt0u8PpzquzoNTCpVtZsyUfDpr4Vct4SYcXmOaHVYroIYy3yonpA8q5uHyIDPZd_CjEtloKmD1Px1rCxM7uw9d-lLKcK1rtV58DDU4RqCtqLl-hqQ-jC5S1r9NnHCE23snPKlk84kxmMdbHX5-iZ1IyfCkT45yP6hIoRB-25q4bb17cBqAINPjj7TaPhIfL1bqT0QW3yKdzB2w7g5owwklCWG6PtC0zd1paJuzgYXwcYr0Ti8cQMDSoLbuGLhU31NZe0WD1hLDwTrC1j9E9q0jBvrIGo5j7kVvgz0cDG_s_ejOdfBhCNy-mbF7KgKc5ueYlpUb0BH7j98922ffWdus_DfTD67uFyx7QBSo731yiuGhW4o58Z48kU1RUr8Lq4gWN8m4Q7i4v76QnsGq1qj95IQ
${data}          [{"part_no": "ISD1620BSYI", "supplier_part_no": "I1620BSYI**Esolo", "packing_name": "Cut Tape", "warehouse_name": "PF4", "qty": 48, "reserved_qty": 0}]
${checkData}     {'part_no': 'ISD1620BSYI', 'supplier_part_no': 'I1620BSYI**Esolo', 'packing_name': 'Cut Tape', 'warehouse_name': 'PF4', 'qty': 48, 'reserved_qty': 0}
${**kwarg}       expected_status=200

*** Test Cases ***
TDC API test:post inventory Info
  Create Session  tdcv1                  ${hostV1}
  ${header}=      create dictionary      Authorization=${token}    Content-Type=application/json
  #${data}         to json                ${data}
  ${resp}=        POST On Session        tdcv1    /api/v1/product-inventory     headers=${header}     data=${data}    expected_status=200
  log to console  ${resp.json()}
  ${check}=       convert to string      ${resp.json()}
  Should Contain x times    ${check}     Success      1
  Should Contain x times    ${check}     result       1

TDC API test:get inventory Info
  Create Session  tdcv1                  ${hostV1}
  ${header}=      create dictionary      Authorization=${token}    Content-Type=application/json
  ${resp}=        GET On Session         tdcv1    /api/v1/product-inventory     headers=${header}
  ${check}=       convert to string      ${resp.json()}
  ${checkData}=   convert to string      ${checkData}
  log to console  ${check}
  Should Contain x times    ${check}     Success      1
  Should Contain x times    ${check}     result       1
  #should contain x times    ${check}     ${checkData}      1

TDC API Test:get your connect
  Create Session  tdcv1                  ${hostV1}
  ${header}=      create dictionary      Authorization=${token}    Content-Type=application/json
  ${resp}=     GET On Session     tdcv1      /api/v1/connect     heades=${header}    expected_status=200
  log to console     ${resp.json()}
  ${check}=       convert to string      ${resp.json()}
  ${checkData}=   convert to string      ${checkData}
  log to console  ${check}
  Should Contain x times    ${check}     Success      1
  Should Contain x times    ${check}     result       1


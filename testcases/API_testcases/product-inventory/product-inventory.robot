*** Settings ***
Resource          ../tdc.robot
Library           JSONLibrary
Library           String

*** Variables ***
${token}          Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNTY4NzVkZTBmNjllMTYxMjNlYzMxN2YyNDUwM2I2YjA0MmQxNmEyODJjYmQ4OTkzYTE2NmJiY2I1MThkMTA4NzM2MWFjMmE2Njk3NzU0YjQiLCJpYXQiOiIxNjE1MjgxMTM0LjA4NjU1MSIsIm5iZiI6IjE2MTUyODExMzQuMDg2NTU1IiwiZXhwIjoiMTkzMDgxMzkzNC4wNzk4ODAiLCJzdWIiOiIzMDdiNDRjYy02YTNhLTExZTgtYTRmYy0wMjU4MTExMzRmMTkiLCJzY29wZXMiOltdfQ.ZjJ3cuBxXmb8v-pa9I-TCjwlJJc1wrm8VyeEFKkyYf8O6dPfNNP9gVwizt8ld4CQ0rh610XF4hqkrikaM41Pnp3XkkJIfO-S4Tg7IxlhzoYct9uP-EAJKcfLH1CriKIBjzmlhLlshZ1lYfGE1u2IO7skvzBDaTI3NJ1jWelZ3wzGbuhJW9BEyh86KV5mIgcxqGiCiO_xYX1B8levNSP3ATb7ZcAnlVbMObi9bGz21N5GTf1bqlQ0w_AEQn_1qa-Vd5UHumSzcIKlOidJQigt0u8PpzquzoNTCpVtZsyUfDpr4Vct4SYcXmOaHVYroIYy3yonpA8q5uHyIDPZd_CjEtloKmD1Px1rCxM7uw9d-lLKcK1rtV58DDU4RqCtqLl-hqQ-jC5S1r9NnHCE23snPKlk84kxmMdbHX5-iZ1IyfCkT45yP6hIoRB-25q4bb17cBqAINPjj7TaPhIfL1bqT0QW3yKdzB2w7g5owwklCWG6PtC0zd1paJuzgYXwcYr0Ti8cQMDSoLbuGLhU31NZe0WD1hLDwTrC1j9E9q0jBvrIGo5j7kVvgz0cDG_s_ejOdfBhCNy-mbF7KgKc5ueYlpUb0BH7j98922ffWdus_DfTD67uFyx7QBSo731yiuGhW4o58Z48kU1RUr8Lq4gWN8m4Q7i4v76QnsGq1qj95IQ
${path}           /api/v1/product-inventory
@{itemList}       packing_name    part_no   qty    reserved_qty    supplier_part_no    warehouse_name


*** Test Cases ***
Test case1: Get company product inventory
    ${resp}=        product-inventory_Get       200
    product-inventory_GetDataVerify             ${resp.json()}

Test casse2: Set company product inventory(no change)
    ${data}         getNthResultData            0
    ${resp}=        product-inventory_Post      ${data}           200
    product-inventory_PostDataVerify(NoChange)  ${resp.json()}


Test casse3: Set company product inventory
    ${data}         getNthResultData            1
    ${value}        getValueOfQty               ${data}           qty
    ${value}        Evaluate                    int(${value}+1)
    ${value}        Convert to integer          ${value}
    ${data}         changeData      ${data}     qty               ${value}
    ${resp}=        product-inventory_Post      ${data}           200
    product-inventory_PostDataVerify            ${resp.json()}    ${data}
    log to console  ${resp.json()}



*** Keywords ***
product-inventory_Get
    [Arguments]     ${expected_status}
    ${datas}        Create dictionary
    ${header}       Create dictionary     Authorization=${token}
    ${resp}=        request_get           ${path}     ${datas}     ${expected_status}     ${header}
    [Return]        ${resp}

product-inventory_Post
    [Arguments]     ${datas}     ${expected_status}
    ${header}       create dictionary     Authorization=${token}
    ${resp}=        request_post          ${path}     ${datas}     ${expected_status}     ${header}
    [Return]        ${resp}

product-inventory_GetDataVerify
    [Arguments]     ${content}
    ${Code}         Get Value From Json   ${content}    $..Code
    ${Message}      Get value From Json   ${content}    $..Message
    ${results}      Get Value From Json   ${content}    $..results[0]
    log to console  ${results}
    #Verify 'Code' is correct or not
    ${Check}        Get from list         ${Code}       0
    Should be equal as integers           ${Check}      0
    #Verify 'Message' is correct or not
    ${Check}        Get from list         ${Message}    0
    Should be equal as strings            ${Check}      Success
    #Verify 'results' include part_no, supplier_part_no, packing name , warehouse_name,qty,reserved_qty
    ${Check}        Get from list         ${results}    0
    ${Items}        Get dictionary keys   ${Check}
    FOR    ${index}   IN RANGE      6
           should be equal as strings     ${Items}[${index}]     ${itemList}[${index}]
    END

product-inventory_PostDataVerify(NoChange)
    [Arguments]     ${content}
    ${Code}         Get Value From Json   ${content}    $..Code
    ${Message}      Get value From Json   ${content}    $..Message
    ${results}      Get Value From Json   ${content}    $..results[0]
    #Verify 'Code' is correct or not
    ${Check}        Get from list         ${Code}       0
    Should be equal as integers           ${Check}      0
    #Verify 'Message' is correct or not
    ${Check}        Get from list         ${Message}    0
    Should be equal as strings            ${Check}      Success
    #Verify 'Result' is empty
    should be empty                       ${results}

product-inventory_PostDataVerify
    [Arguments]     ${content}            ${compare}
    ${Code}         Get Value From Json   ${content}    $..Code
    ${Message}      Get value From Json   ${content}    $..Message
    ${results}      Get Value From Json   ${content}    $..results[0]
    #Verify 'Code' is correct or not
    ${Check}        Get from list         ${Code}       0
    Should be equal as integers           ${Check}      0
    #Verify 'Message' is correct or not
    ${Check}        Get from list         ${Message}    0
    Should be equal as strings            ${Check}      Success
    #Verify 'Result' same as changing
    @{compare}      evaluate              list(${compare})
    log             ${compare}
    log             ${results}
    Dictionaries should be equal          ${results}[0]           ${compare}[0]

getNthResultData
    [Arguments]     ${index}
    ${resp}         product-inventory_Get       200
    ${data}         Get Value From Json         ${resp.json()}    $..results[${index}]
    ${data}         convert to string           ${data}
    ${data}         Replace String              ${data}           '         "
    [Return]        ${data}

ChangeData
    [Arguments]     ${data}     ${key}    ${value}
    @{data}         evaluate    list(${data})
    set to dictionary    ${data}[0]      ${key}       ${value}
    ${data}         convert to string    ${data}
    ${data}         Replace String       ${data}      '         "
    [Return]        ${data}

getValueOfQty
    [Arguments]     ${data}      ${key}
    @{data}         evaluate     list(${data})
    ${value}        get from dictionary   ${data}[0]   ${key}
    [Return]        ${value}
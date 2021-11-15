*** Settings ***
Resource          ../../../tdc_b2b_host.robot
Resource          ../../../../../config/beta_setting.robot
Library           JSONLibrary
Library           String

*** Variables ***
${path}           /api/v1/product-inventory
@{itemList}       packing_name    part_no    qty    reserved_qty    supplier_part_no    warehouse_name

*** Test Cases ***
Test case1: Get company product inventory
    ${resp}         product-inventory_get       200
    product-inventory_get_data_verify             ${resp.json()}

Test case2: Set company product inventory(no change)
    ${data}         get_nth_result_data            0
    log to console  ${data}
    ${resp}         product-inventory_post      ${data}           200
    product-inventory_post_data_verify_(no_change)  ${resp.json()}

Test case3: Change qty in company product inventory
    ${data}         get_nth_result_data            1
    ${value}        get_value_of_qty               ${data}           qty
    ${value}        Evaluate                    int(${value}+1)
    ${data}         change_data      ${data}     qty               ${value}
    ${resp}         product-inventory_post      ${data}           200
    product-inventory_post_data_verify            ${resp.json()}    ${data}

Test case4: Change reserved_qty in company product inventory
    ${data}         get_nth_result_data            1
    ${value}        get_value_of_qty               ${data}           qty
    ${value}        Evaluate                    int(${value}-1)
    ${data}         change_data      ${data}     qty               ${value}
    ${value}        get_value_of_qty               ${data}           reserved_qty
    ${value}        Evaluate                    int(${value}+1)
    ${data}         change_data      ${data}     reserved_qty      ${value}
    ${resp}         product-inventory_post      ${data}           200
    product-inventory_post_data_verify            ${resp}    ${data}



*** Keywords ***
product-inventory_get
    [Arguments]     ${expectedStatus}
    ${datas}        Create dictionary
    ${header}       Create dictionary      Authorization=${TOKEN}
    ${resp}=        request_get            ${path}     ${datas}     ${expectedStatus}     ${header}
    [Return]        ${resp}

product-inventory_post
    [Arguments]     ${datas}     ${expectedStatus}
    ${header}       create dictionary      Authorization=${TOKEN}
    ${resp}=        request_post           ${path}     ${datas}     ${expectedStatus}     ${header}
    [Return]        ${resp}

product-inventory_get_data_verify
    [Arguments]     ${content}
    ${Code}         Get Value From Json    ${content}    $..Code
    ${Message}      Get value From Json    ${content}    $..Message
    ${results}      Get Value From Json    ${content}    $..results[0]
    log to console  ${results}
    #Verify 'Code' is correct or not
    ${Check}        Get from list          ${Code}       0
    Should be equal as integers            ${Check}      0
    #Verify 'Message' is correct or not
    ${Check}        Get from list          ${Message}    0
    Should be equal as strings             ${Check}      Success
    #Verify 'results' include part_no, supplier_part_no, packing name , warehouse_name,qty,reserved_qty
    ${Check}        Get from list          ${results}    0
    ${Items}        Get dictionary keys    ${Check}
    FOR    ${index}   IN RANGE      6
                should be equal as strings     ${Items}[${index}]     ${itemList}[${index}]
    END

product-inventory_post_data_verify_(no_change)
    [Arguments]     ${content}
    ${Code}         Get Value From Json    ${content}    $..Code
    ${Message}      Get value From Json    ${content}    $..Message
    ${results}      Get Value From Json    ${content}    $..results[0]
    #Verify 'Code' is correct or not
    ${Check}        Get from list          ${Code}       0
    Should be equal as integers            ${Check}      0
    #Verify 'Message' is correct or not
    ${Check}        Get from list          ${Message}    0
    Should be equal as strings             ${Check}      Success
    #Verify 'Result' is empty
    should be empty                        ${results}

product-inventory_post_data_verify
    [Arguments]     ${content}    ${compare}
    ${Code}         Get Value From Json    ${content}    $..Code
    ${Message}      Get value From Json    ${content}    $..Message
    ${results}      Get Value From Json    ${content}    $..results[0]
    #Verify 'Code' is correct or not
    ${Check}        Get from list          ${Code}       0
    Should be equal as integers            ${Check}      0
    #Verify 'Message' is correct or not
    ${Check}        Get from list          ${Message}    0
    Should be equal as strings             ${Check}      Success
    #Verify 'Result' same as changing
    @{compare}      evaluate               list(${compare})
    log             ${compare}
    log             ${results}
    run keyword and continue on failure    Dictionaries should be equal          ${results}[0]           ${compare}[0]

get_nth_result_data
    [Arguments]     ${index}
    ${resp}         product-inventory_get  200
    ${data}         Get Value From Json    ${resp.json()}    $..results[${index}]
    ${data}         convert to string      ${data}
    ${data}         Replace String         ${data}           '         "
    [Return]        ${data}

Change_data
    [Arguments]     ${data}     ${key}    ${value}
    @{data}         evaluate    list(${data})
    set to dictionary    ${data}[0]       ${key}       ${value}
    ${data}         convert to string     ${data}
    ${data}         Replace String        ${data}      '           "
    [Return]        ${data}

get_value_of_qty
    [Arguments]     ${data}      ${key}
    @{data}         evaluate     list(${data})
    ${value}        get from dictionary   ${data}[0]   ${key}
    [Return]        ${value}
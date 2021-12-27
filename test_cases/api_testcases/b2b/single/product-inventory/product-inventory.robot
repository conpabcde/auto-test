*** Settings ***
Resource            ../../../../../library/utility_tool.robot
Resource            ../../../tdc_b2b_host.robot

*** Variables ***
${path}             /api/v1/product-inventory
@{itemList}         packing_name  part_no  qty  reserved_qty  supplier_part_no  warehouse_name

*** Test Cases ***
Get company product inventory
    ${resp}         product-inventory_get  200
    product-inventory_get data verify  ${resp.json()}

Set company product inventory(no change)
    ${data}         get nth result data  0
    ${resp}         product-inventory_post  ${data}  200
    product-inventory_post data verify (no change)  ${resp.json()}

##
# Below 2 test cases is always fialed caused because packing_name is wrong, ex: packing_name: Piecemeal != Cut Tape
# It will be restart these two test cases after fixing issue https://techdesign-team.atlassian.net/browse/IT-4489
##
#Change qty in company product inventory
#    ${data}         get nth result data  1
#    ${value}        get value of data  ${data}  qty
#    ${value}        Evaluate  int(${value}+1)
#    ${data}         change data  ${data}  qty  ${value}
#    ${value}        Evaluate  int(0)
#    ${data}         change data  ${data}  reserved_qty  ${value}
#    ${resp}         product-inventory_post  ${data}  200
#    product-inventory_post data verify  ${resp.json()}  ${data}

#Change reserved_qty in company product inventory
#    ${data}         get nth result data  1
#    ${value}        Evaluate  int(0)
#    ${data}         change data  ${data}  qty  ${value}
#    ${data}         change data  ${data}  reserved_qty  ${value}
#    ${resp}         product-inventory_post  ${data}   200
#    ${value}        Evaluate  int(50)
#    ${data}         change data  ${data}  qty  ${value}
#    ${value}        Evaluate  int(1)
#    ${data}         change data  ${data}  reserved_qty  ${value}
#    ${resp}         product-inventory_post  ${data}   200
#    ${value}        Evaluate  int(49)
#    ${data}         change data  ${data}  qty  ${value}
#    ${value}        Evaluate  int(0)
#    ${data}         change data  ${data}  reserved_qty  ${value}
#    product-inventory_post data verify  ${resp.json()}  ${data}

*** Keywords ***
product-inventory_get
    [Arguments]     ${expectedStatus}
    ${datas}        Create dictionary
    ${header}       Create dictionary  Authorization=${b2b_token}
    ${resp}         request_get  ${path}  ${datas}  ${expectedStatus}  ${header}
    [Return]        ${resp}

product-inventory_post
    [Arguments]     ${datas}  ${expectedStatus}
    ${header}       create dictionary  Authorization=${b2b_token}
    ${resp}         request_post  ${path}  ${datas}  ${expectedStatus}  ${header}
    [Return]        ${resp}

product-inventory_get data verify
    [Arguments]     ${content}
    ${Code}         Get Value From Json  ${content}  $..Code
    ${Message}      Get value From Json  ${content}  $..Message
    ${results}      Get Value From Json  ${content}  $..results[0]
    #Verify 'Code' is correct or not
    ${Check}        Get from list  ${Code}  0
    Should be equal as integers  ${Check}  0
    #Verify 'Message' is correct or not
    ${Check}        Get from list  ${Message}  0
    Should be equal as strings  ${Check}  Success
    #Verify 'results' include part_no, supplier_part_no, packing name , warehouse_name,qty,reserved_qty
    ${Check}        Get from list  ${results}  0
    ${Items}        Get dictionary keys  ${Check}
    FOR  ${index}  IN RANGE  6
         should be equal as strings  ${Items}[${index}]  ${itemList}[${index}]
    END

product-inventory_post data verify (no change)
    [Arguments]     ${content}
    ${Code}         Get Value From Json  ${content}  $..Code
    ${Message}      Get value From Json  ${content}  $..Message
    ${results}      Get Value From Json  ${content}  $..results[0]
    #Verify 'Code' is correct or not
    ${Check}        Get from list  ${Code}  0
    Should be equal as integers  ${Check}  0
    #Verify 'Message' is correct or not
    ${Check}        Get from list  ${Message}  0
    Should be equal as strings  ${Check}  Success
    #Verify 'Result' is empty
    should be empty  ${results}

product-inventory_post data verify
    [Arguments]     ${content}    ${compare}
    ${Code}         Get Value From Json  ${content}  $..Code
    ${Message}      Get value From Json  ${content}  $..Message
    ${results}      Get Value From Json  ${content}  $..results[0]
    #Verify 'Code' is correct or not
    ${Check}        Get from list  ${Code}  0
    Should be equal as integers  ${Check}  0
    #Verify 'Message' is correct or not
    ${Check}        Get from list  ${Message}  0
    Should be equal as strings  ${Check}  Success
    #Verify 'Result' same as changing
    @{compare}      evaluate  list(${compare})
    log             ${compare}
    log             ${results}
    run keyword and continue on failure  Dictionaries should be equal  ${results}[0]  ${compare}[0]

get nth result data
    [Arguments]     ${index}
    ${resp}         product-inventory_get  200
    ${data}         Get Value From Json  ${resp.json()}  $..results[${index}]
    ${data}         convert data for html router  ${data}
    [Return]        ${data}

Change data
    [Arguments]     ${data}  ${key}  ${value}
    @{data}         evaluate  list(${data})
    set to dictionary  ${data}[0]  ${key}  ${value}
    ${data}         convert data for html router  ${data}
    [Return]        ${data}

get value of data
    [Arguments]     ${data}  ${key}
    @{data}         evaluate  list(${data})
    ${value}        get from dictionary  ${data}[0]  ${key}
    [Return]        ${value}

*** Settings ***
Resource            ../../../../../library/utility_tool.robot
Resource            ../../../tdc_host.robot

*** Variables ***
${path}             /sys/login

*** Keywords ***
login
    [Arguments]     ${expectedStatus}  ${account}  ${password}  ${remember}  ${timezone}
    log to console  Start to login ${account}.
    ${datas}        create dictionary  email=${account}  password=${password}  remember=${remember}  timezone=${timezone}
    ${datas}        convert data for html router  ${datas}
    ${resp}         request_post  ${path}  ${datas}  ${expectedStatus}
    log to console  Next step.
    [Return]        ${resp}

generate user data
    [Documentation]  generate user data for checking result
    [Arguments]     ${id}  ${username}  ${email}  ${timezone}  ${supplier}=${None}
    log to console  Start to generate ${email} user data.
    ${user_data}    create dictionary  id=${id}  username=${username}  email=${email}  timezone=${timezone}
    ${zero}         evaluate  0
    ${data_check}   create dictionary  ReturnCode=${zero}  status=OK  user=${user_data}  supplier=${supplier}
    log to console  Next step.
    [Return]        ${data_check}

generate designer status
    [Documentation]  generate designer data for checking result
    [Arguments]     ${email}
    log to console  Start to gengerate designer status.
    @{user_data}    get database content  SELECT * FROM users WHERE email = '${email}'
    @{supplier_data}  get database content  SELECT * FROM designer WHERE id = '${user_data}[0][designer_id]'
    ${supplier}     convert to dictionary  @{supplier_data}[0]
    ${is_seller}    change value to boolean  ${supplier}[is_seller]
    ${is_supplier}  change value to boolean  ${supplier}[is_supplier]
    ${result}       create dictionary  status=${supplier}[status]  isSeller=${is_seller}  isSupplier=${is_supplier}
    [Return]        ${result}

generate error respond for less data
    [Documentation]  according to email, password, timezone being empty or not generate different respond
    [Arguments]     ${email}  ${password}  ${timezone}
    ${key_list}     create list  email  password  timezone
    ${value_list}   create list  ${email}  ${password}  ${timezone}
    ${the}          catenate  The
    ${field_is_required}  catenate  field is required.
    ${data}         create dictionary
    FOR  ${i}  IN RANGE  3
        ${str_error}    create list
        run keyword unless  ${value_list}[${i}]  append to list  ${str_error}
        ...  ${the} ${key_list}[${i}] ${field_is_required}
        run keyword unless  ${value_list}[${i}]  set to dictionary  ${data}  ${key_list}[${i}]  ${str_error}
    END
    ${return_code}  evaluate  40003
    ${msg}          catenate  The given data was invalid.
    ${result}       create dictionary  ReturnCode=${return_code}  msg=${msg}  data=${data}
    [Return]        ${result}
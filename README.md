# auto-test
1. Robot framework
2. for API test 
3. for UI test (web)

## Install the library 
1. 安裝python3.9  
   cmd: ```brew install python@3.9```
2. 安裝 robotframework套件
   Cmd: ```pip3 install -r requirements --user```

## 使用的IDE
可以使用 pycharm，下載地方(請選Community)
https://www.jetbrains.com/pycharm/download/#section=mac   

## 測試環境變數
1. 打開env_local_data.yaml 檔案
2. 更改裡面的數據
   * host: 環境的 url，如：在 beta環境， beta.techdesignlink.com
   * b2b_host: 供應商打入 tdc 系統的 url 如：在 beta環境，https://b2bapi-beta.techdesignlink.com
   * b2b_token: 供應商打入 tdc 系統所需要的token，如何產生token 請參考 https://techdesign-team.atlassian.net/wiki/spaces/IT/pages/678101082/supplier+Token
   * b2b_err_token: 任意一個錯誤的token，隨便寫
   * db_host: sql server 的 host name
   * db_port: sql server 的 port
   * db_database: sql server 裡的 database 名稱
   * db_username: sql server 使用者帳號
   * db_password: sql server 使用者密碼
   * browser: 想要用什麼browser跑自動化測試，使用chrome，可以下 `chrome` 。如果server 沒有 gui，可以下 `headlesschrome`

## webdrivermanager
1. Document: https://robotframework.org/SeleniumLibrary/
```
pip3 install webdrivermanager
webdrivermanager firefox chrome --linkpath /usr/local/bin
```

## 如何跑robot framework
1. 如果是要測試一整包的test cases，要到專案的根目錄下指令
   Cmd: ```robot --suite test_cases . ```
2. 如果是要測試一個 robot file，到該file的目錄下指令
   Cmd: ```robot -d results Your_File.robot```
3. 如果是要測試一條 test case，如 test_case.robot 裡的`Scenario: Login On Homepage`，到該robot file的目錄下指令 
   Cmd: ```robot -t "Scenario: Login On Homepage" test_case.robot```

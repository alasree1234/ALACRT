*** Settings ***
Documentation         Test suite for creating a Acoount Related Contact record in Salesforce.
Library               QWeb
Library               QForce
Library               String
Suite Setup           Setup Browser
Suite Teardown        Close Browser
Resource              common.robot
Resource              common1.robot

*** Variables *** ***
# ${BROWSER}          chrome
# ${login_url}        https://login.salesforce.com
# #${User_name}       sreelekha@sfdc.com
# #${Password}        Cloud@1234
# ${User_name}        rams@9714.com
# ${Password}         September@123
# ${Acc_name}         Ishani
# ${Update_Acc_name}                              Ishu
# ${contact_name}     Alasree
# #${phone}           89898989
# ${account_url}
# ${contact_url}
# ${url_parts}
# ${Rating}           Hot
# ${update_rating}    Cold
# ${isActive}         Yes,It si Active
# ${serial_number}    12345
*** Keywords ***
Setup Browser
    Open Browser      ${login_url}                ${BROWSER}
Login
    #[Documentation]                              Log in to Salesforce
    GoTo              ${login_url}
    TypeText          Username                    ${User_name}
    TypeText          Password                    ${Password}
    ClickText         Log In
*** Test Cases ***
Creating Account
    [Tags]            Account
    Appstate          Login
    LaunchApp         Sales
    ClickText         Accounts
    ClickElement      xpath=//a[@title="New"]
    #ClickText        New
    UseModal          On
    ##TypeText        *Account Name               ${Acc_name}
    ClickElement      xpath=//input[@name='Name']
    TypeText          *Account Name               ${Acc_name}

    ClickElement      xpath=//button[@aria-label="Rating"]
    PickList          Rating                      ${Rating}

    ClickElement      xpath=//textarea[@class='slds-textarea']
    TypeText          isActive                    ${isActive}

    ClickElement      xpath=//textarea[@class="slds-textarea"]
    TypeText          Billing Street              Hyderabad

    ClickElement      xpath=//input[@name="SLASerialNumber__c"]
    TypeText          SLA Serial Number           ${serial_number}
    TypeText          Description                 alasree
    ClickText         Save                        Partial_match=false

    Sleep             5
    ${account_url}    GetUrl
    ${url_parts}      Split String                ${account_url}         /
    ${account_id}     Set Variable                ${url_parts}[5]

updation of Account record
    #ClickElement     xpath=//svg[@data-key="down"]
    #ClickElement     xpath=//button[@class="slds-assistive-text"]
    [Tags]            Update Account
    ClickElement      xpath=//lightning-button-menu[@class='menu-button-item slds-dropdown-trigger slds-dropdown-trigger_click']//button[@type='button']
    sleep             5s
    ClickText         Edit                        Partial_match=false
    UseModal          On
    ClickElement      xpath=//input[@name="Name"]

    TypeText          Account Name                ${Update_Acc_name}

    #ClickElement     xpath=//button[@aria-label="Rating"]
    #ClickElement     xpath=//button[@data-value="Hot"]
    #ClickElement     xpath=//button[@title="Edit Rating"]
    ClickElement      xpath=//button[@data-value="Hot"]
    #ClickText        Rating                      ${update_rating}
    PickList          Rating                      Cold

    # ClickElement    xpath=//button[@name="SaveEdit"]
    #ClickElement     xpath=//button[@kx-type="ripple"]
    ClickElement      xpath=//lightning-button[@variant="brand"]//button[@type='button']

    ClickText         Save                        Partial_match=false
Delete An Account
    [Tags]            Delete Account
    ClickElement      xpath=//lightning-button-menu[@class='menu-button-item slds-dropdown-trigger slds-dropdown-trigger_click']//button[@type='button']
    sleep             5s

    ClickText         Delete                      Partial_match=false
    UseModal          On
    ClickElement      xpath=//button[@title="Delete"]

    #ClickText        Delete                      Partial_match=false



Logout

    ClickElement      xpath=//span[@class="photoContainer forceSocialPhoto"]//span[@class="uiImage"]
    #ClickText        View profile
    Sleep             5
    ClickElement      xpath=//a[@class="profile-link-label logout uiOutputURL"]
    ClickText         Log Out


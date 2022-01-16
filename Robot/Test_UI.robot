*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${URL}    https://www.apple.com/th/

${menu_iphone}    //*[@class="ac-gn-link ac-gn-link-iphone"]
${button_buy_13pro}    //*[@id="main"]//*[@data-analytics-title="buy -  iphone 13 pro"]

${select_screen_size6_1inch}    //*[@class="rc-dimension-selector-row form-selector"][1]
${text_iphone_model}    //*[@class="rc-dimension-selector-row form-selector"][1]//*[@class="as-dimension-chicklets"]
${select_color_sierrablue}    //*[@class="rc-dimension-multiple form-selector-swatch column large-6 small-6 form-selector"][1]
${text_color}    //*[@class="rc-dimension-multiple form-selector-swatch column large-6 small-6 form-selector"][1]//span[2]

${select_capacity_128gb}    //*[@class="rc-dimension-multiple form-selector-threeline column large-6 small-6 form-selector"][1]
${text_capacity}     //*[@class="rc-dimension-multiple form-selector-threeline column large-6 small-6 form-selector"][1]//span[1][@class="form-selector-title"]

${text_fullprice}    //*[@class="rf-flagship-summary"]//*[@class="rc-prices-fullprice"]
${button_add_to_cart}    //*[@id="root"]//*[@name="add-to-cart"]

${button_bag_view}    //*[@id="root"]//*[@value="proceed"]

${text_iteminfo}    //*[@data-autom="bag-item-name"]
${text_iteminfo_price}    //*[@class="rs-iteminfo-price"]/p
${text_summary_totol_price}    //*[@data-autom="bagtotalvalue"]
${text_financing_options}    //*[@id="rs-financingOptions-overlay"]
${button_checkout}    //*[@id="shoppingCart.actions.checkout"]

${button_guest_login}    //*[@id="signIn.guestLogin.guestLogin"]

*** Keywords ***
Click Menu iPhone and Buy iPhone
    Wait Until Element Is Visible    ${menu_iphone}    timeout=10s
    Click Element    ${menu_iphone}
    Wait Until Element Is Visible    ${button_buy_13pro}    timeout=10s
    Click Element    ${button_buy_13pro}

Select Screen Size
    Wait Until Element Is Visible    ${select_screen_size6_1inch}    timeout=20s
    Click Element    ${select_screen_size6_1inch}
    ${iphone_model}    Get Text    ${text_iphone_model}
    [Return]    ${iphone_model}

Select Color
    Click Element    ${select_color_sierrablue}
    ${iphone_color}    Get Text    ${text_color}
    [Return]    ${iphone_color}

Select Capacity
    Click Element    ${select_capacity_128gb}
    ${iphone_capacity}    Get Text    ${text_capacity}
    ${iphone_capacity}    Get Regexp Matches    ${iphone_capacity}    .*GB
    [Return]    ${iphone_capacity[0]}
    
Click Add To Cart
    ${iphone_fullprice}    Get Text    ${text_fullprice}
    Click Button    ${button_add_to_cart}
    [Return]    ${iphone_fullprice}

Click View Cart
    Wait Until Element Is Visible    ${button_bag_view}    timeout=20s
    Click Element    ${button_bag_view}

Verify Payment Screen and Click Checkout
    [Arguments]    ${iphone_model}    ${iphone_color}    ${iphone_capacity}    ${iphone_fullprice}

    Wait Until Element Is Visible    ${text_iteminfo}    timeout=20s
    ${summary_iphone_info}    Get Text    ${text_iteminfo}
    ${summary_price}    Get Text    ${text_iteminfo_price}
    ${summary_total_price}    Get Text    ${text_summary_totol_price}

    Should Be Equal As Strings    ${summary_iphone_info}    ${iphone_model} ความจุ ${iphone_capacity} สี${iphone_color}
    Should Be Equal As Strings    ${summary_price}    ${iphone_fullprice}
    Should Be Equal As Strings    ${summary_total_price}    ${iphone_fullprice}

    Click Element    ${button_checkout}
    Wait Until Element Is Visible    ${button_guest_login}    timeout=20s

*** Test Cases ***
Add 1 iPhone to basket and verify payment screen
    [Teardown]    Close Browser
    Open Browser    ${URL}    browser=gc
    Set Selenium Speed    0.5s
    Click Menu iPhone and Buy iPhone
    ${iphone_model}    Select Screen Size
    ${iphone_color}    Select Color
    ${iphone_capacity}    Select Capacity
    ${iphone_fullprice}    Click Add To Cart
    Click View Cart
    Verify Payment Screen and Click Checkout    ${iphone_model}    ${iphone_color}    ${iphone_capacity}    ${iphone_fullprice}
*** Settings ***
Library    SeleniumLibrary
Variables       ../PageObject/locators.py
#Library     DataDriver     ../TestData/TestData.csv

*** Variables ***
${url}      https://www.google.com
${browser}      chrome
${googlesearchText}     Amazon
${selectdropdownItem}       Electronics
${SearcProduct}     Dell computers
${lowerPrice}    30000
${higherrPrice}     50000

*** Test Cases ***

amazon
    Open browser     ${url}    ${browser}
    Search Website     ${googlesearchText}
    Select From Search in DropDown      ${selectdropdownItem}
    Enter search text in search box      ${SearcProduct}
    Apply Filter for range value     ${lowerPrice}       ${higherrPrice}
    Items with rating 5
*** Keywords ***
Open Chrome browser
    [Arguments]     ${url}    ${browser}
    Open Browser   ${url}    ${browser}
    set selenium implicit wait    10
    Maximize Browser Window

Search Website
    [Arguments]     ${serchText}
    input text      ${GoogleSearch_txt}     ${serchText}
    press keys      ${GoogleSearch_PressKeys}     ENTER
    click element    ${ClickOnLink}
Select From Search in DropDown
    [Arguments]     ${selectdropdownItem}
    select from list by label    ${SelectFromDropDown}      ${selectdropdownItem}

Enter search text in search box
    [Arguments]     ${SearchProduct}
    input text      ${Search_Item}        ${SearchProduct}
    click element       ${Icon_Search_Click}

Apply Filter for range value
    [Arguments]    ${lowerPrice}    ${higherrPrice}
    input text      ${filter_lowerPrice}      ${lowerPrice}
    input text      ${filter_higherPrice}     ${higherrPrice}
    click element       ${btn_Go}
    ${count}       get element count      ${count_elements}
    log to console      ${count}
    ${itellist}       get webelements      ${get_element_list}
    #log to console      ${itellist}
    ${currUrl1}      get location
    FOR    ${i}    IN RANGE    1    ${count}
        ${title}    get text    xpath:(//*[contains(@class,'sg-col-20-of-24 s-r')])[${i}]
 #       log to console    ${title}
    END

Items with rating 5
    ${5ratingcount}     get element count      ${count_5_stars_rating}
    ${curloc}  get title
    log to console      Number of 5 stars products count is: ${5ratingcount}
    sleep    2
    ${currloc}      get location
#    log to console    ${currloc}
    FOR    ${i}    IN RANGE    1    30
        ${linkText}    get text    xpath:(//span[normalize-space()='5.0']//preceding::div[2])[${i}]
        log to console    ${linkText}
        scroll element into view    xpath:(//span[normalize-space()='5.0']//preceding::div[2])[${i}]
        click element   xpath:(//span[normalize-space()='5.0']//preceding::div[2])[${i}]
        sleep    5
        switch window    ${curloc}

    END

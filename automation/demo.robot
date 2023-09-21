*** Settings ***
Library    SeleniumLibrary
Variables       ../PageObject/locators.py
#Library     DataDriver     ../TestData/TestData.csv
*** Variables ***
${url}      https://www.amazon.in/s?k=dell+computers&i=electronics&rh=p_36%3A3000000-5000000&qid=1695272769&rnid=1318502031&ref=sr_nr_p_36_5
${browser}      chrome

*** Test Cases ***
amazon
    Oepn browser     ${url}    ${browser}
    sleep    5
    Items with rating 5

*** Keywords ***
Oepn browser
    [Arguments]     ${url}    ${browser}
    Open Browser   ${url}    ${browser}
    set selenium implicit wait    10
#    Maximize Browser Window

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

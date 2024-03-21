@feature=AdminRegion
Feature: Admin region

  @AdminRegion_01 @AdminRegion
  Scenario: All regions list
    Given NGOC_ADMIN_15 open web admin
    When NGOC_ADMIN_15 login to web with role Admin
    And NGOC_ADMIN_15 navigate to "Regions" to "All regions" by sidebar
    And Admin verify info of region
      | id | name                     | type       | pricing | abbreviated | description                                                                                                                                                                                                     |
      | 58 | Pod Direct Central       | Direct     | 5.00%   | PDC         | [blank]                                                                                                                                                                                                         |
      | 26 | Chicagoland Express      | Warehoused | [blank] | CHI         | Chicago, officially the City of Chicago, is the most populous city in Illinois, as well as the third most populous city in the United States. Do not edit this region until further notice - tan                |
      | 58 | Dallas Express           | Warehoused | [blank] | DAL         | [blank]                                                                                                                                                                                                         |
      | 66 | Denver Express           | Warehoused | [blank] | DV          | Denver                                                                                                                                                                                                          |
      | 65 | Phoenix Express          | Warehoused | [blank] | PHX         | Phoenix                                                                                                                                                                                                         |
      | 55 | Pod Direct East          | Direct     | 10.00%  | PDE         | [blank]                                                                                                                                                                                                         |
      | 64 | Atlanta Express          | Warehoused | [blank] | ATL         | Atlanta                                                                                                                                                                                                         |
      | 63 | Florida Express          | Warehoused | [blank] | FL          | Florida                                                                                                                                                                                                         |
      | 62 | Mid Atlantic Express     | Warehoused | [blank] | MA          | Washington, DC, the U.S. capital, is a compact city on the Potomac River, bordering the states of Maryland and Virginia.                                                                                        |
      | 53 | New York Express         | Warehoused | [blank] | NY          | Do not edit this region until further notice - tan                                                                                                                                                              |
      | 58 | Pod Direct West          | Direct     | [blank] | PDW         | Child Region: San Francisco and Los Angeles .Do not edit this region until further notice - tan                                                                                                                 |
      | 25 | North California Express | Warehoused | [blank] | SF          | The San Francisco Bay Area (popularly referred to as the Bay Area) is a populous region surrounding the San Francisco, San Pablo and Suisun Bay estuaries in the northern part of the U.S. state of California. |
      | 67 | Sacramento Express       | Warehoused | [blank] | SAC         | Sacramento                                                                                                                                                                                                      |
      | 51 | South California Express | Warehoused | [blank] | LA          | Greater Los Angeles area Do not edit this region until further notice - tan                                                                                                                                     |

      # Verify Pod Direct Central
    And Admin go to region "Pod Direct Central" detail
    And Admin verify general info of region detail
      | name               | description | abbreviated | deleveryMethod        | cutOffTime | pricing |
      | Pod Direct Central | [blank]     | PDC         | Ship direct to stores | [blank]    | 5.00%   |
    And Admin verify redirect link of region "58" in detail
    # Verify Chicagoland Express
    And Admin go back with button
    And Admin go to region "Chicagoland Express" detail
    And Admin verify general info of region detail
      | name                | description                                                                                                                                                                                      | abbreviated | deleveryMethod  | cutOffTime                                         | pricing |
      | Chicagoland Express | Chicago, officially the City of Chicago, is the most populous city in Illinois, as well as the third most populous city in the United States. Do not edit this region until further notice - tan | CHI         | Pod Consignment | 11 AM PST the day before your set delivery day(s). | [blank] |
    And Admin verify redirect link of region "26" in detail
      # Verify Dallas Express
    And Admin go back with button
    And Admin go to region "Dallas Express" detail
    And Admin verify general info of region detail
      | name           | description | abbreviated | deleveryMethod  | cutOffTime                                        | pricing |
      | Dallas Express | [blank]     | DAL         | Pod Consignment | 11 am (pst) a day before your set delivery day(s) | [blank] |
    And Admin verify redirect link of region "61" in detail
    # Verify Denver Express
    And Admin go back with button
    And Admin go to region "Denver Express" detail
    And Admin verify general info of region detail
      | name           | description | abbreviated | deleveryMethod  | cutOffTime | pricing |
      | Denver Express | Denver      | DV          | Pod Consignment | [blank]    | [blank] |
    And Admin verify redirect link of region "66" in detail
     # Verify Phoenix Express
    And Admin go back with button
    And Admin go to region "Phoenix Express" detail
    And Admin verify general info of region detail
      | name            | description | abbreviated | deleveryMethod  | cutOffTime | pricing |
      | Phoenix Express | Phoenix     | PHX         | Pod Consignment | [blank]    | [blank] |
    And Admin verify redirect link of region "65" in detail
     # Verify Pod Direct East
    And Admin go back with button
    And Admin go to region "Pod Direct East" detail
    And Admin verify general info of region detail
      | name            | description | abbreviated | deleveryMethod        | cutOffTime | pricing |
      | Pod Direct East | [blank]     | PDE         | Ship direct to stores | [blank]    | [blank] |
    And Admin verify redirect link of region "55" in detail
     # Verify Atlanta Express
    And Admin go back with button
    And Admin go to region "Atlanta Express" detail
    And Admin verify general info of region detail
      | name            | abbreviated | deleveryMethod  | cutOffTime | pricing | description |
      | Atlanta Express | ATL         | Pod Consignment | [blank]    | [blank] | Atlanta     |
    And Admin verify redirect link of region "64" in detail
      # Verify Florida Express
    And Admin go back with button
    And Admin go to region "Florida Express" detail
    And Admin verify general info of region detail
      | name            | abbreviated | deleveryMethod  | cutOffTime | pricing | description |
      | Florida Express | FL          | Pod Consignment | [blank]    | [blank] | Florida     |
    And Admin verify redirect link of region "63" in detail
     # Verify Mid Atlantic Express
    And Admin go back with button
    And Admin go to region "Mid Atlantic Express" detail
    And Admin verify general info of region detail
      | name                 | abbreviated | deleveryMethod  | cutOffTime                                        | pricing | description                                                                                                              |
      | Mid Atlantic Express | MA          | Pod Consignment | 1 pm (east) a day before your set delivery day(s) | [blank] | Washington, DC, the U.S. capital, is a compact city on the Potomac River, bordering the states of Maryland and Virginia. |
    And Admin verify redirect link of region "62" in detail
      # Verify New York Express
    And Admin go back with button
    And Admin go to region "New York Express" detail
    And Admin verify general info of region detail
      | name             | abbreviated | deleveryMethod  | cutOffTime                                             | pricing | description                                        |
      | New York Express | NY          | Pod Consignment | 11 am (pst) monday for wed, 11 am (pst) wed for friday | [blank] | Do not edit this region until further notice - tan |
    And Admin verify redirect link of region "53" in detail
     # Verify Pod Direct West
    And Admin go back with button
    And Admin go to region "Pod Direct West" detail
    And Admin verify general info of region detail
      | name            | abbreviated | deleveryMethod        | cutOffTime | pricing | description |
      | Pod Direct West | PDW         | Ship direct to stores | [blank]    | 8.00%   | [blank]     |
    And Admin verify redirect link of region "54" in detail
    # Verify North California Express
    And Admin go back with button
    And Admin go to region "North California Express" detail
    And Admin verify general info of region detail
      | name                     | abbreviated | deleveryMethod  | cutOffTime                                        | pricing | description                                                                                                                                                                                                     |
      | North California Express | SF          | Pod Consignment | 12 PM (PST) a day before your set delivery day(s) | [blank] | The San Francisco Bay Area (popularly referred to as the Bay Area) is a populous region surrounding the San Francisco, San Pablo and Suisun Bay estuaries in the northern part of the U.S. state of California. |
    And Admin verify redirect link of region "25" in detail
      # Verify South California Express
    And Admin go back with button
    And Admin go to region "Sacramento Express" detail
    And Admin verify general info of region detail
      | name               | abbreviated | deleveryMethod  | cutOffTime | pricing | description |
      | Sacramento Express | SAC         | Pod Consignment | [blank]    | [blank] | Sacramento  |
    And Admin verify redirect link of region "67" in detail
     # Verify South California Express
    And Admin go back with button
    And Admin go to region "South California Express" detail
    And Admin verify general info of region detail
      | name                     | abbreviated | deleveryMethod  | cutOffTime                                        | pricing | description                                                                 |
      | South California Express | LA          | Pod Consignment | 12 ps (pst) a day before your set delivery day(s) | [blank] | Greater Los Angeles area Do not edit this region until further notice - tan |
    And Admin verify redirect link of region "51" in detail

  @AdminRegion_02 @AdminRegion
  Scenario: Create new Distribution Center
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx15@podfoods.co | 12345678a |
    When Admin search distribution center "AT Distribution NY Delete 01" by api
    And Admin delete distribution center "" by api

    Given NGOC_ADMIN_15 open web admin
    When NGOC_ADMIN_15 login to web with role Admin
    And NGOC_ADMIN_15 navigate to "Regions" to "Distribution Centers" by sidebar
    And Admin verify default of create new distribution center
    And Admin verify error empty when create new distribution center
    And Admin fill info to create distribution center
      | region           | warehouse           | timeZone                   | name                         | attn | street1            | street2  | city     | state    | zip   | phone      |
      | New York Express | Auto Ngoc LP Mix 01 | Pacific Time (US & Canada) | AT Distribution NY Delete 01 | 123  | 455 Madison Avenue | street 2 | New York | New York | 10022 | 1234567890 |
    And Admin create distribution center success
    And Admin verify result after create distribution center
      | name                         | timezone                   | description                                                    |
      | AT Distribution NY Delete 01 | Pacific Time (US & Canada) | 123, 455 Madison Avenue, street 2, New York, 10022, 1234567890 |
    And Admin go to detail distribution center "AT Distribution NY Delete 01"
    And Admin verify info distribution center detail
      | region           | warehouse           | timeZone                   | name                         | attn | street1            | street2  | city     | state    | zip   | phone      |
      | New York Express | Auto Ngoc LP Mix 01 | Pacific Time (US & Canada) | AT Distribution NY Delete 01 | 123  | 455 Madison Avenue | street 2 | New York | New York | 10022 | 1234567890 |

  @AdminRegion_03 @AdminRegion
  Scenario: Verify route
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx15@podfoods.co | 12345678a |
    When Admin search route by api
      | q[name]          | q[region_id] |
      | AT route test 01 | 53           |
    And Admin delete route "" by api

    Given NGOC_ADMIN_15 open web admin
    When NGOC_ADMIN_15 login to web with role Admin
    And NGOC_ADMIN_15 navigate to "Regions" to "Routes" by sidebar
    And Admin verify default of create new route
    And Admin verify error empty when create new route
    And Admin fill info to create route
      | name             | region           | weekdays               | store               | deliveryCost | casePickFee |
      | AT route test 01 | New York Express | Within 7 business days | ngoctx stclaim1ny01 | 1            | 1           |
    And Admin create route success
    # Search no found
    And Admin search route
      | name                    | region  |
      | AT route test 123456789 | [blank] |
    And Admin no found data in result
    And Admin search route
      | name             | region  |
      | AT route test 01 | [blank] |
    And Admin verify route result after search
      | name             | region           | weekdays               |
      | AT route test 01 | New York Express | Within 7 business days |
    And Admin search route
      | name    | region           |
      | [blank] | New York Express |
    And Admin verify route result after search
      | name             | region           | weekdays               |
      | AT route test 01 | New York Express | Within 7 business days |
    And Admin search route
      | name             | region           |
      | AT route test 01 | New York Express |
    And Admin verify route result after search
      | name             | region           | weekdays               |
      | AT route test 01 | New York Express | Within 7 business days |
    And Admin go to detail route "AT route test 01"
    And Admin verify route detail
      | name             | region           | weekdays               | store               | deliveryCost | casePickFee |
      | AT route test 01 | New York Express | Within 7 business days | ngoctx stclaim1ny01 | 1.0          | 1.0         |
      # Edit without edit any thing
    And Admin edit route success
      # Edit
    And Admin edit route "AT route test 01"
      | name                  | region           | weekdays               | store               | deliveryCost | casePickFee |
      | AT route test 01 Edit | New York Express | Within 7 business days | ngoctx stroute1ny01 | 2            | 2           |
    And Admin edit route success
    And Admin search route
      | name                  | region           |
      | AT route test 01 Edit | New York Express |
    And Admin verify route result after search
      | name                  | region           | weekdays               |
      | AT route test 01 Edit | New York Express | Within 7 business days |
    And Admin go to detail route "AT route test 01 Edit"
    And Admin verify route detail
      | name                  | region           | weekdays               | store               | deliveryCost | casePickFee |
      | AT route test 01 Edit | New York Express | Within 7 business days | ngoctx stclaim1ny01 | 2.0          | 2.0         |
    And Admin close popup route
    And NGOC_ADMIN_15 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name                | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stroute1ny01 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin go to detail of store "ngoctx stroute1ny01"
    And Admin verify general information of all store
      | name                | nameCompany    | stateStore | storeSize | storeType     | invoiceOption | sendInvoice | threshold | region           | street                                    | city     | state    | zip   | email                           | apEmail | phone      | timezone                   | day     | start   | end     | route                 | referredBy |
      | ngoctx stroute1ny01 | ngoc cpn route | Active     | <50k      | Grocery Store | Yes           | Yes         | 35 day(s) | New York Express | 281 9th Avenue, New York, New York, 10001 | New York | New York | 10001 | ngoctx+stroute1ny01@podfoods.co | [blank] | 1234567890 | Pacific Time (US & Canada) | [blank] | [blank] | [blank] | AT route test 01 Edit | [blank]    |

  @AdminRegion_04 @AdminRegion
  Scenario: Admin verify filter
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx15@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "89" by api
      | q[name]      |
      | q[region_id] |

    Given NGOC_ADMIN_15 open web admin
    When login to beta web with email "ngoctx1100@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_15 navigate to "Regions" to "Routes" by sidebar
    # Verify uncheck all field search+
    And Admin uncheck field of edit visibility in search
      | name    | region  |
      | [blank] | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | name    | region  |
      | [blank] | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | name    | region  |
      | [blank] | [blank] |
    Then Admin verify field search in edit visibility
      | name    | region  |
      | [blank] | [blank] |
    # Verify save new filter
    And Admin search route
      | name                  | region           |
      | AT route test 01 Edit | New York Express |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in route
      | name                  | region           |
      | AT route test 01 Edit | New York Express |
    # Verify save as filter
    And Admin search route
      | name             | region          |
      | Auto bao route 1 | Atlanta Express |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in route
      | name             | region          |
      | Auto bao route 1 | Atlanta Express |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1623@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Regions" to "Routes" by sidebar
    And Admin search route
      | name    | region  |
      | [blank] | [blank] |
    Then Admin verify filter "AutoTest1" is not display



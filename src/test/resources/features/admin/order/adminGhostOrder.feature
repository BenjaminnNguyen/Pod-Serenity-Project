#mvn clean verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=AdminGhostOrder
Feature: Admin Ghost Order

  Narrative:
  Auto test admin ghost order

  @AdminGhostOrder_01 @AdminGhostOrder
  Scenario: Admin verify search and filter
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1200@podfoods.co | 12345678a |
     #Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97722              | 38859              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97722              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx500@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order a 01 | 31645              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Reset search filter full textbox
    And Admin filter visibility with id "312" by api
      | q[number]              |
      | q[store_ids]           |
      | q[buyer_id]            |
      | q[vendor_company_id]   |
      | q[buyer_company_id]    |
      | q[brand_id]            |
      | q[product_variant_ids] |
      | q[region_id]           |
      | q[store_manager_id]    |
      | q[end_date]            |
      | q[start_date]          |
      | q[store_id]            |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1200@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
     # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderGhost | store   | buyer   | buyercompany | vendorCompany | brand   | sku     | region  | managedBy | startDate | endDate |
      | [blank]    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | orderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managedBy | startDate | endDate |
      | [blank]     | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | orderGhost | store   | buyer   | buyercompany | vendorCompany | brand   | sku     | region  | managedBy | startDate | endDate |
      | [blank]    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] |
    Then Admin verify field search in edit visibility
      | orderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managedBy | startDate | endDate |
      | [blank]     | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] |

    # Verify save new filter
    And Admin search the ghost orders by info
      | ghostOrderNumber | store                   | buyer             | buyerCompany                | vendorCompany | brand                   | sku                   | region              | managed    | startDate   | endDate     |
      | 1241231243       | AT Store Ghost Order 01 | AT ghostorder01ny | AT Buyer cpn Ghost Order 01 | ngoc vc 1     | AT Brand Ghost Order 01 | AT Sku Ghost Order 01 | Chicagoland Express | ngoctx1200 | currentDate | currentDate |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | number     | store                   | buyer             | buyerCompany                | vendorCompany | brand                   | sku                   | region              | managed    | startDate   | endDate     |
      | 1241231243 | AT Store Ghost Order 01 | AT ghostorder01ny | AT Buyer cpn Ghost Order 01 | ngoc vc 1     | AT Brand Ghost Order 01 | AT Sku Ghost Order 01 | Chicagoland Express | ngoctx1200 | currentDate | currentDate |
    # Verify save as filter
    And Admin search the ghost orders by info
      | ghostOrderNumber | store                   | buyer                   | buyerCompany                | vendorCompany | brand                   | sku                   | region              | managed    | startDate | endDate |
      | 2312352134       | AT Store Ghost Order 02 | ngoctx atghostorder02ny | AT Buyer cpn Ghost Order 02 | ngoc vc2      | AT Brand Ghost Order 02 | AT Sku Ghost Order 01 | Chicagoland Express | ngoctx1201 | Minus1    | Minus1  |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | orderNumber | store                   | buyer                   | buyerCompany                | vendorCompany | brand                   | sku                   | region              | managed    | startDate | endDate |
      | 2312352134  | AT Store Ghost Order 02 | ngoctx atghostorder02ny | AT Buyer cpn Ghost Order 02 | ngoc vc2      | AT Brand Ghost Order 02 | AT Sku Ghost Order 01 | Chicagoland Express | ngoctx1201 | Minus1    | Minus1  |

     # Verify Order number
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
    # Verify Store
    And Admin search the ghost orders by info
      | ghostOrderNumber | store                   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | AT Store Ghost Order 01 | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
     # Verify Buyer
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer             | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | AT ghostorder01ny | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
     # Verify Buyer Company
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany                | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | AT Buyer cpn Ghost Order 01 | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
     # Verify Vendor company
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany       | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | AT A Ghost Order 01 | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
     # Verify Brand
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand                   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | AT Brand Ghost Order 02 | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
     # Verify SKU
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku                   | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | AT Sku Ghost Order 01 | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
     # Verify region
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region           | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | New York Express | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
      # Verify managed by
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
      # Verify Start date
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | Minus1    | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
     # Verify End date
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | Plus1   |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1200 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
    # No found result
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | Plus2     | Plus1   |
    And Admin no found order in result
    And NGOC_ADMIN_12 quit browser

    Given NGOC_ADMIN_12A open web admin
    When login to beta web with email "ngoctx1210@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12A navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | Plus1   |
    Then Admin verify filter "AutoTest1" is not display
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_02 @AdminGhostOrder
  Scenario: Admin verify create ghost order
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1201@podfoods.co | 12345678a |
     # Active SOS
    And Admin change status using SOS of store "3583" to "true"
     # Change info store
    And Admin change info of store "3583" by api
      | attn | full_name | street1             | street2             | city     | address_state_id | zip   | phone_number | id     | address_state_code | address_state_name | receiving_note | direct_receiving_note |
      | attn | [blank]   | 281 Columbus Avenue | 282 Columbus Avenue | New York | 33               | 10023 | 0123456798   | 107189 | NY                 | New York           | [blank]        | [blank]               |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1201@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin go to create new ghost order
    And Admin verify field blank when create ghost order
    # Verify buyer field
    And Admin verify field buyer when create ghost order
    # Verify stamp SOS and LS when choose buyer
    And Admin verify stamp SOS, LS when choose field buyer when create ghost order
      | buyer                   | sos     |
      | ngoctx atghostorder02ny | display |

    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1201@podfoods.co | 12345678a |
     # Active SOS
    And Admin change status using SOS of store "3583" to "false"

    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin go to create new ghost order
      # Verify stamp SOS and LS when choose buyer
    And Admin verify stamp SOS, LS when choose field buyer when create ghost order
      | buyer                   | sos       |
      | ngoctx atghostorder02ny | undisplay |
    And Admin verify auto fill address
      | buyer                   | street1             | street2             | city     | state    | zip   | attn |
      | ngoctx atghostorder02ny | 281 Columbus Avenue | 282 Columbus Avenue | New York | New York | 10023 | attn |
    And Admin verify zip code in create ghost order
      | zip    | verify                                          |
      | 9999   | Postal zip code should have 5 characters length |
      | 999999 | Postal zip code should have 5 characters length |
      | 10023  | [blank]                                         |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_03 @AdminGhostOrder
  Scenario: Admin verify line item
    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1202@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer             | paymentType    | street              | city     | state    | zip   |
      | AT ghostorder01ny | Pay by invoice | 280 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT SKU B Checkout 13" and quantities "1"
    And Admin verify MOV require of line items in create new ghost orders
      | companyName                  | totalPayment | movPrice    | message                                                                                                                                               |
      | AT VENDOR BUYER CHECKOUT 12C | $10.00       | $100.00 MOV | Please add more case(s) to any SKU below to meet the minimum order value required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Admin verify line items in create new ghost orders
      | brand                  | product                  | sku                  | skuID | unitUPC      | unitCase     | status   | region | price  | quantity |
      | AT BRAND B CHECKOUT 13 | AT Product B Checkout 13 | AT SKU B Checkout 13 | 35136 | 112312414213 | 1 units/case | In stock | PDE    | $10.00 | 1        |
    And Admin add line item "AT Sku Ghost Order 03" and quantities "1"
    And Admin verify line items in create new ghost orders
      | brand                   | product                   | sku                   | skuID | unitUPC      | unitCase     | status   | region | price  | quantity |
      | AT BRAND GHOST ORDER 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 03 | 45605 | 180219939999 | 1 units/case | In stock | PDE    | $20.00 | 1        |
    And Admin verify MOQ require of line items in create new ghost orders
      | itemMOQ        | message                                                                           |
      | ITEMS WITH MOQ | The line-item(s) highlighted below doesn't meet the minimum order quantity (MOQ). |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_04 @AdminGhostOrder
  Scenario: Admin verify line item (instock - comming soon - launching soon)
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1203@podfoods.co | 12345678a |
     # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 97733 | 53        | 38861              | 1000             | 1000       | in_stock     | active |
    And Admin update limit type of vendor company "1978" to "moq" by api

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1203@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer             | paymentType    | street              | city     | state    | zip   |
      | AT ghostorder01ny | Pay by invoice | 280 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT Sku Ghost Order 02" and quantities "1"
    And Admin verify line items in create new ghost orders
      | brand                   | product                   | sku                   | skuID | unitUPC      | unitCase     | status   | region | price  | quantity |
      | AT BRAND GHOST ORDER 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 02 | 38861 | 180219939999 | 1 units/case | In stock | NY     | $10.00 | 1        |
    And Admin delete line item of sku "38861" in create order

    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1203@podfoods.co | 12345678a |
     # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason   |
      | 97733 | 53        | 38861              | 1000             | 1000       | sold_out     | active | pending_replenishment |
    # Verify sku launching soon
    And Switch to actor NGOC_ADMIN_12
    And Admin add line item "AT Sku Ghost Order 02" and quantities "1"
    And Admin verify line items in create new ghost orders
      | brand                   | product                   | sku                   | skuID | unitUPC      | unitCase     | status       | region | price  | quantity |
      | AT BRAND GHOST ORDER 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 02 | 38861 | 180219939999 | 1 units/case | Out of stock | NY     | $10.00 | 1        |
    And Admin delete line item of sku "38861" in create order

    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1203@podfoods.co | 12345678a |
     # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason   |
      | 97733 | 53        | 38861              | 1000             | 1000       | sold_out     | active | pending_replenishment |

     # Verify sku out of stock
    And Switch to actor NGOC_ADMIN_12
    And Admin add line item "AT Sku Ghost Order 02" and quantities "1"
    And Admin verify line items in create new ghost orders
      | brand                   | product                   | sku                   | skuID | unitUPC      | unitCase     | status       | region | price  | quantity |
      | AT BRAND GHOST ORDER 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 02 | 38861 | 180219939999 | 1 units/case | Out of stock | NY     | $10.00 | 1        |
    And Admin delete line item of sku "38861" in create order
    # Verify invalid file upload CSV
    And Admin verify invalid file upload CSV in create ghost order
    # Verify upload CSV success
    And Admin upload file order "adminCreateNewOrder.csv"
    Then Admin verify info after upload file CSV
      | nameSKU         | info  | warning | danger | uploadedPrice | estimatedPrice | quantity | promoPrice |
      | AT SKU Upload14 | empty | empty   | empty  | $15.00        | $1,400.00      | 14       | empty      |
    And Admin verify price in create order upload file
      | type      | totalCase | totalOrderValue | discount | taxes   | logisticsSurcharge | specialDiscount | totalPayment |
      | Total     | 14        | $1,400.00       | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | In stock  | 14        | $1,400.00       | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | OOS or LS | 0         | $0.00           | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
    And Admin upload file CSV success
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_05 @AdminGhostOrder
  Scenario: Admin verify CSV
    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1204@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer        | paymentType    | street                | city    | state    | zip   |
      | ngoctx N_CHI | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Upload08"
    Then Admin verify line item added
      | title          | brand           | product           | sku             | tag   | upc          | unit         |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload08 | 30645 | 180219931238 | 1 units/case |
    And Admin upload file order "autotest1.csv"
    Then Admin verify info after upload file CSV
      | nameSKU              | info  | warning                                    | danger                                                | uploadedPrice | estimatedPrice | quantity | promoPrice |
      | AT SKU Upload01      | empty | empty                                      | empty                                                 | $10.00        | $10.00         | 1        | empty      |
      | AT SKU Upload02      | empty | empty                                      | empty                                                 | $15.00        | $20.00         | 2        | empty      |
      | empty                | empty | empty                                      | This item isn't available to the selected buyer/store | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload04      | empty | empty                                      | The UPC / EAN is used for multiple SKUs               | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload05      | empty | empty                                      | The UPC / EAN is used for multiple SKUs               | $15.00        | empty          | empty    | empty      |
      | empty                | empty | empty                                      | This item isn't available to the selected buyer/store | $15.00        | empty          | empty    | empty      |
      | empty                | empty | empty                                      | This upc / ean not found                              | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload08      | empty | empty                                      | This SKU was already uploaded                         | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload09      | empty | This item’s quantity doesn't meet the MOQs | Quantity should not be 0                              | $15.00        | $0.00          | 0        | empty      |
      | AT SKU Upload10      | empty | empty                                      | empty                                                 | $0.00         | $1,000.00      | 10       | empty      |
      | empty                | empty | empty                                      | This upc / ean not found                              | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload MOV 01 | empty | empty                                      | empty                                                 | $15.00        | $144.00        | 12       | empty      |
      | AT SKU MOV2 01       | empty | empty                                      | empty                                                 | $15.00        | $1,690.00      | 13       | empty      |
      | AT SKU Upload14      | empty | empty                                      | empty                                                 | $15.00        | $1,400.00      | 14       | empty      |
    And Admin verify price in create order upload file
      | type      | totalCase | totalOrderValue | discount | taxes   | logisticsSurcharge | specialDiscount | totalPayment |
      | Total     | 52        | $4,264.00       | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | In stock  | 50        | $4,244.00       | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | OOS or LS | 2         | $20.00          | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
    And Admin upload file CSV success
    Then Admin verify line item added
      | title          | brand           | product           | sku             | tag   | upc          | unit         |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload08 | 30645 | 180219931238 | 1 units/case |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload01 | 30635 | 180219931231 | 1 units/case |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload02 | 30637 | 180219931232 | 1 units/case |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload10 | 30648 | 180219931100 | 1 units/case |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload14 | 30655 | 180219931214 | 1 units/case |
    And Admin verify line item added with company name
      | brand            | product               | sku                  | tag   | upc          | status   | price     | newPrice | quantity |
      | AT BRAND MOV     | AT Product Upload MOV | AT SKU Upload MOV 01 | 30653 | 123124123145 | In stock | $144.00   | empty    | 12       |
      | AT BRAND MOV2 02 | AT Product MOV2 01    | AT SKU MOV2 01       | 30654 | 352341235123 | In stock | $1,690.00 | empty    | 13       |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_06 @AdminGhostOrder
  Scenario: Admin verify OOS or LS column
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1205@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Admin Ghost Order Promo"
    And Admin delete promotion by skuName "Admin Ghost Order Promo"
    And Admin search promotion by Promotion Name "Admin Ghost Order Pod Sponsored"
    And Admin delete promotion by skuName "Admin Ghost Order Pod Sponsored"
      # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason   |
      | 128070 | 53        | 61880              | 1000             | 1000       | sold_out     | active | pending_replenishment |
    #  Delete tax
    Then Admin delete all tax of product '29469'
    # Add tax
    Then Admin add tax to product '29469'
      | id | value |
      | 52 | 100   |
    # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61880 | 3584      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                    | description             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Admin Ghost Order Promo | Admin Ghost Order Promo | currentDate | currentDate | 1           | 10000      | 1                | true           | [blank] | default    | [blank]       | false   |

    # Create promotion pod-sponsored
    And Admin add region by API
      | region           | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | New York Express | 53        | [blank] | 3584      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty  |
      | PromotionActions::PercentageAdjustment | 0.1         | false | [blank] |
    And Admin create promotion by api with info
      | type                     | name                            | description                     | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | actionType | buy_in  | skuExpireDate |
      | Promotions::PodSponsored | Admin Ghost Order Pod Sponsored | Admin Ghost Order Pod Sponsored | currentDate | currentDate | 1000        | [blank]    | 1                | [blank]        | default    | [blank] | [blank]       |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1205@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer                   | paymentType    | street              | city     | state    | zip   |
      | ngoctx atghostorder03ny | Pay by invoice | 280 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT Sku Ghost Order 06" and quantities "1"
    And Admin verify line items in create new ghost orders
      | brand                   | product                   | sku                   | skuID | unitUPC      | unitCase     | status       | region | price  | quantity |
      | AT BRAND GHOST ORDER 02 | AT Product Ghost Order 02 | AT Sku Ghost Order 06 | 61880 | 123124123421 | 1 units/case | Out of stock | NY     | $10.00 | 1        |
    Then Verify price "total" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    Then Verify price "in stock" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    Then Verify price "OOS or LS" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    And Admin create order success
    Then Admin verify line items in ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | tagPD   | tagPE | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 02 | AT Sku Ghost Order 06 | 61880 | 1 units/case | [blank] | Yes   | $10.00 | 1        | 0           | $10.00 |
    # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    # Verify info in convert ghost order
    And Admin verify line item in convert ghost order
      | skuID | brand                   | product                   | sku                   | price  | units        | quantity | endQuantity | newTotal | oldTotal |
      | 61880 | AT Brand Ghost Order 02 | AT Product Ghost Order 02 | AT Sku Ghost Order 06 | $10.00 | 1 units/case | 1        | 0           | $9.00    | $10.00   |
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | $1.00    | $1.00 | [blank]             | [blank]            | $0.90           | $9.10        |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | $1.00    | $1.00 | [blank]             | [blank]            | $0.90           | $9.10        |
     # Confirm convert ghost order to real order
    And Admin confirm convert ghost order to real order
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                   | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx atghostorder03ny | AT Store Ghost Order 03 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin expand line item in order detail
    And Admin check line items "deleted or shorted items" in order details
      | brand                   | product                   | sku                   | unitCase     | casePrice | quantity | endQuantity | total | oldTotal |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 02 | AT Sku Ghost Order 06 | 1 units/case | $10.00    | 1        | 0           | $9.00 | $10.00   |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_07 @AdminGhostOrder
  Scenario: Admin verify In stock column
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1206@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Admin Ghost Order Promo 07"
    And Admin delete promotion by skuName "Admin Ghost Order Promo 07"
    And Admin search promotion by Promotion Name "Admin Ghost Order Pod Sponsored 07"
    And Admin delete promotion by skuName "Admin Ghost Order Pod Sponsored 07"
      # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 128072 | 53        | 61882              | 1000             | 1000       | in_stock     | active |

    # Add tax
    Then Admin add tax to product '29470'
      | id | value |
      | 52 | 100   |
    # Delete order
    When Search order by sku "61882" by api
    And Admin delete order of sku "61882" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT Sku Ghost Order 07   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT Sku Ghost Order 07" from API
    And Admin delete inventory "all" by API
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT Sku Ghost Order 07 | 61882              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61882 | 3585      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Admin Ghost Order Promo 07 | Admin Ghost Order Promo 07 | currentDate | currentDate | 1           | 10000      | 1                | true           | [blank] | default    | [blank]       | false   |

    # Create promotion pod-sponsored
    And Admin add region by API
      | region           | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | New York Express | 53        | [blank] | 3585      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty  |
      | PromotionActions::PercentageAdjustment | 0.1         | false | [blank] |
    And Admin create promotion by api with info
      | type                     | name                               | description                        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | actionType | buy_in  | skuExpireDate |
      | Promotions::PodSponsored | Admin Ghost Order Pod Sponsored 07 | Admin Ghost Order Pod Sponsored 07 | currentDate | currentDate | 1000        | [blank]    | 1                | [blank]        | default    | [blank] | [blank]       |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1206@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer                   | paymentType    | street              | city     | state    | zip   |
      | ngoctx atghostorder07ny | Pay by invoice | 280 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT Sku Ghost Order 07" and quantities "1"
    And Admin verify line items in create new ghost orders
      | brand                   | product                   | sku                   | skuID | unitUPC      | unitCase     | status   | region | price  | quantity |
      | AT BRAND GHOST ORDER 02 | AT Product Ghost Order 03 | AT Sku Ghost Order 07 | 61882 | 123124123421 | 1 units/case | In stock | NY     | $10.00 | 1        |
    Then Verify price "total" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    Then Verify price "in stock" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    Then Verify price "OOS or LS" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    And Admin create order success
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer                   | store                   | orderValue | creator    | managed | launched | address                                        | adminNote |
      | [blank]    | currentDate | New York Express | ngoctx atghostorder07ny | AT Store Ghost Order 07 | $10.00     | ngoctx1206 | N/A     | N/A      | 280 Columbus Avenue, New York, New York, 10023 | [blank]   |
    And Admin refresh page by button
    Then Admin verify line items in ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | tagPD | tagPE | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 03 | AT Sku Ghost Order 07 | 61882 | 1 units/case | No    | Yes   | $10.00 | 1        | 0           | $10.00 |
    # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    # Verify info in convert ghost order
    And Admin verify line item in convert ghost order
      | skuID | brand                   | product                   | sku                   | price  | units        | quantity | endQuantity | newTotal | oldTotal |
      | 61882 | AT Brand Ghost Order 02 | AT Product Ghost Order 03 | AT Sku Ghost Order 07 | $10.00 | 1 units/case | 1        | 0           | $9.00    | $10.00   |
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | $1.00    | $1.00 | [blank]             | [blank]            | $0.90           | $39.10       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $10.00          | $1.00    | $1.00 | [blank]             | [blank]            | $0.90           | $39.10       |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
     # Confirm convert ghost order to real order
    And Admin confirm convert ghost order to real order
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                   | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx atghostorder07ny | AT Store Ghost Order 07 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                   | product                   | sku                   | unitCase     | casePrice | quantity | endQuantity | total | oldTotal |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 03 | AT Sku Ghost Order 07 | 1 units/case | $10.00    | 1        | 9           | $9.00 | $10.00   |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_08 @AdminGhostOrder
  Scenario: Admin verify search and filter1
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1207@podfoods.co | 12345678a |
     #Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97733              | 38861              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97733              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3729     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1207@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer                   | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1207 | ngoctx atghostorder08ny | AT Store Ghost … | NY     | $10.00 |
    And Admin go to ghost order detail number "create by api"
    And Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer                   | store                   | orderValue | creator    | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | ngoctx atghostorder08ny | AT Store Ghost Order 08 | $10.00     | ngoctx1207 | N/A     | N/A      | [blank] | [blank]   |
    And Admin edit general information of ghost order detail
      | customerPO       | adminNote |
      | Auto Customer PO | adminNote |
    And Admin refresh page by button
    And Admin verify general information of ghost order detail
      | customerPo       | date        | region           | buyer                   | store                   | orderValue | creator    | managed | launched | address | adminNote |
      | Auto Customer PO | currentDate | New York Express | ngoctx atghostorder08ny | AT Store Ghost Order 08 | $10.00     | ngoctx1207 | N/A     | N/A      | [blank] | adminNote |
     # Change info buyer company
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1207@podfoods.co | 12345678a |
    And Admin change info of buyer company "2537" by API
      | manager_id | launcher_id |
      | 84         | 84          |
    And Admin refresh page by button
    And Admin verify general information of ghost order detail
      | customerPo       | date        | region           | buyer                   | store                   | orderValue | creator    | managed | launched | address | adminNote |
      | Auto Customer PO | currentDate | New York Express | ngoctx atghostorder08ny | AT Store Ghost Order 08 | $10.00     | ngoctx1207 | [blank] | [blank]  | [blank] | adminNote |
    And Admin go to "buyer" by redirect icon and verify
    And NGOC_ADMIN_12 go back
    And Admin go to "store" by redirect icon and verify
    And NGOC_ADMIN_12 go back
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_09 @AdminGhostOrder
  Scenario: Admin verify add line item - sku in stock
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1208@podfoods.co | 12345678a |
     #Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97733              | 38861              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97733              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1208@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1208 | AT ghostorder01ny | AT Store Ghost … | NY     | $10.00 |
    And Admin go to ghost order detail number "create by api"
    Then Admin verify line items in ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | tagPD   | tagPE | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 02 | 38861 | 1 units/case | [blank] | Yes   | $10.00 | 1        | 0           | $10.00 |
    And Admin add line item in ghost order
      | sku                   | quantity | note     | reason           |
      | AT Sku Ghost Order 03 | 2        | Autotest | Buyer adjustment |
    Then Admin verify line items in ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | tagPD   | tagPE   | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 03 | 45605 | 1 units/case | Yes     | [blank] | $20.00 | 2        | 0           | $40.00 |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 02 | 38861 | 1 units/case | [blank] | Yes     | $10.00 | 1        | 0           | $10.00 |
    And Admin verify history add new line item in ghost order detail
      | sku                   | quantity       | reason           | updateBy          | updateOn    | note     |
      | AT Sku Ghost Order 03 | New item added | Buyer adjustment | Admin: ngoctx1208 | currentDate | Autotest |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_10 @AdminGhostOrder
  Scenario: Admin verify add line item - sku out of stock
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1209@podfoods.co | 12345678a |
       # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason   |
      | 128079 | 55        | 61888              | 2000             | 2000       | sold_out     | active | pending_replenishment |

     #Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97733              | 38859              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97733              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1209@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator  | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx12 | AT ghostorder01ny | AT Store Ghost … | NY     | $10.00 |
    And Admin go to ghost order detail number "create by api"
    Then Admin verify line items in ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | tagPD   | tagPE | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 02 | 38861 | 1 units/case | [blank] | Yes   | $10.00 | 1        | 0           | $10.00 |
    And Admin add line item in ghost order
      | sku                   | quantity | note     | reason           |
      | AT Sku Ghost Order 10 | 2        | Autotest | Buyer adjustment |
    Then Admin verify line items in ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | tagPD   | tagPE   | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 10 | 61888 | 1 units/case | Yes     | [blank] | $20.00 | 2        | 0           | $40.00 |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 02 | 38861 | 1 units/case | [blank] | Yes     | $10.00 | 1        | 0           | $10.00 |
    And Admin verify history add new line item in ghost order detail
      | sku                   | quantity       | reason           | updateBy        | updateOn    | note     |
      | AT Sku Ghost Order 10 | New item added | Buyer adjustment | Admin: ngoctx12 | currentDate | Autotest |
    And Admin delete line item in ghost order detail
      | index | sku                   | reason  | note    | deduction |
      | 1     | AT Sku Ghost Order 10 | [blank] | [blank] | No        |
    And Admin save action in order detail
    And Admin check line items "deleted or shorted items" in ghost order details
      | brand                   | product                   | sku                   | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 10 | 1 units/case | $20.00    | 2        | [blank]     | $40.00 | 61888 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_11 @AdminGhostOrder
  Scenario: Check display if all line items are inactive on buyer's region
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1210@podfoods.co | 12345678a |
       # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 128082 | 53        | 61891              | 2000             | 2000       | in_stock     | active |
     #Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97722              | 38859              | 1        | false     | [blank]          |
      | 128082             | 61891              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97722              | 1        |
      | 128082             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1210@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1210 | AT ghostorder01ny | AT Store Ghost … | NY     | $40.00 |
    And Admin go to ghost order detail number "create by api"

    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1210@podfoods.co | 12345678a |
    # Active product and sku
    And Admin change info of regions attributes with sku "inactive"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 128082 | 53        | 61891              | 2000             | 2000       | in_stock     | inactive | [blank]                  |
    # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    Then Admin verify line iem in not display in convert ghost order
      | skuID |
      | 61891 |
    And Admin verify line item in convert ghost order
      | skuID | brand                   | product                   | sku                   | price  | units        | quantity | endQuantity | total  |
      | 38859 | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 01 | $20.00 | 1 units/case | 1        | [blank]     | $20.00 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_12 @AdminGhostOrder
  Scenario: Check display if all line items are inactive on buyer's region
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1210@podfoods.co | 12345678a |
     #Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97722              | 38859              | 1        | false     | [blank]          |
      | 106858             | 45606              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97722              | 1        |
      | 106858             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1210@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator  | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx12 | AT ghostorder01ny | AT Store Ghost … | NY     | $40.00 |
    And Admin go to ghost order detail number "create by api"
    And Admin delete line item in ghost order detail
      | index | sku                   | reason  | note    | deduction |
      | 1     | AT Sku Ghost Order 04 | [blank] | [blank] | No        |
    And Admin save action in order detail
    # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    Then Admin verify line iem in not display in convert ghost order
      | skuID |
      | 45606 |
    And Admin verify line item in convert ghost order
      | skuID | brand                   | product                   | sku                   | price  | units        | quantity | endQuantity | total  |
      | 38859 | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 01 | $20.00 | 1 units/case | 1        | [blank]     | $20.00 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_13 @AdminGhostOrder
  Scenario: Check display of Pod Express/Direct line item has meet MOV
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1211@podfoods.co | 12345678a |
    # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 115263             | 52314              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 115263             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1211@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1211 | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 |
    And Admin go to ghost order detail number "create by api"
     # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    Then Admin verify MOV require of line items in convert ghost orders
      | companyName                  | totalPayment | movPrice    | message                                                                                                                                               |
      | AT VENDOR BUYER CHECKOUT 12C | $20.00       | $100.00 MOV | Please add more case(s) to any SKU below to meet the minimum order value required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_14 @AdminGhostOrder
  Scenario: Check display of Pod Express/Direct line item has meet MOQ
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1212@podfoods.co | 12345678a |
    # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128083             | 61892              | 1        | false     | [blank]          |
      | 128085             | 61893              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128083             | 1        |
      | 128085             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1212@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator    | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx1212 | AT ghostorder01ny | AT Store Ghost … | NY     | $40.00 |
    And Admin go to ghost order detail number "create by api"
     # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    Then Admin verify MOQ require of line items in convert ghost orders
      | message                                                                           |
      | The line-item(s) highlighted below doesn't meet the minimum order quantity (MOQ). |
    And Admin verify stamp SOS, LS when choose field buyer in convert ghost order
      | sos                                                | ls      |
      | Small order surcharge for orders less than $500.00 | [blank] |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_15 @AdminGhostOrder
  Scenario: Check display of line items if admin edit SKU information
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1213@podfoods.co | 12345678a |
      # Delete order
    When Search order by sku "61908" by api
    And Admin delete order of sku "61908" by api
      # Active SOS
    And Admin change status using SOS of store "3587" to "true"
    And Admin change info SOS of store "3587"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT Sku Ghost Order a15  | AT Product Ghost Order 04 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT Sku Ghost Order a15" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT Sku Ghost Order a15 | 61908              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128103             | 61908              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128103             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3730     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
     # Edit brand
    And Admin edit brand "4065" by API
      | name                         | description                | micro_description | city    | address_state_id | vendor_company_id |
      | AT Brand Ghost Order 03 Edit | AT Brand Buyer PreOrder 03 | [blank]           | [blank] | 33               | 1978              |
    # Active SOS
    And Admin change status using SOS of store "3587" to "false"

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1213@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator  | buyer                 | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx12 | ngoctx ghostorder15ny | AT Store Ghost … | NY     | $20.00 |
    And Admin go to ghost order detail number "create by api"
    Then Admin verify line items in ghost order detail
      | brand                        | product                   | sku                    | skuID | unitCase     | tagPD   | tagPE | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 03 Edit | AT Product Ghost Order 04 | AT Sku Ghost Order a15 | 61908 | 1 units/case | [blank] | Yes   | $20.00 | 1        | 10          | $20.00 |

    And NGOC_ADMIN_12 convert ghost order to real order
    And Admin confirm convert ghost order to real order
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                 | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | New York Express | ngoctx ghostorder15ny | AT Store Ghost Order 15 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin check line items "sub invoice" in order details
      | brand                        | product                   | sku                    | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Ghost Order 03 Edit | AT Product Ghost Order 04 | AT Sku Ghost Order a15 | 1 units/case | $20.00    | 1        | 9           | $20.00 | 61908 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_16 @AdminGhostOrder
  Scenario: Admin verify delete ghost order
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1214@podfoods.co | 12345678a |
     # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97733              | 38861              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97733              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1214@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify result ghost order in all order
      | ghostOrderNumber | customerPO | createdDate | creator  | buyer             | store            | region | total  |
      | create by api    | [blank]    | currentDate | ngoctx12 | AT ghostorder01ny | AT Store Ghost … | NY     | $10.00 |
    And Admin go to ghost order detail number "create by api"
    And Admin delete ghost order
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin no found data in result
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_17 @AdminGhostOrder
  Scenario: Admin convert a Ghost order has more than 20 line items
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1213@podfoods.co | 12345678a |
      # Delete order
    And Admin delete order by sku of product "Auto Product Multiple Order" by api
    # Delete inventory
    And Delete all inventory with product "Auto Product Multiple Order"
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 01 | 44180              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 02 | 44181              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 03 | 44182              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 04 | 44183              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 05 | 44184              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 06 | 44185              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 07 | 44186              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 08 | 44187              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 09 | 44188              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 10 | 44189              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 11 | 44190              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 12 | 44191              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 13 | 44192              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 14 | 44193              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 15 | 44194              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 16 | 44195              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 17 | 44196              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 18 | 44197              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 19 | 44198              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 20 | 44199              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1215@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer        | paymentType    | street                | city    | state    | zip   |
      | ngoctx N_CHI | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin upload file order "convert20item.csv"
    Then Admin verify info after upload file CSV
      | product                     | sku                      | skuID | upc          | status   | region | info  | warning | danger | uploadedPrice | estimatedPrice | quantity | promoPrice |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | 250419980001 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | 250419980002 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 03 | 44182 | 250419980003 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | 250419980004 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 05 | 44184 | 250419980005 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 06 | 44185 | 250419980006 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 07 | 44186 | 250419980007 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 08 | 44187 | 250419980008 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 09 | 44188 | 250419980009 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 10 | 44189 | 250419980010 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 11 | 44190 | 250419980011 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 12 | 44191 | 250419980012 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 13 | 44192 | 250419980013 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 14 | 44193 | 250419980014 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 15 | 44194 | 250419980015 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 16 | 44195 | 250419980016 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 17 | 44196 | 250419980017 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 18 | 44197 | 250419980018 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 19 | 44198 | 250419980019 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
      | Auto Product Multiple Order | AT SKU Multiple Order 20 | 44199 | 250419980020 | In stock | CHI    | empty | empty   | empty  | $10.00        | $10.00         | 1        | empty      |
    And Admin verify price in create order upload file
      | type      | totalCase | totalOrderValue | discount | taxes   | logisticsSurcharge | specialDiscount | totalPayment |
      | Total     | 20        | $200.00         | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | In stock  | 20        | $200.00         | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
      | OOS or LS | 0         | $0.00           | [blank]  | [blank] | [blank]            | [blank]         | [blank]      |
    And Admin upload file CSV success
    And Admin create order success
    Then Admin verify line items in ghost order detail
      | brand                      | product                     | sku                      | skuID | unitCase     | tagPD   | tagPE | price  | quantity | endQuantity | total  |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 03 | 44182 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 05 | 44184 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 06 | 44185 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 07 | 44186 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 08 | 44187 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 09 | 44188 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 10 | 44189 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 11 | 44190 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 12 | 44191 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 13 | 44192 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 14 | 44193 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 15 | 44194 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 16 | 44195 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 17 | 44196 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 18 | 44197 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 19 | 44198 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 20 | 44199 | 1 units/case | [blank] | Yes   | $10.00 | 1        | [blank]     | $10.00 |
    # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    # Verify info in convert ghost order
    And Admin verify line item in convert ghost order
      | skuID | brand                      | product                     | sku                      | price  | units        | quantity | endQuantity | total  |
      | 44180 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 01 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44181 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 02 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44182 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 03 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44183 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 04 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44184 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 05 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44185 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 06 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44186 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 07 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44187 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 08 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44188 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 09 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44189 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 10 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44190 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 11 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44191 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 12 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44192 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 13 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44193 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 14 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44194 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 15 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44195 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 16 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44196 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 17 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44197 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 18 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44198 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 19 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
      | 44199 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 20 | $10.00 | 1 units/case | 1        | [blank]     | $10.00 |
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 20        | $200.00         | $0.00    | $0.00 | $30.00              | [blank]            | $0.00           | $230.00      |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 20        | $200.00         | $0.00    | $0.00 | $30.00              | [blank]            | $0.00           | $230.00      |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00               | [blank]            | $0.00           | $0.00        |
     # Confirm convert ghost order to real order
    And Admin confirm convert ghost order to real order
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store    | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx N_CHI | ngoc st1 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | skuID | brand                      | product                     | sku                      | unitCase     | casePrice | quantity | endQuantity | total  |
      | 44180 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 01 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44180 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 02 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44182 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 03 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44183 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 04 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44184 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 05 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44185 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 06 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44186 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 07 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44187 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 08 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44188 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 09 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44189 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 10 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44190 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 11 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44191 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 12 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44192 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 13 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44193 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 14 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44194 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 15 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44195 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 16 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44196 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 17 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44197 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 18 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44198 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 19 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
      | 44199 | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 20 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
    And NGOC_ADMIN_12 quit browser

    # Create multiple order
  @AdminGhostOrder_18 @AdminGhostOrder
  Scenario: Admin select more than 20 line items on file create multiple order to create order
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1216@podfoods.co | 12345678a |
     # Set PRICING Brand
    And Admin set Fixed pricing of brand "3367" with "0.25" by API

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1216@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Create multiple orders" by sidebar
    And Admin go to create new multiple order
    And Admin upload CSV file "Create_order_for_multiple_stores.csv" to create multiple order
    And Admin verify order uploaded of file "Create_order_for_multiple_stores.csv" in multi order
      | store    | customerPO | lineItem | status | quantity |
      | ngoc st1 | Auto PO    | 21       | 0 / 21 | 21       |
    And Admin go to detail of multiple order
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 21 | 44200 | In stock     | 250419980021 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 20 | 44199 | In stock     | 250419980020 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 19 | 44198 | In stock     | 250419980019 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 18 | 44197 | In stock     | 250419980018 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 17 | 44196 | In stock     | 250419980017 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 16 | 44195 | In stock     | 250419980016 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 15 | 44194 | In stock     | 250419980015 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 14 | 44193 | In stock     | 250419980014 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 13 | 44192 | In stock     | 250419980013 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 12 | 44191 | In stock     | 250419980012 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 11 | 44190 | In stock     | 250419980011 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 10 | 44189 | In stock     | 250419980010 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 09 | 44188 | In stock     | 250419980009 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 08 | 44187 | In stock     | 250419980008 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 07 | 44186 | In stock     | 250419980007 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 06 | 44185 | In stock     | 250419980006 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 05 | 44184 | In stock     | 250419980005 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | In stock     | 250419980004 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 03 | 44182 | In stock     | 250419980003 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 25 | 65651 | Out of stock | 250419980025 | Pending | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock     | 250419980001 | Pending | $10.00 | 1        | [blank]                                                     |
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin choose line item to convert to order in multi
      | sku                      | quantity |
      | AT SKU Multiple Order 20 | 1        |
      | AT SKU Multiple Order 19 | 1        |
      | AT SKU Multiple Order 18 | 1        |
      | AT SKU Multiple Order 17 | 1        |
      | AT SKU Multiple Order 16 | 1        |
      | AT SKU Multiple Order 15 | 1        |
      | AT SKU Multiple Order 14 | 1        |
      | AT SKU Multiple Order 13 | 1        |
      | AT SKU Multiple Order 12 | 1        |
      | AT SKU Multiple Order 11 | 1        |
      | AT SKU Multiple Order 10 | 1        |
      | AT SKU Multiple Order 09 | 1        |
      | AT SKU Multiple Order 08 | 1        |
      | AT SKU Multiple Order 07 | 1        |
      | AT SKU Multiple Order 06 | 1        |
      | AT SKU Multiple Order 05 | 1        |
      | AT SKU Multiple Order 04 | 1        |
      | AT SKU Multiple Order 03 | 1        |
      | AT SKU Multiple Order 25 | 1        |
      | AT SKU Multiple Order 01 | 1        |
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 20        | $200.00         | $0.00    | $0.00 | $0.00           | $200.00      |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 19        | $190.00         | $0.00    | $0.00 | $0.00           | $190.00      |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Admin create multiple order from detail with customer PO
    # Verify in order detail
    And NGOC_ADMIN_12 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber | orderSpecific | store    | buyer        | buyerCompany | vendorCompany | brand   | sku                      | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | empty       | [blank]       | ngoc st1 | ngoctx N_CHI | [blank]      | [blank]       | [blank] | AT SKU Multiple Order 01 | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order | customerPO | creator  | checkout    | buyer        | store    | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | Auto PO    | ngoctx12 | currentDate | ngoctx N_CHI | ngoc st1 | CHI    | $190.00 | [blank]   | Pending      | Pending     | Pending       |
    When Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store    | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Auto PO    | currentDate | Chicagoland Express | ngoctx N_CHI | ngoc st1 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $190.00    | $0.00    | $0.00 | $30.00              | $0.00              | $49.40           | $220.00 |
    And Admin check line items "deleted or shorted items" in order details
      | brand                      | product                     | sku                      | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 25 | 1 units/case | $10.00    | 1        | 0           | $10.00 | 65651 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_19 @AdminGhostOrder
  Scenario: Admin customer po
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1217@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT Sku Ghost Order 02 | 38861              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT Sku Ghost Order 01 | 38859              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97722              | 38859              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po  | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3516     | [blank]    | GhostOrder19 | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1217@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer             | paymentType    | street              | city     | state    | zip   |
      | AT ghostorder01ny | Pay by invoice | 280 Columbus Avenue | New York | New York | 10023 |
    And Admin fill info optional to create new order
      | customerPO   | attn    | department | noteAdmin |
      | GhostOrder19 | [blank] | [blank]    | AT Note   |
    And Admin add line item "AT Sku Ghost Order 02" and quantities "10"
    And Admin create ghost order success
    And NGOC_ADMIN_12 convert ghost order to real order
      # Confirm convert ghost order to real order
    And Admin confirm convert ghost order to real order "" with customer PO
    And Verify general information of order detail
      | customerPo   | date        | region           | buyer             | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | GhostOrder19 | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_20 @AdminGhostOrder
  Scenario: 0If admin create a new ghost order for sub-buyer but line item is not available to this sub-buyer (item is not added to whitelist)
    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1218@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer                    | paymentType    | street              | city     | state    | zip   |
      | ngoctx stcheckout01sNY01 | Pay by invoice | 280 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT Sku Ghost Order 02" and quantities "10"
    And Admin create ghost order success
    And NGOC_ADMIN_12 convert ghost order to real order
      # Confirm convert ghost order to real order
    And Admin convert ghost order then see message "Line items The itemcode #38861 is not available to this sub-buyer. Please visit here (https://adminbeta.podfoods.co/buyers/3530?head_buyer=false) and update his/her allowlist"
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_21 @AdminGhostOrder
  Scenario: Check display of Bulk convert ghost orders
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1219@podfoods.co | 12345678a |
        # Delete order
    When Search order by sku "61894" by api
    And Admin delete order of sku "61894" by api
       # Update sku
    And Admin update SKU info "61894" by api
      | product_variant[name] |
      | AT Sku Ghost Order 21 |
     # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128087 | 53        | 61895              | 1000             | 1000       | in_stock     | active | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128086 | 53        | 61894              | 2000             | 2000       | in_stock     | active | [blank]                  |

    # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97722              | 38859              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97722              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "1"

      # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128087             | 61895              | 1        | false     | [blank]          |
      | 128086             | 61894              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128087             | 1        |
      | 128086             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "2"

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1219@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    # Verify select checkbox
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer             | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | [blank]          | [blank] | AT ghostorder01ny | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin verify checkbox ghost order result
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 1     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 1     | create by api    |
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 2     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 2     | create by api    |
    And Admin convert bulk ghost order
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 1     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $20.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 01 | 38859 | 1 units/case | $20.00 | 1        | [blank]     | $20.00 |
    And NGOC_ADMIN_12 wait 2000 mini seconds
  # Verify info in convert ghost order
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $20.00          | $0.00    | $0.00 | [blank]             | [blank]            | [blank]         | $20.00       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $20.00          | $0.00    | $0.00 | [blank]             | [blank]            | [blank]         | $20.00       |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | [blank]         | $0.00        |
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                    | skuID | unitCase     | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order a21 | 61895 | 1 units/case | $10.00 | 1        | 0           | $10.00 |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 21  | 61894 | 1 units/case | $20.00 | 1        | 0           | $20.00 |
    # Verify info in convert ghost order
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 2         | $30.00          | $0.00    | $0.00 | [blank]             | [blank]            | [blank]         | $30.00       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 2         | $30.00          | $0.00    | $0.00 | [blank]             | [blank]            | [blank]         | $30.00       |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | [blank]         | $0.00        |
   # Active product and sku
    Given NGOCTX12 login web admin by api
      | email                | password  |
      | ngoctx12@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "inactive"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 128087 | 53        | 61895              | 1000             | 1000       | in_stock     | inactive | [blank]                  |
    And Admin change info of regions attributes with sku "inactive"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 128086 | 53        | 61894              | 2000             | 2000       | in_stock     | inactive | [blank]                  |

    # Check display if admin remove all line items on Line item section of ghost order detail page
    And NGOC_ADMIN_12 refresh browser
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    And NGOC_ADMIN_12 wait 2000 mini seconds
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line iem in not display in convert ghost order
      | skuID |
      | 61895 |
      | 61894 |

    # Active product and sku
    Given NGOCTX12 login web admin by api
      | email                | password  |
      | ngoctx12@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 128087 | 53        | 61895              | 1000             | 1000       | in_stock     | inactive | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128086 | 53        | 61894              | 2000             | 2000       | in_stock     | active | [blank]                  |

    # Check display if there are some line items are inactive on buyer's region
    And NGOC_ADMIN_12 refresh browser
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 21 | 61894 | 1 units/case | $20.00 | 1        | 0           | $20.00 |
    Then Admin verify line iem in not display in convert ghost order
      | skuID |
      | 61895 |
     # Verify info in convert ghost order
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $20.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $50.00       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $20.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $50.00       |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
     # Active product and sku
    Given NGOCTX12 login web admin by api
      | email                | password  |
      | ngoctx12@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128087 | 53        | 61895              | 1000             | 1000       | in_stock     | active | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128086 | 53        | 61894              | 2000             | 2000       | in_stock     | active | [blank]                  |

    # Check display if there are some line items are deleted on Line item section of ghost order detail page
    And NGOC_ADMIN_12 refresh browser
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                    | skuID | unitCase     | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order a21 | 61895 | 1 units/case | $10.00 | 1        | 0           | $10.00 |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 21  | 61894 | 1 units/case | $20.00 | 1        | 0           | $20.00 |
  # Verify info in convert ghost order
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 2         | $30.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $60.00       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 2         | $30.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $60.00       |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    # Delete line item in bulk ghost
    And Admin delete line item in bulk ghost order detail
      | sku                    |
      | AT Sku Ghost Order a21 |
    Then Admin verify line iem in not display in convert ghost order
      | skuID |
      | 61895 |
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $20.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $50.00       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $20.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $50.00       |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |

      # Active product and sku
    Given NGOCTX12 login web admin by api
      | email                | password  |
      | ngoctx12@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date | out_of_stock_reason   |
      | 128087 | 53        | 61895              | 1000             | 1000       | sold_out     | active | [blank]                  | pending_replenishment |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date | out_of_stock_reason   |
      | 128086 | 53        | 61894              | 2000             | 2000       | sold_out     | active | [blank]                  | pending_replenishment |
    # Check display if there are some line items are out of stock
    And NGOC_ADMIN_12 refresh browser
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                    | skuID | unitCase     | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order a21 | 61895 | 1 units/case | $10.00 | 1        | 0           | $10.00 |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 21  | 61894 | 1 units/case | $20.00 | 1        | 0           | $20.00 |
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 2         | $30.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $30.00       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 2         | $30.00          | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $30.00       |

    # Update sku
    Given NGOCTX12 login web admin by api
      | email                | password  |
      | ngoctx12@podfoods.co | 12345678a |
    And Admin update SKU info "61894" by api
      | product_variant[name]      |
      | AT Sku Ghost Order 21 Edit |
  # Check display if there are some line items are out of stock
    And NGOC_ADMIN_12 refresh browser
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                        | skuID | unitCase     | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order a21     | 61895 | 1 units/case | $10.00 | 1        | 0           | $10.00 |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 21 Edit | 61894 | 1 units/case | $20.00 | 1        | 0           | $20.00 |
   # Convert ghost order to real order
    And NGOC_ADMIN_12 convert order in bulk ghost order to real order

    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 1     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $20.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
     # Convert ghost order to real order
    And NGOC_ADMIN_12 convert order in bulk ghost order to real order
      # Verify order detail after convert
    And NGOC_ADMIN_12 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 2     | index_ghost | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order | customerPO | creator  | checkout    | buyer             | store            | region | total | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | [blank]    | ngoctx12 | currentDate | AT ghostorder01ny | AT Store Ghost … | NY     | $0.00 | $0.00     | Pending      | Pending     | Pending       |
    When Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region           | buyer             | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $0.00      | $0.00    | $0.00 | Not applied         | $0.00              | $0.00            | $0.00 |
    And Admin check line items "deleted or shorted items" in order details
      | brand                   | product                   | sku                        | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 21 Edit | 1 units/case | $20.00    | 1        | 0           | $20.00 | 61894 |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order a21     | 1 units/case | $10.00    | 1        | 0           | $10.00 | 61895 |
    # Verify order detail after convert
    And NGOC_ADMIN_12 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 1     | index_ghost | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order | customerPO | creator  | checkout    | buyer             | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | [blank]    | ngoctx12 | currentDate | AT ghostorder01ny | AT Store Ghost … | NY     | $20.00 | $5.00     | Pending      | Pending     | Pending       |
    When Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region           | buyer             | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $20.00     | $0.00    | $0.00 | $30.00              | $0.00              | $5.00            | $50.00 |
    And Admin check line items "sub invoice" in order details
      | brand                   | product                   | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 01 | 1 units/case | $20.00    | 1        | [blank]     | $20.00 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_22 @AdminGhostOrder
  Scenario: Check display of Bulk convert ghost orders with promotion
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1220@podfoods.co | 12345678a |
      # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128090 | 53        | 61898              | 1000             | 1000       | in_stock     | active | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128089 | 53        | 61897              | 2000             | 2000       | in_stock     | active | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 106857 | 55        | 61899              | 2000             | 2000       | in_stock     | active | [blank]                  |

    # Delete promotion
    And Admin search promotion by Promotion Name "AT Promo Bulk Ghost 22"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Admin Bulk Ghost Order Pod Sponsored 22"
    And Admin delete promotion by skuName ""
      # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61898 | 3588      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | Pod Direct East  | 55        | 61897 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]          | [blank]   | 61899 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description            | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Bulk Ghost 22 | AT Promo Bulk Ghost 22 | currentDate | currentDate | 4           | [blank]    | 1                | true           | [blank] | default    | [blank]       |
    # Create promotion pod-sponsored
    And Admin add region by API
      | region           | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | New York Express | 53        | [blank] | 3588      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty  |
      | PromotionActions::PercentageAdjustment | 0.1         | false | [blank] |
    And Admin create promotion by api with info
      | type                     | name                                    | description                             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | actionType | buy_in  | skuExpireDate |
      | Promotions::PodSponsored | Admin Bulk Ghost Order Pod Sponsored 22 | Admin Bulk Ghost Order Pod Sponsored 22 | currentDate | currentDate | 1000        | [blank]    | 1                | [blank]        | default    | [blank] | [blank]       |

      # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128094             | 61901              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128094             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3731     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "1"
      # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128090             | 61898              | 1        | false     | [blank]          |
      | 128089             | 61897              | 1        | false     | [blank]          |
      | 128091             | 61899              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128090             | 1        |
      | 128089             | 1        |
      | 128091             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3731     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "2"

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1220@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 1     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 1     | create by api    |
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 2     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 2     | create by api    |
    And Admin convert bulk ghost order

    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer                 | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | ngoctx ghostorder22ny | AT Store Ghost Order 22 | $50.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    Then Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                    | skuID | unitCase     | price  | quantity | endQuantity | newTotal | oldTotal |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order b22 | 61898 | 1 units/case | $10.00 | 1        | 0           | $9.00    | $10.00   |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order a22 | 61897 | 1 units/case | $20.00 | 1        | 0           | $18.00   | $20.00   |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order c22 | 61899 | 1 units/case | $20.00 | 1        | 0           | $18.00   | $20.00   |
    # Verify info in convert ghost order
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 3         | $50.00          | $5.00    | $0.00 | [blank]             | [blank]            | $4.50           | $70.50       |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 3         | $50.00          | $5.00    | $0.00 | [blank]             | [blank]            | $4.50           | $70.50       |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_23 @AdminGhostOrder
  Scenario: Check display of Bulk convert ghost orders with MOV, MOQ not meet
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1221@podfoods.co | 12345678a |

    # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 106857 | 55        | 45605              | 2000             | 2000       | in_stock     | active | [blank]                  |
    # Change regional limit
    And Admin set regional moq of product "10966"
      | id     | product_id | region_id | moq | created_at  | updated_at  |
      | 110906 | 10966      | 55        | 5   | currentDate | currentDate |
      # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128095             | 61902              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128095             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "1"
      # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 89911              | 34104              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 89911              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "2"

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1221@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 1     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 1     | create by api    |
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 2     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 2     | create by api    |
    And Admin convert bulk ghost order
    # verify mov meet
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $100.00    | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    And Admin verify line items in bulk ghost order detail
      | brand                 | product                 | sku                 | skuID | unitCase     | price   | quantity | endQuantity | total   |
      | AT Brand Ghost MOV 01 | AT Product Ghost MOV 01 | AT SKU Ghost MOV 01 | 34104 | 1 units/case | $100.00 | 1        | 0           | $100.00 |
    And Admin verify MOV require of line items in convert bulk ghost orders
      | companyName             | totalPayment | movPrice      | message                                                                                                                                               |
      | AUTO VENDOR COMPANY MOV | $100.00      | $1,000.00 MOV | Please add more case(s) to any SKU below to meet the minimum order value required. This vendor may not fulfill if this minimum is not met. Thank you! |
    When Admin change quantity of line items in convert bulk ghost orders
      | sku                 | quantity |
      | AT SKU Ghost MOV 01 | 10       |
    And Admin verify not meet MOV require of line items in convert bulk ghost orders
     # Verify info in convert ghost order
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 10        | $1,000.00       | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $1,000.00    |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 10        | $1,000.00       | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $1,000.00    |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    # verify moq meet
    When Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 1     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $20.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    And Admin verify line items in bulk ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | price  | quantity | endQuantity | total  |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 23 | 61902 | 1 units/case | $20.00 | 1        | 0           | $20.00 |
    And Admin verify MOQ require of line items in convert bulk ghost orders
      | itemMOQ        | message                                                                           |
      | ITEMS WITH MOQ | The line-item(s) highlighted below doesn't meet the minimum order quantity (MOQ). |
    When Admin change quantity of line items in convert bulk ghost orders
      | sku                   | quantity |
      | AT Sku Ghost Order 23 | 5        |
    And Admin verify not meet MOQ require of line items in convert bulk ghost orders
     # Verify info in convert ghost order
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 5         | $100.00         | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $100.00      |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 5         | $100.00         | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $100.00      |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    And Admin delete line item in bulk ghost order detail
      | sku                   |
      | AT Sku Ghost Order 23 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_24 @AdminGhostOrder
  Scenario: Convert button if there aren't any line items on convert ghost order page
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1222@podfoods.co | 12345678a |
     # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128099 | 53        | 61904              | 1000             | 1000       | in_stock     | active | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128100 | 53        | 61905              | 2000             | 2000       | in_stock     | active | [blank]                  |
    # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97722              | 38859              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97722              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "1"
      # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128099             | 61904              | 1        | false     | [blank]          |
      | 128100             | 61905              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128099             | 1        |
      | 128100             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "2"

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1222@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    # Verify select checkbox
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer             | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | [blank]          | [blank] | AT ghostorder01ny | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 1     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 1     | create by api    |
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 2     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 2     | create by api    |
    And Admin convert bulk ghost order
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
    # Remove line item in order
    And Admin delete line item in bulk ghost order detail
      | sku                    |
      | AT Sku Ghost Order 24  |
      | AT Sku Ghost Order a24 |
    Then Admin verify line iem in not display in convert ghost order
      | skuID |
      | 61904 |
    And NGOC_ADMIN_12 convert order in bulk ghost order to real order and see message "Line items must have at least 1 item"
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_25 @AdminGhostOrder
  Scenario: Convert if there are line items in stock and out of stock on convert ghost order page
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1223@podfoods.co | 12345678a |
     # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128101 | 53        | 61906              | 1000             | 1000       | in_stock     | active | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason   |
      | 128102 | 53        | 61907              | 2000             | 2000       | sold_out     | active | pending_replenishment |

       # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT Sku Ghost Order 25 | 61906              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 97722              | 38859              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 97722              | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "1"
      # Create ghost order
    And Admin create line items attributes by API of ghost order
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 128101             | 61906              | 1        | false     | [blank]          |
      | 128102             | 61907              | 1        | false     | [blank]          |
    And Admin create ghost order line items attributes by API
      | variants_region_id | quantity |
      | 128101             | 1        |
      | 128102             | 1        |
    Then Admin create ghost order by API
      | buyer_id | payment_type | street1             | city     | address_state_id | zip   | number | street          |
      | 3516     | invoice      | 281 Columbus Avenue | New York | 33               | 10023 | 281    | Columbus Avenue |
    And Admin save ghost order number by index "2"

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1223@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    # Verify select checkbox
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer             | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | [blank]          | [blank] | AT ghostorder01ny | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 1     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 1     | create by api    |
    And Admin search the ghost orders by info
      | index | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | 2     | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin select ghost order in result search
      | index | ghostOrderNumber |
      | 2     | create by api    |
    And Admin convert bulk ghost order
    And Admin expand order bulk ghost order
      | index | ghostOrderNumber |
      | 2     | create by api    |
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer             | store                   | orderValue | creator  | managed | launched | address | adminNote |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | $30.00     | ngoctx12 | N/A     | N/A      | [blank] | [blank]   |
     # Convert ghost order to real order
    And NGOC_ADMIN_12 convert order in bulk ghost order to real order
      # Verify order detail after convert
    And NGOC_ADMIN_12 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | index | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 2     | index_ghost | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order | customerPO | creator  | checkout    | buyer             | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | [blank]    | ngoctx12 | currentDate | AT ghostorder01ny | AT Store Ghost … | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    When Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region           | buyer             | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | New York Express | AT ghostorder01ny | AT Store Ghost Order 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | [blank]             | [blank]            | $2.50            | $40.00 |
    And Admin check line items "deleted or shorted items" in order details
      | brand                   | product                   | sku                    | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order a25 | 1 units/case | $20.00    | 1        | [blank]     | $20.00 | 61907 |
    And Admin check line items "sub invoice" in order details
      | brand                   | product                   | sku                   | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 25 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 | 61906 |
    And NGOC_ADMIN_12 quit browser

  @AdminGhostOrder_26 @AdminGhostOrder
  Scenario: Admin verify OOS or LS column
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx1224@podfoods.co | 12345678a |
   # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT Sku Ghost Order 04 | 45606              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx1224@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer                      | paymentType    | street         | city     | state    | zip   |
      | ngoctx financialpendingb01 | Pay by invoice | 281 9th Avenue | New York | New York | 10001 |
    And Admin add line item "AT Sku Ghost Order 04" and quantities "10"
    And Admin create order success
    Then Admin verify line items in ghost order detail
      | brand                   | product                   | sku                   | skuID | unitCase     | tagPD   | tagPE | price  | quantity | endQuantity | total   |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 04 | 45606 | 1 units/case | [blank] | Yes   | $20.00 | 1        | [blank]     | $200.00 |
    # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
    # Verify info in convert ghost order
    And Admin verify line item in convert ghost order
      | skuID | brand                   | product                   | sku                   | price  | units        | quantity | endQuantity | total   |
      | 45606 | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 04 | $20.00 | 1 units/case | 10       | [blank]     | $200.00 |
     # Confirm convert ghost order to real order
    And Admin confirm convert ghost order to real order
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                      | store                           | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx financialpendingb01 | ngoctx str financial pending 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                   | product                   | sku                   | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Ghost Order 02 | AT Product Ghost Order 01 | AT Sku Ghost Order 04 | 1 units/case | $20.00    | 10       | [blank]     | $200.00 |
    When Admin approve to fulfill this order
    And Admin expand line item in order detail
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                      | store                           | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | financeApproval | financeApproveBy  | financeApproveAt |
      | Empty      | currentDate | New York Express | ngoctx financialpendingb01 | ngoctx str financial pending 01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Approved        | Admin: ngoctx1224 | currentDate      |
    And NGOC_ADMIN_12 quit browser

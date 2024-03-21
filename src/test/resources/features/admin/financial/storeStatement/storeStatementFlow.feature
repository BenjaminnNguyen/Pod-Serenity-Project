#mvn verify -Dtestsuite="StoreStatementFlowTestSuite" -Dcucumber.options="src/test/resources/features/storestatement" -Denvironment=default -Dfailsafe.rerunFaillingTestsCount=1
@feature=StoreStatement-flow
Feature: StoreStatement Flow

  @StoreStatement_flow01 @StoreStatement @STORE-STATEMENT_31 @STORE-STATEMENT_32 @STORE-STATEMENT_33 @STORE-STATEMENT_34 @STORE-STATEMENT_40 @STORE-STATEMENT_54
  @STORE-STATEMENT_55 @STORE-STATEMENT_57 @STORE-STATEMENT_59 @STORE-STATEMENT_60 @STORE-STATEMENT_63 @STORE-STATEMENT_68 @STORE-STATEMENT_73 @STORE-STATEMENT_75 @STORE-STATEMENT_76
  Scenario: Store statement > Admin record payment: Credit memo, Adjustment, Unapplied payment, Sub-invoice of Current Month
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx700@podfoods.co | 12345678a |
    When Admin search order by API
      | skuID | fulfillment_state | buyer_payment_state |
      | 30742 | fulfilled         | pending             |
    And Admin delete order of sku "30742" by api
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc03 | 30742              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx700@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    When NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststate01chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc03"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc03 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region  | managedBy |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate01"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 180           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net      |
      | $0.00      | $130.00    | $0.00 | $0.00     | ($180.00) | ($50.00) |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | description              | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | Other - Autotest payment | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($130.00) | ($130.00) |
    And Admin get id of Unapplied payment after record payment success
    And Admin verify unapplied payment in "middle" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |
    And Admin verify unapplied payment in "bottom" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |

    And NGOC_ADMIN_07 navigate to "Financial" to "Credit memos" by sidebar
    When Admin create credit memo with info
      | buyer                 | orderID | type              | amount | description      | file                 |
      | ngoctx ststate01chi01 | random  | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success

    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststate01chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc03"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc03 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate01"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 10    | adjustment 1 | random     | currentDate  | Auto Adjustment |
    And Admin verify "credit memo" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status   | aging | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Not used | 0     | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "middle" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    And Admin verify "credit memo" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status   | aging | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Not used | 0     | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | random  | 80            | currentDate | Other       | Autotest payment | random      | Unapplied Payment | adjustment 1 |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo     | unapplied | payment  | net   |
      | $10.00     | $130.00    | ($10.00) | ($50.00)  | ($80.00) | $0.00 |
    When Admin add record payment success

    And Admin verify "credit memo" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Used   | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging   | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Paid   | [blank] | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And Admin verify unapplied payment in "bottom" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Used   | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |
    And NGOC_ADMIN_07 refresh browser
    When Admin verify sum of "order-value" in "bottom" of store statements details
    When Admin verify sum of "deposit" in "bottom" of store statements details
    When Admin verify sum of "fee" in "bottom" of store statements details
    When Admin verify sum of "memo" in "bottom" of store statements details
    When Admin verify sum of "payment" in "bottom" of store statements details
    When Admin verify sum of "total" in "bottom" of store statements details
    And NGOC_ADMIN_07 quit browser

  @StoreStatement_flow01b @StoreStatement
  Scenario: Store statement > Admin record payment: Credit memo, Adjustment, Unapplied payment, Sub-invoice of Previous Month and Previous Month is Locked
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx702@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc03 | 30742              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx702@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc03"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc03 | 05/31/22    |
    And Admin get ID of sub-invoice of order "express"
    And NGOC_ADMIN_07 quit browser

  @StoreStatement02 @StoreStatement
  Scenario: Check creating a store financial statement with a new unapproved store (buyer onboarding process)
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx703@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany          | store                 | buyer   | statementMonth | region  | managedBy |
      | AutoOnboard0701002458 | AutoOnboard0701002458 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin no found store statement in result
    And NGOC_ADMIN_07 quit browser

  @StoreStatement03 @StoreStatement
  Scenario: Check creating a store financial statement with a new approved store (buyer onboarding process)
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx704@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany          | store                 | buyer   | statementMonth | region  | managedBy |
      | AutoOnboard0621021254 | AutoOnboard0621021254 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin verify store statement in result
      | store                 | month       | beginningBalance | endingBalance |
      | AutoOnboard0621021254 | currentDate | [blank]          | [blank]       |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement04 @StoreStatement
  Scenario: Check creating a store financial statement with a new store created by admin
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx705@podfoods.co | 12345678a |
    When Admin search store by API
      | q[name]          | q[has_surcharge] | q[store_size] | q[store_type_id] | q[city] | q[state] | q[receiving_week_day] | q[region_ids] | q[route_id] |
      | ngoctx ststate04 | [blank]          | [blank]       | [blank]          | [blank] | [blank]  | [blank]               | [blank]       | [blank]     |
    And Admin delete store "" by api

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx705@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Stores" to "All stores" by sidebar
    And Admin go to create store
    And Admin fill info to create store
      | name             | email                        | region              | timeZone                   | storeSize | buyerCompany | phone      | street                | city    | state    | zip   |
      | ngoctx ststate04 | ngoctx+ststate01@podfoods.co | Chicagoland Express | Pacific Time (US & Canada) | <50k      | ngoc cpn1    | 0123456789 | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin create store success
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | ngoctx ststate04 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin verify store statement in result
      | store            | month       | beginningBalance | endingBalance |
      | ngoctx ststate04 | currentDate | [blank]          | [blank]       |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement05 @StoreStatement
  Scenario: Check creating a store statement with a inactive store (approved)
    Given NGOCTX07 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Admin search store by API
      | q[name]          | q[has_surcharge] | q[store_size] | q[store_type_id] | q[city] | q[state] | q[receiving_week_day] | q[region_ids] | q[route_id] |
      | ngoctx ststate05 | [blank]          | [blank]       | [blank]          | [blank] | [blank]  | [blank]               | [blank]       | [blank]     |
    And Admin delete store "" by api

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx706@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Stores" to "All stores" by sidebar
    And Admin go to create store
    And Admin fill info to create store
      | name             | email                        | region              | timeZone                   | storeSize | buyerCompany | phone      | street                | city    | state    | zip   |
      | ngoctx ststate05 | ngoctx+ststate01@podfoods.co | Chicagoland Express | Pacific Time (US & Canada) | <50k      | ngoc cpn1    | 0123456789 | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin create store success
    And Admin "Deactivate this store" in store detail

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | ngoctx ststate05 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin verify store statement in result
      | store            | month       | beginningBalance | endingBalance |
      | ngoctx ststate05 | currentDate | $0.00            | $0.00         |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement10 @StoreStatement
  Scenario: Check store statement list when admin deletes an approved store which has any order
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx707@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 03 | 61731              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

     # Create order
    Given Buyer login web with by api
      | email                           | password  |
      | ngoctx+ststate10chi@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 16396     | 61731 | 5        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx707@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name             | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate10 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin delete store "ngoctx ststate10" and verify message "This entity cannot be deleted since it is associated with another data (e.g. Order, Inventory, Promotion, ect)"
    And NGOC_ADMIN_07 quit browser

  @StoreStatement11 @StoreStatement
  Scenario: Check store statement list when admin deletes an approved store which has no order
    Given NGOCTX07 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Admin search store by API
      | q[name]          | q[has_surcharge] | q[store_size] | q[store_type_id] | q[city] | q[state] | q[receiving_week_day] | q[region_ids] | q[route_id] |
      | ngoctx ststate11 | [blank]          | [blank]       | [blank]          | [blank] | [blank]  | [blank]               | [blank]       | [blank]     |
    And Admin delete store "" by api

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx708@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Stores" to "All stores" by sidebar
    And Admin go to create store
    And Admin fill info to create store
      | name             | email                        | region              | timeZone                   | storeSize | buyerCompany | phone      | street                | city    | state    | zip   |
      | ngoctx ststate11 | ngoctx+ststate01@podfoods.co | Chicagoland Express | Pacific Time (US & Canada) | <50k      | ngoc cpn1    | 0123456789 | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin create store success
    And NGOC_ADMIN_07 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name             | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate11 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin delete store "ngoctx ststate11"
    And Admin search all store
      | name             | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx ststate11 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    And Admin no found store statement in result
    And NGOC_ADMIN_07 quit browser

  @StoreStatement16 @StoreStatement
  Scenario: Check all happenned events when admin clicks on Show filters button
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx709@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin verify field Statement month criteria
    And NGOC_ADMIN_07 quit browser

  @StoreStatement23 @StoreStatement
  Scenario: Check displayed information on the header-bar of the statement details
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx710@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | ngoctx ststate23 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin verify store statement in result
      | store            | month       | beginningBalance | endingBalance |
      | ngoctx ststate23 | currentDate | [blank]          | [blank]       |
    And Admin go to detail of store statement "ngoctx ststate23"
    Then Admin verify header-bar of statement detail "ngoctx ststate23" - "currentDate"
    And NGOC_ADMIN_07 quit browser

  @StoreStatement25 @StoreStatement26 @StoreStatement
  Scenario: Check displayed information on the GENERAL INFORMATION section
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx711@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | ngoctx ststate23 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin verify store statement in result
      | store            | month       | beginningBalance | endingBalance |
      | ngoctx ststate23 | currentDate | [blank]          | [blank]       |
    And Admin go to detail of store statement "ngoctx ststate23"
    Then Admin verify general information of statement detail
      | store            | statementMonth |
      | ngoctx ststate23 | currentDate    |
    And Admin verify electronic ACH in top section of statement detail
      | bank                | accountName  | routingNumber | accountNumber |
      | Silicon Valley Bank | Pod Foods Co | 121140399     | 3302839194    |
    And Admin verify mail a check in top section of statement detail
      | name         | address      | city          | state    |
      | Pod Foods Co | PO Box 77490 | San Francisco | CA 94107 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement38 @StoreStatement
  Scenario: Check display of sub-invoice on statement when all its line-items are unfullfiled
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx712@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc02 | 29918              | 100      | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx712@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststate36CHI1 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | ngoctx ststate36 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate36"
    And Admin no found sub invoice in store statement detail
    And NGOC_ADMIN_07 quit browser

  @StoreStatement39 @StoreStatement
  Scenario: Check display of sub-invoice on statement when its is fullfiled partially
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx713@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc02 | 29918              | 100      | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc01 | 29917              | 100      | random   | 90           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                            | password  |
      | ngoctx+ststate36chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 5933      | 29917 | 1        |
      | 5933      | 29918 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx713@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc01 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | ngoctx ststate36 | [blank] | currentDate    | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate36"
    And Admin no found sub invoice in store statement detail
    And NGOC_ADMIN_07 quit browser

  @StoreStatement40 @StoreStatement
  Scenario: Check display of sub-invoice on statement when all its line-items are fullfiled
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx714@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc01 | 29917              | 100      | random   | 90           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                            | password  |
      | ngoctx+ststate36chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 5933      | 29917 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx714@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc01 | Minus30     |
    And Admin get ID of sub-invoice of order "express"
    And NGOC_ADMIN_07 quit browser

  @StoreStatement42 @StoreStatement
  Scenario: Check display of a sub-invoice on statement after admin unfulfilled PO of a sub-invoice
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx715@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 03 | 61731              | 100      | random   | 90           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                            | password  |
      | ngoctx+ststatement55@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 16396     | 61731 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx715@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And NGOC_ADMIN_07 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | [blank]   | [blank] |
    And Admin get ID of sub-invoice of order "express"
    And Admin unfulfill all line items created by buyer
      | index | skuName                   |
      | 1     | AT SKU Store Statement 03 |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement55 | ngoctx ststatement55 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement55"
    And Admin no found sub invoice in store statement detail
    And NGOC_ADMIN_07 quit browser

  @StoreStatement43 @StoreStatement
  Scenario: Check display of a sub-invoice after LP confirm a PO on LP dashboard
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx716@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc02 | 29918              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx716@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    And NGOC_ADMIN_07 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | [blank]         | [blank] | [blank]   | [blank] |
    And Admin get ID of sub-invoice of order "express"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store               | fulFilledDate | order           | po      |
      | Ordered, Latest first | Unconfirmed  | ngoc storestatement | [blank]       | create by admin | [blank] |
    And LP go to order detail ""
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer                | store               | address                                         | department | receivingWeekday | receivingTime | route   | adminNote | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | ngoctx ststatement01 | ngoc storestatement | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]    | [blank]          | [blank]       | [blank] | [blank]   | [blank] | [blank]         |
    And LP confirm order unconfirmed then verify status is "In progress"
    And LP set fulfillment order from admin with date "Plus1"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"
    And Admin no found sub invoice in store statement detail
    And NGOC_ADMIN_07 quit browser
    And USER_LP quit browser

  @StoreStatement43.1 @StoreStatement
  Scenario: Check display of a sub-invoice after LP confirm a PO on LP dashboard (Fulfillment date LP < CurrentDate)
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx717@podfoods.co | 12345678a |
    # Delete order
    When Admin search order by API
      | skuID | fulfillment_state | buyer_payment_state |
      | 29918 | [blank]           | pending             |
    And Admin delete order of sku "29918" by api
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc02 | 29918              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx717@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    And NGOC_ADMIN_07 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | [blank]         | [blank] | [blank]   | [blank] |
    And Admin get ID of sub-invoice of order "express"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store               | fulFilledDate | order           | po      |
      | Ordered, Latest first | Unconfirmed  | ngoc storestatement | [blank]       | create by admin | [blank] |
    And LP go to order detail ""
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer                | store               | address                                         | department | receivingWeekday | receivingTime | route   | adminNote | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | ngoctx ststatement01 | ngoc storestatement | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]    | [blank]          | [blank]       | [blank] | [blank]   | [blank] | [blank]         |
    And LP confirm order unconfirmed then verify status is "In progress"
    And LP set fulfillment order from admin with date "Minus1"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | Minus1       | ngoctx ststatement01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | Minus1       | ngoctx ststatement01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser
    And USER_LP quit browser

  @StoreStatement43.2 @StoreStatement44 @StoreStatement
  Scenario: Check display of a sub-invoice after LP confirm a PO on LP dashboard  (Fulfillment date LP = currentDate)
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx718@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc02 | 29918              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx718@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    And NGOC_ADMIN_07 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | [blank]         | [blank] | [blank]   | [blank] |
    And Admin get ID of sub-invoice of order "express"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store               | fulFilledDate | order           | po      |
      | Ordered, Latest first | Unconfirmed  | ngoc storestatement | [blank]       | create by admin | [blank] |
    And LP go to order detail ""
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer                | store               | address                                         | department | receivingWeekday | receivingTime | route   | adminNote | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | ngoctx ststatement01 | ngoc storestatement | 1544 West 18th Street, Chicago, Illinois, 60608 | [blank]    | [blank]          | [blank]       | [blank] | [blank]   | [blank] | [blank]         |
    And LP confirm order unconfirmed then verify status is "In progress"
    And LP set fulfillment order from admin with date "currentDate"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststatement01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststatement01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser
    And USER_LP quit browser

  @StoreStatement45 @StoreStatement
  Scenario: Check when Admin split sub-invoice
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx719@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 01 | 45618              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
       # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 02 | 45619              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx719@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement45 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Store Statement 01"
    And Admin add line item is "AT SKU Store Statement 02"
    And Admin create order success
    And NGOC_ADMIN_07 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | [blank]         | [blank] | [blank]   | [blank] |
    When Admin fulfill all line items created by buyer
      | index | skuName                   | fulfillDate |
      | 1     | AT SKU Store Statement 01 | currentDate |
      | 1     | AT SKU Store Statement 02 | currentDate |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName                   |
      | AT SKU Store Statement 01 |
    And Admin get ID of sub-invoice by info
      | index | skuName                   | type    |
      | 1     | AT SKU Store Statement 01 | express |
      | 1     | AT SKU Store Statement 02 | express |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement45 | ngoctx ststatement45 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement45"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement45 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $0.00  | [blank] | [blank] | $100.00 |
      | AT SKU Store Statement 02 | random  | currentDate | currentDate  | ngoctx ststatement45 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement45 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $0.00  | [blank] | [blank] | $100.00 |
      | AT SKU Store Statement 02 | random  | currentDate | currentDate  | ngoctx ststatement45 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement46 @StoreStatement
  Scenario: Check when Admin delete line item from sub-invoice
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx720@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 01 | 45618              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
       # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 02 | 45619              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx720@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement47 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Store Statement 01"
    And Admin add line item is "AT SKU Store Statement 02"
    And Admin create order success
    And NGOC_ADMIN_07 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | [blank]         | [blank] | [blank]   | [blank] |
    When Admin fulfill all line items created by buyer
      | index | skuName                   | fulfillDate |
      | 1     | AT SKU Store Statement 01 | currentDate |
    And Admin delete line item created by buyer
      | index | skuName                   | type    |
      | 1     | AT SKU Store Statement 02 | express |
    And Admin get ID of sub-invoice by info
      | index | skuName                   | type    |
      | 1     | AT SKU Store Statement 01 | express |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement47 | ngoctx ststatement47 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement47"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement47 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement47 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement47 @StoreStatement
  Scenario: Check when Admin mergers fulfilled sub-invoices
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx721@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 01 | 45618              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
       # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 02 | 45619              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx721@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement48 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Store Statement 01"
    And Admin add line item is "AT SKU Store Statement 02"
    And Admin create order success
    And NGOC_ADMIN_07 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | [blank]         | [blank] | [blank]   | [blank] |
    When Admin fulfill all line items created by buyer
      | index | skuName                   | fulfillDate |
      | 1     | AT SKU Store Statement 01 | currentDate |
    And Admin delete line item created by buyer
      | index | skuName                   | type    | deduction |
      | 1     | AT SKU Store Statement 02 | express | No        |
    And Admin get ID of sub-invoice by info
      | index | skuName                   | type    |
      | 1     | AT SKU Store Statement 01 | express |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement48 | ngoctx ststatement48 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement48"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement48 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement48 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement48 @StoreStatement
  Scenario: Check when Admin add line items to sub-invoice
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx722@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 01 | 45618              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
       # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 02 | 45619              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx722@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement49 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Store Statement 01"
    And Admin create order success
    When Admin fulfill all line items created by buyer
      | index | skuName                   | fulfillDate |
      | 1     | AT SKU Store Statement 01 | currentDate |
    And Admin add line item in order detail
      | skuName                   | quantity | note    |
      | AT SKU Store Statement 02 | 1        | [blank] |
    And Admin create "add to" sub-invoice with Suffix ="1"
      | skuName                   |
      | AT SKU Store Statement 02 |
    And Admin get ID of sub-invoice by info
      | index | skuName                   | type    |
      | 1     | AT SKU Store Statement 01 | express |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement49 | ngoctx ststatement49 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement49"
    And Admin no found sub invoice of SKU "AT SKU Store Statement 01" in store statement detail

    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    When Admin fulfill all line items created by buyer
      | index | skuName                   | fulfillDate |
      | 1     | AT SKU Store Statement 02 | currentDate |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement49 | ngoctx ststatement49 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement49"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement49 | Unpaid | 0     | [blank]     | $200.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $230.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement49 | Unpaid | 0     | [blank]     | $200.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $230.00 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement49 @StoreStatement
  Scenario: Check when Admin deletes a fulfilled sub-invoice successfully
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx723@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 01 | 45618              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx723@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement50 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Store Statement 01"
    And Admin create order success
    When Admin fulfill all line items created by buyer
      | index | skuName                   | fulfillDate |
      | 1     | AT SKU Store Statement 01 | currentDate |
    And Admin get ID of sub-invoice by info
      | index | skuName                   | type    |
      | 1     | AT SKU Store Statement 01 | express |
#    And Admin remove sub-invoice with info
#      | index | skuName                   | type    | subinvoice |
#      | 1     | AT SKU Store Statement 01 | express | [blank]    |
#
#    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
#    And Admin fill password to authen permission
#    And Admin search store statements
#      | buyerCompany | store             | buyer                  | statementMonth | region              | managedBy |
#      | ngoc cpn1    | ngoctx ststated46 | ngoctx ststated46chi01 | currentDate    | Chicagoland Express | [blank]   |
#    And Admin go to detail of store statement "ngoctx ststated46"
#    And Admin no found sub invoice of SKU "AT SKU Store Statement 01" in store statement detail
    And NGOC_ADMIN_07 quit browser

  @StoreStatement51 @StoreStatement
  Scenario: Check when an unpaid sub-invoice on the current month statement is paid successfully
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx724@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store Statement 01 | 45618              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx724@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement51 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Store Statement 01"
    And Admin create order success
    When Admin fulfill all line items created by buyer
      | index | skuName                   | fulfillDate |
      | 1     | AT SKU Store Statement 01 | currentDate |
    And Admin get ID of sub-invoice by info
      | index | skuName                   | type    |
      | 1     | AT SKU Store Statement 01 | express |
    And Admin get sub invoice id to run job sidekiq

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement51 | ngoctx ststatement51 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement51"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement51 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | skuName                   | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | AT SKU Store Statement 01 | random  | currentDate | currentDate  | ngoctx ststatement51 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser
    And ADMIN_OLD quit browser

  @StoreStatement61 @StoreStatement
  Scenario: Check when admin cancels an Not used credit memo successfully
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx725@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                | orderID | type              | amount | description      | file                 |
      | ngoctx ststatement52 | random  | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success
    And Admin cancel this credit memo

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement52 | ngoctx ststatement52 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement52"
    And Admin verify "credit memo" no found in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging   | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststatement52 | Used   | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement62 @StoreStatement
  Scenario: Check when admin edits amount of an Not used credit memo successfully
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx726@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                | orderID | type              | amount | description      | file                 |
      | ngoctx ststatement53 | random  | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success

    And Admin edit general information of credit memo
      | amount | state   | order   | description |
      | 200    | [blank] | [blank] | [blank]     |

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement53 | ngoctx ststatement53 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement53"
    And Admin verify "credit memo" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status   | aging | description | orderValue | discount | deposit | fee     | credit    | pymt    | total     |
      | random  | currentDate | currentDate  | ngoctx ststatement53 | Not used | 0     | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($200.00) | [blank] | ($200.00) |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement69 @StoreStatement
  Scenario: Check when admin edits an unpaid adjustment created on current month successfully
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx727@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                   | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx storestatement54 | ngoctx ststatement54 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx storestatement54"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 100   | adjustment 1 | [blank]    | currentDate  | Auto Adjustment |
    And NGOC_ADMIN_07 refresh browser
    And Admin verify "adjustment" in "middle" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt    | total   |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $100.00 | $100.00 |
    And Admin edit an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 200   | adjustment 1 | random     | currentDate  | Auto Adjustment |
    And NGOC_ADMIN_07 refresh browser
    And Admin verify "adjustment" in "middle" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt    | total   |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $200.00 | $200.00 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement77 @StoreStatement
  Scenario: Check that Payment amount is more than total amount of unpaid sub-invoices and adjustments
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx728@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU StoreA77 | 64316              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                              | password  |
      | ngoctx+ststatea77chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7071      | 64316 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx728@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin fulfill all line items created by buyer
      | index | skuName         | fulfillDate |
      | 1     | AT SKU StoreA77 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store             | buyer                  | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststateA77 | ngoctx ststateA77chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststateA77"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 100   | adjustment 1 | [blank]    | currentDate  | Auto Adjustment |

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment   |
      | all     | 300           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | adjustment 1 |
    When Admin add record payment success
    And NGOC_ADMIN_07 refresh browser
    And Admin get id of Unapplied payment after record payment success
    And Admin verify unapplied payment in "middle" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($70.00) | ($70.00) |
    And Admin verify unapplied payment in "bottom" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($70.00) | ($70.00) |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement78 @StoreStatement
  Scenario: Check that Payment amount is more than total amount of unpaid sub-invoices and adjustments
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx729@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store77 | 32554              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+ststate77chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7071      | 32554 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx729@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin fulfill all line items created by buyer
      | index | skuName        | fulfillDate |
      | 1     | AT SKU Store77 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate77 | ngoctx ststate77chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate77"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 100   | adjustment 1 | [blank]    | currentDate  | Auto Adjustment |

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | all     | 200           | currentDate | Other       | Autotest payment | [blank]     | Unapplied Payment | adjustment 1 |
    When Admin add record payment success
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging   | description     | orderValue | discount | deposit | fee     | credit  | pymt    | total   |
      | adjustment 1 | currentDate | currentDate  | [blank] | Paid   | [blank] | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $100.00 | $100.00 |
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate77chi01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement79 @StoreStatement
  Scenario: Check that Payment amount + Selected unapplied payments amount are more than Selected adjustments + All unpaid sub-invoice
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx730@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Store77 | 32554              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Tạo unapplied payment
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+ststate79chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7071      | 32554 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx730@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin fulfill all line items created by buyer
      | index | skuName        | fulfillDate |
      | 1     | AT SKU Store77 | Minus1      |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate79 | ngoctx ststate79chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate79"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | all     | 200           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success
    And NGOC_ADMIN_07 refresh browser
    And Admin get id of Unapplied payment after record payment success

    # Tạo order để dùng unapplied payment vừa tạo
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+ststate79chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7071      | 32554 | 1        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin fulfill all line items created by buyer
      | index | skuName        | fulfillDate |
      | 1     | AT SKU Store77 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate79 | ngoctx ststate79chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate79"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 100   | adjustment 1 | [blank]    | currentDate  | Auto Adjustment |
    And NGOC_ADMIN_07 refresh browser
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | all     | 250           | currentDate | Other       | Autotest payment | [blank]     | Unapplied Payment | adjustment 1 |
    When Admin add record payment success
    And NGOC_ADMIN_07 refresh browser
    And Admin get id of Unapplied payment after record payment success
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging   | description     | orderValue | discount | deposit | fee     | credit  | pymt    | total   |
      | adjustment 1 | currentDate | currentDate  | [blank] | Paid   | [blank] | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $100.00 | $100.00 |
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate79chi01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    And NGOC_ADMIN_07 quit browser

  @StoreStatement80 @STORE-STATEMENT_81 @STORE-STATEMENT_83 @STORE-STATEMENT_84 @STORE-STATEMENT_85 @STORE-STATEMENT_86 @StoreStatement
  Scenario: Check that Payment amount + Selected unapplied payments amount are less than Selected adjustments + All unpaid sub-invoice
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx731@podfoods.co | 12345678a |
    When Search order by sku "29918" by api
    And Admin delete order of sku "29918" by api
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc02 | 29918              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      # Tạo unapplied payment
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+ststate80chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7071      | 32554 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx731@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    When Admin fulfill all line items created by buyer
      | index | skuName        | fulfillDate |
      | 1     | AT SKU Store77 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate80 | ngoctx ststate80chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate80"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | all     | 200           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success
    And NGOC_ADMIN_07 refresh browser
    And Admin get id of Unapplied payment after record payment success

    # Tạo order để dùng unapplied payment vừa tạo
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+ststate80chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7071      | 32554 | 1        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin fulfill all line items created by buyer
      | index | skuName        | fulfillDate |
      | 1     | AT SKU Store77 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate80 | ngoctx ststate80chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate80"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 100   | adjustment 1 | [blank]    | currentDate  | Auto Adjustment |

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | all     | 150           | currentDate | Other       | Autotest payment | [blank]     | Unapplied Payment | adjustment 1 |
    When Admin add record payment error
    When Admin edit record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | all     | 200           | currentDate | Other       | Autotest payment | [blank]     | Unapplied Payment | adjustment 1 |
    When Admin add record payment success
    And NGOC_ADMIN_07 quit browser

  @STORE-STATEMENT_87
  Scenario: Check when Stripes charges sub-invoices successfully (credit card or bank account)
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx731@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Autotest SKU1 Ngoc02 | 29918              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Tạo unapplied payment
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+ststate80chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 5933      | 29918 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx731@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate80 | ngoctx ststate80chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate80"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | all     | 200           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success
    And Admin get id of Unapplied payment after record payment success

    # Tạo order để dùng unapplied payment vừa tạo
    Given Buyer login web with by api
      | email                             | password  |
      | ngoctx+ststate80chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 5933      | 29918 | 1        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_07 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate80 | ngoctx ststate80chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate80"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 100   | adjustment 1 | [blank]    | currentDate  | Auto Adjustment |

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | all     | 150           | currentDate | Other       | Autotest payment | [blank]     | Unapplied Payment | adjustment 1 |
    When Admin add record payment error
    When Admin edit record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | all     | 200           | currentDate | Other       | Autotest payment | [blank]     | Unapplied Payment | adjustment 1 |
    When Admin add record payment success
    And NGOC_ADMIN_07 quit browser

  @STORE-STATEMENT_88
  Scenario: Verify edit visibility search in store statement
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx732@podfoods.co | 12345678a |
    # Reset search filter full textbox
    And Admin filter visibility with id "24" by api
      | q[buyer_id]         |
      | q[region_id]        |
      | q[store_id]         |
      | q[statement_month]  |
      | q[manager_id]       |
      | q[buyer_company_id] |

    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx732@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | buyerCompany | buyer | region | store | statementMonth | managedBy |
      | Yes          | Yes   | Yes    | Yes   | Yes            | Yes       |
    Then Admin verify field search uncheck all in edit visibility
      | buyerCompany | buyer | region | store | statementMonth | managedBy |
      | Yes          | Yes   | Yes    | Yes   | Yes            | Yes       |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | buyerCompany | buyer | region | store | statementMonth | managedBy |
      | Yes          | Yes   | Yes    | Yes   | Yes            | Yes       |
    Then Admin verify field search in edit visibility of store statement
    # Verify save new filter
    When Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy     |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | [blank]        | Chicagoland Express | thuy_admin123 |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy     |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | [blank]        | Chicagoland Express | thuy_admin123 |
    # Verify save as filter
    When Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region           | managedBy     |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | [blank]        | New York Express | thuy_admin123 |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in store statements
      | buyerCompany | store            | buyer                 | statementMonth | region           | managedBy     |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | [blank]        | New York Express | thuy_admin123 |

    Given NGOC_ADMIN_071 open web admin
    When login to beta web with email "ngoctx733@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_071 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    When Admin search store statements
      | buyerCompany | store   | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | [blank] | [blank] | [blank]        | [blank] | [blank]   |
    Then Admin verify filter "AutoTest1" is not display

    And Switch to actor NGOC_ADMIN_07
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display






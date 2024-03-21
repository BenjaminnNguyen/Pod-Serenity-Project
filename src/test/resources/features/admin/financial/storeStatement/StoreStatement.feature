@feature=StoreStatement
Feature: StoreStatement

  @StoreStatement @StoreStatement01 @STORE-STATEMENT_31
  Scenario: Store statement > Admin record payment: Credit memo, Adjustment, Unapplied payment, Sub-invoice of Current Month
    Given NGOCTX02 login web admin by api
      | email                | password  |
      | ngoctx02@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 30" from product id "6335" by API
    # Delete order
    When Admin search order by API
      | skuID | fulfillment_state | buyer_payment_state |
      | 29918 | [blank]           | pending             |
    And Admin delete order of sku "31003" by api

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
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
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 180           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net      |
      | $0.00      | $130.00    | $0.00 | $0.00     | ($180.00) | ($50.00) |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststatement01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $130.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description              | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest payment | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($130.00) | ($130.00) |
    And Admin get id of Unapplied payment after record payment success
    And Admin verify unapplied payment in "middle" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |
    And Admin verify unapplied payment in "bottom" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |

    And NGOC_ADMIN navigate to "Financial" to "Credit memos" by sidebar
    When Admin create credit memo with info
      | buyer                | orderID | type              | amount | description      | file                 |
      | ngoctx ststatement01 | random  | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success

    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 10    | adjustment 1 | random     | currentDate  | Auto Adjustment |
    And Admin verify "credit memo" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status   | aging | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststatement01 | Not used | 0     | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "middle" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    And Admin verify "credit memo" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status   | aging | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststatement01 | Not used | 0     | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | random  | 100           | currentDate | Other       | Autotest payment | random      | Unapplied Payment | adjustment 1 |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo     | unapplied | payment   | net   |
      | $10.00     | $130.00    | ($10.00) | ($50.00)  | ($100.00) | $0.00 |
    When Admin add record payment success

    And Admin verify "credit memo" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging   | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststatement01 | Used   | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging   | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Paid   | [blank] | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststatement01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $130.00 |
    And Admin verify unapplied payment in "bottom" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Used   | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |
    When Admin verify sum of "order-value" in "bottom" of store statements details
    When Admin verify sum of "deposit" in "bottom" of store statements details
    When Admin verify sum of "fee" in "bottom" of store statements details
    When Admin verify sum of "memo" in "bottom" of store statements details
    When Admin verify sum of "payment" in "bottom" of store statements details
    When Admin verify sum of "total" in "bottom" of store statements details

  @StoreStatement @StoreStatement02
  Scenario: Store statement > Admin record payment: Credit memo, Adjustment, Unapplied payment, Sub-invoice of Previous Month and Previous Month not Locked yet (Payment date from 1-5th of Current Month)
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | 05/31/22    |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | 05/2022        | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 200           | 05/31/22    | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net      |
      | $0.00      | $150.00    | $0.00 | $0.00     | ($200.00) | ($50.00) |
    When Admin add record payment success

    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | 05/31/22    |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | 05/2022        | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"

    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 10    | adjustment 1 | random     | 05/31/22     | Auto Adjustment |
    And Admin verify "adjustment" in "middle" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | 05/31/22     | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | 05/31/22     | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note                    | creditMemos | unappliedPayment  | adjustment   |
      | random  | 150           | currentDate | Other       | Autotest Previous month | [blank]     | Unapplied Payment | adjustment 1 |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net      |
      | $10.00     | $150.00    | $0.00 | ($50.00)  | ($150.00) | ($40.00) |
    When Admin add record payment success
    And Admin verify "random" in "middle" of store statements details is disable
    And Admin verify "Unapplied Payment" in "middle" of store statements details is disable
    And Admin verify "adjustment 1" in "middle" of store statements details is disable

#    And Admin verify "credit memo" in "bottom" of store statements details
#      | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee | credit   | pymt | total    |
#      | random  | currentDate | currentDate  | ngoctx ststatement01 | Used   | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | [blank]  | ($10.00) | [blank]  | ($10.00) |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | 05/31/22     | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | 05/31/22     | ngoctx ststatement01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin get id of unapplied payment previous month
    And Admin verify unapplied payment in "bottom" of store statements detail of "previous" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"
    And Admin verify "Payment" after record in "bottom" of store statements detail of previous month
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description                     | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest Previous month | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($110.00) | ($110.00) |
    And Admin verify "Unapplied Payment" after record in "bottom" of store statements detail of previous month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($40.00) | ($40.00) |
    And Admin verify "Unapplied Payment" after record in "middle" of store statements detail of previous month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($40.00) | ($40.00) |
    When Admin verify sum of "order-value" in "bottom" of store statements details
    When Admin verify sum of "deposit" in "bottom" of store statements details
    When Admin verify sum of "fee" in "bottom" of store statements details
    When Admin verify sum of "memo" in "bottom" of store statements details
    When Admin verify sum of "payment" in "bottom" of store statements details
    When Admin verify sum of "total" in "bottom" of store statements details

    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store               | buyer                | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc storestatement | ngoctx ststatement01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc storestatement"

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment |
      | random  | 110           | currentDate | Other       | Autotest payment | [blank]     | Unapplied Payment | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net   |
      | $0.00      | $150.00    | $0.00 | ($40.00)  | ($110.00) | $0.00 |
    When Admin add record payment success

  @StoreStatement @StoreStatement02
  Scenario: Store statement > Admin record payment: Credit memo, Adjustment, Unapplied payment, Sub-invoice of Previous Month and Previous Month is Locked
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststatement01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | 05/31/22    |
    And Admin get ID of sub-invoice of order "express"
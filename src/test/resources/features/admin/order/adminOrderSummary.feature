#mvn clean verify -Dtestsuite="AdminOrderSummaryTestSuite" -Dcucumber.options="src/test/resources/features/admin/order" -Drp.launch=Testcommandline -Drp.project=podfoodsweb
@feature=AdminOrderSummary
Feature: Admin Order Summary

  Narrative:
  Auto test admin order summary

  @AdminOrderSummary_01 @AdminOrderSummary
  Scenario: Admin create product, edit and filter
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1100@podfoods.co | 12345678a |
      # Delete order
    When Search order by sku "36479" by api
    And Admin delete order of sku "36479" by api
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU A Order Sum 01   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 01" from API
    And Admin delete inventory "all" by API
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 01 | 36479 | create by api buyer | [blank]  | pending       | [blank] |

    # Reset search filter full textbox
    And Admin filter visibility with id "34" by api
      | q[number]                 |
      | q[custom_store_name]      |
      | q[store_ids]              |
      | q[store_id]               |
      | q[buyer_id]               |
      | q[vendor_company_id]      |
      | q[brand_id]               |
      | q[product_variant_ids]    |
      | q[upc]                    |
      | q[buyer_company_id]       |
      | q[fulfillment_states]     |
      | q[buyer_payment_state]    |
      | q[region_id]              |
      | q[route_id]               |
      | q[store_manager_id]       |
      | q[lack_pod]               |
      | q[lack_tracking]          |
      | start_date                |
      | end_date                  |
      | q[temperature_name]       |
      | q[has_out_of_stock_items] |
      | q[type]                   |
      | q[express_progress]       |
      | q[only_spring_po]         |
      | per_page                  |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1100@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderNumber | customStore | stores  | buyer   | vendorCompany | brand   | sku     | upc     | buyercompany | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | startDate | endDate | temperature | oos     | orderType | expressProgress | edi     | perPage |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank] | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | orderNumber | customStore | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyercompany | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | startDate | endDate | temperature | oos     | orderType | expressProgress | edi     |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | orderNumber | customStore | stores  | buyer   | vendorCompany | brand   | sku     | upc     | buyercompany | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | startDate | endDate | temperature | oos     | orderType | expressProgress | edi     | perPage |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank] | [blank] |
    Then Admin verify field search in edit visibility
      | orderNumber | customStore | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyercompany | fulfillment | buyerPayment | region  | route   | storeManager | lackPOD | lackTracking | startDate | endDate | temperature | oos     | orderType | expressProgress | edi     | perPage |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | [blank]     | [blank]      | [blank] | [blank] | [blank]      | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank] | [blank]   | [blank]         | [blank] | [blank] |
    # Verify save new filter
    And Admin search the orders in summary by info
      | orderNumber | orderSpecific  | store              | buyer                 | vendorCompany | brand                      | sku                  | upc       | buyerCompany         | fulfillment | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | edi | perPage |
      | 123123      | customer Store | ngoctx stdropsum01 | ngoctx bdropsum07ny01 | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | ngoc cpn a order sum | remove      | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes | 12      |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in order summary
      | orderNumber | orderSpecific  | store              | buyer                 | vendorCompany | brand                      | sku                  | upc       | buyerCompany         | fulfillment | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | edi | perPage |
      | 123123      | customer Store | ngoctx stdropsum01 | ngoctx bdropsum07ny01 | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | ngoc cpn a order sum | Pending     | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes | 12      |
    # Verify save as filter
    And Admin search the orders in summary by info
      | orderNumber | orderSpecific  | store              | buyer                 | vendorCompany | brand                      | sku                  | upc       | buyerCompany         | fulfillment | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | edi | perPage |
      | 12312124123 | customer Store | ngoctx stdropsum01 | ngoctx bdropsum07ny01 | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | ngoc cpn a order sum | remove      | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes | 12      |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in order summary
      | orderNumber | orderSpecific  | store              | buyer                 | vendorCompany | brand                      | sku                  | upc       | buyerCompany         | fulfillment | buyerPayment | region              | route      | managed   | pod | tracking | startDate   | endDate     | temp | oos | orderType | exProcess | edi | perPage |
      | 12312124123 | customer Store | ngoctx stdropsum01 | ngoctx bdropsum07ny01 | ngoc vc 1     | AT Brand A Drop Summary 01 | AT SKU A Drop Sum 01 | 123456789 | ngoc cpn a order sum | Pending     | Pending      | Chicagoland Express | Unassigned | ngoctx555 | Yes | Yes      | currentDate | currentDate | Dry  | Yes | Express   | Pending   | Yes | 12      |

    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 01 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_05 @AdminOrderSummary
  Scenario: Admin verify payment status - paid
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1103@podfoods.co | 12345678a |
      # Active SOS
    And Admin change status using SOS of store "3514" to "true"
    And Admin change info SOS of store "3514"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 09 | 59412              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123962             | 59412              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3704     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 09 | 59412 | create by api buyer | [blank]  | pending       | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1103@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName               | fulfillDate |
      | 1     | AT SKU A Order Sum 09 | currentDate |
    And NGOC_ADMIN_11 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                | buyer                    | statementMonth | region  | managedBy |
      | [blank]      | ngoctx staordersum07 | ngoctx staordersum07ny01 | currentDate    | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx staordersum07"
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 10            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum07 | ngoctx staordersum07ny01 | New York | New York     | UNASSIGNED | Paid   | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 09 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_02 @AdminOrderSummary
  Scenario: Admin verify route - PE item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1101@podfoods.co | 12345678a |
    And Admin change route of store by api
      | storeID | routeID |
      | 3513    | 52      |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3703     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName           | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order 01 | 36479 | create by api buyer | [blank]  | pending       | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1101@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum06 | ngoctx staordersum06ny01 | New York | New York     | Route test | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $15.25        | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 01 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_03 @AdminOrderSummary
  Scenario: Admin verify route - PE item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1102@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 07 | 59410              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123960             | 59410              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | bank_or_cc   | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 01 | 59410 | create by api buyer | [blank]  | pending       | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1102@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment                            |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via credit card or bank account |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 07 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_04 @AdminOrderSummary
  Scenario: Admin verify payment status - pending
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1103@podfoods.co | 12345678a |
    When Search order by sku "59411" by api
    And Admin delete order of sku "59411" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 08   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 08" from API
    And Admin delete inventory "all" by API
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 08 | 59411              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123961             | 59411              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | bank_or_cc   | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 08 | 59411 | create by api buyer | [blank]  | pending       | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1103@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment                            |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via credit card or bank account |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 08 | Dry | [blank]  | 1        | 9           | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_07 @AdminOrderSummary
  Scenario: Admin verify Small order surcharge stamp - turn off SOS
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1105@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3705     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1105@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum08 | ngoctx staordersum08ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | [blank] |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 01 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_06 @AdminOrderSummary
  Scenario: Admin verify payment status - declined
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1104@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123963             | 59413              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3517     | [blank]    | [blank]     | bank_or_cc   | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 59413              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Lấy sub invoice id để run job
    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1104@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName               | fulfillDate |
      | 1     | AT SKU A Order Sum 10 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin get sub invoice id to run job sidekiq

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq
    And ADMIN_OLD quit browser

    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status   | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment                            |
      | NY     | currentDate | ngoctx staordersum02 | ngoctx staordersum02ny01 | New York | New York     | UNASSIGNED | Declined | $30.00     | currentDate     | day(s)       | Payment via credit card or bank account |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 10 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_08 @AdminOrderSummary
  Scenario: Admin verify Small order surcharge stamp - (order value - discount)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1106@podfoods.co | 12345678a |
      # Active SOS
    And Admin change status using SOS of store "3514" to "true"
    And Admin change info SOS of store "3514"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 51       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3704     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1106@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum07 | ngoctx staordersum07ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     |
      | No | $0.00         | $510.00      | $127.50      | 51.00 lbs   | [blank] |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 01 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_09 @AdminOrderSummary
  Scenario: Admin verify Small order surcharge stamp - (edit sos of declined order)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1107@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 11 | 59414              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
        # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123964             | 59414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3517     | [blank]    | [blank]     | bank_or_cc   | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

      # Lấy sub invoice id để run job
    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1107@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName               | fulfillDate |
      | 1     | AT SKU A Order Sum 11 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin get sub invoice id to run job sidekiq

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq
    And ADMIN_OLD quit browser

    # Change sos,ls in order detail
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx11@podfoods.co | 12345678a |
    And Admin edit general info of order "" detail by api
      | sos  | ls   | customer_po |
      | 4000 | 2000 | CustomerPO  |
    # Verify
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status   | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment                            | customerPO |
      | NY     | currentDate | ngoctx staordersum02 | ngoctx staordersum02ny01 | New York | New York     | UNASSIGNED | Declined | $40.00     | [blank]         | [blank]      | Payment via credit card or bank account | CustomerPO |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $50.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 11 | Dry | [blank]  | 1        | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_11 @AdminOrderSummary
  Scenario: Admin verify line item with sub invoice has PO fulfilled
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1108@podfoods.co | 12345678a |
     # active sku
    And Update regions info of SKU "59445"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123996 | 53        | 59445              | 1000             | 1000       | in_stock     | active |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 30 | 59445              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 31 | 59446              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 05 | 38079              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123997             | 59446              | 1        | false     | [blank]          |
      | 123996             | 59445              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1108@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete line item created by buyer
      | index | skuName               | type    | deduction |
      | 1     | AT SKU A Order Sum 31 | express | No        |
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | anhJPEG.jpg | adminNote | lpNote |
    And Admin go to Order summary from order detail

    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        | notification                     |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice | All Express line-items confirmed |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | eta         |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | currentDate |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 30 | Dry | [blank]  | 1        | [blank]   | [blank]     |
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentDate | fulfillmentState | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | currentDate     | Fulfilled        | adminNote | lpNote |
    # Add Express line item are not confirmed check notification badge
    And Admin go to add line item in order summary
    And Admin add line item is "AT SKU A Order Sum 05"
    And Admin save action in order detail
    And Admin create "create" sub-invoice with Suffix ="2" in order summary
      | skuName               |
      | AT SKU A Order Sum 05 |
    And NGOC_ADMIN_11 refresh browser
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        | notification                     |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice | All Express line-items confirmed |
    # Add Direct line item check notification badge
    And Admin go to add line item in order summary
    And Admin add line item is "AT SKU A Order Sum 04"
    And Admin save action in order detail
    And Admin create "create" sub-invoice with Suffix ="3" in order summary
      | skuName               |
      | AT SKU A Order Sum 04 |
    And NGOC_ADMIN_11 refresh browser
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        | notification                     |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice | All Express line-items confirmed |
   # Remove Express line item check notification badge
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete line item created by buyer
      | index | skuName               | type    | deduction |
      | 1     | AT SKU A Order Sum 05 | express | No        |
      | 1     | AT SKU A Order Sum 04 | direct  | No        |
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        | notification                     |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice | All Express line-items confirmed |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_10 @AdminOrderSummary
  Scenario: Admin verify Small order surcharge stamp - (edit sos of pending order)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1107@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "59415" by api
    And Admin delete order of sku "59415" by api
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU A Order Sum 12   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 12" from API
    And Admin delete inventory "all" by API
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 12 | 59415              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123965             | 59415              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Change sos,ls in order detail
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx11@podfoods.co | 12345678a |
    And Admin edit general info of order "" detail by api
      | sos  | ls   |
      | 4000 | 3000 |

    # Verify
    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1107@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $40.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     |
      | No | $0.00         | $50.00       | $2.50        | 1.00 lbs    | [blank] |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 12 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |

    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin turn off display surcharges
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin export order summary
    And Admin check content file export "order list"
      | customerPO | date    | store                | shippingAddress | receivingDate          | earlestReceivingTime | latestReceivingTime | buyer                    | paymentMethod   | region           | brandID | brand                       | product                       | sku                   | priceCase | unitCase | taxes   | quantity | promotion | itemValue | itemPrice | fulfillmentDate | deliveryMethod  | deliveryDetail                                     | sub |
      | [blank]    | [blank] | ngoctx staordersum01 | [blank]         | Within 7 business days | [blank]              | [blank]             | ngoctx staordersum01ny01 | Pay via invoice | New York Express | 3148    | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 12 | 10        | 1        | [blank] | 1        | $0.00     | [blank]   | [blank]   | [blank]         | Pod Consignment | pod_consignment, Pod Consignment auto-confirmation | 1   |

    And Admin verify popup export items in Order summary
      | sku                   | price  | quantity | total  |
      | AT SKU A Order Sum 12 | $10.00 | 1        | $10.00 |
    And Admin verify packing slip in export items of Order summary
      | store                | buyer                    | order       | address                                        | brand                       | product                       | sku                   | storageCondition | upc                          | caseUpc           | caseUnit   | quantity |
      | ngoctx staordersum01 | ngoctx staordersum01ny01 | currentDate | 281 Columbus Avenue, New York, New York, 10001 | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 12 | Dry              | Unit UPC / EAN: 180219930001 | Case UPC / EAN: 1 | 1 per case | 1        |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_12 @AdminOrderSummary
  Scenario: Admin verify Receving > Set within 7 business days
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1109@podfoods.co | 12345678a |
    And Admin set all possible delivery days of store "3516" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "3516" by api
      | day                    |
      | within 7 business days |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 13 | 59416              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    #  Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123966             | 59416              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3706     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 13 | 59416 | create by api buyer | [blank]  | pending       | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1109@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum09 | ngoctx staordersum09ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | [blank] |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 13 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And Admin verify note in order summary
      | deliveryDay            | preferredDay           | receivingNote | directReceivingNote | adminNote | buyerNote |
      | Within 7 business days | Within 7 business days | [blank]       | [blank]             | [blank]   | [blank]   |
    And NGOC_ADMIN_11 quit browser

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx11@podfoods.co | 12345678a |
    And Admin set all receiving weekday of store "3516" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "3516" by api
      | day     |
      | [blank] |

  @AdminOrderSummary_13 @AdminOrderSummary
  Scenario: Admin verify Receving > Set full day
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1110@podfoods.co | 12345678a |
        # Delete order
    When Search order by sku "59417" by api
    And Admin delete order of sku "59417" by api
    And Admin set all receiving weekday of store "3517" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "3517" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "3517" by api
      | day     |
      | monday  |
      | tuesday |
    And Admin set all receiving weekday of store "3517" by api
      | day     |
      | monday  |
      | tuesday |
   # Change info store
    And Admin change info of store "3517" by api
      | attn    | full_name | street1            | street2 | city     | address_state_id | zip   | phone_number | id    | address_state_code | address_state_name | receiving_note | direct_receiving_note |
      | [blank] | [blank]   | 81 Columbus Avenue | [blank] | New York | 33               | 10023 | 1234567890   | 66655 | NY                 | New York           | [blank]        | [blank]               |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 14 | 59417              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    #  Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123967             | 59417              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3707     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 14 | 59417 | create by api buyer | [blank]  | pending       | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1110@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum10 | ngoctx staordersum10ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 14 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And Admin verify note in order summary
      | deliveryDay     | preferredDay | receivingNote | directReceivingNote | adminNote | buyerNote |
      | Monday, Tuesday | Mon          | [blank]       | [blank]             | [blank]   | [blank]   |

    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx11@podfoods.co | 12345678a |
    And Admin set all receiving weekday of store "3517" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "3517" by api
      | day     |
      | [blank] |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_14 @AdminOrderSummary
  Scenario: Admin verify Express receiving note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1111@podfoods.co | 12345678a |
       # Change info store
    And Admin change info of store "3518" by api
      | attn    | full_name | street1            | city     | address_state_id | zip   | phone_number | id     | address_state_code | address_state_name | receiving_note         | direct_receiving_note |
      | [blank] | [blank]   | 81 Columbus Avenue | New York | 33               | 10023 | 0123456798   | 103872 | NY                 | New York           | Express receiving note | Direct receiving note |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 15 | 59419              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      #  Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123969             | 59419              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3708     | Admin Note | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 15 | 59419 | create by api buyer | [blank]  | pending       | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1111@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum11 | ngoctx staordersum11ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 15 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And Admin verify note in order summary
      | deliveryDay | preferredDay | receivingNote          | directReceivingNote   | adminNote  | buyerNote |
      | [blank]     | [blank]      | Express receiving note | Direct receiving note | Admin Note | [blank]   |

    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1111@podfoods.co | 12345678a |
       # Change info store
    And Admin change info of store "3518" by api
      | attn    | full_name | street1            | city     | address_state_id | zip   | phone_number | id     | address_state_code | address_state_name | receiving_note | direct_receiving_note |
      | [blank] | [blank]   | 81 Columbus Avenue | New York | 33               | 10023 | 0123456798   | 103872 | NY                 | New York           | [blank]        | [blank]               |

    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum11 | ngoctx staordersum11ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | -   |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 15 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And Admin verify note in order summary
      | deliveryDay | preferredDay | receivingNote          | directReceivingNote   | adminNote | buyerNote |
      | [blank]     | [blank]      | Express receiving note | Direct receiving note | [blank]   | [blank]   |

    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1111@podfoods.co | 12345678a |
    #  Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123969             | 59419              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3708     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 15 | 59419 | create by api buyer | [blank]  | pending       | [blank] |

    And NGOC_ADMIN_11 refresh browser
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum11 | ngoctx staordersum11ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 15 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And Admin verify note in order summary
      | deliveryDay | preferredDay | receivingNote | directReceivingNote | adminNote | buyerNote |
      | [blank]     | [blank]      | [blank]       | [blank]             | [blank]   | [blank]   |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_15 @AdminOrderSummary
  Scenario: Admin verify Buyer special note - Admin Note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1112@podfoods.co | 12345678a |
    And Update regions info of SKU "30949"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123970 | 53        | 59420              | 1000             | 1000       | in_stock     | active |
        # Change info store
    And Admin change info of store "3069" by api
      | attn    | full_name | street1            | city     | address_state_id | zip   | phone_number | id    | address_state_code | address_state_name | receiving_note | direct_receiving_note |
      | [blank] | [blank]   | 81 Columbus Avenue | New York | 33               | 10023 | 0123456798   | 66655 | NY                 | New York           | [blank]        | [blank]               |

    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 16 | 59420              | 20       | Lotcode01 | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+staordersum01ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 9423      | 59420 | 1        |
    And Buyer add receiving info by API
      | buyerSpecialNote | customStoreName | customerPO | department |
      | Buyer Note       | [blank]         | [blank]    | [blank]    |
    And Checkout cart with payment by "invoice" by API

#    Given NGOC_ADMIN_11 open web admin
#    When NGOC_ADMIN_11 login to web with role Admin
#    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
#    And Admin search the orders in summary by info
#      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | perPage |
#      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] |
#    And Admin check Order summary
#      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        | notification                     |
#      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice | All Express line-items confirmed |
#    And Admin check express invoice in Order summary
#      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     |
#      | No | $0.00         | $60.00       | $2.50        | 1.00 lbs    | [blank] |
#    And Admin check invoice detail in Order summary
#      | brand                       | product                       | sku                   | tmp | delivery  | quantity | endQuantity | warehouse               | fulfillment |
#      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 01 | Dry | Confirmed | 1        | [blank]     | Auto Distribute NewYork | [blank]     |
#    And Admin verify note in order summary
#      | deliveryDay | preferredDay | receivingNote | directReceivingNote | adminNote | buyerNote  |
#      | [blank]     | [blank]      | [blank]       | [blank]             | [blank]   | Buyer Note |
#    And Admin verify delivery detail in Order summary
#      | sku                   | type            | comment                           |
#      | AT SKU A Order Sum 01 | Pod Consignment | Pod Consignment auto-confirmation |
#    # Change warehouse
#    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
#    And Admin search the orders "create by api"
#    And Admin go to order detail number "create by api"
##    And Admin change warehouse of sku "AT SKU A Order Sum 01" in line item to "Auto Distribute NewYork"
#
#    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
#    And Admin search the orders in summary by info
#      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess |edi     | perPage |
#      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   |[blank] | [blank] |
#    And Admin check Order summary
#      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        | notification                     |
#      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice | All Express line-items confirmed |
#    And Admin check express invoice in Order summary
#      | po | totalDelivery | totalPayment | totalService | totalWeight |
#      | No | $0.00         | $60.00       | $2.50        | 1.00 lbs    |
#    And Admin check invoice detail in Order summary
#      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse               | fulfillment |
#      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 01 | Dry | [blank]  | 1        | 19          | Auto Distribute NewYork | [blank]     |
#    And Admin verify note in order summary
#      | deliveryDay | preferredDay | receivingNote | directReceivingNote | adminNote | buyerNote  |
#      | [blank]     | [blank]      | [blank]       | [blank]             | [blank]   | Buyer Note |
#
#    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
#    And Admin search the orders "create by api"
#    And Admin go to order detail number "create by api"
#    And Admin remove pod consignment deliverable of sku "AT SKU A Order Sum 01" in line item
#    And Admin go to Order summary from order detail
#    And Admin check Order summary
#      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder |  fulfillmentDate | dayToFulfill | buyerPayment        | notification                         |
#      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     |  [blank]         | [blank]      | Payment via invoice | 1 Express line-item(s) not confirmed |

  @AdminOrderSummary_16 @AdminOrderSummary
  Scenario: Admin verify non invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1113@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123995             | 59420              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
  # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 16 | 59420              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1113@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 16 | Dry | [blank]  | 1        | [blank]     | Direct    | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_17 @AdminOrderSummary
  Scenario: Admin verify create sub-invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1114@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1114@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | anhJPEG.jpg | [blank]   | [blank] |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_18 @AdminOrderSummary
  Scenario: Admin verify create sub-invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1115@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1115@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin verify error message when create empty purchase order
    When Admin choose LP company only warehouse is "Auto Bao LP Warehousing" then verify No data
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_19 @AdminOrderSummary
  Scenario: Admin create/edit unconfirmed PO for one Express sub-invoice - do not upload POD
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1116@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1116@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin get purchase order "1" of order "create by api" ID in order summary
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Pending           |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_19b @AdminOrderSummary
  Scenario: Admin create/edit unconfirmed PO for one Express sub-invoice - upload POD
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1117@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1117@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | anhJPEG.jpg | adminNote | lpNote |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin get purchase order "1" of order "create by api" ID in order summary
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Fulfilled         |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_20 @AdminOrderSummary
  Scenario: Admin create/edit In-progress PO for one Express sub-invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1118@podfoods.co | 12345678a |

    And Update regions info of SKU "59421"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123971 | 53        | 59421              | 1000             | 1000       | in_stock     | active |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123971             | 59421              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 17 | 59421              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1118@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | In progress      | [blank]         | [blank] | adminNote | lpNote |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin get purchase order "1" of order "create by api" ID in order summary
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress      | [blank]         | adminNote | lpNote |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Pending           |
    And Admin edit purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote  | lpNote  |
      | 1   | Auto Ngoc LP Mix 01 | In progress      | [blank]         | [blank] | adminNote1 | lpNote1 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress      | [blank]         | adminNote1 | lpNote1 |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_21 @AdminOrderSummary
  Scenario: Admin create/edit In-progress PO for one Express sub-invoice - upload POD and note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1119@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1119@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | In progress      | [blank]         | anhJPEG.jpg | adminNote | lpNote |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And NGOC_ADMIN_11 wait 2000 mini seconds
    And Admin get purchase order "1" of order "create by api" ID in order summary
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote | lpNote | proof                   |
      | Auto Ngoc LP Mix 01 | Fulfilled        | [blank]         | adminNote | lpNote | PoD_Auto_Ngoc_LP_Mix_01 |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Fulfilled         | No          |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_22 @AdminOrderSummary
  Scenario: Admin create/edit Fulfilled PO for one Express sub-invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1120@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1120@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | adminNote | lpNote |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin get purchase order "1" of order "create by api" ID in order summary
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | adminNote | lpNote |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Fulfilled         | No          |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_23 @AdminOrderSummary
  Scenario: Admin create/edit Fulfilled PO for one Express sub-invoice - upload POD and note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1121@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1121@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | anhJPEG.jpg | adminNote | lpNote |
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote | lpNote | proof       |
      | Auto Ngoc LP Mix 01 | Fulfilled | Minus1      | adminNote | lpNote | anhJPEG.jpg |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_23b @AdminOrderSummary
  Scenario: Admin create/edit Fulfilled PO for one Express sub-invoice - upload POD and note - state In Progress
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1122@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1122@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress      | Minus1          | anhJPEG.jpg | adminNote | lpNote |
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote | lpNote | proof       |
      | Auto Ngoc LP Mix 01 | Fulfilled | Minus1      | adminNote | lpNote | anhJPEG.jpg |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_23c @AdminOrderSummary
  Scenario: Admin create/edit Fulfilled PO for one Express sub-invoice - upload POD and note - state Fulfilled
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1123@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1123@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Fulfilled        | Minus1          | anhJPEG.jpg | adminNote | lpNote |
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote | lpNote | proof       |
      | Auto Ngoc LP Mix 01 | Fulfilled | Minus1      | adminNote | lpNote | anhJPEG.jpg |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_23d @AdminOrderSummary
  Scenario: Admin verify Fulfilled date PO
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1124@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1124@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin verify fulfilment date of purchase order in order summary
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_24 @AdminOrderSummary
  Scenario: Admin create/edit unconfirmed PO for multi Express sub-invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1125@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1125@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | currentDate     | [blank] | [blank]   | [blank] |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress | currentDate | [blank]   | [blank] |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_25 @AdminOrderSummary
  Scenario: Admin create/edit unconfirmed PO for multi Express sub-invoice - admin lp note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1126@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1126@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | adminNote | lpNote |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_26 @AdminOrderSummary
  Scenario: Admin create/edit in process PO for multi Express sub-invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1127@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1127@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | currentDate     | [blank] | [blank]   | [blank] |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress | currentDate | [blank]   | [blank] |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_27 @AdminOrderSummary
  Scenario: Admin create/edit in process PO for multi Express sub-invoice - admin lp note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1128@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1128@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress      | tomorrow        | [blank] | adminNote | lpNote |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress | tomorrow    | adminNote | lpNote |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_27b @AdminOrderSummary
  Scenario: Admin create/edit in process PO for multi Express sub-invoice - admin lp note - do not select Fulfillment state
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1129@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1129@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | adminNote | lpNote |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | In progress | currentDate | adminNote | lpNote |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_28 @AdminOrderSummary
  Scenario: Admin create/edit fulfilled PO for multi Express sub-invoice
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1130@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1130@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | Minus1          | [blank] | [blank]   | [blank] |
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled | Minus1      | [blank]   | [blank] |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_29 @AdminOrderSummary
  Scenario: Admin create/edit fulfilled PO for multi Express sub-invoice - admin lp note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1131@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1131@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | anhJPEG.jpg | adminNote | lpNote |
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Fulfilled | currentDate | adminNote | lpNote |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_30 @AdminOrderSummary
  Scenario: Admin create/edit fulfilled PO for multi Express sub-invoice - admin lp note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1132@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 01 | 36479              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1132@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | anhJPEG.jpg | adminNote | lpNote |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_31 @AdminOrderSummary
  Scenario: Admin verify line item in order detail - PE Item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1133@podfoods.co | 12345678a |
    And Update regions info of SKU "59422"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123972 | 53        | 59422              | 1000             | 1000       | in_stock     | active |
    # Delete order
    When Search order by sku "59422" by api
    And Admin delete order of sku "59422" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU A Order Sum 18   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 18" from API
    And Admin delete inventory "all" by API
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123972             | 59422              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 18 | 59422              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1133@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 59422 | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Cancel" quantity line item in order detail

    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 18 | 1 units/case | $10.00    | 1        | 9           | $10.00 |
    # Increase quantity of line item
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 59422 | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin revert action in order detail

    And NGOC_ADMIN_11 refresh page admin
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 18 | 1 units/case | $10.00    | 1        | 9           | $10.00 |

     # Increase quantity of line item
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 59422 | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And NGOC_ADMIN_11 refresh page admin
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 18 | 1 units/case | $10.00    | 2        | 8           | $20.00 |
    And Admin verify history change quantity of line item in order detail
      | sub | order         | subID | quantity | reason           | updateBy        | updateOn | note     | showOnVendor |
      | 1   | create by api | 59422 | 1 → 2    | Buyer adjustment | Admin: ngoctx11 | [blank]  | Autotest | Yes          |
     # Degrease quantity of line item
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 59422 | 1        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And NGOC_ADMIN_11 refresh page admin
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 18 | 1 units/case | $10.00    | 1        | 9           | $10.00 |
    And Admin verify history change quantity of line item in order detail
      | sub | order         | subID | quantity | reason           | updateBy        | updateOn | note     | showOnVendor |
      | 1   | create by api | 59422 | 2 → 1    | Buyer adjustment | Admin: ngoctx11 | [blank]  | Autotest | Yes          |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_32 @AdminOrderSummary
  Scenario: Admin verify line item in order detail - PD Item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1134@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 02 | 36739 | create by api buyer | [blank]  | pending       | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 02 | 36739              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1134@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 36739 | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Cancel" quantity line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 02 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
    # Increase quantity of line item
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 36739 | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And NGOC_ADMIN_11 refresh page admin
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 02 | 1 units/case | $10.00    | 2        | [blank]     | $20.00 |
    And Admin verify history change quantity of line item in order detail
      | sub | order         | subID | quantity | reason           | updateBy        | updateOn | note     | showOnVendor |
      | 1   | create by api | 36739 | 1 → 2    | Buyer adjustment | Admin: ngoctx11 | [blank]  | Autotest | Yes          |
     # Degrease quantity of line item
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 36739 | 1        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And NGOC_ADMIN_11 refresh page admin
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 02 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
    And Admin verify history change quantity of line item in order detail
      | sub | order         | subID | quantity | reason           | updateBy        | updateOn | note     | showOnVendor |
      | 1   | create by api | 36739 | 2 → 1    | Buyer adjustment | Admin: ngoctx11 | [blank]  | Autotest | Yes          |
    And Admin go to Order summary from order detail
    And Admin go to add line item in order summary
    And Admin remove line item in order detail in order summary
      | sku                   | reason           | note     | deduction | showEdit |
      | AT SKU A Order Sum 02 | Buyer adjustment | Autotest | No        | yes      |
    And Admin save action then verify message error "Line items must have at least 1 item"
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_33 @AdminOrderSummary
  Scenario: Admin verify line item in order detail - PE Item - Check on checkbox "Also create inventory deductions" - 1 lot code
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1135@podfoods.co | 12345678a |
    And Update regions info of SKU "59423"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123973 | 53        | 59423              | 1000             | 1000       | in_stock     | active |
    # Delete order
    When Search order by sku "59423" by api
    And Admin delete order of sku "59423" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 19   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 19" from API
    And Admin delete inventory "all" by API
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123973             | 59423              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 19 | 59423              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1135@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 59423 | 1        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 19 | 1 units/case | $10.00    | 1        | 8           | $10.00 |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_34 @AdminOrderSummary
  Scenario: Admin verify line item in order detail - PE Item - Uncheck on checkbox "Also create inventory deductions" - 1 lot code
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1136@podfoods.co | 12345678a |
    And Update regions info of SKU "59424"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123974 | 53        | 59424              | 1000             | 1000       | in_stock     | active |
     # Delete order
    When Search order by sku "59424" by api
    And Admin delete order of sku "59424" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 20   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 20" from API
    And Admin delete inventory "all" by API
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123974             | 59424              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 20 | 59424              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1136@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 59424 | 1        | Buyer adjustment | Autotest | Change | No        | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 20 | 1 units/case | $10.00    | 1        | 9           | $10.00 |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_35 @AdminOrderSummary
  Scenario: Admin verify line item in order detail - PE Item - Check on checkbox "Also create inventory deductions" - 2 lot code
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1137@podfoods.co | 12345678a |
    # Active SKU
    And Update regions info of SKU "59444"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123994 | 53        | 59444              | 1000             | 1000       | in_stock     | active |
     # Delete order
    When Search order by sku "59444" by api
    And Admin delete order of sku "59444" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 29   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 29" from API
    And Admin delete inventory "all" by API
      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123994             | 59444              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 29 | 59444              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | AT SKU A Order Sum 29 | 59444              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1137@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin edit line item in order detail
      | sub | order         | subID | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | 59444 | 1        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 29 | 1 units/case | $10.00    | 1        | 18          | $10.00 |

    And NGOC_ADMIN_11 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName               | productName                   | vendorCompany | vendorBrand | region           | distribution            | createdBy | lotCode | pulled  |
      | AT SKU A Order Sum 29 | AT Product A Order Summary 01 | [blank]       | [blank]     | New York Express | Auto Distribute NewYork | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                   | skuName               | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter      | vendorCompany         | region | createdBy |
      | 1     | AT Product A Order Summary 01 | AT SKU A Order Sum 29 | randomIndex | 10               | 9               | 8        | 0            | [blank]    | [blank]  | [blank]          | Plus1       | Auto Distribute NewYork | AT Product A Order 01 | NY     | Admin     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_36 @AdminOrderSummary
  Scenario: Admin delete line item in order detail - PE Item - Check on checkbox "Also create inventory deductions" - 1 lot code
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1138@podfoods.co | 12345678a |
    # Active sku
    And Update regions info of SKU "59425"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123975 | 53        | 59425              | 1000             | 1000       | in_stock     | active |
    And Update regions info of SKU "59426"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123976 | 53        | 59426              | 1000             | 1000       | in_stock     | active |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 21   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 21" from API
    And Admin delete inventory "all" by API
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123975             | 59425              | 2        | false     | [blank]          |
      | 123976             | 59426              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 21 | 59425              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1138@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin go to add line item in order summary
    And Admin remove line item in order detail in order summary
      | sku                   | reason           | note     | deduction | showEdit |
      | AT SKU A Order Sum 21 | Buyer adjustment | Autotest | No        | yes      |
    And Admin save action in order detail

    And NGOC_ADMIN_11 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName               | productName                   | vendorCompany | vendorBrand | region           | distribution            | createdBy | lotCode | pulled  |
      | AT SKU A Order Sum 21 | AT Product A Order Summary 01 | [blank]       | [blank]     | New York Express | Auto Distribute NewYork | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName                   | skuName               | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter      | vendorCompany         | region | createdBy |
      | 1     | AT Product A Order Summary 01 | AT SKU A Order Sum 21 | randomIndex | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | Plus1       | Auto Distribute NewYork | AT Product A Order 01 | NY     | Admin     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_37 @AdminOrderSummary
  Scenario: Admin delete line item in order detail - PE Item - Check on checkbox "Also create inventory deductions" - 2 lot code
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1139@podfoods.co | 12345678a |

    And Update regions info of SKU "59427"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123977 | 53        | 59427              | 1000             | 1000       | in_stock     | active |
    And Update regions info of SKU "59428"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123978 | 53        | 59428              | 1000             | 1000       | in_stock     | active |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 23   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 23" from API
    And Admin delete inventory "all" by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 24   | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 24" from API
    And Admin delete inventory "all" by API
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123977             | 59427              | 2        | false     | [blank]          |
      | 123978             | 59428              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 23 | 59427              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 2     | AT SKU A Order Sum 23 | 59427              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 24 | 59428              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1139@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete line item in "sub invoice"
      | index | skuName               | reason  | note    | deduction |
      | 1     | AT SKU A Order Sum 23 | [blank] | [blank] | Yes       |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin delete line item success in order detail
    And Admin save action in order detail
    And Admin check line items "sub invoice" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 24 | 1 units/case | $10.00    | 2        | [blank]     | $20.00 | 59428 |
    And Admin check line items "deleted or shorted items" in order details
      | brand                       | product                       | sku                   | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 23 | 1 units/case | $10.00    | 2        | [blank]     | $20.00 | 59427 |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_38 @AdminOrderSummary
  Scenario: Admin delete sub invoice Line item Express have Quantity < or = End quantity of inventory (all lot code of 1 warehouse)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1140@podfoods.co | 12345678a |

    And Update regions info of SKU "59430"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123980 | 53        | 59430              | 1000             | 1000       | in_stock     | active |
      # Delete order
    When Search order by sku "59430" by api
    And Admin delete order of sku "59430" by api
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123980             | 59430              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 25 | 59430              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1140@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | markFulfill |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Yes         |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery  | quantity | endQuantity | warehouse               | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 25 | Dry | Confirmed | 1        | 9           | Auto Distribute NewYork | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_39 @AdminOrderSummary
  Scenario: Admin delete sub invoice Line item Express have Quantity > End quantity of inventory (all lot code of 1 warehouse)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1141@podfoods.co | 12345678a |
    When Search order by sku "59435" by api
    And Admin delete order of sku "59435" by api
       # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 26   | AT Product A Order Summary 01 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 26" from API
    And Admin delete inventory "all" by API
    And Update regions info of SKU "59435"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123985 | 53        | 59435              | 1000             | 1000       | in_stock     | active |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 26 | 59435              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123985             | 59435              | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |


    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1141@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     |
      | No | $0.00         | $80.00       | $12.50       | 5.00 lbs    | [blank] |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery  | quantity | endQuantity | warehouse               | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 26 | Dry | Confirmed | 5        | [blank]     | Auto Distribute NewYork | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_40 @AdminOrderSummary
  Scenario: Admin delete sub invoice Line item Express doesn't have inventory - verify slip note
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1142@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1142@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | [blank] |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse               | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 03 | Dry | [blank]  | 1        | [blank]     | Auto Distribute NewYork | [blank]     |
#    And Admin verify no warehouse of delivery in order summary
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_41 @AdminOrderSummary
  Scenario: Admin verify fulfillment - By fulfill line item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1143@podfoods.co | 12345678a |
    And Update regions info of SKU "36778"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 94721 | 53        | 36778              | 1000             | 1000       | in_stock     | active |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1143@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin expand order summary
    And Admin fulfill all line item of order in order summary
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | currentDate     | day(s)       | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     | fulfillmentStatus | markFulfill |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | [blank] | Fulfilled         | No          |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 03 | Dry | [blank]  | 1        | [blank]     | [blank]   | currentDate |
    And Admin verify fulfillment date can not edit
    And Admin remove fulfillment of line item order "create by api" in order summary
      | sub | sku                   |
      | 1   | AT SKU A Order Sum 03 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     | fulfillmentStatus |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | [blank] | Pending           |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 03 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And Admin fulfill line item of order "create by api" in order summary
      | sub | sku                   |
      | 1   | AT SKU A Order Sum 03 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | eta     | fulfillmentStatus |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | [blank] | Fulfilled         |
    And Admin check invoice detail of order "create by api" in Order summary
      | sub | brand                       | product                       | sku                   | tmp | delivery  | quantity | endQuantity | warehouse | fulfillment | fulfilledCheck |
      | 1   | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 03 | Dry | Confirmed | 1        | [blank]     | [blank]   | currentDate | Yes            |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_42 @AdminOrderSummary
  Scenario: Admin verify add item in stock
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1144@podfoods.co | 12345678a |
    When Search order by sku "59437" by api
    And Admin delete order of sku "59437" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 27   | AT Product A Order Summary 01 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 27" from API
    And Admin delete inventory "all" by API
    # active sku
    And Update regions info of SKU "59437"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 123987 | 53        | 59437              | 1000             | 1000       | in_stock     | active |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 27 | 59437              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123987             | 59437              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1144@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin go to add line item in order summary
    And Admin add line item is "AT SKU A Order Sum 05"
    # increase quantity with show edit history - positive integer
    And Admin edit line item in order summary
      | sku                   | quantity | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order summary
    And Admin save action in order detail
     # increase quantity with show edit history - positive decimal
    And Admin edit line item in order summary
      | sku                   | quantity | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 2.2      | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order summary
    And Admin save action in order detail
      # increase quantity with show edit history error
    And Admin edit line item in order summary
      | sku                   | quantity      | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 1000000000000 | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order summary
    And Admin save action then verify message error "is out of range for ActiveModel::Type::Integer with limit 4 bytes"
     # revert increase quantity with don't show edit history
    And Admin edit line item in order summary
      | sku                   | quantity | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 4        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order summary
    And Admin revert action in order detail
      # increase quantity with don't show edit history
    And Admin edit line item in order summary
      | sku                   | quantity | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 3        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order summary
    And Admin save action in order detail
    # decrease quantity with show edit history
    And Admin edit line item in order summary
      | sku                   | quantity | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 2        | Buyer adjustment | Autotest | Change | Yes       | Yes      |
    And Admin create subtraction items in order detail
      | quantity | category          | subCategory | comment  |
      | [blank]  | Pull date reached | Donated     | Autotest |
    And Admin "Change" quantity line item in order summary
    And Admin save action in order detail
    # revert decrease quantity with don't show edit history
    And Admin edit line item in order summary
      | sku                   | quantity | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 3        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order summary
    And Admin revert action in order detail
       # increase quantity with don't show edit history
    And Admin edit line item in order summary
      | sku                   | quantity | reason           | note     | action | deduction | showEdit |
      | AT SKU A Order Sum 27 | 1        | Buyer adjustment | Autotest | Change | [blank]   | No       |
    And Admin "Change" quantity line item in order summary
    And Admin save action in order detail
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin check line item non invoice in Order summary
      | brand                       | product                       | sku                   | tmp | delivery  | quantity | endQuantity | warehouse               |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 05 | Dry | Confirmed | 1        | [blank]     | Auto Distribute NewYork |
    And Admin go to add line item in order summary
    And Admin verify can not add line item "AT SKU A Order Sum 06" to order summary
    And NGOC_ADMIN_11 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName               | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU A Order Sum 27 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName                   | skuName               | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter      | vendorCompany         | region | createdBy |
      | 1     | AT Product A Order Summary 01 | AT SKU A Order Sum 27 | randomIndex | 10               | 9               | 8        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Distribute NewYork | AT Product A Order 01 | NY     | Admin     |
    And NGOC_ADMIN_11 quit browser

    # Verify edit history
    Given VENDOR open web user
    When login to beta web with email "ngoctx+atproductaorder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx staordersum01 | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                | payment | fullfillment | total  |
      | currentDate | create by api | ngoctx staordersum01 | Pending | Pending      | $15.00 |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                   | productName                   | skuName               | casePrice | quantity | total  |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 27 | $10.00    | 1        | $10.00 |
    And Vendor verify change quantity history in order detail
      | quantity | reason           | editDate    |
      | 2 → 1    | Buyer adjustment | currentDate |
      | 3 → 2    | Buyer adjustment | currentDate |
      | 2 → 3    | Buyer adjustment | currentDate |
      | 1 → 2    | Buyer adjustment | currentDate |
    And VENDOR quit browser

  @AdminOrderSummary_44 @AdminOrderSummary
  Scenario: Admin verify fulfillment status with click mark as fulfilled
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1146@podfoods.co | 12345678a |
    When Search order by sku "36778" by api
    And Admin delete order of sku "36778" by api
       # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]               | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order Sum 03   | AT Product A Order Summary 01 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order Sum 03" from API
    And Admin delete inventory "all" by API
    And Update regions info of SKU "36778"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 94721 | 53        | 36778              | 1000             | 1000       | in_stock     | active |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1146@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin fulfill by mark as fulfilled in order summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | markFulfill |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | No          |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery  | quantity | endQuantity | warehouse               | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 03 | Dry | Confirmed | 1        | [blank]     | Auto Distribute NewYork | currentDate |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_43 @AdminOrderSummary
  Scenario: Admin verify awaiting POD filter search
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1145@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1145@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_11 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | Minus1          | [blank] | adminNote | lpNote |
    And Admin go to Order summary from order detail

    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment  | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | Awaiting POD | Pending      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | eta     | fulfillmentStatus | markFulfill |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | [blank] | Awaiting POD      | Yes         |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_45 @AdminOrderSummary
  Scenario: PE item fulfillment status > Other cases (merge sub 2 to sub 1)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1147@podfoods.co | 12345678a |
    When Search order by sku "36739" by api
    And Admin delete order of sku "36739" by api
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 36778 | create by api buyer | [blank]  | pending       | 2      |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1147@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin get purchase order "1" of order "create by api" ID in order summary
    And Admin expand order summary
    And Admin create "add to" sub-invoice with Suffix ="2" in order summary
      | skuName               |
      | AT SKU A Order Sum 03 |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus |
      | Yes | $0.00         | $50.00       | $5.00        | 2.00 lbs    | Pending           |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_47 @AdminOrderSummary
  Scenario: PE item fulfillment status > Other cases (select line item 1 and create new sub 2)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1149@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1149@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin fulfill line item of order "create by api" in order summary
      | sub | sku                   |
      | 1   | AT SKU A Order Sum 03 |
    And NGOC_ADMIN_11 wait 2000 mini seconds
    And Admin create "create" sub-invoice with Suffix ="2" in order summary
      | skuName               |
      | AT SKU A Order Sum 01 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | No | $0.00         | $20.00       | $5.00        | 1.00 lbs    | Pending           | Yes         |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Fulfilled         | No          |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_50 @AdminOrderSummary
  Scenario: Admin verify fulfillment - By fulfill line item - PD item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1152@podfoods.co | 12345678a |
      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 96305              | 37906              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1152@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin create "create" sub-invoice with Suffix ="1" in order summary
      | skuName               |
      | AT SKU A Order Sum 04 |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 04 | Dry | [blank]  | 1        | [blank]     | Direct    | [blank]     |
    And Admin check express invoice in Order summary
      | po | fulfillmentStatus | markFulfill |
      | No | Pending           | Yes         |
    And Admin fulfill all line item of order in order summary
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | currentDate     | 0 day(s)     | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | fulfillmentStatus | markFulfill |
      | No | Fulfilled         | No          |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 04 | Dry | [blank]  | 1        | [blank]     | Direct    | currentDate |
    And Admin verify fulfillment date can not edit
    And Admin remove fulfillment of line item order "create by api" in order summary
      | sub | sku                   |
      | 1   | AT SKU A Order Sum 04 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check express invoice in Order summary
      | po | fulfillmentStatus | markFulfill |
      | No | Pending           | Yes         |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 04 | Dry | [blank]  | 1        | [blank]     | Direct    | [blank]     |
    And Admin fulfill line item of order "create by api" in order summary
      | sub | sku                   |
      | 1   | AT SKU A Order Sum 04 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check express invoice in Order summary
      | po | fulfillmentStatus | markFulfill |
      | No | Fulfilled         | No          |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 04 | Dry | [blank]  | 1        | [blank]     | Direct    | currentDate |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_48 @AdminOrderSummary
  Scenario: PE item fulfillment status > Other cases (select line item 2 and create new sub 2)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1150@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1150@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin fulfill line item of order "create by api" in order summary
      | sub | sku                   |
      | 1   | AT SKU A Order Sum 03 |
    And Admin create "create" sub-invoice with Suffix ="2" in order summary
      | skuName               |
      | AT SKU A Order Sum 03 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | No | $0.00         | $20.00       | $5.00        | 1.00 lbs    | Fulfilled         | No          |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Pending           | Yes         |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_51 @AdminOrderSummary
  Scenario: Admin verify fulfillment status with click mark as fulfilled - PD item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1153@podfoods.co | 12345678a |
    When Search order by sku "37906" by api
    And Admin delete order of sku "37906" by api
      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 96305              | 37906              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 04 | 37906 | create by api | [blank]  | pending       | 1      |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1153@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin fulfill by mark as fulfilled in order summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | fulfillmentStatus | markFulfill |
      | No | Fulfilled         | No          |
    And Admin check invoice detail of order "create by api" in Order summary
      | sub | brand                       | product                       | sku                   | tmp | delivery | quantity | warehouse | fulfillment | fulfilledCheck |
      | 1   | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 04 | Dry | [blank]  | 1        | Direct    | currentDate | Yes            |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_99 @AdminOrderSummary
  Scenario: Delivery method (SHIP DIRECT TO STORE stamp)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1154@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 02 | 36739 | create by api buyer | [blank]  | pending       | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 2        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1154@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Amin set deliverable for order "create by api"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | create by api | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |
    And Admin go to Order summary from order detail
    # Verify summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      |
    And Admin verify popup delivery stamp in order summary
      | type                  | deliveryDate | carrier | trackingNumber | comment   |
      | Ship direct to stores | currentDate  | USPS    | 123456789      | Auto test |
    # Delete deliverable
    And Admin delete delivery stamp "Ship direct to stores" in order summary
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_100 @AdminOrderSummary
  Scenario: Delivery method (SELF DELIVER TO STORE stamp)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1155@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 02 | 36739 | create by api buyer | [blank]  | pending       | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 2        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1155@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Amin set deliverable for order "create by api"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof       |
      | create by api | Self deliver to store | currentDate  | [blank] | [blank]        | 00:30            | 01:00          | Auto test | anhJPEG.jpg |
    And Admin go to Order summary from order detail
    # Verify summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      |
    And Admin verify popup delivery stamp in order summary
      | type                  | deliveryDate | eta                 | comment   | proof       |
      | Self deliver to store | currentDate  | 12:30 am - 01:00 am | Auto test | anhJPEG.jpg |
   # Delete deliverable
    And Admin delete delivery stamp "Self deliver to store" in order summary
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_101 @AdminOrderSummary
  Scenario: Delivery method (SHIPPO) Unknown stamp {USPS tracking number}
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1156@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 2        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atproductaorder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region           | store                | paymentStatus | orderType | checkoutDate |
      | New York Express | ngoctx staordersum01 | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku                   | date  |
      | AT SKU A Order Sum 02 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store                | address                                        |
      | Ship Direct to Store | ngoctx staordersum01 | 281 Columbus Avenue, New York, New York, 10001 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1            | city     | zipcode | state    | country | email                |
      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | name | company | 281 Columbus Avenue | New York | 10001   | New York | US      | ngoctx11@podfoods.co |
    And Vendor select shippo and then confirm
    And Click on button "Buy"

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1156@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      |
    And Admin verify popup shippo stamp in order summary
      | name | number  | addressTo                                 | addressFrom                               |
      | USPS | [blank] | 281 COLUMBUS AVE, NEW YORK, NY, US, 10023 | 281 COLUMBUS AVE, NEW YORK, NY, US, 10023 |
    And Admin expand order summary
    And Admin fulfill all line item of order in order summary
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill | buyerPayment        |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | currentDate     | 0 day(s)     | Payment via invoice |
    And Admin check express invoice in Order summary
      | po | fulfillmentStatus | markFulfill |
      | No | Fulfilled         | No          |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 02 | Dry | [blank]  | 1        | [blank]     | Direct    | currentDate |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_102 @AdminOrderSummary
  Scenario: Admin moved Direct line item in sub-invoice from A to B
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1157@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order Sum 02 | 36739 | create by api buyer | [blank]  | pending       | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 2        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1157@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Amin set deliverable for order "create by api"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | create by api | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName               |
      | AT SKU A Order Sum 02 |
    And Admin go to Order summary from order detail
    And Admin expand order summary
    # Verify summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 02 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_46 @AdminOrderSummary
  Scenario: PE item fFulfillment status > Other cases (merge sub 1 to sub 2)
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1148@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 36778 | create by api buyer | [blank]  | pending       | 2      |
   # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1148@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin get purchase order "1" of order "create by api" ID in order summary
    And Admin expand order summary
    And Admin create "add to" sub-invoice with Suffix ="1" in order summary
      | skuName               |
      | AT SKU A Order Sum 01 |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus |
      | No | $0.00         | $20.00       | $5.00        | 2.00 lbs    | Pending           |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_103 @AdminOrderSummary
  Scenario: Admin moved Direct line item in sub-invoice from A,B to B
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1158@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
      | 96305              | 37906              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 02 | 36739 | create by api buyer | [blank]  | pending       | 1      |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 04 | 37906 | create by api buyer | [blank]  | pending       | 2      |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1158@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Amin set deliverable for order "create by api"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | create by api | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |
    And Admin create "create" sub-invoice with Suffix ="3"
      | skuName               |
      | AT SKU A Order Sum 02 |
      | AT SKU A Order Sum 04 |
    And Admin go to Order summary from order detail
    And Admin expand order summary
    # Verify summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 02 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 04 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_49 @AdminOrderSummary
  Scenario: PE item fulfillment status > Other cases (select line item 2 and create new sub 2) 2 item unfulfilled
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1151@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94376              | 36479              | 1        | false     | [blank]          |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36739              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1151@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin create "create" sub-invoice with Suffix ="2" in order summary
      | skuName               |
      | AT SKU A Order Sum 03 |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin check express invoice in Order summary
      | po | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | No | $0.00         | $10.00       | $2.50        | 1.00 lbs    | Pending           | Yes         |
      | No | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Pending           | Yes         |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_104 @AdminOrderSummary
  Scenario: Admin moved Direct line item in sub-invoice item 1 from A to B
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1159@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
      | 96305              | 37906              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 02 | 36739 | create by api buyer | [blank]  | pending       | 1      |
      | AT SKU A Order Sum 04 | 37906 | create by api buyer | [blank]  | pending       | 1      |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1159@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Amin set deliverable for order "create by api"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | create by api | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName               |
      | AT SKU A Order Sum 04 |
    And Admin go to Order summary from order detail
    And Admin expand order summary
    # Verify summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                  | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 0 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 0 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_105 @AdminOrderSummary
  Scenario: Admin moved Direct line item in sub-invoice item 1 from A to B
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1160@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94682              | 36739              | 1        | false     | [blank]          |
      | 96305              | 37906              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 02 | 36739 | create by api buyer | [blank]  | pending       | 1      |
    And Admin set Invoice by API
      | skuName               | skuId | order_id            | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 04 | 37906 | create by api buyer | [blank]  | pending       | 2      |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1160@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Amin set deliverable for order "sub1"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof       |
      | create by api | Self deliver to store | currentDate  | [blank] | [blank]        | 00:30            | 01:00          | Auto test | anhJPEG.jpg |
    And Amin set deliverable for order "sub2"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | create by api | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |

    And Admin create "add to" sub-invoice with Suffix ="2"
      | skuName               |
      | AT SKU A Order Sum 02 |
    And Admin go to Order summary from order detail
    And Admin expand order summary
    # Verify summary
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | [blank]    | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | po | sub | eta         |
      | No | 2   | currentDate |
    And Admin check invoice detail in Order summary
      | brand                       | product                       | sku                   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 02 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
      | AT Brand A Order Summary 01 | AT Product A Order Summary 01 | AT SKU A Order Sum 04 | Dry | [blank]  | 1        | [blank]     | [blank]   | [blank]     |
    And NGOC_ADMIN_11 quit browser

  @AdminOrderSummary_192 @AdminOrderSummary
  Scenario: Admin verify purchase order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1161@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 94721              | 36778              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3403     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order Sum 03 | 36778              | 1        | random   | 91           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx1161@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    # Create purchase order
    And Admin create purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | [blank]   | [blank] |
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | remove      | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin get purchase order "1" of order "create by api" ID in order summary
    # Verify
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank]   | [blank] |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Pending           | Yes         |
    # Edit purchase order
    And Admin edit purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 03 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    # Verify
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote | lpNote |
      | Auto Ngoc LP Mix 03 | Unconfirmed      | [blank]         | adminNote | lpNote |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Pending           | Yes         |
      # Edit purchase order unconfirmed to in progress
    And Admin edit purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 03 | In progress      | [blank]         | [blank] | adminNote | lpNote |
    # Verify
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote | lpNote |
      | Auto Ngoc LP Mix 03 | In progress      | [blank]         | adminNote | lpNote |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Pending           | Yes         |
      # Edit purchase order in progress to fulfilled
    And Admin edit purchase order "create by api" in order summary
      | sub | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 03 | In progress      | currentDate     | anhJPEG.jpg | adminNote | lpNote |
    # Verify
    And Admin check Order summary
      | region | date        | store                | buyer                    | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | ngoctx staordersum01 | ngoctx staordersum01ny01 | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin verify popup purchase order in order summary
      | driver              | fulfillmentState | fulfillmentDate | adminNote | lpNote | proof                   |
      | Auto Ngoc LP Mix 03 | Fulfilled        | currentDate     | adminNote | lpNote | PoD_Auto_Ngoc_LP_Mix_03 |
    And Admin check express invoice in Order summary
      | po  | totalDelivery | totalPayment | totalService | totalWeight | fulfillmentStatus | markFulfill |
      | Yes | $0.00         | $40.00       | $2.50        | 1.00 lbs    | Fulfilled         | No          |
    And NGOC_ADMIN_11 quit browser


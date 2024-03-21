@feature=VendorStatement
Feature: VendorStatement

  @VendorStatement_01 @VendorStatement
  Scenario: Check when creating a vendor statement successfully with new company that created on current month
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1600@podfoods.co | 12345678a |
     # Delete vendor company
    And Admin search vendor company by API
      | q[name]              |
      | ngoctx vcstatement01 |
    And Admin delete vendor company by API
    # Create vendor company
    And Admin set region mov for vendor company API
      | region_id | mov_cents |
      | 58        | 0         |
      | 55        | 0         |
#      | 60        | 0         |
#      | 59        | 0         |
      | 54        | 0         |
    And Admin create vendor company by API
      | name                 | contact_number | show_all_tabs | email                            | limit_type | street1             | street2 | city     | address_state_id | zip   | country_name  |
      | ngoctx vcstatement01 | 1234567890     | true          | ngoctx+vcstatement01@podfoods.co | mov        | 281 Columbus Avenue | street2 | New York | 33               | 10023 | United States |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1600@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement01 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement01 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement01"
    Then Admin verify general information vendor statement
      | vendorCompany        | statementMonth | paymentState |
      | ngoctx vcstatement01 | currentDate    | [blank]      |
    And NGOC_ADMIN_16 quit browser
  # Đang bug không upload được file
  @VendorStatement_02 @VendorStatement
  Scenario: Check when admin deletes a vendor company that has any order successfully
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1601@podfoods.co | 12345678a |
     # Delete order
    When Search order by sku "39195" by api
    And Admin delete order of sku "39195" by api
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98256              | 39195              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1601@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | ngoctx vcstatement02 | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name                 | region    | email   | ein     | website | managedBy | launchBy |
      | ngoctx vcstatement02 | 2 regions | [blank] | [blank] | [blank] | [blank]   | [blank]  |
    And Admin delete vendor company "ngoctx vcstatement02" in result search and see message

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    # Search by payment status
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | Unpaid        | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
     # Search by email
    And Admin search vendor statements
      | paymentStatus | email                            | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | ngoctx+vcstatement02@podfoods.co | [blank]       | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
#       # Search by ACH
#    And Admin search vendor statements
#      | paymentStatus | email                            | vendorCompany | ach | statementMonth | prePayment |
#      | [blank]       | ngoctx+vcstatement02@podfoods.co | [blank]       | No  | currentDate    | [blank]    |
#    Then Admin no found order in result
#    And Admin search vendor statements
#      | paymentStatus | email                            | vendorCompany | ach | statementMonth | prePayment |
#      | [blank]       | ngoctx+vcstatement02@podfoods.co | [blank]       | Yes | currentDate    | [blank]    |
#    Then Admin verify result vendor statements
#      | vendorCompany        | month       | status | beginningBalance | endingBalance |
#      | ngoctx vcstatement02 | currentDate | Unpaid | [blank]          | [blank]       |
        # Search by statement month
    And Admin search vendor statements
      | paymentStatus | email                            | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | ngoctx+vcstatement02@podfoods.co | [blank]       | [blank] | 01/2024        | [blank]    |
    Then Admin no found order in result
    And Admin search vendor statements
      | paymentStatus | email                            | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | ngoctx+vcstatement02@podfoods.co | [blank]       | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    # Search by prepayment
    And Admin search vendor statements
      | paymentStatus | email                            | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | ngoctx+vcstatement02@podfoods.co | [blank]       | [blank] | [blank]        | Yes        |
    Then Admin no found order in result
    And Admin search vendor statements
      | paymentStatus | email                            | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | ngoctx+vcstatement02@podfoods.co | [blank]       | [blank] | currentDate    | No         |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
  # Search by all criteria
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany           | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | AT Vendor Adjustment 01 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany           | month       | status  | beginningBalance | endingBalance |
      | AT Vendor Adjustment 01 | currentDate | [blank] | [blank]          | [blank]       |

    And Admin upload file "uploadAdjustment.csv" in Upload Adjustments in vendor statement
    Then Admin verify upload adjustment csv popup
      | month   | vendorCompany           | adjustmentType  | effectiveDate | description                                    | amount  | error                                        |
      | 09/2023 | AT Vendor Adjustment 01 | Financial test1 | 09/25/23      | 1 - Upload Valid                               | $10.00  | [blank]                                      |
      | 09/2023 | AT Vendor Adjustment 01 | [blank]         | 09/25/23      | 2 - Adjustment not found                       | $20.00  | Adjustment config adjustment type must exist |
      | 09/2023 | [blank]                 | Financial test1 | 09/25/23      | 3 - No VC exist                                | -$30.00 | Vendor company ID cannot be empty            |
      | 09/2023 | [blank]                 | [blank]         | 09/25/23      | 4 - vendor company locked                      | $40.00  | [blank]                                      |
      | 09/2023 | [blank]                 | Warehouse Fee   | 09/25/23      | 5 - VC blank                                   | $50.00  | Vendor company ID cannot be empty            |
      | 09/2023 | [blank]                 | Financial test1 | 09/25/23      | 6 - Discount for Prepayment: 2% - Amount empty | $0.00   | Please enter a non-zero amount               |
      | 09/2023 | AT Vendor Adjustment 01 | Financial test1 | 09/25/23      | 7 - Other - Amount = 0                         | $0.00   | Please enter a non-zero amount               |
      | 09/2023 | [blank]                 | Financial test1 | 09/25/23      | 8 - Financial Adjustment Type test 1           | -$80.00 | [blank]                                      |
      | 1-Sep   | [blank]                 | [blank]         | 09/25/23      | 9 - Format date invald - Credit to store       | $90.00  | Month is invalid                             |
      | 09/2023 | AT Vendor Adjustment 01 | Financial test1 | 09/25/23      | 10 - Financial Adjustment Type test 2          | $100.99 | [blank]                                      |
      | 09/2023 | [blank]                 | [blank]         | 09/25/23      | 11 - VC not found - Adj not found              | $110.00 | Vendor statement must exist                  |
      | 09/2023 | AT Vendor Adjustment 01 | [blank]         | 09/25/23      | 13 - Adj blank                                 | $130.00 | Adjustment type cannot be empty              |
      | 09/2023 | AT Vendor Adjustment 01 | Financial test1 | 09/25/23      | [blank]                                        | $140.00 | Description cannot be empty                  |
      | 09/2023 | AT Vendor Adjustment 01 | Financial test1 | [blank]       | 16 - Effective Date blank                      | $160.00 | Effective date is invalid                    |
    And Admin confirm to upload adjustment csv success
    And Admin go to detail of vendor statement "AT Vendor Adjustment 01"
    And Admin verify adjustment in vendor statement detail
      | date     | type            | description | amount  |
      | 02/01/23 | Financial test1 | Autotest    | $110.00 |
    And Admin refresh page by button
    And Admin verify adjustment in vendor statement detail
      | date     | type            | description | amount  |
      | 02/01/23 | Financial test1 | Autotest    | $110.00 |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_03 @VendorStatement
  Scenario: Check vendor statement detail
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1602@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1602@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_04 @VendorStatement
  Scenario: Check display of an order which has multiple vendor company on the statement
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1603@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 02 | 39194              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
      | 98255              | 39194              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1603@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |

    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1603@podfoods.co | 12345678a |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName         | skuId | order_id      | fulfilled |
      | 2     | AT SKU Claim 02 | 39194 | create by api | true      |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany   | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | AT Vendor Order | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany   | month       | status  | beginningBalance | endingBalance |
      | AT Vendor Order | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "AT Vendor Order"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser
  # không cho fulfillment date là ngày tương lai
  @VendorStatement_05 @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - Admin create PO for PE sub-invoice with fulfillement date is FUTURE DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1604@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled | fulfillmentDate |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      | Plus1           |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1604@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | Plus1     | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser
# không cho fulfillment date là ngày tương lai
  @VendorStatement_05a @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - Admin create PO for PD sub-invoice with fulfillment date is FUTURE DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1605@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 39231 | create by api | [blank]  | pending       | 1      |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled | fulfillmentDate |
      | 1     | AT SKU Vendor Statement 02 | 39231 | create by api | true      | currentDate     |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1605@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | Pod Direct  | ngoctx stvendorstatement1ny01 | $10.00     | ($1.00)    | $9.00      |
    And NGOC_ADMIN_16 quit browser
  #không cho fulfillment date là ngày tương lai
  @VendorStatement_06 @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - LP confirm PO with fulfillment date is FUTURE DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1606@podfoods.co | 12345678a |
       # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1606@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_16 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | [blank]   | [blank] |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_07 @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - Admin fulfill in order summary fulfillment date is FUTURE DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1607@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1607@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin fulfill by mark as fulfilled in order summary

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_08 @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - Admin create PO for PE sub-invoice with fulfillment date is CURRENT DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1608@podfoods.co | 12345678a |
       # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled | fulfillmentDate |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      | currentDate     |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1608@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_08a @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - Admin create PO for PD sub-invoice with fulfillment date is CURRENT DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1609@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 39231 | create by api | [blank]  | pending       | 1      |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled | fulfillmentDate |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      | currentDate     |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1609@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | Pod Direct  | ngoctx stvendorstatement1ny01 | $10.00     | ($1.00)    | $9.00      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_09 @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - LP confirm PO with fulfillment date is CURRENT DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1610@podfoods.co | 12345678a |
       # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1610@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_16 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | [blank]   | [blank] |
#
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_10 @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - Admin fulfill in order summary fulfillment date is FUTURE DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1611@podfoods.co | 12345678a |
       # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1611@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "Order summary" by sidebar
    And Admin search the orders in summary by info
      | orderNumber   | orderSpecific | store   | buyer   | vendorCompany | brand   | sku     | upc     | buyerCompany | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | edi     | perPage |
      | create by api | [blank]       | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]      | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank] | [blank] |
    And Admin expand order summary
    And Admin fulfill by mark as fulfilled in order summary

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_11 @VendorStatement
  Scenario: Check the order is automatically shown on the statement successfully - LP confirm PO with fulfillment date is < CURRENT DATE
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1612@podfoods.co | 12345678a |
       # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1612@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_16 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | Minus1          | [blank] | [blank]   | [blank] |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | Minus1    | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |

    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | clear           | [blank] | adminNote | lpNote |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order "create by api" no found in vendor statement
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_13 @VendorStatement
  Scenario Outline: Check display of a order after LP confirm a PO on LP dashboard - PO fulfill = CURRENT DATE or < CURRENT DATE
    Given NGOCTX16 login web admin by api
      | email   | password  |
      | <admin> | 12345678a |
   # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    # Fulfillment date = currentDate
    And LP confirm order unconfirmed then verify status is "In progress"
    And LP set fulfillment order from admin with date "<date>"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "<admin>" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | <date>    | [blank]     | ngoctx stvendorstatement1ny01 | $10.00     | ($2.50)    | $7.50      |
    And NGOC_ADMIN_16 quit browser
    And USER_LP quit browser

    Examples:
      | date        | admin                  |
      | currentDate | ngoctx1614@podfoods.co |
      | Minus1      | ngoctx1628@podfoods.co |

  @VendorStatement_14 @VendorStatement
  Scenario: Check display of an order with only OOS/CS items on the statement
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1615@podfoods.co | 12345678a |
     # Change availability field
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason   |
      | 127923 | 53        | 61740              | 1000             | 1000       | sold_out     | active | pending_replenishment |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 05 | 61740              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 127923             | 61740              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1615@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order "create by api" no found in vendor statement
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_12 @VendorStatement
  Scenario: Check display of a order after LP confirm a PO on LP dashboard - Order with only PE line items
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1613@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order         | po      |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | create by api | [blank] |
    And LP go to order detail "create by api"
    # Fulfillment date = null
    And LP confirm order unconfirmed then verify status is "In progress"
#    And LP upload Proof of Delivery file
#      | POD.png |
#    And LP check alert message
#      | Fulfillment details updated successfully. |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1613@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order "create by api" no found in vendor statement

    # Fulfillment date > currentDate
    And Switch to actor USER_LP
    And LP set fulfillment order from admin with date "Plus1"

    And Switch to actor NGOC_ADMIN_16
    And Admin refresh page by button
    And Admin check the order "create by api" no found in vendor statement

     # Fulfillment date = currentDate
    And Switch to actor USER_LP
    And LP set fulfillment order from admin with date "currentDate"

    And Switch to actor NGOC_ADMIN_16
    And Admin refresh page by button
    And Admin check the order "create by api" no found in vendor statement
    And NGOC_ADMIN_16 quit browser
    And USER_LP quit browser

  @VendorStatement_15 @VendorStatement
  Scenario: Check display of an order on the statement when merger PE line-items successfully
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1616@podfoods.co | 12345678a |
      # Change availability field
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 98285 | 53        | 39224              | 1000             | 1000       | in_stock     | active |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 01 | 39195              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
      | 98256              | 39195              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName                    | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU Vendor Statement 02 | 39224 | create by api | [blank]  | pending       | 2      |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled | fulfillmentDate |
      | 1     | AT SKU Vendor Statement 01 | 39195 | create by api | true      | currentDate     |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      | currentDate     |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1616@podfoods.co" pass "12345678a" role "Admin"
      # Merge line item
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Admin create "add to" sub-invoice with Suffix ="2"
      | skuName                    |
      | AT SKU Vendor Statement 01 |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $20.00     | ($5.00)    | $15.00     |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_16 @VendorStatement
  Scenario: Check display of an order on the statement when split PE line-items successfully
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1617@podfoods.co | 12345678a |
      # Change availability field
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 127924 | 53        | 61741              | 1000             | 1000       | in_stock     | active |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 01 | 39195              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 06 | 61741              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 127924             | 61741              | 1        | false     | [blank]          |
      | 98256              | 39195              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled | fulfillmentDate |
      | 1     | AT SKU Vendor Statement 01 | 39195 | create by api | true      | currentDate     |
      | 1     | AT SKU Vendor Statement 06 | 61741 | create by api | true      | currentDate     |
    # Set invoice
    And Admin set Invoice by API
      | skuName                    | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU Vendor Statement 06 | 61741 | create by api | [blank]  | pending       | 2      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1617@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $20.00     | ($5.00)    | $15.00     |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_17 @VendorStatement
  Scenario: Check display of an order on the statement when merger PD line-items successfully
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1618@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName                    | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU Vendor Statement 03 | 39231 | create by api | [blank]  | pending       | 1      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1618@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    And Admin add line item in order detail
      | skuName                    | quantity | note    |
      | AT SKU Vendor Statement 04 | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName                    |
      | AT SKU Vendor Statement 04 |
    And Admin create "add to" sub-invoice with Suffix ="2"
      | skuName                    |
      | AT SKU Vendor Statement 03 |
    When Admin fulfill all line items created by buyer
      | index | skuName                    | fulfillDate |
      | 1     | AT SKU Vendor Statement 03 | currentDate |
      | 1     | AT SKU Vendor Statement 04 | currentDate |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | Pod Direct  | ngoctx stvendorstatement1ny01 | $20.00     | ($2.00)    | $18.00     |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_18 @VendorStatement
  Scenario: Check display of an order on the statement when split PD line-items successfully
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1619@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98293              | 39231              | 1        | false     | [blank]          |
      | 99237              | 39949              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName                    | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU Vendor Statement 03 | 39231 | create by api | [blank]  | pending       | 1      |
      | AT SKU Vendor Statement 04 | 39949 | create by api | [blank]  | pending       | 1      |
    # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      |
      | 2     | AT SKU Vendor Statement 04 | 39949 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1619@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | Pod Direct  | ngoctx stvendorstatement1ny01 | $20.00     | ($2.00)    | $18.00     |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_19 @VendorStatement
  Scenario: Check display of an order on the statement when admin add a line item to order successfully - add item same vendor company
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1620@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName                    | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU Vendor Statement 03 | 39231 | create by api | [blank]  | pending       | 1      |
    # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1620@podfoods.co" pass "12345678a" role "Admin"
      # Merge line item
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Admin add line item in order detail
      | skuName                    | quantity | note    |
      | AT SKU Vendor Statement 01 | 1        | [blank] |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement02 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order "create by api" no found in vendor statement
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_20 @VendorStatement
  Scenario: Check display of an order on the statement when admin add a line item to order successfully - add item other vendor company
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1621@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName                    | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU Vendor Statement 03 | 39231 | create by api | [blank]  | pending       | 1      |
    # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1621@podfoods.co" pass "12345678a" role "Admin"
      # Merge line item
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by admin"
    And Admin go to order detail number "create by admin"
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Claim 2 07 | 1        | [blank] |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany   | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | AT Vendor Order | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "AT Vendor Order"
    And Admin check the order "create by api" no found in vendor statement
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_21 @VendorStatement
  Scenario: Check display of an order on the statement (paid) when admin add a line item to order successfully - add item same vendor company
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1622@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 2 03 | 64706              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132736             | 64706              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                      | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 2 03 | 64706 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1622@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement03 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement03"
     # paid adjustment
    And Admin add an adjustment in vendor statement
      | value | type            | effectiveDate | description |
      | 10    | Financial test1 | currentDate   | random      |
    And Admin choose adjustment in vendor statements
      | adjustmentDescription |
      | random                |
    And Admin choose all order in vendor statements
    And Admin pay in vendor statements
      | paymentType  | description |
      | Mark as paid | random      |
    And Admin verify payment in vendor statement detail
      | effectiveDate | type    | description | payments | netPayment |
      | currentDate   | Payment | random      | ($17.50) | ($17.50)   |

    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin can not add line item in order detail
      | skuName                      |
      | AT SKU Vendor Statement 2 02 |
    And Admin add line item in order detail
      | skuName                    | quantity | note    |
      | AT SKU Vendor Statement 01 | 1        | [blank] |
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                         | store                         | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx stbvendorstatementny01 | ngoctx stvendorstatement1ny01 | [blank]     | [blank]   | Pending      | Payment via invoice | In progress   | In progress |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order "create by api" no found in vendor statement

    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete line item in "non invoice"
      | index | skuName                    | reason  | note    | deduction |
      | 1     | AT SKU Vendor Statement 01 | [blank] | [blank] | No        |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_22 @VendorStatement
  Scenario: Check display of an order on the statement when admin removes a unfulfilled line item successfully
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1623@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 39231 | create by api | [blank]  | pending       | 2      |
   # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1623@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin unfulfill all line items created by buyer
      | index | skuName                    |
      | 1     | AT SKU Vendor Statement 02 |
      | 1     | AT SKU Vendor Statement 03 |
    And Admin delete line item in "sub invoice"
      | index | skuName                    | reason  | note    | deduction |
      | 1     | AT SKU Vendor Statement 02 | [blank] | [blank] | No        |
      | 1     | AT SKU Vendor Statement 03 | [blank] | [blank] | No        |
    And Admin save action in order detail

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order "create by api" no found in vendor statement
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_23 @VendorStatement
  Scenario: Check display of an order on the statement when admin removes a fulfilled line item successfully
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1624@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 39231 | create by api | [blank]  | pending       | 2      |
   # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1624@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin verify can not delete fulfill line item "sub invoice"
      | index | skuName                    | reason  | note    | deduction |
      | 1     | AT SKU Vendor Statement 02 | [blank] | [blank] | No        |
      | 1     | AT SKU Vendor Statement 03 | [blank] | [blank] | No        |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $20.00     | ($3.50)    | $16.50     |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_24 @VendorStatement
  Scenario: Check display of an order on the statement when admin deletes order
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1625@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 20       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 39231 | create by api | [blank]  | pending       | 2      |
   # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1625@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete order from order detail and verify message "Can not delete this order because it is related to statement items"
      | reason           | note     | showEdit | passkey |
      | Buyer adjustment | Autotest | Yes      | [blank] |

    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin check the order in list
      | number        | orderDate   | description | store                         | orderValue | serviceFee | netPayment |
      | create by api | currentDate | [blank]     | ngoctx stvendorstatement1ny01 | $20.00     | ($3.50)    | $16.50     |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_25 @VendorStatement
  Scenario: Check display of an order on the statement when admin deletes order
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1626@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 02 | 39224              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98285              | 39224              | 1        | false     | [blank]          |
      | 98293              | 39231              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Order Sum 03 | 39231 | create by api | [blank]  | pending       | 2      |
   # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName                    | skuId | order_id      | fulfilled |
      | 1     | AT SKU Vendor Statement 02 | 39224 | create by api | true      |
      | 1     | AT SKU Vendor Statement 03 | 39231 | create by api | true      |
  # Delete Adjustment of Vendor Statement
    And Admin delete adjustment of vendor statement "20383" by api

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1626@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement02 | [blank] | currentDate    | [blank]    |
    And Admin go to detail of vendor statement "ngoctx vcstatement02"
    And Admin verify default adjustment in vendor statement
    And Admin add an adjustment in vendor statement
      | value | type            | effectiveDate | description |
      | 10    | Financial test1 | currentDate   | random      |
    And Admin verify adjustment by description in vendor statement detail
      | effectiveDate | type            | description | value  |
      | currentDate   | Financial test1 | random      | $10.00 |
    And Admin edit an adjustment in vendor statement
      | date  | value | type          | effectiveDate | description |
      | Plus1 | 20    | Warehouse Fee | Plus1         | random      |
    And Admin verify adjustment by description in vendor statement detail
      | effectiveDate | type          | description | value  |
      | Plus1         | Warehouse Fee | random      | $20.00 |
    And Admin delete an adjustment in vendor statement
      | description |
      | random      |
    And Admin verify no found adjustment in vendor statement
      | description |
      | random      |
    And NGOC_ADMIN_16 quit browser

  @VendorStatement_28 @VendorStatement
  Scenario: Check when Admin pays unpaid orders on the current month statement with Payment type = Mark as paid without payment
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx1629@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Not Stripe 01 | 65527              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 133887             | 65527              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3439     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName              | skuId | order_id      | fulfilled |
      | 1     | AT SKU Not Stripe 01 | 65527 | create by api | true      |
    # Delete Adjustment of Vendor Statement
    And Admin delete adjustment of vendor statement "21095" by api

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1627@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | AT Vendor Not Stripe | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | AT Vendor Not Stripe | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "AT Vendor Not Stripe"
    And Admin add an adjustment in vendor statement
      | value | type            | effectiveDate | description |
      | 10    | Financial test1 | currentDate   | random      |
    And Admin choose order in vendor statements
      | orderID       |
      | create by api |
    And Admin choose adjustment in vendor statements
      | adjustmentDescription |
      | random                |
    And Admin pay in vendor statements
      | paymentType                  | description |
      | Mark as paid without payment | random      |
    Then Admin verify payment not display in vendor statement detail
      | description |
      | random      |

  @VendorStatement_29 @VendorStatement
  Scenario: Verify edit visibility search in vendor statement
    Given NGOC_ADMIN_16 login web admin by api
      | email                  | password  |
      | ngoctx1630@podfoods.co | 12345678a |
    # Reset search filter full textbox
    And Admin filter visibility with id "22" by api
      | q[payment_state]      |
      | q[email]              |
      | q[vendor_company_id]  |
      | q[statement_month]    |
      | q[pay_early_discount] |
      | q[vendor_company_ach] |

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx1630@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | paymentStatus | email | vendorCompany | ach | statementMonth | prePayment |
      | Yes           | Yes   | Yes           | Yes | Yes            | Yes        |
    Then Admin verify field search uncheck all in edit visibility
      | paymentStatus | email | vendorCompany | ach | statementMonth | prePayment |
      | Yes           | Yes   | Yes           | Yes | Yes            | Yes        |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | paymentStatus | email | vendorCompany | ach | statementMonth | prePayment |
      | Yes           | Yes   | Yes           | Yes | Yes            | Yes        |
    Then Admin verify field search in edit visibility
      | paymentStatus | email   | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | [blank]       | [blank] | [blank]        | [blank]    |
    # Verify save new filter
    And Admin search vendor statements
      | paymentStatus | email                              | vendorCompany        | ach | statementMonth | prePayment |
      | Unpaid        | ngoctx+vendorNotStripe@podfoods.co | AT Vendor Not Stripe | Yes | currentDate    | Yes        |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in vendor statements
      | paymentStatus | email                              | vendorCompany        | ach | statementMonth | prePayment |
      | Unpaid        | ngoctx+vendorNotStripe@podfoods.co | AT Vendor Not Stripe | Yes | currentDate    | Yes        |
    # Verify save as filter
    And Admin search vendor statements
      | paymentStatus | email                              | vendorCompany        | ach | statementMonth | prePayment |
      | Paid          | ngoctx+vendorNotStripe@podfoods.co | ngoctx vcstatement01 | No  | currentDate    | No         |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter in vendor statements
      | paymentStatus | email                              | vendorCompany        | ach | statementMonth | prePayment |
      | Paid          | ngoctx+vendorNotStripe@podfoods.co | ngoctx vcstatement01 | No  | currentDate    | No         |

    Given NGOC_ADMIN_161 open web admin
    When login to beta web with email "ngoctx1623@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_161 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany | ach     | statementMonth | prePayment |
      | Unpaid        | [blank] | [blank]       | [blank] | [blank]        | [blank]    |
    Then Admin verify filter "AutoTest1" is not display

    And Switch to actor NGOC_ADMIN_16
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

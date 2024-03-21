@feature=email
Feature: Verify All Email

  @adminOrder_150 @email01
  Scenario: Admin check ETA in order with PE item (Store set Receiving weekdays is delivery day: Mon, Tue..)
    Given NGOCTX05 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 150 | 32864              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name              | sos     | size    | type    | city    | state   | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | ngoctx stOrder150 | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    When Admin go to detail of store "ngoctx stOrder150"
    And Admin change set receiving day is current day in store detail

    And NGOC_ADMIN_05 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                  | paymentType    | street                | city    | state    | zip   |
      | ngoctx storder150chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU Order 150"
    And Admin create order success
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU Order 150b | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName           |
      | AT SKU Order 150b |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
      | 2   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Pending           | Yes         |
    And Admin send ETA email
    And NGOC_ADMIN_05 quit browser

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail sau khi tạo order được gửi cho buyer
    And USER_EMAIL search email with order "create by admin"
    And QA go to detail email "order details"
    And QA verify info email order detail
      | name             | store             | order           | date        | timeZone                   | buyer                  | brand             | sku              | price   | quantity | total   |
      | Hello ngoc vc 1, | ngoctx stOrder150 | create by admin | currentDate | Pacific Time (US & Canada) | ngoctx storder150chi01 | AT Brand Store 01 | AT SKU Order 150 | $100.00 | 1        | $100.00 |

    # Check mail sau khi tạo order được gửi cho vendor
    And USER_EMAIL search email with order "create by admin"
    And QA go to detail email "Pod Foods Order Details"
    And QA verify info email order detail for buyer
      | name                          | order           | date        | timeZone                   | buyer                  | brand             | product          | sku              | upc          | price   | quantity | total   |
      | Hello ngoctx storder150chi01, | create by admin | currentDate | Pacific Time (US & Canada) | ngoctx storder150chi01 | AT Brand Store 01 | AT Product Order | AT SKU Order 150 | 123123123012 | $100.00 | 1        | $100.00 |

    # Check mail sau send ETA
    And USER_EMAIL search email with order "create by admin"
    And QA go to detail email "eta order"
    And QA verify info email ETA of order
      | name                          | line1                              | line2                                     | date  | timeZone                   |
      | Hello ngoctx storder150chi01, | Thank you for your Pod Foods order | You can expect your order to be delivered | Plus7 | Pacific Time (US & Canada) |

  @AdminDropSummary_02 @email02
  Scenario: Admin create Drop summary without PO -> Admin Push drop to LP
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "47154" by api
    And Admin delete order of sku "47154" by api
        # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 01 | 47154              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order of store 01
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3552     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Create order of store 01
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3552     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"
  # Create order of store 02
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3553     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "3"
    # Create order of store 02
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3553     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "4"
    # Create order of store 03
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3554     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "5"
     # Create order of store 03
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3554     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "6"
    # Create order of store 04
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3555     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "7"
    # Create order of store 04
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3555     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "8"
    # Create order of store 05
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3556     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "9"
    And Admin edit display surcharges in orderID by api
      | index | order         | value |
      | 9     | create by api | false |
    # Create order of store 05
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3556     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "10"
    And Admin edit display surcharges in orderID by api
      | index | order         | value |
      | 10    | create by api | false |
     # Create order of store 01 to add drop
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109008             | 47154              | 8        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3552     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "11"

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1901@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 3     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 4     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 5     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 6     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 7     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 8     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 9     | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 10    | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
      | 3     | create by api | 1          |
      | 4     | create by api | 1          |
      | 5     | create by api | 1          |
      | 6     | create by api | 1          |
      | 7     | create by api | 1          |
      | 8     | create by api | 1          |
      | 9     | create by api | 1          |
      | 10    | create by api | 1          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 10       | $2,600.00    | $2,600.00          | $650.00          | 52.00 lbs   |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 3     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 4     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 5     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 6     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 7     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 8     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 9     | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 10    | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin verify summary in create drop popup
      | store              | totalPayment | totalOrdered | vendorFee | totalWeight |
      | ngoctx stdropsum01 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum02 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum03 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum04 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum05 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
    And Admin edit sos surcharge in create drop popup
      | index | order         | subInvoice | sosValue | reason               | additionNote |
      | 7     | create by api | 1          | 40       | Drop total meets MOQ | Auto test    |
      | 8     | create by api | 1          | 40       | Drop total meets MOQ | Auto test    |
    And Admin apply sos suggestions of store in create drop popup
      | store              | reason               | additionNote |
      | ngoctx stdropsum01 | Drop total meets MOQ | Auto test    |
      | ngoctx stdropsum03 | Drop total meets MOQ | Auto test    |
    And Admin reject sos suggestions of store "ngoctx stdropsum02" in create drop popup
    # Verify in create drop popup
    And Admin verify sub-invoices in create drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 3     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 4     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 5     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 6     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $0.00  | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 7     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $40.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 8     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $40.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 9     | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 10    | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin create drop in create drop popup
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum01 |
      | 1     | ngoctx stdropsum02 |
      | 1     | ngoctx stdropsum03 |
      | 1     | ngoctx stdropsum04 |
      | 1     | ngoctx stdropsum05 |
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
      | 2     |
      | 3     |
      | 4     |
      | 5     |
    And Admin verify drop in drop summary
      | region  | route   | store              | order   | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | [blank] | [blank] | ngoctx stdropsum01 | [blank] | [blank]    | $0.00  | $0.00 | $800.00      | $800.00      | $200.00   | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
      | [blank] | [blank] | ngoctx stdropsum02 | [blank] | [blank]    | $60.00 | $0.00 | $800.00      | $800.00      | $200.00   | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
      | [blank] | [blank] | ngoctx stdropsum03 | [blank] | [blank]    | $30.00 | $0.00 | $100.00      | $100.00      | $25.00    | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
      | [blank] | [blank] | ngoctx stdropsum04 | [blank] | [blank]    | $80.00 | $0.00 | $100.00      | $100.00      | $25.00    | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
      | [blank] | [blank] | ngoctx stdropsum05 | [blank] | [blank]    | $0.00  | $0.00 | $800.00      | $800.00      | $200.00   | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
    And Admin choose drop of store "ngoctx stdropsum01" in drop result
    And Admin verify create purchase order in drop summary
      | selected | totalPayment | vendorFee |
      | 1        | $800.00      | $200.00   |
    And Admin create purchase order in drop summary
      | driver              | fulfillmentDate | fulfillmentState | proof   | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum01 | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |

    And Admin go to detail drop of store "ngoctx stdropsum01" in drop summary
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $400.00    | $0.00    | $0.00 | Not applied         | $0.00              | $100.00          | $400.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress | currentDate | [blank]   | [blank] |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
#    Given USER_EMAIL3 open login gmail
    And USER_EMAIL search email with drop "ngoctx stdropsum01"
    And QA go to detail email "New Purchase Order received"
    And QA verify info email new purchase order received of drop
      | name                    | line1                       | date        | timeZone                   | store              |
      | Hi Auto Ngoc LP Mix 01, | New Purchase Order received | currentDate | Pacific Time (US & Canada) | ngoctx stdropsum01 |

  @vendorBrand01 @email03
  Scenario: Vendor create new brand
    Given NGOCTX06 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Delete brand
    And Admin search brand name "Auto Brand Check Mail 01" by api
    And Admin delete brand by API
    # Delete product
    And Admin search product name "Auto Product Check Mail 01" by api
    And Admin delete product name "Auto Product Check Mail 01" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Click on button "New Brand"
    And Vendor create brand with info
      | brandName                | description              | country       | state  | city  |
      | Auto Brand Check Mail 01 | Auto Brand Check Mail 01 | United States | Alaska | Hanoi |

    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to Create new Product
    And VENDOR Create an new Product Success
      | productName                | brandName                | productType | allowSample | category | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | unit | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight |
      | Auto Product Check Mail 01 | Auto Brand Check Mail 01 | Bread       | yes         | Dairy    | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | oz.  | 10             | 10            | 10                  | 1                      | 1                    | 1                          | 1                         | 1                          | 1                |
    And Vendor upload Master case photo
      | casePack    | masterCarton |
      | anhJPEG.jpg | anhJPG2.jpg  |
    And Vendor confirm Next new Product
    And Vendor input info new SKU
      | skuName                | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition            | retailShelfLife | retailCondition             | tempRequirementMin | tempRequirementMax | country       | city     | stateManufacture | ingredient                              | leadTime | description | nutritionLabel     |
      | Auto SKU Check Mail 01 | 12        | 123123123123      | masterImage.jpg | 123123123123 | UPCImage.png | CaseImage.png | 30               | Deep Frozen (-20°F ~ -11°F) | 10              | Deep Frozen (-20°F ~ -11°F) | -20                | -12                | United States | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | nutritionImage.jpg |
    And Vendor upload "UPC" image for new SKU
      | image           | masterCarton |
      | masterImage.jpg | 123          |
    And Vendor choose qualities of SKU
      | Dairy-Free |
    And Vendor add nutrition labels of SKU
      | image              | description |
      | nutritionImage.jpg | [blank]     |
    And Vendor confirm Next new Product
    And Vendor choose region "Chicagoland Express" for SKU
    And Vendor choose option on confirm add region
      | You have product in the corresponding regional DC or on the way to it.           |
      | You're focusing your sales efforts on activating new accounts in this region.    |
      | You've sent us a list of direct accounts you’d like us to manage in this region. |
      | You've reached out to success@podfoods.co and/or orders@podfoods.co!             |
    And Click on dialog button "Add"
    And Vendor input Region-Specific info of SKU
      | regionName          | casePrice | msrpunit | availability | expectedDate |
      | Chicagoland Express | 12        | 15       | In Stock     | [blank]      |
    And Vendor click "Publish" new SKU
    And VENDOR check dialog message
      | Are you sure all the information is accurate? Once confirmed, your product will be live and your key product information including price, UPC / EAN, case pack, and size will be locked in so that stores can benefit from consistent information. You can still request changes. Changes may take up to 90 days to process. |
    And Vendor Continue confirm publish SKU
    And Wait for create product successfully

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail tạo brand
    And USER_EMAIL search email with sender "Auto Brand Check Mail 01"
    And QA go to first email with title "New brand created"
    And QA verify info email create brand
      | vendor              | brand                    |
      | ngocvc1@podfoods.co | Auto Brand Check Mail 01 |

        # Check mail tạo product
    And USER_EMAIL search email with sender "Auto Product Check Mail 01"
    And QA go to first email with title "New product created"
    And QA verify info email create brand
      | vendor              | brand                    | product                    |
      | ngocvc1@podfoods.co | Auto Brand Check Mail 01 | Auto Product Check Mail 01 |

  @VendorStatement_26 @email04
  Scenario: Check when Admin pays unpaid orders on the current month statement with Payment type = Pay via Stripe - The vendor has connected to stripe yet
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 2 03 | 64706              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
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
    # Delete Adjustment of Vendor Statement
    And Admin delete adjustment of vendor statement "20384" by api

    Given NGOC_ADMIN_16 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_16 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany        | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoctx vcstatement03 | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany        | month       | status  | beginningBalance | endingBalance |
      | ngoctx vcstatement03 | currentDate | [blank] | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "ngoctx vcstatement03"

    # paid adjustment
    And Admin add an adjustment in vendor statement
      | value | type            | effectiveDate | description |
      | 10    | Financial test1 | currentDate   | random      |
    And Admin choose adjustment in vendor statements
      | adjustmentDescription |
      | random                |
    And Admin choose order in vendor statements
      | orderID       |
      | create by api |
    And Admin pay in vendor statements
      | paymentType    | description |
      | Pay via Stripe | Auto        |
    And Admin verify adjustment by description in vendor statement detail
      | effectiveDate | type            | description | value  | status |
      | currentDate   | Financial test1 | random      | $10.00 | paid   |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail tạo brand
    And USER_EMAIL search email with sender "You have been paid"
    And QA go to first email with title "You have been paid"
    And QA verify info email order paid as stripe success
      | vendor                   |
      | ngoctx vendorstatement03 |

  @VendorStatement_27 @email05
  Scenario: Check when Admin pays unpaid orders on the current month statement with Payment type = Pay via Stripe - The vendor has not connected to stripe yet
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
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
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
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
    And Admin pay error in vendor statements
      | paymentType    | description | message                                    |
      | Pay via Stripe | Auto        | The vendor has not connected to stripe yet |

  @VendorStatement_28 @email06
  Scenario: Check when Admin pays unpaid orders on the current month statement with Payment type = Pay via Stripe - The vendor has connected to stripe yet - run job sidekiq
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Vendor Statement 2 03 | 64706              | 10       | random   | 91           | Plus1        | [blank]     | [blank] |
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
    # Delete Adjustment of Vendor Statement
    And Admin delete adjustment of vendor statement "20384" by api

   # Lấy sub invoice id để run job
    Given NGOC_ADMIN_11 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_11 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName                      | fulfillDate |
      | 1     | AT SKU Vendor Statement 2 03 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin get sub invoice id to run job sidekiq

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq

#    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
#    # Check mail tạo brand
#    And USER_EMAIL search email with sender "You have been paid"
#    And QA go to first email with title "You have been paid"
#    And QA verify info email order paid as stripe success
#      | vendor                   |
#      | ngoctx vendorstatement03 |

  @adminOrder_169 @email07
  Scenario: Check handling unconfirmed Express line-items - pending financial
    Given NGOCTX05 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 01 | 31495              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 83913              | 31495              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3498     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin approve to fulfill this order

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail sau khi tạo order được gửi cho buyer
    And USER_EMAIL search email with order "create by api"
    And QA go to detail email "order details"
    And QA verify info email order detail
      | name             | store                           | order         | date        | timeZone                   | buyer                      | brand             | sku             | price   | quantity | total   |
      | Hello ngoc vc 1, | ngoctx str financial pending 01 | create by api | currentDate | Pacific Time (US & Canada) | ngoctx financialpendingb01 | AT Brand Store 01 | AT SKU Order 01 | $200.00 | 1        | $200.00 |

    # Check mail sau khi tạo order được gửi cho vendor
    And USER_EMAIL search email with order "create by api"
    And QA go to detail email "Pod Foods Order Details"
    And QA verify info email order detail for buyer
      | email                      | name                              | order         | date        | timeZone                   | buyer                      | brand             | product          | sku             | upc          | price   | quantity | total   |
      | ngoctx+financialpendingb01 | Hello ngoctx financialpendingb01, | create by api | currentDate | Pacific Time (US & Canada) | ngoctx financialpendingb01 | AT Brand Store 01 | AT Product Order | AT SKU Order 01 | 123123123012 | $200.00 | 1        | $200.00 |

    # Check mail sau khi tạo order được gửi cho admin
    And QA verify info email order detail for admin
      | email      | name             | order         | date        | timeZone                   | store                           | buyer                      | managedBy | brand             | sku             | price   | quantity | total   | orderValue | discount | subTotal | sos    | bottle | specialDiscount | totalOrder | address                                   | paymentInfo |
      | ngoctx+666 | Hi Pod Foods Co, | create by api | currentDate | Pacific Time (US & Canada) | ngoctx str financial pending 01 | ngoctx financialpendingb01 | [blank]   | AT Brand Store 01 | AT SKU Order 01 | $200.00 | 1        | $200.00 | $200.00    | $0.00    | $200.00  | $30.00 | $0.00  | $0.00           | $230.00    | 281 9th Avenue, New York, New York, 60608 | [blank]     |

   # Check mail sau khi tạo order pending financial được gửi cho admin
    And USER_EMAIL search email with sender "Pending order due to credit limit exceeded"
    And QA go to first email with title "Pending order due to credit limit exceeded"
    And QA show trimmed content of email
    And QA verify info email credit limit exceeded
      | email      | buyerCompany                 | store                           | emailBuyer                             |
      | ngoctx+666 | ngoctx cpn financial pending | ngoctx str financial pending 01 | ngoctx+financialpendingb01@podfoods.co |

  @adminOrder_169 @email08
  Scenario: Check handling unconfirmed Direct line-items - pending financial
    Given NGOCTX05 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 01 | 31495              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88835              | 33691              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3498     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName                  | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU B Order Detail 74 | 33691 | create by api | [blank]  | pending       | 2      |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    When Admin approve to fulfill this order

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail sau khi tạo order được gửi cho buyer
    And USER_EMAIL search email with order "create by api"
    And QA go to detail email "new pod direct order"
    And QA verify info email order detail of pod direct item
      | email                  | store                           | order         | date        | timeZone                   | buyer                      | brand             | sku             | price   | quantity | total   |
      | ngoctx+atvendororder01 | ngoctx str financial pending 01 | create by api | currentDate | Pacific Time (US & Canada) | ngoctx financialpendingb01 | AT Brand Store 01 | AT SKU Order 01 | $100.00 | 1        | $100.00 |

  @email09
  Scenario: Order out of stock
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Create sku
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1200 |
    And Admin create a "active" SKU from admin with name "sku168 random" of product "32407"

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3887     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

  @CREATE_SAMPLE_REQUESTS_18 @email10
  Scenario: Create new Sample Requests for head buyers
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    And Admin delete order by sku of product "auto product create sample 1" by api
    And Admin search product name "auto product create sample 1" by api
    And Admin delete product name "auto product create sample 1" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | auto product create sample 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku create sample 1" of product ""

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Sample Requests" to "Create new sample requests" by sidebar
    And Admin create new sample request for Head buyer
      | fulfillment | fulfillmentDate | comment      | headBuyer       | brand                     |
      | Pending     | currentDate     | Auto comment | Auto HeadBuyer1 | Auto brand create product |
    And Admin add SKUs of product "auto product create sample 1" to new sample request
      | sku                      | comment       |
      | auto sku create sample 1 | comment sku 1 |
    And Admin use default head buyer store address
      | store                      | address             |
      | Auto Store check Orrder NY | 455 Madison Avenue, |
    And Admin create sample request success
    And Check general information sample detail
      | created     | vendor_company      | buyer_company          | buyer           | email                            | address                                       | fulfillmentState | fulfillmentDate | comment      |
      | currentDate | Auto vendor company | Auto Buyer Company Bao | Auto HeadBuyer1 | goctx+autoheadbuyer1@podfoods.co | 455 Madison Avenue, New York, New York, 10022 | Pending          | [blank]         | Auto comment |
    And Admin edit fulfillment state sample request
      | fulfillmentDate | fulfillmentState |
      | Minus3          | Fulfilled        |

     #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "fulfilled_sample_request_notice"

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail sau khi tạo sample request duoc gui cho buyer
    And USER_EMAIL search email with order "ngoctx+autovendor29"
    And QA go to detail email "sample request"
    And QA verify info email sample request detail for buyer
      | email               | buyerCompany           | product                   | sku                      |
      | ngoctx+autovendor29 | Auto Buyer Company Bao | Auto brand create product | auto sku create sample 1 |
    # Check mail sau khi tạo sample request duoc gui cho head buyer
    And USER_EMAIL search email with order "ngoctx+666"
    And QA go to detail email "sample request"
    And QA verify info email sample request detail for admin
      | email      | headBuyer       | buyerCompany           | date        | buyer           | product                   | sku                      | comment      | address                                       | managedBy |
      | ngoctx+666 | Auto HeadBuyer1 | Auto Buyer Company Bao | currentDate | Auto HeadBuyer1 | Auto brand create product | auto sku create sample 1 | Auto comment | 455 Madison Avenue, New York, New York, 10022 | [blank]   |

  @VendorClaim_04 @email11
  Scenario: Verify email create inbound
    Given NGOCTX20 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
      # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47269              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 53        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 121          |
    And Admin save inbound number by index "1"
    And Admin clear list sku inbound by API

     #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "inbound_new_status_notification"

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by api | [blank]       | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin submit incoming inventory
      | index | skuName        | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT SKU Claim 2 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin process incoming inventory
    And NGOC_ADMIN_05 wait 5000 mini seconds

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail sau khi tao inbound
    And USER_EMAIL search email with sender "ngoctx+lp1,"
    And QA go to detail email inbound submit
      | brand             | date        |
      | AT Brand Claim 01 | currentDate |
    And QA verify info email new inventory needed
      | email                  | buyerCompany           | product                   | sku                      |
      | ngoctx+atvendororder01 | Auto Buyer Company Bao | Auto brand create product | auto sku create sample 1 |
    # Check mail sau khi submit inbound
    And QA verify info email inbound submit
    # Check mail sau khi process inbound
    And QA verify info email inbound process

  @VendorSetting01 @Setting @email12
  Scenario: Verify email new-user-invited
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Change general information of vendor company
    And Admin change general information of vendor company "2035"
      | manager_id | launcher_id | referral_buyer_company_ids | email                       | contact_number | website       | legal_entity_name | ein    | company_size | show_all_tabs |
      | [blank]    | [blank]     | [blank]                    | ngocvcsetting01@podfoods.co | 1234567890     | vcsetting.com | setting legal     | 123456 | <25k         | false         |
    And Admin change address of vendor company "2035"
      | attn    | full_name | street1        | street2 | city     | address_state_id | zip   | phone_number | address_state_code | address_state_name | lat     | lng     | number | street     |
      | [blank] | [blank]   | 281 9th Avenue | [blank] | New York | 33               | 10001 | [blank]      | IL                 | Illinois           | [blank] | [blank] | 281    | 9th Avenue |
     # Change general information of vendor
    And Admin change info of vendor "2013"
      | email                          | first_name | last_name   | password  |
      | ngoctx+vcsetting01@podfoods.co | ngoctx     | vcsetting01 | 12345678a |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Settings" by sidebar
    And Vendor go to invite colleagues
    And Vendor fill info to invite colleagues
      | firstName | lastName | email              |
      | Auto      | Test     | ngoctx@podfoods.co |

    Given BUYER open web user
    When login to beta web with email "ngoctx+chi1@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Settings" by sidebar
    And Vendor go to invite colleagues
    And Vendor fill info to invite colleagues
      | firstName | lastName | email              | author  |
      | Auto      | Test     | ngoctx@podfoods.co | [blank] |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "12345678a"
    # Check mail sau khi vendor invite colleagues
    And USER_EMAIL search email with sender "AT invites you to create your Pod Foods account"
    And QA go to detail email "AT invites you to create your Pod Foods account"
    And QA verify info email vendor invite colleagues
      | vendor             |
      | AT Vendor Order 01 |

     # Check mail sau khi buyer invite colleagues
    And USER_EMAIL search email with sender "ngoctx invites you to create your Pod Foods account"
    And QA go to detail email "ngoctx invites you to create your Pod Foods account"
    And QA verify info email buyer invite colleagues
      | buyer       |
      | ngoctx chi1 |

  @email13
  Scenario: Verify email withdrawal send to vendor
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
   # Create product
    And Create product by api with file "CreateProduct.json" and info
      | name                                          | brand_id |
      | random product lp withdraw inventory 23 api 1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    # Create sku
    And Admin create a "active" SKU from admin with name "random sku lp withdraw inventory 23 api 1" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku                                       | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku lp withdraw inventory 23 api 1 | random             | 5        | random sku lp withdraw inventory 23 api 1 | 99           | Plus1        | Plus1       | [blank] |
    # Create Withdrawal
    And Admin add Lot code to withdraw request api
      | inventory_id | product_variant_id | inventory_lot_code                        | quantity | pull_quantity | withdraw_case | inventory_expiry_date |
      | random       | random             | random sku lp withdraw inventory 23 api 1 | 5        | 0             | 1             | Plus1                 |
    And Admin create withdraw request api2
      | region_id | vendor_company_id | pickup_date | start_time | end_time | pickup_type    | pickup_partner_name | pallet_weight | comment | attachment |
      | 26        | 1847              | currentDate | 00:30      | 01:00    | carrier_pickup | pickup_partner_name | 1             | comment | BOL.pdf    |
     # approve withdrawal
    And Admin approve withdrawal request "create by api" by api

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail sau khi vendor tạo withdrawal
    And USER_EMAIL search email with withdrawal "create by api"
    And QA go to detail email "approved withdrawal"
    And QA verify info email admin approve request

  @email14
  Scenario: Verify email vendor change email of themself
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Change general information of vendor company
    And Admin change general information of vendor company "2035"
      | manager_id | launcher_id | referral_buyer_company_ids | email                       | contact_number | website       | legal_entity_name | ein    | company_size | show_all_tabs |
      | [blank]    | [blank]     | [blank]                    | ngocvcsetting01@podfoods.co | 1234567890     | vcsetting.com | setting legal     | 123456 | <25k         | false         |
    And Admin change address of vendor company "2035"
      | attn    | full_name | street1        | street2 | city     | address_state_id | zip   | phone_number | address_state_code | address_state_name | lat     | lng     | number | street     |
      | [blank] | [blank]   | 281 9th Avenue | [blank] | New York | 33               | 10001 | [blank]      | IL                 | Illinois           | [blank] | [blank] | 281    | 9th Avenue |
     # Change general information of vendor
    And Admin change info of vendor "2013"
      | email                          | first_name | last_name   | password  |
      | ngoctx+vcsetting01@podfoods.co | ngoctx     | vcsetting01 | 12345678a |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+vcsetting01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Settings" by sidebar
    And Vendor go to general
     # Verify personal
    And Vendor go to edit personal in general settings
    When Vendor edit personal in general settings
      | firstName  | lastName        | email                              |
      | ngoctxEdit | vcsetting01Edit | ngoctx+vcsetting01edit@podfoods.co |
    And Vendor edit success in general settings

     # Check mail sau khi vendor change password
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "Password Changed"
    And QA go to first email with title "Password Changed"
    And QA verify info email password changed
      | email                  | mail                           |
      | ngoctx+vcsetting01edit | ngoctx+vcsetting01@podfoods.co |
    # Check mail sau khi vendor change name
    And USER_EMAIL search email with sender "Email Changed"
    And QA go to first email with title "Email Changed"
    And QA verify info email changed
      | email              | vendor                         | vendorEdit                         |
      | ngoctx+vcsetting01 | ngoctx+vcsetting01@podfoods.co | ngoctx+vcsetting01edit@podfoods.co |

  @email15
  Scenario: Verify email when - Admin change email of Vendor
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Change general information of vendor company
    And Admin change general information of vendor company "2035"
      | manager_id | launcher_id | referral_buyer_company_ids | email                       | contact_number | website       | legal_entity_name | ein    | company_size | show_all_tabs |
      | [blank]    | [blank]     | [blank]                    | ngocvcsetting01@podfoods.co | 1234567890     | vcsetting.com | setting legal     | 123456 | <25k         | false         |
    And Admin change address of vendor company "2035"
      | attn    | full_name | street1        | street2 | city     | address_state_id | zip   | phone_number | address_state_code | address_state_name | lat     | lng     | number | street     |
      | [blank] | [blank]   | 281 9th Avenue | [blank] | New York | 33               | 10001 | [blank]      | IL                 | Illinois           | [blank] | [blank] | 281    | 9th Avenue |
     # Change general information of vendor
    And Admin change info of vendor "2013"
      | email                          | first_name | last_name   | password  |
      | ngoctx+vcsetting01@podfoods.co | ngoctx     | vcsetting01 | 12345678a |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Vendors" to "All vendors" by sidebar
    # Search vendor with email criteria
    And Admin search vendors
      | fullName | email                          | vendorCompany | brand   | region  | address | state   | tags    | approved | shopify |
      | [blank]  | ngoctx+vcsetting01@podfoods.co | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] |
    And Admin go to vendor detail "ngoctx vcsetting01"
    And Admin verify edit email field in vendor detail
      | email                              | message                      |
      | [blank]                            | Email can't be blank         |
      | 123                                | Email is not an email        |
      | ngoctx+vcsetting02@podfoods.co     | Email has already been taken |
      | ngoctx+vcsetting01edit@podfoods.co | success                      |
    And Admin change password to "123456789a" success in vendor detail

     # Check mail sau khi vendor change password
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "Password Changed"
    And QA go to first email with title "Password Changed"
    And QA show trimmed content of email
    And QA verify info email password changed
      | email                  | mail                               |
      | ngoctx+vcsetting01edit | ngoctx+vcsetting01edit@podfoods.co |
    # Check mail sau khi vendor change name
    And USER_EMAIL search email with sender "Email Changed"
    And QA go to first email with title "Email Changed"
    And QA verify info email changed
      | email              | vendor                         | vendorEdit                         |
      | ngoctx+vcsetting01 | ngoctx+vcsetting01@podfoods.co | ngoctx+vcsetting01edit@podfoods.co |

  @email16
  Scenario: Verify email when - Admin change email of Buyer
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
   # Change infor buyer
    And Admin change general information of buyer "3901"
      | email                      | first_name | last_name | password  |
      | ngoctx+mailb01@podfoods.co | ngoctx     | mailb01   | 12345678a |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Buyers" to "All buyers" by sidebar
     # search with all criteria status
    And Admin search all buyer
      | anyText        | fullName | email   | role          | store   | managedBy | tag     | status  |
      | ngoctx mailb01 | [blank]  | [blank] | Store manager | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail of buyer "ngoctx mailb01"
    # Edit
    And Admin edit general information of store buyer
      | email                          | firstName | lastName | contact | department | store   | role    | manager |
      | ngoctx+mailb01edit@podfoods.co | ngoctx    | mailb01  | [blank] | [blank]    | [blank] | [blank] | [blank] |
    And Admin change password to "123456789a" success in vendor detail

     # Check mail sau khi admin change password buyer
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "Password Changed"
    And QA go to first email with title "Password Changed"
    And QA show trimmed content of email
    And QA verify info email password changed
      | email              | mail                           |
      | ngoctx+mailb01edit | ngoctx+mailb01edit@podfoods.co |
    # Check mail sau khi amdin change email buyer
    And USER_EMAIL search email with sender "Email Changed"
    And QA go to first email with title "Email Changed"
    And QA verify info email changed
      | email          | vendor                     | vendorEdit                     |
      | ngoctx+mailb01 | ngoctx+mailb01@podfoods.co | ngoctx+mailb01edit@podfoods.co |

  @email17
  Scenario: Verify email buyer change email of themself
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Change infor buyer
    And Admin change general information of buyer "3901"
      | email                      | first_name | last_name | password  |
      | ngoctx+mailb01@podfoods.co | ngoctx     | mailb01   | 12345678a |

    Given BUYER open web user
    When login to beta web with email "ngoctx+mailb01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Settings" by sidebar
    And Buyer go to general
     # Edit email
    And Buyer go to edit personal in general settings
    When Vendor edit personal in general settings
      | firstName | lastName | email                          | contactNumber |
      | ngoctx    | mailb01  | ngoctx+mailb01edit@podfoods.co | 1234567890    |
    And Vendor edit success in general settings

    And BUYER wait 5000 mini seconds
    And BUYER refresh browser
    # Change password
    When login to beta web with email "ngoctx+mailb01edit@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Settings" by sidebar
    And Buyer go to general
    When Vendor go to change password in general settings
    And Vendor change password in general settings
      | currentPassword | newPassword | confirm    |
      | 12345678a       | 123456789a  | 123456789a |
    And Vendor change password success

   # Check mail sau khi admin change password buyer
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "Password Changed"
    And QA go to first email with title "Password Changed"
    And QA show trimmed content of email
    And QA verify info email password changed
      | email              | mail                           |
      | ngoctx+mailb01edit | ngoctx+mailb01edit@podfoods.co |
    # Check mail sau khi amdin change email buyer
    And USER_EMAIL search email with sender "Email Changed"
    And QA go to first email with title "Email Changed"
    And QA verify info email changed
      | email          | vendor                     | vendorEdit                     |
      | ngoctx+mailb01 | ngoctx+mailb01@podfoods.co | ngoctx+mailb01edit@podfoods.co |

  @email18
  Scenario: Verify email when - Admin change email of LP
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
 # Change general information of lp company
    And Admin change general information of lp company "226"
      | business_name      | contact_number |
      | AT Ngoc LP Setting | 1234567890     |
     # Change general information of lp
    And Admin change general information of lp "247"
      | email                          | first_name | last_name   | logistics_company_id | contact_number | password  |
      | ngoctx+lpsetting01@podfoods.co | ngoctx     | lpsetting01 | 226                  | 1234567890     | 12345678a |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Logistics Partners" to "All logistics partners" by sidebar
     # search with all criteria status
    And Admin search LP
      | fullName | lpCompany | email                          | contactNumber | status  |
      | [blank]  | [blank]   | ngoctx+lpsetting01@podfoods.co | [blank]       | [blank] |
    And Admin go to detail of LP "ngoctx lpsetting01"
    # Edit
    And Admin edit general information of lp
      | email                              | firstName | lastName    | lpCompany | contactNumber |
      | ngoctx+lpsetting01edit@podfoods.co | ngoctx    | lpsetting01 | [blank]   | [blank]       |
    And Admin change password to "123456789a" success in vendor detail

    # Check mail sau khi admin change password buyer
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "Password Changed"
    And QA go to first email with title "Password Changed"
    And QA show trimmed content of email
    And QA verify info email password changed
      | email                  | mail                               |
      | ngoctx+lpsetting01edit | ngoctx+lpsetting01edit@podfoods.co |
    # Check mail sau khi amdin change email buyer
    And USER_EMAIL search email with sender "Email Changed"
    And QA go to first email with title "Email Changed"
    And QA verify info email changed
      | email              | vendor                         | vendorEdit                         |
      | ngoctx+lpsetting01 | ngoctx+lpsetting01@podfoods.co | ngoctx+lpsetting01edit@podfoods.co |

  @email19
  Scenario: Verify email lp change email of themself
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Change general information of lp company
    And Admin change general information of lp company "226"
      | business_name      | contact_number |
      | AT Ngoc LP Setting | 1234567890     |
     # Change general information of lp
    And Admin change general information of lp "247"
      | email                          | first_name | last_name   | logistics_company_id | contact_number | password  |
      | ngoctx+lpsetting01@podfoods.co | ngoctx     | lpsetting01 | 226                  | 1234567890     | 12345678a |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lpsetting01@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Settings" by sidebar
    And Vendor go to general
    And Vendor go to edit personal in general settings
    When Vendor edit personal in general settings
      | firstName  | lastName    | email                              | contactNumber |
      | ngoctxEdit | lpsetting01 | ngoctx+lpsetting01edit@podfoods.co | 1234567891    |
    And Vendor edit success in general settings
    And USER_LP refresh browser

    When login to beta web with email "ngoctx+lpsetting01edit@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Settings" by sidebar
    And Vendor go to general
    When Vendor go to change password in general settings
    And Vendor change password in general settings
      | currentPassword | newPassword | confirm    |
      | 12345678a       | 123456789a  | 123456789a |
    And Vendor change password success

   # Check mail sau khi admin change password buyer
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "Password Changed"
    And QA go to first email with title "Password Changed"
    And QA show trimmed content of email
    And QA verify info email password changed
      | email                  | mail                               |
      | ngoctx+lpsetting01edit | ngoctx+lpsetting01edit@podfoods.co |
    # Check mail sau khi amdin change email buyer
    And USER_EMAIL search email with sender "Email Changed"
    And QA go to first email with title "Email Changed"
    And QA verify info email changed
      | email              | vendor                         | vendorEdit                         |
      | ngoctx+lpsetting01 | ngoctx+lpsetting01@podfoods.co | ngoctx+lpsetting01edit@podfoods.co |

  @email20
  Scenario: Verify email reset password
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Change infor buyer
    And Admin change general information of buyer "3901"
      | email                      | first_name | last_name | password  |
      | ngoctx+mailb01@podfoods.co | ngoctx     | mailb01   | 12345678a |

    Given BUYER open web user
    Given BUYER reset password
      | email                      | type  |
      | ngoctx+mailb01@podfoods.co | buyer |

   # Check mail sau khi admin change password buyer
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "Password Changed"
    And QA go to first email with title "Password Changed"
    And QA show trimmed content of email
    And QA verify info email reset password
      | email          |
      | ngoctx+mailb01 |

  @email21
  Scenario: Verify email new inventory registered by lp
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP go to create new inventory
    And LP create new inventory
      | distribution               | sku                 | quantity | lotCode             | receiveDate | expiryDate  | comment  |
      | Auto Ngoc Distribution CHI | AT SKU Inventory 13 | 1        | AT SKU Inventory 13 | currentDate | currentDate | Autotest |
    And LP create new inventory successfully

     # Check mail sau khi admin change password buyer
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with value "lp inventory lotcode"
    And QA go to first email with title "New inventory registered by LP"
    And QA show trimmed content of email
    And QA verify info email lp create new inventory
      | email | lp         | region              | brand                 | product             | sku                 | lotCode             | quantity | receivingDate | expiryDate  |
      | admin | ngoctx lp1 | Chicagoland Express | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 13 | AT SKU Inventory 13 | 1        | currentDate   | currentDate |

  @email22
  Scenario: Verify email buyer credit note
    Given NGOC_ADMIN_07 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_07 navigate to "Financial" to "Credit memos" by sidebar
    And Admin fill password to authen permission
    When Admin create credit memo with info
      | buyer                 | orderID | type              | amount | description      | file                 |
      | ngoctx ststate01chi01 | [blank] | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success
    And Admin send email to buyer of credit memo

       # Check mail sau khi credit memo send email to buyer
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with value "New credit note"
    And QA go to first email with title "New credit note"
    And QA show trimmed content of email
    And QA verify info email new credit note
      | email                 |
      | ngoctx+ststate01chi01 |

  @email23
  Scenario: Create new Sample Requests for buyers cancel
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    And Admin search product name "random product sample 24 api" by api
    And Admin delete product name "random product sample 24 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | random product sample 24 api | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random" of product ""
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | [blank]            | [blank]            |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state | comment |
      | 3314      | 3314     | [blank]     | 2582     | 1936              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           | comment |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Samples" by sidebar
    And Vendor search sample request on tab "All"
      | region              | store               | requestFrom | requestTo |
      | Chicagoland Express | Auto Store Chicago1 | currentDate | [blank]   |
    And Vendor check records sample request
      | requested   | number        | store               | brand                  | products                     | fulfillment |
      | currentDate | create by api | Auto Store Chicago1 | Auto Brand product mov | random product sample 24 api | Pending     |
    And Vendor go to sample detail of number: "by api"
    And Vendor Cancel sample request
      | reason | note      |
      | Other  | auto note |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    # Check mail sau khi tạo sample request duoc gui cho buyer
    And USER_EMAIL search email with value "sample request api"
    And QA go to detail email "sample request cancel"
    And QA verify info email sample request cancel

  @email24
  Scenario: Verify email vendor-store-refers-brand
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcreatebrand01chi01@podfoods.co" pass "12345678a" role "Buyer"
    And BUYER Go to Dashboard
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName          | email              | contact | currentBrand |
      | AT Brand Create 02 | ngoctx@podfoods.co | ngoctx  | true         |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |

    Given NGOC_ADMIN_22 open web admin
    When NGOC_ADMIN_22 login to web with role Admin
    And NGOC_ADMIN_22 navigate to "Brands" to "Brand referrals" by sidebar
    # verify search filter brand
    And Admin search brand referral with info
      | brand   | store                  | email   | contact | onboarded | vendorCompany |
      | [blank] | ngoctx stcreateBrand01 | [blank] | [blank] | [blank]   | [blank]       |
    And Admin go to brand referrals details
    And Admin choose brand, edit and mark as onboarded with vendor company "AT Create Brand vc 01"
      | choose | brand              |
      | Yes    | AT Brand Create 02 |

      # Check mail vendor-store-refers-brand
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with sender "ngoctx stcreateBrand01 wants AT Brand Create 02"
    And QA go to first email with title "ngoctx stcreateBrand01 wants AT Brand Create 02"
    # And QA show trimmed content of email
    And QA verify info email vendor-store-refers-brand
      | store                  |
      | ngoctx stcreateBrand01 |

  @email25
  Scenario: Verify email admin create buyer claim
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |

      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 2 04 | 47332              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109246             | 47332              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3563     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    And Admin create claims
      | type  | buyer                | store                | buyerCompany   | orderID       | subInvoice | issue    | description | adminNote  |
      | buyer | ngoctx stclaim1chi01 | ngoctx stclaim1chi01 | ngoc cpn claim | create by api | 1          | Shortage | Description | Admin Note |
    And Admin create claims success
    And Admin get claims id

      # Check mail admin create claim
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with title "admin create claim"
    And QA go to detail email "admin create claim"
    # And QA show trimmed content of email
    And QA verify info email new retail claim received
      | issue    | description |
      | Shortage | Description |

  @email26
  Scenario: Verify email admin create vendor claim
    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin go to create claims page
    And Admin fill info to create vendor claim
      | vendor             | region           | issue             | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | Issue Description | Admin Note |
    And Admin upload file to create vendor claim
      | uploadFile  |
      | anhJPEG.jpg |
    And Admin add sku to create vendor claim
      | sku               | quantity |
      | AT SKU Claim 2 01 | 2        |
    And Admin create vendor claim success
    And Admin get number of vendor claim in detail

      # Check mail admin create claim
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with title "admin create claim"
    And QA go to detail email "admin create claim"
    # And QA show trimmed content of email
    And QA verify info email new retail claim received
      | issue    | description | order   |
      | Shortage | Description | [blank] |

  @email27
  Scenario: Verify email vendor-donation-disposal-approved
    Given NGOCTX03 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inventory 31 | 59228              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create dispose request
    And Admin set inventory request items API
      | index | sku                 | inventory_id  | product_variant_id | request_case |
      | 1     | AT SKU Inventory 31 | create by api | 59228              | 1            |
    And Admin create dispose donate request by API
      | comment      | region_id | request_type | vendor_company_id |
      | Auto comment | 26        | disposal     | 1787              |
    # Approved Donate
    And Admin approved dispose donate request by API

    # Check mail admin approve donation approved
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with title "admin dispose donate"
    And QA go to detail email "admin dispose donate"
    And QA verify info email vendor-donation-disposal-approved
    # Check mail admin LP-disposal-request-approved
    And USER_EMAIL search email with sender "Disposal Request - AT Brand Inventory 01"
    And QA go to first email with title "Disposal Request - AT Brand Inventory 01"
    And QA verify info email LP-disposal-request-approved
      | region              | brand                 | product             | sku                 | itemCode | lotCode | quantity | expiryDate |
      | Chicagoland Express | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 31 | 59228    | [blank] | 1        | [blank]    |
    # Check mail admin Email: vendor-donation-disposal-complete
    And USER_EMAIL search email with title "dispose donate complete"
    And QA go to detail email "dispose donate complete"
    And QA verify info email vendor-donation-disposal-complete

    #
    # Verify email qa@podfoods.co
    #

  @emailQA01
  Scenario: Verify email create inbound
    Given NGOCTX20 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
      # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47269              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 53        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 121          |
    And Admin save inbound number by index "1"
    And Admin clear list sku inbound by API

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number        | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate |
      | create by api | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number "create by api"
    And Admin upload file to inbound
      | bol     | pod     |
      | [blank] | POD.pdf |
    And Admin submit incoming inventory
      | index | skuName        | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT SKU Claim 2 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search Inbound inventory
      | number        | brand   | start   | end     | deliveryMethod |
      | create by api | [blank] | [blank] | [blank] | [blank]        |
    And LP go to Inbound inventory detail of number "create by api"
    And LP upload Signed WPL with file "POD.pdf"
    And Admin wait 20000 mini seconds

    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    # Check mail sau khi tao inbound
    And USER_EMAIL search email with sender "AT Brand Claim 01 has reviewed replenishment request to New York Express"
    And QA go to first email with title "AT Brand Claim 01 has reviewed replenishment request to New York Express"
    And QA verify info email admin-initiated-inbound-inventory-confirmed
      | brand             |
      | AT Brand Claim 01 |
     # Check mail sau khi upload POD inbound
    And USER_EMAIL search email with value "upload inbound pod"
    And QA go to detail email "upload inbound pod"
    And QA verify info email upload inbound pod
      # Check mail sau khi upload WPL inbound
    And USER_EMAIL search email with value "upload inbound pod"
    And QA go to detail email "upload inbound wpl"
    And QA verify info email inbound upload WPL
      | lp         | vendorCompany   |
      | ngoctx lp1 | AT Vendor Order |

  @emailQA02
  Scenario: Verify email withdrawal send to admin
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product admin withdrawal 551 api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product admin withdrawal 551 api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product admin withdrawal 551 api 1" by api
    And Admin delete product name "random product admin withdrawal 551 api 1" by api
   # Create SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product admin withdrawal 551 api 1 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku admin withdrawal 551 api 1" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code                              | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random sku admin withdrawal 551 api 1 | 90           | Plus1        | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor28@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact     | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | data/BOL.pdf |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku                                   | lotCode                               | lotQuantity | max     |
      | 1     | random sku admin withdrawal 551 api 1 | random sku admin withdrawal 551 api 1 | 5           | [blank] |
    And Vendor click create withdrawal request

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand   | region  | request |
      | random | [blank]       | [blank] | [blank] | [blank] |
    And LP go to details withdrawal requests "create by api"
    And LP edit field in withdrawal requests detail
      | number | pickupDate | startTime | endTime |
      | random | Plus7      | 10:00     | 10:30   |
    And LP update success withdrawal request
    And LP complete withdrawal request in detail

    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    # Check mail sau khi vendor tạo withdrawal
    And USER_EMAIL search email with withdrawal "create by api"
    And QA go to detail email "approval needed withdrawal"
    And QA verify info email vendor create withdrawal request
      | brand             | region              |
      | AT Brand Claim 01 | Chicagoland Express |
     # Check mail sau khi lp edit pickup date and/or pickup time
    And USER_EMAIL search email with withdrawal "create by api"
    And QA go to detail email "new pickup appointment withdrawal"
    And QA verify info email vendor-inventory-withdrawal-time-update
      | pickupDate | pickupTime    |
      | Plus7      | 10:00 ~ 10:30 |
    # Check mail sau khi lp complete withdrawal
    And USER_EMAIL search email with withdrawal "create by api"
    And QA go to detail email "new pickup appointment withdrawal"
    And QA verify info email vendor-inventory-withdrawal-time-update
      | pickupDate | pickupTime    |
      | Plus7      | 10:00 ~ 10:30 |

  @emailQA04
  Scenario: Verify email create store
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Delete store
    When Admin search store by API
      | q[name]         | q[has_surcharge] | q[store_size] | q[store_type_id] | q[city] | q[state] | q[receiving_week_day] | q[region_ids] | q[route_id] |
      | ngoctx emails01 | [blank]          | [blank]       | [blank]          | [blank] | [blank]  | [blank]               | [blank]       | [blank]     |
    And Admin delete store "" by api
      # Create store by api
    And Admin create store by API
      | name            | email                       | region_id | time_zone                  | store_size | buyer_company_id | phone_number | city     | street1        | address_state_id | zip   | number | street           |
      | ngoctx emails01 | ngoctx+emails01@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2296             | 1234567890   | New York | 281 9th Avenue | 33               | 10001 | 1554   | West 18th Street |

    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    # Check mail sau khi admin tạo store
    And USER_EMAIL search email with withdrawal "ngoctx emails01"
    And QA go to detail email "New store created"
    And QA verify info email admin create store
      | email                  | store           | buyerCompany | region              | address                                   | managedBy     | launchedBy    | allPossibleDeliveryDays | setDeliveryDays | receivingTimes             | receivingNote | apEmail | sos |
      | ngoctx+666@podfoods.co | ngoctx emails01 | ngoc cpn1    | Chicagoland Express | 281 9th Avenue, New York, New York, 10001 | thuy_admin123 | thuy_admin123 | [blank]                 | [blank]         | Pacific Time (US & Canada) | [blank]       | [blank] | Yes |

  @emailQA03
  Scenario: Vendor email new purchase request
    Given BUYER open web user
    And Buyer go to "Catalog" from menu bar
    And Guest search product in catalog
      | typeSort                    | typeSearch | valueSearch       |
      | Order by Brand name — A > Z | product    | AT Brand Claim 01 |
    And Go to product detail "AT Brand Claim 01" from product list of Brand
    And Guest fill info wholesale pricing of product detail
      | firstName | lastName | email                       | storeName           | comment  | partner |
      | Auto      | Test     | ngoctx+autotest@podfoods.co | Auto Store Chicago1 | AutoTest | [blank] |
    And Guest choose sku in wholesale pricing of product detail
      | sku             |
      | AT SKU Claim 01 |
    And Guest create wholesale pricing success

    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    # Check mail tạo brand
    And USER_EMAIL search email with sender "New purchase request"
    And QA go to first email with title "New purchase request"
    And QA verify info email new purchase request
      | email                       |
      | ngoctx+autotest@podfoods.co |

  @emailQA05
  Scenario: Verify email Admin-payment-failure
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin go to process of vendor statement
     # chọn ngày cuối tháng
    And Admin search info in process of vendor statement
      | startDate | endDate  | filterAmount | amount  | ach | password  |
      | 09/24/23  | 09/30/23 | More than    | [blank] | No  | 12345678a |
    And Admin select vendor company in process of vendor statement
      | vendorCompany        |
      | AT Vendor Not Stripe |
    And Admin process of vendor statement

    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    # Check mail sau khi tạo sample request duoc gui cho buyer
    And USER_EMAIL search email with value "Vendor statement payments failed"
    And QA go to first email with title "Vendor statement payments failed"
    And QA verify info email vendor statement payments failed
      | vendorCompany        | message                                    |
      | AT Vendor Not Stripe | The vendor has not connected to stripe yet |

  @emailQA06
  Scenario: Verify email New POD uploaded in order
    Given NGOCTX05 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 150 | 32864              | 1        | random   | 90           | currentDate  | [blank]     | [blank] |

     # Create order of store 01
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 86996              | 32864              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3288     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
    # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |
    And Admin save sub-invoice of order "create by api" with index "1"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store             | fulFilledDate | order         | po      |
      | Ordered, Latest first | In progress  | ngoctx stOrder150 | [blank]       | create by api | [blank] |
    And LP go to order detail ""
    And LP upload Proof of Delivery file
      | POD.png |

    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    # Check mail sau khi tạo order được gửi cho buyer
    And USER_EMAIL search email with order "create by admin"
    And QA go to first email with title "New POD uploaded"
    And QA verify info email lp upload pod
      | lp         | store             |
      | ngoctx lp1 | ngoctx stOrder150 |

  @emailQA07
  Scenario: Verify email lp doc expired
    Given BAO_ADMIN7 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
    Then Admin search lp company by api
      | business_name           | contact_number | roles_name |
      | Auto Mail LP company 01 | [blank]        | [blank]    |
    And Admin delete lp company by api
    Then Admin create lp company by api
      | business_name           | contact_number | roles_name           |
      | Auto Mail LP company 01 | 0123456789     | driver , warehousing |

    Given BAO_ADMIN7 open web admin
    When BAO_ADMIN7 login to web with role Admin
    And BAO_ADMIN7 navigate to "Logistics Partners" to "LP companies" by sidebar
    And Admin search LP company
      | businessName            | contactNumber | roles   |
      | Auto Mail LP company 01 | 0123456789    | [blank] |
    And Admin go to detail of LP company and check information
      | businessName            | contactNumber | roles             |
      | Auto Mail LP company 01 | 0123456789    | DriverWarehousing |
    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Logistics Partners" to "LP companies" by sidebar
     # search with all criteria status
    And Admin search LP company
      | businessName            | contactNumber | roles   |
      | Auto Mail LP company 01 | [blank]       | [blank] |
    And Admin go to detail of LP company and check information
      | businessName            | contactNumber | roles             |
      | Auto Mail LP company 01 | 0123456789    | DriverWarehousing |
    # Edit
    And Admin upload documents for LP company
      | document    | documentName | startDate   | expiryDate  |
      | anhJPEG.jpg | Autotest     | currentDate | currentDate |

     #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "lp_doc_expired_reminder"

    # Check mail sau khi admin change password buyer
    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    And USER_EMAIL search email with sender "LP document has expired"
    And QA go to first email with title "LP document has expired"
#    And QA show trimmed content of email
    And QA verify info email lp document expired
      | lpCompany               | documentName |
      | Auto Mail LP company 01 | Autotest     |

  @emailQA08
  Scenario: Verify email lp doc expired
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcreatebrand01chi01@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName          | email              | contact | currentBrand |
      | AT Brand Create 02 | ngoctx@podfoods.co | ngoctx  | true         |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |

    Given NGOC_ADMIN_05 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_05 navigate to "Brands" to "Brand referrals" by sidebar
    # verify search filter brand
    And Admin search brand referral with info
      | brand   | store                  | email   | contact | onboarded | vendorCompany |
      | [blank] | ngoctx stcreateBrand01 | [blank] | [blank] | [blank]   | [blank]       |
    And Admin go to brand referrals details
    And Admin choose brand, edit and mark as onboarded with vendor company "AT Create Brand vc 01"
      | choose | brand              |
      | Yes    | AT Brand Create 02 |

      # Check mail sau khi admin referral a brand
    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    And USER_EMAIL search email with sender "ngoctx stcreateBrand01 referred a brand"
    And QA go to first email with title "ngoctx stcreateBrand01 referred a brand"
    # And QA show trimmed content of email
    And QA verify info email brand referred
      | store                  | brand              |
      | ngoctx stcreateBrand01 | AT Brand Create 02 |

    And USER_EMAIL search email with sender "Referred vendor has been onboarded"
    And QA go to first email with title "Referred vendor has been onboarded"
    And QA verify info email admin-store-refers-brand
      | store                  | brand              |
      | ngoctx stcreateBrand01 | AT Brand Create 02 |

  @emailQA09
  Scenario: Verify email create new and convert ghost order
    Given NGOCTX12 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order a 01 | 31645              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
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

    Given NGOC_ADMIN_12 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_12 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin search the ghost orders by info
      | ghostOrderNumber | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | region  | managed | startDate | endDate |
      | create by api    | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] |
    And Admin go to ghost order detail number "create by api"
    # Convert ghost order to real order
    And NGOC_ADMIN_12 convert ghost order to real order
       # Confirm convert ghost order to real order
    And Admin confirm convert ghost order to real order

      # Check mail sau khi admin referral a brand
    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    And USER_EMAIL search email with sender "New Ghost order placed"
    And QA go to first email with title "New Ghost order placed"
    # And QA show trimmed content of email
    And QA verify info email create new ghost order

    And USER_EMAIL search email with sender "Ghost order converted to regular order"
    And QA go to first email with title "Ghost order converted to regular order"
    # And QA show trimmed content of email
    And QA verify info email convert ghost order

  @emailQA10
  Scenario: Verify email admin create vendor claim
    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx+666@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin go to create claims page
    And Admin fill info to create vendor claim
      | vendor             | region           | issue             | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | Issue Description | Admin Note |
    And Admin upload file to create vendor claim
      | uploadFile  |
      | anhJPEG.jpg |
    And Admin add sku to create vendor claim
      | sku               | quantity |
      | AT SKU Claim 2 01 | 2        |
    And Admin create vendor claim success
    And Admin get number of vendor claim in detail

      # Check mail admin create claim
    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with title "qa create claim"
    And QA go to detail email "qa create claim"
    # And QA show trimmed content of email
    And QA verify info email new qa retail claim received
      | vendorCompany   | brand             | vendorEmail                        | issue             | issueDescription  |
      | AT Vendor Order | AT Brand Claim 01 | ngoctx+atvendororder01@podfoods.co | Damaged Inventory | Issue Description |

  @emailQA11
  Scenario: Verify email admin-donation-disposal-submitted
    Given NGOCTX03 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inventory 31 | 59228              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to create request dispose donate inventory
    And Vendor fill info request dispose donate
      | type                           | region              | comment      |
      | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor add inventory to request dispose
      | index | sku                 | lotCode | quantity |
      | 1     | AT SKU Inventory 31 | random  | 1        |
    And Vendor create request dispose success

   # Check mail admin approve donation approved
    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    And USER_EMAIL search email with title "Donation/Disposal request submitted"
    And QA go to first email with title "Donation/Disposal request submitted"
    And QA verify info email admin-donation-disposal-approved

  @emailQA12
  Scenario: Verify email pod-foods-data-export-ready (Vendor click "OK" when export Order detail)
    Given NGOCTX16 login web admin by api
      | email                  | password  |
      | ngoctx+666@podfoods.co | 12345678a |
     # Create SKU
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id |
      | random sku email 01 | 2944     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku email 01" of product ""
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code            | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 5        | random sku email 01 | 90           | Plus1        | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor28@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    And Vendor export inventory "Current status"

 # Check mail admin approve donation approved
    Given USER_EMAIL open login gmail with email "qa@podfoods.co" pass "12345678a"
    And USER_EMAIL search email with title "Daily finance files"
    And QA go to detail email "Daily finance files"
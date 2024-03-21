@feature=AdminDropSummary
Feature: Admin Drop Summary


  @AdminDropSummary_01 @AdminDropSummary
  Scenario: Admin create Drop summary with PO -> Admin add/remove sub-invoices to Drop -> Admin remove a Drop
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1900@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "47154" by api
    And Admin delete order of sku "47154" by api

     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 01 | 47154              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |

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
    When login to beta web with email "ngoctx1900@podfoods.co" pass "12345678a" role "Admin"
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
    And Admin clear selected in create drop action bar
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
    And Admin can not edit sos surcharge in create drop popup
      | index | order         | subInvoice |
      | 9     | create by api | 1          |
      | 10    | create by api | 1          |
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
    And Admin verify summary in create drop popup
      | store              | totalPayment | totalOrdered | vendorFee | totalWeight |
      | ngoctx stdropsum01 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum02 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum03 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum04 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
      | ngoctx stdropsum05 | $800.00      | $800.00      | $200.00   | 16.00 lbs   |
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | ngoctx stdropsum01 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum02 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum03 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum04 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum05 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
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
    And Admin verify detail drop in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta         | receivingNote | adminNote | buyerSpecialNote | action  |
      | 1     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 2     | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 3     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 4     | NY     | [blank] | ngoctx stdropsum02 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 5     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $30.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 6     | NY     | [blank] | ngoctx stdropsum03 | create by api | 1          | $0.00  | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 7     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $40.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 8     | NY     | [blank] | ngoctx stdropsum04 | create by api | 1          | $40.00 | $0.00 | $50.00       | $50.00       | $12.50    | 1.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 9     | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
      | 10    | NY     | [blank] | ngoctx stdropsum05 | create by api | 1          | $0.00  | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | currentDate | [blank]       | [blank]   | [blank]          | [blank] |
    And Admin verify history change sos of drop detail
      | index | order         | sub | value           | reason               | note      | updateBy        | updateOn    |
      | 1     | create by api | 1   | $30.00 → $0.00  | [blank]              | [blank]   | Admin: ngoctx19 | currentDate |
      | 2     | create by api | 1   | $30.00 → $0.00  | [blank]              | [blank]   | Admin: ngoctx19 | currentDate |
      | 7     | create by api | 1   | $30.00 → $40.00 | Drop total meets MOQ | Auto test | Admin: ngoctx19 | currentDate |
      | 8     | create by api | 1   | $30.00 → $40.00 | Drop total meets MOQ | Auto test | Admin: ngoctx19 | currentDate |
    # Add subinvoice to drop
    And Admin go to add subinvoice to drop of store in drop detail
      | store              | purchase |
      | ngoctx stdropsum01 | Yes      |
    # verify search sub invoice by order number
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 11    | create by api | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 11    | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $30.00 | $0.00 | $400.00      | $100.00   | 8.00 lbs    |
#      # verify search sub invoice by buyer
#    And Admin search the orders to add to drop
#      | index | orderNumber   | store   | buyer             | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
#      | 11    | create by api | [blank] | ngoctx bdropsum02 | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
#    Then Admin no found order in result
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 11    | create by api | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 11    | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $30.00 | $0.00 | $400.00      | $100.00   | 8.00 lbs    |

    And Admin choose orders to add to drop
      | index | orderNumber   | sub |
      | 11    | create by api | 1   |
    And Admin add order to drop success
    And Admin verify detail drop in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | 11    | NY     | [blank] | ngoctx stdropsum01 | create by api | 1          | $30.00 | $0.00 | $400.00      | $400.00      | $100.00   | 8.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
    # Delete subinvoice in drop
    And Admin delete subinvoice in drop
      | index | orderNumber   | sub |
      | 11    | create by api | 1   |
    And Admin delete drop of store
      | store              |
      | ngoctx stdropsum01 |
      | ngoctx stdropsum02 |
      | ngoctx stdropsum03 |
      | ngoctx stdropsum04 |
      | ngoctx stdropsum05 |
    # Add lại drop với PO
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
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
    And Admin create drop in drop summary
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | ngoctx stdropsum01 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum02 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum03 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum04 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
      | ngoctx stdropsum05 | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
    And Admin create drop with had PO in create drop popup
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
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $400.00    | $0.00    | $0.00 | Not applied         | $0.00              | $100.00          | $400.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress | [blank]     | Admin Note | LP Note |
    # Verify LP
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | index | orderBy               | fulFillState | store              | fulFilledDate | order | po      |
      | 1     | Ordered, Latest first | [blank]      | ngoctx stdropsum01 | [blank]       | index | [blank] |
    And LP go to order detail
      | index | order | store              |
      | 1     | drop  | ngoctx stdropsum01 |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer             | store              | address                                   | department | receivingWeekday | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | In progress | ngoctx bdropsum01 | ngoctx stdropsum01 | 281 9th Avenue, New York, New York, 10001 | [blank]    | [blank]          | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check Distribution
      | distributionCenter                            | distributionCenterName  |
      | 455 Madison Avenue, New York, New York, 10022 | Auto Distribute NewYork |
    And LP check line items
      | brand                      | product                      | sku                  | pack        | unitUPC                      | quantity | podConsignment  | storageCondition |
      | AT Brand A Drop Summary 01 | AT Product A Drop Summary 01 | AT SKU A Drop Sum 01 | 1 unit/case | Unit UPC / EAN: 180219900001 | 1        | Pod consignment | 1 day - Dry      |

  # viết tạm create multi order of headbuyer
  @AdminDropSummary_03 @AdminDropSummary
  Scenario: Create multi order of headbuyer
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1911@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "55682" by api
    And Admin delete order of sku "55682" by api
    # Delete promotion
    And Admin search promotion by Promotion Name "Admin Head Buyer Multi Order"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Admin Head Multi Order Sponsored"
    And Admin delete promotion by skuName ""
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name]      | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Multi Order Head 0101 | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Multi Order Head 0101" from API
    And Admin delete inventory "all" by API
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name]      | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Multi Order Head 0201 | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Multi Order Head 0201" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multi Order Head 0101 | 55682              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multi Order Head 0201 | 55684              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create promotion
    And Admin add region by API
      | region               | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express     | 53        | 55682 | 3361      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | Pod Direct Northeast | 55        | 55689 | 3362      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                         | description                  | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Admin Head Buyer Multi Order | Admin Head Buyer Multi Order | currentDate | currentDate | 1           | 2          | 1                | true           | [blank] | default    | [blank]       | false   |
    # Create promotion pod-sponsored
    And Admin add region by API
      | region               | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | New York Express     | 53        | [blank] | 3361      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
      | Pod Direct Northeast | 55        | [blank] | 3362      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty  |
      | PromotionActions::PercentageAdjustment | 0.1         | false | [blank] |
    And Admin create promotion by api with info
      | type                     | name                             | description                      | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | actionType | buy_in  | skuExpireDate |
      | Promotions::PodSponsored | Admin Head Multi Order Sponsored | Admin Head Multi Order Sponsored | currentDate | currentDate | 1000        | [blank]    | 1                | [blank]        | default    | [blank] | [blank]       |

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+hbbuyermultiorder01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Head buyer go to create multi order
    And Head buyer add store to create multi order
      | value                      |
      | ngoctx stbuyermultiorder01 |
      | ngoctx stbuyermultiorder02 |
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                          |
      | AT SKU Multi Order Head 0101 |
    And Head buyer verify info sku in add sku popup of create multi order
      | sku                          | product                          | brand                          | upc                       | skuID   |
      | AT SKU Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT Brand Multi Order Head 0101 | Unit UPC/EAN 180216540001 | # 55682 |
    And Head buyer add sku to create multi order
      | sku                          |
      | AT SKU Multi Order Head 0101 |
    And Head buyer search sku in add sku popup of create multi order
      | sku                          |
      | AT SKU Multi Order Head 0103 |
    And Head buyer add sku to create multi order
      | sku                          |
      | AT SKU Multi Order Head 0103 |
    And Head buyer search sku in add sku popup of create multi order
      | sku                          |
      | AT SKU Multi Order Head 0201 |
    And Head buyer add sku to create multi order
      | sku                          |
      | AT SKU Multi Order Head 0201 |
    And Head buyer add sku success to create multi order
    And Head buyer next to create multi order
    # Verify buyer 1
    And Head buyer change buyer of store "ngoctx stbuyermultiorder01" to buyer "ngoctx sbbuyermultiorder0101" order of create multi order
    And Head buyer verify item in order of store "ngoctx stbuyermultiorder01"
      | brand                          | product                          | sku                          | skuID | upc                          | unit        | oldPrice | price  | amount | error                                         |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0101 | 55682 | Unit UPC / EAN: 180216540001 | 1 unit/case | $10.00   | $9.00  | 1      | This item is not available to this sub-buyer. |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0103 | 55689 | Unit UPC / EAN: 180216540003 | 1 unit/case | $20.00   | $18.00 | 1      | This item is not available to this sub-buyer. |
      | AT Brand Multi Order Head 0201 | AT Product Multi Order Head 0201 | AT SKU Multi Order Head 0201 | 55684 | Unit UPC / EAN: 182098409001 | 1 unit/case | [blank]  | $10.00 | 1      | This item is not available to this sub-buyer. |
    And Head buyer verify cart summary of buyer "ngoctx stbuyermultiorder01" in create multi order
      | orderValue | promotion | subTotal | sos    | specialDiscount | taxes | total  |
      | $40.00     | -$3.00    | $37.00   | $30.00 | -$3.70          | $1.00 | $64.30 |
     # Verify buyer 2
    And Head buyer change buyer of store "ngoctx stbuyermultiorder02" to buyer "ngoctx sbbuyermultiorder0201" order of create multi order
    And Head buyer verify item in order of store "ngoctx stbuyermultiorder02"
      | brand                          | product                          | sku                          | skuID | upc                          | unit        | oldPrice | price  | amount | error                                         |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0101 | 55682 | Unit UPC / EAN: 180216540001 | 1 unit/case | $10.00   | $9.00  | 1      | This item is not available to this sub-buyer. |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0103 | 55689 | Unit UPC / EAN: 180216540003 | 1 unit/case | $20.00   | $18.00 | 1      | This item is not available to this sub-buyer. |
      | AT Brand Multi Order Head 0201 | AT Product Multi Order Head 0201 | AT SKU Multi Order Head 0201 | 55684 | Unit UPC / EAN: 182098409001 | 1 unit/case | [blank]  | $10.00 | 1      | This item is not available to this sub-buyer. |
    And Head buyer verify cart summary of buyer "ngoctx stbuyermultiorder02" in create multi order
      | orderValue | promotion | subTotal | sos    | specialDiscount | taxes | total  |
      | $40.00     | -$3.00    | $37.00   | $30.00 | -$3.70          | $1.00 | $64.30 |
    And Head buyer change buyer of store "ngoctx stbuyermultiorder01" to buyer "ngoctx bbuyermultiorder0101" order of create multi order
    And Head buyer change buyer of store "ngoctx stbuyermultiorder02" to buyer "ngoctx bbuyermultiorder0201" order of create multi order
    And HEAD_BUYER wait 2000 mini seconds
    And Head buyer create all orders

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1911@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "All orders" by sidebar
    # verify order 1
    And Admin search the orders by info
      | orderNumber | orderSpecific | store   | buyer                       | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | not         | [blank]       | [blank] | ngoctx bbuyermultiorder0101 | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    And Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                       | store                      | customStore | creator                    | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | New York Express | ngoctx bbuyermultiorder0101 | ngoctx stbuyermultiorder01 | [blank]     | ngoctx hbbuyermultiorder01 | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | vendorServiceFee | total  |
      | $40.00     | $3.00    | $1.00 | $30.00              | $0.00              | $3.70           | $40.00           | $64.30 |
    And Admin check line items "sub invoice" in order details
      | brand                          | product                          | sku                          | unitCase     | casePrice | quantity | endQuantity | total  | skuID | oldTotal | additionalFee |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0101 | 1 units/case | $10.00    | 1        | 8           | $9.00  | 55682 | $10.00   | 100.00%       |
      | AT Brand Multi Order Head 0201 | AT Product Multi Order Head 0201 | AT SKU Multi Order Head 0201 | 1 units/case | $10.00    | 1        | 8           | $10.00 | 55684 | [blank]  | [blank]       |
    And Admin check line items "non invoice" in order details
      | brand                          | product                          | sku                          | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0103 | 1 units/case | $20.00    | 1        | [blank]     | $18.00 | $20.00   |
    Then Verify pod consignment and preferment warehouse is "Auto Distribute NewYork"
     # verify order 2
    And NGOC_ADMIN_19 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber | orderSpecific | store   | buyer                       | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | not         | [blank]       | [blank] | ngoctx bbuyermultiorder0201 | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    And Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                       | store                      | customStore | creator                    | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | New York Express | ngoctx bbuyermultiorder0201 | ngoctx stbuyermultiorder02 | [blank]     | ngoctx hbbuyermultiorder01 | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | vendorServiceFee | total  |
      | $40.00     | $0.00    | $1.00 | $30.00              | $0.00              | $4.00           | $40.00           | $67.00 |
    And Admin check line items "sub invoice" in order details
      | brand                          | product                          | sku                          | unitCase     | casePrice | quantity | endQuantity | total  | skuID | additionalFee |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0101 | 1 units/case | $10.00    | 1        | 8           | $10.00 | 55682 | 100.00%       |
      | AT Brand Multi Order Head 0201 | AT Product Multi Order Head 0201 | AT SKU Multi Order Head 0201 | 1 units/case | $10.00    | 1        | 8           | $10.00 | 55684 | [blank]       |
    And Admin check line items "non invoice" in order details
      | brand                          | product                          | sku                          | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Multi Order Head 0101 | AT Product Multi Order Head 0101 | AT SKU Multi Order Head 0103 | 1 units/case | $20.00    | 1        | [blank]     | $20.00 |
    Then Verify pod consignment and preferment warehouse is "Auto Distribute NewYork"

  @AdminDropSummary_04 @AdminDropSummary
  Scenario: Admin create Drop summary with In-process PO
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1902@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 02 | 64414              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3849     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3849     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1902@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 2        | $20.00       | $20.00             | $5.00            | 2.00 lbs    |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | ngoctx stdropsum06 | Auto Ngoc LP Mix 01 | [blank]         | In progress      | [blank] | Admin Note | LP Note |
    And Admin create drop in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum06 | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
    And Admin verify drop in drop summary
      | region  | route   | store              | order   | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | [blank] | [blank] | ngoctx stdropsum06 | [blank] | [blank]    | $60.00 | $0.00 | $20.00       | $20.00       | $5.00     | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
    And Admin choose drop of store "ngoctx stdropsum06" in drop result
    And Admin verify create purchase order in drop summary
      | selected | totalPayment | vendorFee |
      | 1        | $20.00       | $5.00     |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress | [blank]     | Admin Note | LP Note |

  @AdminDropSummary_05 @AdminDropSummary
  Scenario: Admin create drop with multi subinvoice has total more than sos
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1903@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 02 | 64414              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 03 | 64416              | 55       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
      | 132368             | 64416              | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3850     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Set invoice
    And Admin set Invoice by API
      | skuName              | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Drop Sum 03 | 64416 | create by api | [blank]  | pending       | 2      |

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1903@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum07 | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos   | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $0.00 | $0.00 | $10.00       | $510.00      | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 1     | NY     | [blank] | ngoctx stdropsum07 | create by api | 2          | $0.00 | $0.00 | $500.00      | $510.00      | $125.00   | 50.00 lbs   | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 1     | create by api | 2          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 2        | $510.00      | $510.00            | $127.50          | 51.00 lbs   |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos   | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $0.00 | $0.00 | $10.00       | $510.00      | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 1     | NY     | [blank] | ngoctx stdropsum07 | create by api | 2          | $0.00 | $0.00 | $500.00      | $510.00      | $125.00   | 50.00 lbs   | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | ngoctx stdropsum07 | Auto Ngoc LP Mix 01 | [blank]         | In progress      | [blank] | Admin Note | LP Note |
    And Admin edit sos surcharge in create drop popup
      | index | order         | subInvoice | sosValue | reason               | additionNote |
      | 1     | create by api | 1          | 30       | Drop total meets MOQ | Auto test    |
    And Admin apply sos suggestions of store in create drop popup
      | store              | reason               | additionNote |
      | ngoctx stdropsum07 | Drop total meets MOQ | Auto test    |
    And Admin create drop in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum07 | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum07 |
    And Admin verify drop in drop summary
      | region  | route   | store              | order   | subInvoice | sos   | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | [blank] | [blank] | ngoctx stdropsum07 | [blank] | [blank]    | $0.00 | $0.00 | $510.00      | $510.00      | $127.50   | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
    And Admin choose drop of store "ngoctx stdropsum07" in drop result
    And Admin verify create purchase order in drop summary
      | selected | totalPayment | vendorFee |
      | 1        | $510.00      | $127.50   |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $510.00    | $0.00    | $0.00 | Not applied         | $0.00              | $127.50          | $510.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress | [blank]     | Admin Note | LP Note |

  @AdminDropSummary_05a @AdminDropSummary
  Scenario: Admin create drop with PO only Driver
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1904@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 03 | 64416              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3851     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3851     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1904@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum07ny02 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 2        | $20.00       | $20.00             | $5.00            | 2.00 lbs    |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | ngoctx stdropsum07 | Auto Ngoc LP Mix 01 | [blank]         | In progress      | [blank] | Admin Note | LP Note |
    And Admin create drop in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer                 | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum07 | ngoctx bdropsum07ny02 | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum07 |
    And Admin verify drop in drop summary
      | region  | route   | store              | order   | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | [blank] | [blank] | ngoctx stdropsum07 | [blank] | [blank]    | $60.00 | $0.00 | $20.00       | $20.00       | $5.00     | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
    And Admin choose drop of store "ngoctx stdropsum07" in drop result
    And Admin verify create purchase order in drop summary
      | selected | totalPayment | vendorFee |
      | 1        | $20.00       | $5.00     |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | In progress | [blank]     | Admin Note | LP Note |

     # Verify LP
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | index | orderBy               | fulFillState | store              | fulFilledDate | order | po      |
      | 1     | Ordered, Latest first | [blank]      | ngoctx stdropsum07 | [blank]       | index | [blank] |
    And LP go to order detail
      | index | order | store              |
      | 1     | drop  | ngoctx stdropsum07 |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer                 | store              | address                                   | department | receivingWeekday | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | In progress | ngoctx bdropsum07ny02 | ngoctx stdropsum07 | 281 9th Avenue, New York, New York, 10001 | [blank]    | [blank]          | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check Distribution
      | distributionCenter                            | distributionCenterName  |
      | 455 Madison Avenue, New York, New York, 10022 | Auto Distribute NewYork |
    And LP check line items
      | brand                      | product                      | sku                  | pack        | unitUPC                      | quantity | podConsignment  | storageCondition |
      | AT Brand A Drop Summary 02 | AT Product A Drop Summary 02 | AT SKU A Drop Sum 02 | 1 unit/case | Unit UPC / EAN: 124125125001 | 2        | Pod consignment | 1 day - Dry      |
    And USER_LP log out

  @AdminDropSummary_06 @AdminDropSummary
  Scenario: Admin verify button "Use this info for all drops"
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1905@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 03 | 64416              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3853     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Create order of store 07
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3852     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1905@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum07ny03 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 2     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 2     | create by api | 1          |
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny02 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 2        | $20.00       | $20.00             | $5.00            | 2.00 lbs    |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum07 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    # Verify field of create po in create drop
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod       | adminNote  | lpNote  |
      | ngoctx stdropsum06 | Auto Ngoc LP Mix 01 | currentDate     | Unconfirmed      | claim.jpg | Admin Note | LP Note |
    And Admin use this info for all drops of store "ngoctx stdropsum06" in create drop popup
    And Admin verify po after copy of store in create drop summary
      | store              | driver              | fulfillmentDate | fulfillmentState | pod       | adminNote  | lpNote  |
      | ngoctx stdropsum06 | Auto Ngoc LP Mix 01 | currentDate     | Unconfirmed      | claim.jpg | Admin Note | LP Note |
    And Admin create drop in create drop popup

    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer                 | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum06 | ngoctx bdropsum06ny02 | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
    And Admin verify drop in drop summary
      | region  | route   | store              | order   | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | [blank] | [blank] | ngoctx stdropsum06 | [blank] | [blank]    | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
    And Admin choose drop of store "ngoctx stdropsum06" in drop result
    And Admin verify create purchase order in drop summary
      | selected | totalPayment | vendorFee |
      | 1        | $10.00       | $2.50     |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled | currentDate | Admin Note | LP Note |
    And Admin switch back to drop

    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer                 | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum07 | ngoctx bdropsum07ny03 | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum07 |
    And Admin verify drop in drop summary
      | region  | route   | store              | order   | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | [blank] | [blank] | ngoctx stdropsum07 | [blank] | [blank]    | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
    And Admin choose drop of store "ngoctx stdropsum07" in drop result
    And Admin verify create purchase order in drop summary
      | selected | totalPayment | vendorFee |
      | 1        | $10.00       | $2.50     |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 2     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status    | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled | currentDate | Admin Note | LP Note |

  @AdminDropSummary_07 @AdminDropSummary
  Scenario: Admin verify button "Use this info for all drops"
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1906@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 03 | 64416              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3854     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Create order of store 07
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3854     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1906@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny03 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 2        | $20.00       | $20.00             | $5.00            | 2.00 lbs    |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    # Verify field of create po in create drop
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | ngoctx stdropsum06 | Auto Ngoc LP Mix 01 | [blank]         | Unconfirmed      | [blank] | Admin Note | LP Note |
    And Admin create drop in create drop popup
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |

    # Verify LP
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | index | orderBy               | fulFillState | store              | fulFilledDate | order | po      |
      | 1     | Ordered, Latest first | [blank]      | ngoctx stdropsum06 | [blank]       | index | [blank] |
    And LP go to order detail
      | index | order | store              |
      | 1     | drop  | ngoctx stdropsum06 |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer                 | store              | address                                   | department | receivingWeekday | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | Unconfirmed | ngoctx bdropsum06ny03 | ngoctx stdropsum06 | 281 9th Avenue, New York, New York, 10001 | [blank]    | [blank]          | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check Distribution
      | distributionCenter                            | distributionCenterName  |
      | 455 Madison Avenue, New York, New York, 10022 | Auto Distribute NewYork |
    And LP check line items
      | brand                      | product                      | sku                  | pack        | unitUPC                      | quantity | podConsignment  | storageCondition |
      | AT Brand A Drop Summary 02 | AT Product A Drop Summary 02 | AT SKU A Drop Sum 02 | 1 unit/case | Unit UPC / EAN: 124125125001 | 2        | Pod consignment | 1 day - Dry      |
    And LP confirm order unconfirmed then verify status is "In progress"
    And LP set fulfillment order from admin with date "<date>"
    And LP upload Proof of Delivery file
      | POD.png |
    And LP check alert message
      | Fulfillment details updated successfully. |
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer                 | store              | address                                   | department | receivingWeekday | receivingTime | route   | adminNote  | lpNote  | fulfillmentDate |
      | currentDate | Fulfilled   | ngoctx bdropsum06ny03 | ngoctx stdropsum06 | 281 9th Avenue, New York, New York, 10001 | [blank]    | [blank]          | [blank]       | [blank] | Admin Note | LP Note | [blank]         |
    And LP check pod uploaded
      | name                     | file    |
      | PoD_Auto_Ngoc_LP_Mix_01_ | POD.png |

  @AdminDropSummary_08 @AdminDropSummary
  Scenario: Admin creates Drop for 2 sub-invoices with 2 POs belonging to 2 different LP companies
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1907@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 03 | 64416              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3855     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Create purchase order
    And Admin create purchase order of sub-invoice "index_1" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | Admin Note | LP Note                | [blank]                        | 99                   |

     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132366             | 64414              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3855     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"
     # Create purchase order
    And Admin create purchase order of sub-invoice "index_2" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | Admin Note | LP Note                | [blank]                        | 101                  |

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1907@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny04 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 2        | $20.00       | $20.00             | $5.00            | 2.00 lbs    |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin create drop with had PO in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny04 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | Admin Note | LP Note |
    And Admin switch back to drop

    And Admin go to order from drop detail
      | index | order         | sub |
      | 2     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 03 | Unconfirmed | [blank]     | Admin Note | LP Note |

  @AdminDropSummary_09 @AdminDropSummary
  Scenario: Admin creates Drop for 2 sub-invoices with line items belonging to the same LP Warehouse
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1908@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 03 | 64416              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 04 | 64426              | 5        | random   | 158          | currentDate  | [blank]     | [blank] |

    # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132368             | 64416              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3856     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132378             | 64426              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3856     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1908@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny05 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
    And Admin verify popup create drop in drop summary
      | selected | totalPayment | totalOrderedAmount | vendorServiceFee | totalWeight |
      | 2        | $20.00       | $20.00             | $5.00            | 2.00 lbs    |
    And Admin create drop in drop summary
    # Verify in create drop popup
    And Admin verify sub-invoices in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote |
      | 1     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          |
    And Admin create PO in create drop popup
      | store              | driver              | fulfillmentDate | fulfillmentState | pod     | adminNote  | lpNote  |
      | ngoctx stdropsum06 | Auto Ngoc LP Mix 01 | [blank]         | Unconfirmed      | [blank] | Admin Note | LP Note |
    And Admin create drop in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny05 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | Admin Note | LP Note |
    And Admin switch back to drop

    And Admin go to order from drop detail
      | index | order         | sub |
      | 2     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | Admin Note | LP Note |
#      # Update purchase order in progress to unconfirmed
#    When Admin edit purchase order of order "create by api" with info
#      | sub | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
#      | 1   | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin remove purchase order of order "create by api" of sub "1" with info

  @AdminDropSummary_10 @AdminDropSummary
  Scenario: Create PO (in-progress, fulfilled and have Fulfillment date) for drop which has at least a sub-invoice selected is lock/paid
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1909@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 05 | 64429              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
 # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum a05 | 64431              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132381             | 64429              | 1        | false     | [blank]          |
      | 132383             | 64431              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3857     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
      # Set invoice
    And Admin set Invoice by API
      | skuName               | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU A Drop Sum a05 | 64431 | create by api | [blank]  | pending       | 2      |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName              | skuId | order_id      | fulfilled |
      | 1     | AT SKU A Drop Sum 05 | 64429 | create by api | true      |

    Given NGOC_ADMIN_1909 open web admin
    When login to beta web with email "ngoctx1909@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1909 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber   | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | create by api | [blank] | ngoctx bdropsum06ny06 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 1     | create by api | 2          |

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx1910@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store              | buyer                 | statementMonth | region  | managedBy |
      | [blank]      | ngoctx stdropsum06 | ngoctx bdropsum06ny06 | [blank]        | [blank] | [blank]   |
    And Admin go to detail of store statement "ngoctx stdropsum06"
    When Admin add record payment
      | sub | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | 1   | index1  | 40            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    When Admin add record payment success

    And Switch to actor NGOC_ADMIN_1909
    And Admin create drop in drop summary
    And Admin create drop in create drop popup

  @AdminDropSummary_11 @AdminDropSummary
  Scenario: Admins create a drop that consist of sub-invs of which POs are assigned to different LPs
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1910@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 05 | 64429              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum a05 | 64431              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132381             | 64429              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3862     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
   # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | Admin Note | LP Note                | [blank]                        | 99                   |

        # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132383             | 64431              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3862     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"
  # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | Admin Note | LP Note                | [blank]                        | 101                  |

    Given NGOC_ADMIN_1909 open web admin
    When login to beta web with email "ngoctx1910@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1909 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny07 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
    And Admin create drop in drop summary
    And Admin create drop with had PO in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny07 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $40.00 |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote  | lpNote  |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | Admin Note | LP Note |

  @AdminDropSummary_12 @AdminDropSummary
  Scenario: Admin deletes orders of the drop - Drop has only 1 sub-invoice
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1911@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum a05 | 64431              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132381             | 64429              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3862     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"

    Given NGOC_ADMIN_1909 open web admin
    When login to beta web with email "ngoctx1911@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1909 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny07 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
    And Admin create drop in drop summary

    And Admin create drop in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny07 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |

    And Admin remove sub-invoice with info
      | index | skuName              | type    | subinvoice    |
      | 1     | AT SKU A Drop Sum 05 | express | create by api |

    And Admin switch back to drop
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny07 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin verify sub invoice not found in drop of drop summary
      | index | store              | order         | subInvoice |
      | 1     | ngoctx stdropsum01 | create by api | 1          |

    And NGOC_ADMIN_1909 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    And Admin delete order by order number by info
      | orderNumber   | reason           | note    | passkey |
      | create by api | Buyer adjustment | [blank] | [blank] |

    And NGOC_ADMIN_1909 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny07 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify drop not found in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |

  @AdminDropSummary_13 @AdminDropSummary
  Scenario: Admin deletes orders of the drop - * Drop has multiple sub-invoices belong to multiple orders
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1912@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 05 | 64429              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum a05 | 64431              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132381             | 64429              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3863     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"

        # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132383             | 64431              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3863     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"

    Given NGOC_ADMIN_1909 open web admin
    When login to beta web with email "ngoctx1912@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1909 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny08 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
      | 2     | create by api | 1          |
    And Admin create drop in drop summary
    And Admin create drop in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny08 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
    And Admin go to order from drop detail
      | index | order         | sub |
      | 1     | create by api | 1   |
    And Admin delete order from order detail
      | reason           | note     | showEdit | passkey |
      | Buyer adjustment | Autotest | Yes      | [blank] |

    And Admin switch back to drop
    And Admin go to order from drop detail
      | index | order         | sub |
      | 2     | create by api | 1   |
    And Admin delete order from order detail
      | reason           | note     | showEdit | passkey |
      | Buyer adjustment | Autotest | Yes      | [blank] |

    And Admin switch back to drop
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny08 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify drop not found in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |

  @AdminDropSummary_14 @AdminDropSummary
  Scenario: Admin verify add sub invoice to drop
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1912@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Drop Sum 05 | 64429              | 5        | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132381             | 64429              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3864     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"

     # Create order of store 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132381             | 64429              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3864     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"
  # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | Admin Note | LP Note                | [blank]                        | 101                  |

    Given NGOC_ADMIN_1909 open web admin
    When login to beta web with email "ngoctx1912@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1909 navigate to "Orders" to "Drop summary" by sidebar
    And Admin search the orders in drop summary by info
      | orderNumber | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | [blank] | ngoctx bdropsum06ny09 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin select sub-invoices in drop summary
      | index | order         | subInvoice |
      | 1     | create by api | 1          |
    And Admin create drop in drop summary
    And Admin create drop in create drop popup
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer                 | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | [blank]     | ngoctx stdropsum06 | ngoctx bdropsum06ny09 | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin expand drop in drop summary
      | index |
      | 1     |
    And Admin get number of drop in drop summary
      | index | store              |
      | 1     | ngoctx stdropsum06 |
        # Add subinvoice to drop
    And Admin go to add subinvoice to drop of store in drop detail
      | store              | purchase |
      | ngoctx stdropsum06 | No       |
    # verify search sub invoice by order number
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
      # verify search sub invoice by buyer
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | ngoctx bdropsum06ny08 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer                 | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | ngoctx bdropsum06ny09 | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
   # verify search sub invoice by buyer company
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | ngoc cpn1    | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany         | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | ngoc cpn a order sum | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by vendor company
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany        | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | ngoctx vcstatement01 | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany         | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | AT Product A Order 01 | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
  # verify search sub invoice by brand
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 01 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand                      | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | AT Brand A Drop Summary 02 | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by fulfillment
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment  | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | Awaiting POD | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | Pending     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by region
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region              | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | Chicagoland Express | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region           | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | New York Express | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by route
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route        | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | Auto Route 1 | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route      | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | Unassigned | [blank]   | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by start date
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | Plus1     | [blank] | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate   | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | currentDate | [blank] | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by end date
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | Minus1  | [blank] | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate     | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | currentDate | [blank] | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by temperature
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp         | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | Refrigerated | [blank] | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | Dry  | [blank] | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by OOS
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | Yes | [blank]   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | No  | [blank]   |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    # verify search sub invoice by express progress
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | Pending   |
    Then Admin verify order not found in add to drop
    And Admin search the orders to add to drop
      | index | orderNumber   | store   | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess  |
      | 2     | create by api | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | Dispatched |
    And Admin verify sub-invoices in add to drop popup
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | vendorFee | totalWeight |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $2.50     | 1.00 lbs    |
    And Admin choose orders to add to drop
      | index | orderNumber   | sub |
      | 2     | create by api | 1   |
    And Admin add order to drop success
    And Admin verify detail drop in drop summary
      | index | region | route   | store              | order         | subInvoice | sos    | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  |
      | 2     | NY     | [blank] | ngoctx stdropsum06 | create by api | 1          | $30.00 | $0.00 | $10.00       | $10.00       | $2.50     | 1.00 lbs    | [blank] | [blank]       | [blank]   | [blank]          | [blank] |
  # bug ko save được filter
  @AdminDropSummary_15
  Scenario: Verify edit visibility search in admin drop summary
    Given NGOCTX07 login web admin by api
      | email                 | password  |
      | ngoctx732@podfoods.co | 12345678a |
    # Reset search filter full textbox
    And Admin filter visibility with id "35" by api
      | q[store_id]               |
      | q[buyer_id]               |
      | q[buyer_company_id]       |
      | q[vendor_company_id]      |
      | q[brand_id]               |
      | q[fulfillment_states]     |
      | q[region_id]              |
      | q[route_id]               |
      | start_date                |
      | end_date                  |
      | q[temperature_name]       |
      | q[has_out_of_stock_items] |
      | q[express_progresses]     |
      | q[number]                 |

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx732@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderNumber | buyer   | vendorCompany | fulfillment | route   | endDate | oos     | store   | buyercompany | brand   | region  | startDate | temperature | expressProgress |
      | [blank]     | [blank] | [blank]       | [blank]     | [blank] | [blank] | [blank] | [blank] | [blank]      | [blank] | [blank] | [blank]   | [blank]     | [blank]         |
    Then Admin verify field search uncheck all in edit visibility
      | orderNumber | buyer   | vendorCompany | fulfillment | route   | endDate | oos     | store   | buyercompany | brand   | region  | startDate | temperature | expressProgress |
      | [blank]     | [blank] | [blank]       | [blank]     | [blank] | [blank] | [blank] | [blank] | [blank]      | [blank] | [blank] | [blank]   | [blank]     | [blank]         |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | orderNumber | buyer   | vendorCompany | fulfillment | route   | endDate | oos     | store   | buyercompany | brand   | region  | startDate | temperature | expressProgress |
      | [blank]     | [blank] | [blank]       | [blank]     | [blank] | [blank] | [blank] | [blank] | [blank]      | [blank] | [blank] | [blank]   | [blank]     | [blank]         |
    Then Admin verify field search in edit visibility
      | orderNumber | buyer   | vendorCompany | fulfillment | route   | endDate | oos     | store   | buyercompany | brand   | region  | startDate | temperature | expressProgress |
      | [blank]     | [blank] | [blank]       | [blank]     | [blank] | [blank] | [blank] | [blank] | [blank]      | [blank] | [blank] | [blank]   | [blank]     | [blank]         |
    # Verify save new filter
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer                 | buyerCompany     | vendorCompany | brand                      | fulfillment | region              | route      | startDate   | endDate     | temp | oos | exProcess |
      | 124123123   | ngoctx stdropsum01 | ngoctx bdropsum06ny09 | ngoc cpn b order | ngoc vc 1     | AT Brand A Drop Summary 01 | Pending     | Chicagoland Express | Unassigned | currentDate | currentDate | Dry  | Yes | Pending   |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | orderNumber | store              | buyer                 | buyerCompany     | vendorCompany | brand                      | fulfillment | region              | route      | startDate   | endDate     | temp | oos | exProcess |
      | 124123123   | ngoctx stdropsum01 | ngoctx bdropsum06ny09 | ngoc cpn b order | ngoc vc 1     | AT Brand A Drop Summary 01 | Pending     | Chicagoland Express | Unassigned | currentDate | currentDate | Dry  | Yes | Pending   |
    # Verify save as filter
    And Admin search the orders in drop summary by info
      | orderNumber | store              | buyer                 | buyerCompany        | vendorCompany | brand                      | fulfillment | region          | route      | startDate   | endDate     | temp         | oos | exProcess  |
      | 12412312512 | ngoctx stdropsum02 | ngoctx bdropsum06ny08 | ngoc cpn b checkout | ngoc vc2      | AT Brand A Drop Summary 02 | Pending     | Atlanta Express | Unassigned | currentDate | currentDate | Refrigerated | No  | Dispatched |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | orderNumber | store              | buyer                 | buyerCompany        | vendorCompany | brand                      | fulfillment | region          | route      | startDate   | endDate     | temp         | oos | exProcess  |
      | 12412312512 | ngoctx stdropsum02 | ngoctx bdropsum06ny08 | ngoc cpn b checkout | ngoc vc2      | AT Brand A Drop Summary 02 | Pending     | Atlanta Express | Unassigned | currentDate | currentDate | Refrigerated | No  | Dispatched |

    Given NGOC_ADMIN_19A open web admin
    When login to beta web with email "ngoctx733@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19A navigate to "Orders" to "Drop summary" by sidebar
    And Admin fill password to authen permission
    When Admin search store statements
      | buyerCompany | store   | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | [blank] | [blank] | [blank]        | [blank] | [blank]   |
    Then Admin verify filter "AutoTest1" is not display

    And Switch to actor NGOC_ADMIN_07
    And Admin delete filter preset is "AutoTest1"
    Then Admin verify filter "AutoTest1" is not display

    Given NGOC_ADMIN_19 open web admin
    When login to beta web with email "ngoctx732@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_19 navigate to "Orders" to "Drop summary" by sidebar
    When Admin search store statements
      | buyerCompany | store   | buyer   | statementMonth | region  | managedBy |
      | ngoc cpn1    | [blank] | [blank] | [blank]        | [blank] | [blank]   |
    Then Admin verify filter "AutoTest1" is not display
#
#    # check flow space của sprout
#  @FlowSpace_01 @AdminDropSummary
#  Scenario: Admin verify drop flow space
#    Given NGOCTX19 login web admin by api
#      | email                  | password  |
#      | ngoctx1900@podfoods.co | 12345678a |
#    # Delete order
#    When Search order by sku "71121" by api
#    And Admin delete order of sku "71121" by api
#
#     # Create inventory
#    And Admin create inventory api1
#      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU Flow Space 01 | 71121              | 5        | random   | 160          | currentDate  | [blank]     | [blank] |
#
#    # Create order of store 01
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | 141755             | 71121              | 1        | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3931     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
#    And Admin clear line items attributes by API
#    And Admin save order number by index "1"
#    And Admin save sub-invoice of order "create by api" with index "1"
#      | subInvoice |
#      | 1          |
#     # Create order of store 01
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | 141755             | 71121              | 1        | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3931     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
#    And Admin clear line items attributes by API
#    And Admin save order number by index "2"
#    And Admin save sub-invoice of order "create by api" with index "2"
#      | subInvoice |
#      | 1          |
#    # Create drop
#    And Admin create drop by API
#      | index | sub | drop | subAtt | store | sos  |
#      | 1     | 1   | 0    | 0      | 3804  | 3000 |
#      | 2     | 1   | 0    | 1      | 3804  | 3000 |
#
#    # Lấy drop number
#    Given NGOC_ADMIN_1909 open web admin
#    When login to beta web with email "ngoctx1912@podfoods.co" pass "12345678a" role "Admin"
#    And NGOC_ADMIN_1909 navigate to "Orders" to "Drop summary" by sidebar
#    And Admin search the orders in drop summary by info
#      | orderNumber   | store           | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
#      | create by api | AT SproutsATL01 | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
#    And Admin expand drop in drop summary
#      | index |
#      | 1     |
#    And Admin get number of drop in drop summary
#      | index | store           |
#      | 1     | AT SproutsATL01 |
#    # Create purchase order cho drop
#    And Admin choose drop of store "AT SproutsATL01" in drop result
#    And Admin create purchase order in drop summary
#      | driver              | fulfillmentDate | fulfillmentState | proof   | adminNote  | lpNote  |
#      | Auto Ngoc LP Mix 01 | currentDate     | [blank]          | [blank] | Admin Note | LP Note |
#    And Admin search the orders in drop summary by info
#      | orderNumber   | store           | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
#      | create by api | AT SproutsATL01 | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
#    And Admin expand drop in drop summary
#      | index |
#      | 1     |
#    # Verify flowspace status
#    And Admin verify drop in drop summary
#      | region  | route   | store           | order   | subInvoice | sos   | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  | flowSpace |
#      | [blank] | [blank] | AT SproutsATL01 | [blank] | [blank]    | $0.00 | $0.00 | $800.00      | $800.00      | $200.00   | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] | Created   |
#    # Verify bên flow space
#    Given FLOW open web flowspace
#    When Login to flowspace with email "jungmin@podfoods.co" pass "PodFoods1!"
#    And FLOW navigate to "Outbound Shipments" of flowspace by sidebar
#    And FS search the orders in outbound orders by info
#      | sku  |
#      | 1338 |
#    Then FS verify drop in outbound orders by info
#      | departure | dropNumber    | customer  | mode    | tag    | status | from                              | fromAddress     | to                   | toAddress    | shipped | skuCount | itemCount |
#      | Plus2     | create by api | Pod Foods | Freight | Sprout | Open   | Pod Foods Fulfillment Fulfillment | Los Angeles, CA | ngoctx bsproutsatl01 | New York, GA | [blank] | 1        | 2         |
#    When FS go to detail drop "create by api" in outbound orders by info
#    Then FS verify info of outbound order detail
#      | dropNumber    | customer  | warehouse                                          | itemOrdered | creationSource      | status |
#      | create by api | Pod Foods | Pod Foods Fulfillment Fulfillment, Los Angeles, CA | 2 cases     | API - Pod Foods API | Open   |
#    And FS verify info of sku in outbound order detail
#      | sku   | upc          | description          | ordered |
#      | 71121 | 123125412312 | AT SKU Flow Space 01 | 2       |
#    # Begin picking
#    When FS change to role "Pod Foods Fulfillment"
#    And FS picking this drop
#
#    # Verify flowspace status
#    And Switch to actor NGOC_ADMIN_1909
#    And Admin search the orders in drop summary by info
#      | orderNumber   | store           | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
#      | create by api | AT SproutsATL01 | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
#    And Admin expand drop in drop summary
#      | index |
#      | 1     |
#    # Verify flowspace status
#    And Admin verify drop in drop summary
#      | region  | route   | store           | order   | subInvoice | sos   | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  | flowSpace       |
#      | [blank] | [blank] | AT SproutsATL01 | [blank] | [blank]    | $0.00 | $0.00 | $800.00      | $800.00      | $200.00   | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] | Shipment picked |
#
#      # FS packed
#    And Switch to actor FLOW
#    And FS pack this drop
#      | length | width | height | palletWeight | numberPallet |
#      | 1      | 1     | 1      | 1            | 1            |
#
#      # Verify flowspace status
#    And Switch to actor NGOC_ADMIN_1909
#    And Admin search the orders in drop summary by info
#      | orderNumber   | store           | buyer   | buyerCompany | vendorCompany | brand   | fulfillment | region  | route   | startDate | endDate | temp    | oos     | exProcess |
#      | create by api | AT SproutsATL01 | [blank] | [blank]      | [blank]       | [blank] | [blank]     | [blank] | [blank] | [blank]   | [blank] | [blank] | [blank] | [blank]   |
#    And Admin expand drop in drop summary
#      | index |
#      | 1     |
#    # Verify flowspace status
#    And Admin verify drop in drop summary
#      | region  | route   | store           | order   | subInvoice | sos   | fuel  | totalPayment | totalOrdered | vendorFee | totalWeight | eta     | receivingNote | adminNote | buyerSpecialNote | action  | flowSpace       |
#      | [blank] | [blank] | AT SproutsATL01 | [blank] | [blank]    | $0.00 | $0.00 | $800.00      | $800.00      | $200.00   | [blank]     | [blank] | [blank]       | [blank]   | [blank]          | [blank] | Shipment packed |
#
#       # FS ship
#    And Switch to actor FLOW
#    And FS ship this drop
#      | billOfLading |
#      | 1            |
#
#
  @FlowSpace_02 @AdminDropSummary
  Scenario: Admin verify push 50 orders of drop to flowspace
    Given NGOCTX19 login web admin by api
      | email                  | password  |
      | ngoctx1912@podfoods.co | 12345678a |

     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Flow Space 01 | 71121              | 200      | random   | 160          | currentDate  | [blank]     | [blank] |

      # Create order 01
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3931     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
    And Admin save sub-invoice of order "create by api" with index "1"
      | subInvoice |
      | 1          |

      # Create order 02
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3938     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"
    And Admin save sub-invoice of order "create by api" with index "2"
      | subInvoice |
      | 1          |

    # Create order 03
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3940     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "3"
    And Admin save sub-invoice of order "create by api" with index "3"
      | subInvoice |
      | 1          |

      # Create order 04
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3984     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "4"
    And Admin save sub-invoice of order "create by api" with index "4"
      | subInvoice |
      | 1          |

      # Create order 05
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3942     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "5"
    And Admin save sub-invoice of order "create by api" with index "5"
      | subInvoice |
      | 1          |

      # Create order 06
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3944     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "6"
    And Admin save sub-invoice of order "create by api" with index "6"
      | subInvoice |
      | 1          |

      # Create order 07
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3946     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "7"
    And Admin save sub-invoice of order "create by api" with index "7"
      | subInvoice |
      | 1          |

      # Create order 08
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3948     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "8"
    And Admin save sub-invoice of order "create by api" with index "8"
      | subInvoice |
      | 1          |


      # Create order 09
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3950     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "9"
    And Admin save sub-invoice of order "create by api" with index "9"
      | subInvoice |
      | 1          |

      # Create order 10
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3952     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "10"
    And Admin save sub-invoice of order "create by api" with index "10"
      | subInvoice |
      | 1          |

      # Create order 11
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3954     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "11"
    And Admin save sub-invoice of order "create by api" with index "11"
      | subInvoice |
      | 1          |

      # Create order 12
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3956     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "12"
    And Admin save sub-invoice of order "create by api" with index "12"
      | subInvoice |
      | 1          |

      # Create order 13
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3958     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "13"
    And Admin save sub-invoice of order "create by api" with index "13"
      | subInvoice |
      | 1          |

      # Create order 14
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3960     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "14"
    And Admin save sub-invoice of order "create by api" with index "14"
      | subInvoice |
      | 1          |

      # Create order 15
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3962     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "15"
    And Admin save sub-invoice of order "create by api" with index "15"
      | subInvoice |
      | 1          |

      # Create order 16
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3964     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "16"
    And Admin save sub-invoice of order "create by api" with index "16"
      | subInvoice |
      | 1          |

      # Create order 07
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3966     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "17"
    And Admin save sub-invoice of order "create by api" with index "17"
      | subInvoice |
      | 1          |

      # Create order 18
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3968     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "18"
    And Admin save sub-invoice of order "create by api" with index "18"
      | subInvoice |
      | 1          |

      # Create order 19
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3970     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "19"
    And Admin save sub-invoice of order "create by api" with index "19"
      | subInvoice |
      | 1          |

      # Create order 20
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3972     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "20"
    And Admin save sub-invoice of order "create by api" with index "20"
      | subInvoice |
      | 1          |

      # Create order 21
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3974     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "21"
    And Admin save sub-invoice of order "create by api" with index "21"
      | subInvoice |
      | 1          |

      # Create order 22
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3976     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "22"
    And Admin save sub-invoice of order "create by api" with index "22"
      | subInvoice |
      | 1          |

      # Create order 23
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3978     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "23"
    And Admin save sub-invoice of order "create by api" with index "23"
      | subInvoice |
      | 1          |

      # Create order 24
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3985     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "24"
    And Admin save sub-invoice of order "create by api" with index "24"
      | subInvoice |
      | 1          |

      # Create order 25
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3980     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "25"
    And Admin save sub-invoice of order "create by api" with index "25"
      | subInvoice |
      | 1          |

      # Create order 26
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3982     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "26"
    And Admin save sub-invoice of order "create by api" with index "26"
      | subInvoice |
      | 1          |

      # Create order 27
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3983     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "27"
    And Admin save sub-invoice of order "create by api" with index "27"
      | subInvoice |
      | 1          |

      # Create order 28
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3981     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "28"
    And Admin save sub-invoice of order "create by api" with index "28"
      | subInvoice |
      | 1          |

      # Create order 29
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3979     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "29"
    And Admin save sub-invoice of order "create by api" with index "29"
      | subInvoice |
      | 1          |

      # Create order 30
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3977     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "30"
    And Admin save sub-invoice of order "create by api" with index "30"
      | subInvoice |
      | 1          |

      # Create order 31
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3975     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "31"
    And Admin save sub-invoice of order "create by api" with index "31"
      | subInvoice |
      | 1          |

      # Create order 32
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3973     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "32"
    And Admin save sub-invoice of order "create by api" with index "32"
      | subInvoice |
      | 1          |

     # Create order 33
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3971     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "33"
    And Admin save sub-invoice of order "create by api" with index "33"
      | subInvoice |
      | 1          |

      # Create order 34
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "34"
    And Admin save sub-invoice of order "create by api" with index "34"
      | subInvoice |
      | 1          |

      # Create order 35
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3967     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "35"
    And Admin save sub-invoice of order "create by api" with index "35"
      | subInvoice |
      | 1          |

      # Create order 36
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3965     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "36"
    And Admin save sub-invoice of order "create by api" with index "36"
      | subInvoice |
      | 1          |

      # Create order 37
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3963     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "37"
    And Admin save sub-invoice of order "create by api" with index "37"
      | subInvoice |
      | 1          |

      # Create order 38
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3961     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "38"
    And Admin save sub-invoice of order "create by api" with index "38"
      | subInvoice |
      | 1          |

      # Create order 39
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3959     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "39"
    And Admin save sub-invoice of order "create by api" with index "39"
      | subInvoice |
      | 1          |

      # Create order 40
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3957     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "40"
    And Admin save sub-invoice of order "create by api" with index "40"
      | subInvoice |
      | 1          |

      # Create order 41
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3955     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "41"
    And Admin save sub-invoice of order "create by api" with index "41"
      | subInvoice |
      | 1          |

    # Create order 42
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3953     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "42"
    And Admin save sub-invoice of order "create by api" with index "42"
      | subInvoice |
      | 1          |

     # Create order 43
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3951     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "43"
    And Admin save sub-invoice of order "create by api" with index "43"
      | subInvoice |
      | 1          |

    # Create order 44
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3949     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "44"
    And Admin save sub-invoice of order "create by api" with index "44"
      | subInvoice |
      | 1          |

      # Create order 45
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3947     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "45"
    And Admin save sub-invoice of order "create by api" with index "45"
      | subInvoice |
      | 1          |

      # Create order 46
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3945     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "46"
    And Admin save sub-invoice of order "create by api" with index "46"
      | subInvoice |
      | 1          |

      # Create order 47
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3943     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "47"
    And Admin save sub-invoice of order "create by api" with index "47"
      | subInvoice |
      | 1          |

      # Create order 48
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3941     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "48"
    And Admin save sub-invoice of order "create by api" with index "48"
      | subInvoice |
      | 1          |

      # Create order 49
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3939     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "49"
    And Admin save sub-invoice of order "create by api" with index "49"
      | subInvoice |
      | 1          |

      # Create order 50
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3986     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "50"
    And Admin save sub-invoice of order "create by api" with index "50"
      | subInvoice |
      | 1          |

     # Create order 51
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3989     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "51"
    And Admin save sub-invoice of order "create by api" with index "51"
      | subInvoice |
      | 1          |

      # Create order 52
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3988     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "52"
    And Admin save sub-invoice of order "create by api" with index "52"
      | subInvoice |
      | 1          |

    # Create order 53
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4036     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "53"
    And Admin save sub-invoice of order "create by api" with index "53"
      | subInvoice |
      | 1          |

      # Create order 54
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3990     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "54"
    And Admin save sub-invoice of order "create by api" with index "54"
      | subInvoice |
      | 1          |

      # Create order 55
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3991     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "55"
    And Admin save sub-invoice of order "create by api" with index "55"
      | subInvoice |
      | 1          |

      # Create order 56
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3992     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "56"
    And Admin save sub-invoice of order "create by api" with index "56"
      | subInvoice |
      | 1          |

      # Create order 57
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3993     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "57"
    And Admin save sub-invoice of order "create by api" with index "57"
      | subInvoice |
      | 1          |

      # Create order 58
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3994     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "58"
    And Admin save sub-invoice of order "create by api" with index "58"
      | subInvoice |
      | 1          |

      # Create order 59
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3995     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "59"
    And Admin save sub-invoice of order "create by api" with index "59"
      | subInvoice |
      | 1          |

      # Create order 60
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3987     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "60"
    And Admin save sub-invoice of order "create by api" with index "60"
      | subInvoice |
      | 1          |

       # Create order 61
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3996     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "61"
    And Admin save sub-invoice of order "create by api" with index "61"
      | subInvoice |
      | 1          |

      # Create order 62
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3997     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "62"
    And Admin save sub-invoice of order "create by api" with index "62"
      | subInvoice |
      | 1          |

    # Create order 63
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3998     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "63"
    And Admin save sub-invoice of order "create by api" with index "63"
      | subInvoice |
      | 1          |

      # Create order 64
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3999     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "64"
    And Admin save sub-invoice of order "create by api" with index "64"
      | subInvoice |
      | 1          |

      # Create order 65
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4000     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "65"
    And Admin save sub-invoice of order "create by api" with index "65"
      | subInvoice |
      | 1          |

      # Create order 66
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4001     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "66"
    And Admin save sub-invoice of order "create by api" with index "66"
      | subInvoice |
      | 1          |

      # Create order 67
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4002     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "67"
    And Admin save sub-invoice of order "create by api" with index "67"
      | subInvoice |
      | 1          |

      # Create order 68
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4003     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "68"
    And Admin save sub-invoice of order "create by api" with index "68"
      | subInvoice |
      | 1          |

      # Create order 69
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4004     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "69"
    And Admin save sub-invoice of order "create by api" with index "69"
      | subInvoice |
      | 1          |

     # Create order 70
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4005     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "70"
    And Admin save sub-invoice of order "create by api" with index "70"
      | subInvoice |
      | 1          |

    # Create order 71
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4006     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "71"
    And Admin save sub-invoice of order "create by api" with index "71"
      | subInvoice |
      | 1          |

      # Create order 72
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4007     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "72"
    And Admin save sub-invoice of order "create by api" with index "72"
      | subInvoice |
      | 1          |

    # Create order 73
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4008     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "73"
    And Admin save sub-invoice of order "create by api" with index "73"
      | subInvoice |
      | 1          |

      # Create order 74
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4009     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "74"
    And Admin save sub-invoice of order "create by api" with index "74"
      | subInvoice |
      | 1          |

      # Create order 75
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4010     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "75"
    And Admin save sub-invoice of order "create by api" with index "75"
      | subInvoice |
      | 1          |

      # Create order 76
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4011     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "76"
    And Admin save sub-invoice of order "create by api" with index "76"
      | subInvoice |
      | 1          |

      # Create order 77
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4012     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "77"
    And Admin save sub-invoice of order "create by api" with index "77"
      | subInvoice |
      | 1          |

      # Create order 78
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4013     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "78"
    And Admin save sub-invoice of order "create by api" with index "78"
      | subInvoice |
      | 1          |


      # Create order 79
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4014     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "79"
    And Admin save sub-invoice of order "create by api" with index "79"
      | subInvoice |
      | 1          |

      # Create order 80
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4015     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "80"
    And Admin save sub-invoice of order "create by api" with index "80"
      | subInvoice |
      | 1          |

       # Create order 81
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4016     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "81"
    And Admin save sub-invoice of order "create by api" with index "81"
      | subInvoice |
      | 1          |

      # Create order 82
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4017     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "82"
    And Admin save sub-invoice of order "create by api" with index "82"
      | subInvoice |
      | 1          |

    # Create order 83
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4018     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "83"
    And Admin save sub-invoice of order "create by api" with index "83"
      | subInvoice |
      | 1          |

      # Create order 84
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4019     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "84"
    And Admin save sub-invoice of order "create by api" with index "84"
      | subInvoice |
      | 1          |

      # Create order 85
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4020     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "85"
    And Admin save sub-invoice of order "create by api" with index "85"
      | subInvoice |
      | 1          |

      # Create order 86
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4021     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "86"
    And Admin save sub-invoice of order "create by api" with index "86"
      | subInvoice |
      | 1          |

      # Create order 87
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4022     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "87"
    And Admin save sub-invoice of order "create by api" with index "87"
      | subInvoice |
      | 1          |

      # Create order 88
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4023     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "88"
    And Admin save sub-invoice of order "create by api" with index "88"
      | subInvoice |
      | 1          |


      # Create order 89
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4024     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "89"
    And Admin save sub-invoice of order "create by api" with index "89"
      | subInvoice |
      | 1          |

      # Create order 90
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4025     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "90"
    And Admin save sub-invoice of order "create by api" with index "90"
      | subInvoice |
      | 1          |

      # Create order 91
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4026     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "91"
    And Admin save sub-invoice of order "create by api" with index "91"
      | subInvoice |
      | 1          |

      # Create order 92
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4027     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "92"
    And Admin save sub-invoice of order "create by api" with index "92"
      | subInvoice |
      | 1          |

    # Create order 93
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4028     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "93"
    And Admin save sub-invoice of order "create by api" with index "93"
      | subInvoice |
      | 1          |

      # Create order 94
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4029     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "94"
    And Admin save sub-invoice of order "create by api" with index "94"
      | subInvoice |
      | 1          |

      # Create order 95
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4030     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "95"
    And Admin save sub-invoice of order "create by api" with index "95"
      | subInvoice |
      | 1          |

      # Create order 96
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4031     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "96"
    And Admin save sub-invoice of order "create by api" with index "96"
      | subInvoice |
      | 1          |

      # Create order 97
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4032     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "97"
    And Admin save sub-invoice of order "create by api" with index "97"
      | subInvoice |
      | 1          |

      # Create order 98
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4033     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "98"
    And Admin save sub-invoice of order "create by api" with index "98"
      | subInvoice |
      | 1          |

      # Create order 99
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4034     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "99"
    And Admin save sub-invoice of order "create by api" with index "99"
      | subInvoice |
      | 1          |

      # Create order 100
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4035     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "100"
    And Admin save sub-invoice of order "create by api" with index "100"
      | subInvoice |
      | 1          |

       # Create order 101
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4037     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "101"
    And Admin save sub-invoice of order "create by api" with index "101"
      | subInvoice |
      | 1          |

      # Create order 102
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4038     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "102"
    And Admin save sub-invoice of order "create by api" with index "102"
      | subInvoice |
      | 1          |

    # Create order 103
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4039     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "103"
    And Admin save sub-invoice of order "create by api" with index "103"
      | subInvoice |
      | 1          |

      # Create order 104
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4040     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "104"
    And Admin save sub-invoice of order "create by api" with index "104"
      | subInvoice |
      | 1          |

      # Create order 105
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4041     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "105"
    And Admin save sub-invoice of order "create by api" with index "105"
      | subInvoice |
      | 1          |

      # Create order 106
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4042     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "106"
    And Admin save sub-invoice of order "create by api" with index "106"
      | subInvoice |
      | 1          |

      # Create order 107
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4043     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "107"
    And Admin save sub-invoice of order "create by api" with index "107"
      | subInvoice |
      | 1          |

      # Create order 108
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4044     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "108"
    And Admin save sub-invoice of order "create by api" with index "108"
      | subInvoice |
      | 1          |


      # Create order 109
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4045     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "109"
    And Admin save sub-invoice of order "create by api" with index "109"
      | subInvoice |
      | 1          |

      # Create order 110
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4046     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "110"
    And Admin save sub-invoice of order "create by api" with index "110"
      | subInvoice |
      | 1          |

         # Create order 111
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4047     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "111"
    And Admin save sub-invoice of order "create by api" with index "111"
      | subInvoice |
      | 1          |

      # Create order 112
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4048     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "112"
    And Admin save sub-invoice of order "create by api" with index "112"
      | subInvoice |
      | 1          |

    # Create order 113
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4049     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "113"
    And Admin save sub-invoice of order "create by api" with index "113"
      | subInvoice |
      | 1          |

      # Create order 114
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4050     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "114"
    And Admin save sub-invoice of order "create by api" with index "114"
      | subInvoice |
      | 1          |

      # Create order 115
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4051     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "115"
    And Admin save sub-invoice of order "create by api" with index "115"
      | subInvoice |
      | 1          |

      # Create order 116
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4052     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "116"
    And Admin save sub-invoice of order "create by api" with index "116"
      | subInvoice |
      | 1          |

      # Create order 117
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4053     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "117"
    And Admin save sub-invoice of order "create by api" with index "117"
      | subInvoice |
      | 1          |

      # Create order 118
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4054     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "118"
    And Admin save sub-invoice of order "create by api" with index "118"
      | subInvoice |
      | 1          |


      # Create order 119
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4055     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "119"
    And Admin save sub-invoice of order "create by api" with index "119"
      | subInvoice |
      | 1          |

      # Create order 120
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4056     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "120"
    And Admin save sub-invoice of order "create by api" with index "120"
      | subInvoice |
      | 1          |

        # Create order 121
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4057     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "121"
    And Admin save sub-invoice of order "create by api" with index "121"
      | subInvoice |
      | 1          |

      # Create order 122
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4058     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "122"
    And Admin save sub-invoice of order "create by api" with index "122"
      | subInvoice |
      | 1          |

    # Create order 123
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4059     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "123"
    And Admin save sub-invoice of order "create by api" with index "123"
      | subInvoice |
      | 1          |

      # Create order 124
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4060     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "124"
    And Admin save sub-invoice of order "create by api" with index "124"
      | subInvoice |
      | 1          |

      # Create order 125
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4061     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "125"
    And Admin save sub-invoice of order "create by api" with index "125"
      | subInvoice |
      | 1          |

      # Create order 126
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4062     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "126"
    And Admin save sub-invoice of order "create by api" with index "126"
      | subInvoice |
      | 1          |

      # Create order 127
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4063     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "127"
    And Admin save sub-invoice of order "create by api" with index "127"
      | subInvoice |
      | 1          |

      # Create order 128
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4064     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "128"
    And Admin save sub-invoice of order "create by api" with index "128"
      | subInvoice |
      | 1          |

      # Create order 129
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4065     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "129"
    And Admin save sub-invoice of order "create by api" with index "129"
      | subInvoice |
      | 1          |

      # Create order 130
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4066     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "130"
    And Admin save sub-invoice of order "create by api" with index "130"
      | subInvoice |
      | 1          |

     # Create order 131
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4067     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "131"
    And Admin save sub-invoice of order "create by api" with index "131"
      | subInvoice |
      | 1          |

      # Create order 132
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4068     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "132"
    And Admin save sub-invoice of order "create by api" with index "132"
      | subInvoice |
      | 1          |

    # Create order 133
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4069     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "133"
    And Admin save sub-invoice of order "create by api" with index "133"
      | subInvoice |
      | 1          |

      # Create order 134
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4070     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "134"
    And Admin save sub-invoice of order "create by api" with index "134"
      | subInvoice |
      | 1          |

      # Create order 135
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4071     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "135"
    And Admin save sub-invoice of order "create by api" with index "135"
      | subInvoice |
      | 1          |

      # Create order 136
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4072     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "136"
    And Admin save sub-invoice of order "create by api" with index "136"
      | subInvoice |
      | 1          |

      # Create order 137
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4073     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "137"
    And Admin save sub-invoice of order "create by api" with index "137"
      | subInvoice |
      | 1          |

      # Create order 138
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4074     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "138"
    And Admin save sub-invoice of order "create by api" with index "138"
      | subInvoice |
      | 1          |

      # Create order 139
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4075     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "139"
    And Admin save sub-invoice of order "create by api" with index "139"
      | subInvoice |
      | 1          |

      # Create order 140
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4076     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "140"
    And Admin save sub-invoice of order "create by api" with index "140"
      | subInvoice |
      | 1          |

       # Create order 141
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4077     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "141"
    And Admin save sub-invoice of order "create by api" with index "141"
      | subInvoice |
      | 1          |

      # Create order 142
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4078     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "142"
    And Admin save sub-invoice of order "create by api" with index "142"
      | subInvoice |
      | 1          |

    # Create order 143
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4079     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "143"
    And Admin save sub-invoice of order "create by api" with index "143"
      | subInvoice |
      | 1          |

      # Create order 144
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4080     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "144"
    And Admin save sub-invoice of order "create by api" with index "144"
      | subInvoice |
      | 1          |

      # Create order 145
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4081     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "145"
    And Admin save sub-invoice of order "create by api" with index "145"
      | subInvoice |
      | 1          |

      # Create order 146
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4082     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "146"
    And Admin save sub-invoice of order "create by api" with index "146"
      | subInvoice |
      | 1          |

      # Create order 147
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4083     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "147"
    And Admin save sub-invoice of order "create by api" with index "147"
      | subInvoice |
      | 1          |

      # Create order 148
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4084     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "148"
    And Admin save sub-invoice of order "create by api" with index "148"
      | subInvoice |
      | 1          |

      # Create order 149
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4085     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "149"
    And Admin save sub-invoice of order "create by api" with index "149"
      | subInvoice |
      | 1          |

      # Create order 150
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4086     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "150"
    And Admin save sub-invoice of order "create by api" with index "150"
      | subInvoice |
      | 1          |

       # Create order 151
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4087     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "151"
    And Admin save sub-invoice of order "create by api" with index "151"
      | subInvoice |
      | 1          |

      # Create order 152
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4088     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "152"
    And Admin save sub-invoice of order "create by api" with index "152"
      | subInvoice |
      | 1          |

    # Create order 153
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4089     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "153"
    And Admin save sub-invoice of order "create by api" with index "153"
      | subInvoice |
      | 1          |

      # Create order 154
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4090     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "154"
    And Admin save sub-invoice of order "create by api" with index "154"
      | subInvoice |
      | 1          |

      # Create order 155
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4091     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "155"
    And Admin save sub-invoice of order "create by api" with index "155"
      | subInvoice |
      | 1          |

      # Create order 156
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4092     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "156"
    And Admin save sub-invoice of order "create by api" with index "156"
      | subInvoice |
      | 1          |

      # Create order 157
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4093     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "157"
    And Admin save sub-invoice of order "create by api" with index "157"
      | subInvoice |
      | 1          |

      # Create order 158
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4094     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "158"
    And Admin save sub-invoice of order "create by api" with index "158"
      | subInvoice |
      | 1          |

      # Create order 159
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4095     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "159"
    And Admin save sub-invoice of order "create by api" with index "159"
      | subInvoice |
      | 1          |

      # Create order 160
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4096     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "160"
    And Admin save sub-invoice of order "create by api" with index "160"
      | subInvoice |
      | 1          |

      # Create order 161
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4097     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "161"
    And Admin save sub-invoice of order "create by api" with index "161"
      | subInvoice |
      | 1          |

      # Create order 162
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4098     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "162"
    And Admin save sub-invoice of order "create by api" with index "162"
      | subInvoice |
      | 1          |

    # Create order 163
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4099     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "163"
    And Admin save sub-invoice of order "create by api" with index "163"
      | subInvoice |
      | 1          |

      # Create order 164
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4100     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "164"
    And Admin save sub-invoice of order "create by api" with index "164"
      | subInvoice |
      | 1          |

      # Create order 165
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4101     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "165"
    And Admin save sub-invoice of order "create by api" with index "165"
      | subInvoice |
      | 1          |

      # Create order 166
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4102     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "166"
    And Admin save sub-invoice of order "create by api" with index "166"
      | subInvoice |
      | 1          |

      # Create order 167
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4103     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "167"
    And Admin save sub-invoice of order "create by api" with index "167"
      | subInvoice |
      | 1          |

      # Create order 168
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4104     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "168"
    And Admin save sub-invoice of order "create by api" with index "168"
      | subInvoice |
      | 1          |

      # Create order 169
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4105     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "169"
    And Admin save sub-invoice of order "create by api" with index "169"
      | subInvoice |
      | 1          |

      # Create order 170
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4106     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "170"
    And Admin save sub-invoice of order "create by api" with index "170"
      | subInvoice |
      | 1          |

      # Create order 171
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4107     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "171"
    And Admin save sub-invoice of order "create by api" with index "171"
      | subInvoice |
      | 1          |

      # Create order 172
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4108     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "172"
    And Admin save sub-invoice of order "create by api" with index "172"
      | subInvoice |
      | 1          |

    # Create order 173
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4109     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "173"
    And Admin save sub-invoice of order "create by api" with index "173"
      | subInvoice |
      | 1          |

      # Create order 174
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4110     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "174"
    And Admin save sub-invoice of order "create by api" with index "174"
      | subInvoice |
      | 1          |

      # Create order 175
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4111     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "175"
    And Admin save sub-invoice of order "create by api" with index "175"
      | subInvoice |
      | 1          |

      # Create order 176
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4112     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "176"
    And Admin save sub-invoice of order "create by api" with index "176"
      | subInvoice |
      | 1          |

      # Create order 177
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4113     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "177"
    And Admin save sub-invoice of order "create by api" with index "177"
      | subInvoice |
      | 1          |

      # Create order 178
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4114     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "178"
    And Admin save sub-invoice of order "create by api" with index "178"
      | subInvoice |
      | 1          |

      # Create order 179
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4115     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "179"
    And Admin save sub-invoice of order "create by api" with index "179"
      | subInvoice |
      | 1          |

      # Create order 180
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4116     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "180"
    And Admin save sub-invoice of order "create by api" with index "180"
      | subInvoice |
      | 1          |

      # Create order 181
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4117     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "181"
    And Admin save sub-invoice of order "create by api" with index "18"
      | subInvoice |
      | 1          |

      # Create order 182
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4118     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "182"
    And Admin save sub-invoice of order "create by api" with index "182"
      | subInvoice |
      | 1          |

    # Create order 183
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4119     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "183"
    And Admin save sub-invoice of order "create by api" with index "183"
      | subInvoice |
      | 1          |

      # Create order 184
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4120     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "184"
    And Admin save sub-invoice of order "create by api" with index "184"
      | subInvoice |
      | 1          |

      # Create order 185
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4121     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "185"
    And Admin save sub-invoice of order "create by api" with index "185"
      | subInvoice |
      | 1          |

      # Create order 186
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4122     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "186"
    And Admin save sub-invoice of order "create by api" with index "186"
      | subInvoice |
      | 1          |

      # Create order 187
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4123     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "187"
    And Admin save sub-invoice of order "create by api" with index "187"
      | subInvoice |
      | 1          |

      # Create order 188
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4124     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "188"
    And Admin save sub-invoice of order "create by api" with index "188"
      | subInvoice |
      | 1          |


      # Create order 189
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4125     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "189"
    And Admin save sub-invoice of order "create by api" with index "189"
      | subInvoice |
      | 1          |

      # Create order 190
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4126     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "190"
    And Admin save sub-invoice of order "create by api" with index "190"
      | subInvoice |
      | 1          |

      # Create order 191
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4127     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "191"
    And Admin save sub-invoice of order "create by api" with index "191"
      | subInvoice |
      | 1          |

      # Create order 192
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4128     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "192"
    And Admin save sub-invoice of order "create by api" with index "192"
      | subInvoice |
      | 1          |

    # Create order 193
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4129     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "193"
    And Admin save sub-invoice of order "create by api" with index "193"
      | subInvoice |
      | 1          |

      # Create order 194
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4130     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "194"
    And Admin save sub-invoice of order "create by api" with index "194"
      | subInvoice |
      | 1          |

      # Create order 195
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4131     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "195"
    And Admin save sub-invoice of order "create by api" with index "195"
      | subInvoice |
      | 1          |

      # Create order 196
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4132     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "196"
    And Admin save sub-invoice of order "create by api" with index "196"
      | subInvoice |
      | 1          |

      # Create order 197
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4133     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "197"
    And Admin save sub-invoice of order "create by api" with index "197"
      | subInvoice |
      | 1          |

      # Create order 198
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4134     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "198"
    And Admin save sub-invoice of order "create by api" with index "198"
      | subInvoice |
      | 1          |

      # Create order 199
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4135     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "199"
    And Admin save sub-invoice of order "create by api" with index "199"
      | subInvoice |
      | 1          |

      # Create order 200
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 141755             | 71121              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1                              | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 4136     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 80 Jesse Hill Junior Drive Southeast | New York | 11               | 30303 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "200"
    And Admin save sub-invoice of order "create by api" with index "200"
      | subInvoice |
      | 1          |

    # Create drop
    And Admin create drop with po by API
      | drop | index | sub | subAtt | store | sos  | adminNote | lpNote  | lpCompanyID |
      | 0    | 1     | 1   | 0      | 3804  | 3000 | [blank]   | [blank] | 99          |
      | 1    | 2     | 1   | 0      | 3832  | 3000 | [blank]   | [blank] | 99          |
      | 2    | 3     | 1   | 0      | 3834  | 3000 | [blank]   | [blank] | 99          |
      | 3    | 4     | 1   | 0      | 3878  | 3000 | [blank]   | [blank] | 99          |
      | 4    | 5     | 1   | 0      | 3836  | 3000 | [blank]   | [blank] | 99          |
      | 5    | 6     | 1   | 0      | 3838  | 3000 | [blank]   | [blank] | 99          |
      | 6    | 7     | 1   | 0      | 3840  | 3000 | [blank]   | [blank] | 99          |
      | 7    | 8     | 1   | 0      | 3842  | 3000 | [blank]   | [blank] | 99          |
      | 8    | 9     | 1   | 0      | 3844  | 3000 | [blank]   | [blank] | 99          |
      | 9    | 10    | 1   | 0      | 3846  | 3000 | [blank]   | [blank] | 99          |
      | 10   | 11    | 1   | 0      | 3848  | 3000 | [blank]   | [blank] | 99          |
      | 11   | 12    | 1   | 0      | 3850  | 3000 | [blank]   | [blank] | 99          |
      | 12   | 13    | 1   | 0      | 3852  | 3000 | [blank]   | [blank] | 99          |
      | 13   | 14    | 1   | 0      | 3854  | 3000 | [blank]   | [blank] | 99          |
      | 14   | 15    | 1   | 0      | 3856  | 3000 | [blank]   | [blank] | 99          |
      | 15   | 16    | 1   | 0      | 3858  | 3000 | [blank]   | [blank] | 99          |
      | 16   | 17    | 1   | 0      | 3860  | 3000 | [blank]   | [blank] | 99          |
      | 17   | 18    | 1   | 0      | 3862  | 3000 | [blank]   | [blank] | 99          |
      | 18   | 19    | 1   | 0      | 3864  | 3000 | [blank]   | [blank] | 99          |
      | 19   | 20    | 1   | 0      | 3866  | 3000 | [blank]   | [blank] | 99          |
      | 20   | 21    | 1   | 0      | 3868  | 3000 | [blank]   | [blank] | 99          |
      | 21   | 22    | 1   | 0      | 3870  | 3000 | [blank]   | [blank] | 99          |
      | 22   | 23    | 1   | 0      | 3872  | 3000 | [blank]   | [blank] | 99          |
      | 23   | 24    | 1   | 0      | 3879  | 3000 | [blank]   | [blank] | 99          |
      | 24   | 25    | 1   | 0      | 3874  | 3000 | [blank]   | [blank] | 99          |
      | 25   | 26    | 1   | 0      | 3876  | 3000 | [blank]   | [blank] | 99          |
      | 26   | 27    | 1   | 0      | 3877  | 3000 | [blank]   | [blank] | 99          |
      | 27   | 28    | 1   | 0      | 3875  | 3000 | [blank]   | [blank] | 99          |
      | 28   | 29    | 1   | 0      | 3873  | 3000 | [blank]   | [blank] | 99          |
      | 29   | 30    | 1   | 0      | 3871  | 3000 | [blank]   | [blank] | 99          |
      | 30   | 31    | 1   | 0      | 3869  | 3000 | [blank]   | [blank] | 99          |
      | 31   | 32    | 1   | 0      | 3867  | 3000 | [blank]   | [blank] | 99          |
      | 32   | 33    | 1   | 0      | 3865  | 3000 | [blank]   | [blank] | 99          |
      | 33   | 34    | 1   | 0      | 3863  | 3000 | [blank]   | [blank] | 99          |
      | 34   | 35    | 1   | 0      | 3861  | 3000 | [blank]   | [blank] | 99          |
      | 35   | 36    | 1   | 0      | 3859  | 3000 | [blank]   | [blank] | 99          |
      | 36   | 37    | 1   | 0      | 3857  | 3000 | [blank]   | [blank] | 99          |
      | 37   | 38    | 1   | 0      | 3855  | 3000 | [blank]   | [blank] | 99          |
      | 38   | 39    | 1   | 0      | 3853  | 3000 | [blank]   | [blank] | 99          |
      | 39   | 40    | 1   | 0      | 3851  | 3000 | [blank]   | [blank] | 99          |
      | 40   | 41    | 1   | 0      | 3849  | 3000 | [blank]   | [blank] | 99          |
      | 41   | 42    | 1   | 0      | 3847  | 3000 | [blank]   | [blank] | 99          |
      | 42   | 43    | 1   | 0      | 3845  | 3000 | [blank]   | [blank] | 99          |
      | 43   | 44    | 1   | 0      | 3843  | 3000 | [blank]   | [blank] | 99          |
      | 44   | 45    | 1   | 0      | 3841  | 3000 | [blank]   | [blank] | 99          |
      | 45   | 46    | 1   | 0      | 3839  | 3000 | [blank]   | [blank] | 99          |
      | 46   | 47    | 1   | 0      | 3837  | 3000 | [blank]   | [blank] | 99          |
      | 47   | 48    | 1   | 0      | 3835  | 3000 | [blank]   | [blank] | 99          |
      | 48   | 49    | 1   | 0      | 3833  | 3000 | [blank]   | [blank] | 99          |
      | 49   | 50    | 1   | 0      | 3880  | 3000 | [blank]   | [blank] | 99          |
      | 50   | 51    | 1   | 0      | 3884  | 3000 | [blank]   | [blank] | 99          |
      | 51   | 52    | 1   | 0      | 3882  | 3000 | [blank]   | [blank] | 99          |
      | 52   | 53    | 1   | 0      | 3931  | 3000 | [blank]   | [blank] | 99          |
      | 53   | 54    | 1   | 0      | 3885  | 3000 | [blank]   | [blank] | 99          |
      | 54   | 55    | 1   | 0      | 3886  | 3000 | [blank]   | [blank] | 99          |
      | 55   | 56    | 1   | 0      | 3887  | 3000 | [blank]   | [blank] | 99          |
      | 56   | 57    | 1   | 0      | 3888  | 3000 | [blank]   | [blank] | 99          |
      | 57   | 58    | 1   | 0      | 3889  | 3000 | [blank]   | [blank] | 99          |
      | 58   | 59    | 1   | 0      | 3890  | 3000 | [blank]   | [blank] | 99          |
      | 59   | 60    | 1   | 0      | 3881  | 3000 | [blank]   | [blank] | 99          |
      | 60   | 61    | 1   | 0      | 3891  | 3000 | [blank]   | [blank] | 99          |
      | 61   | 62    | 1   | 0      | 3892  | 3000 | [blank]   | [blank] | 99          |
      | 62   | 63    | 1   | 0      | 3893  | 3000 | [blank]   | [blank] | 99          |
      | 63   | 64    | 1   | 0      | 3894  | 3000 | [blank]   | [blank] | 99          |
      | 64   | 65    | 1   | 0      | 3895  | 3000 | [blank]   | [blank] | 99          |
      | 65   | 66    | 1   | 0      | 3896  | 3000 | [blank]   | [blank] | 99          |
      | 66   | 67    | 1   | 0      | 3897  | 3000 | [blank]   | [blank] | 99          |
      | 67   | 68    | 1   | 0      | 3898  | 3000 | [blank]   | [blank] | 99          |
      | 68   | 69    | 1   | 0      | 3899  | 3000 | [blank]   | [blank] | 99          |
      | 69   | 70    | 1   | 0      | 3900  | 3000 | [blank]   | [blank] | 99          |
      | 70   | 71    | 1   | 0      | 3901  | 3000 | [blank]   | [blank] | 99          |
      | 71   | 72    | 1   | 0      | 3902  | 3000 | [blank]   | [blank] | 99          |
      | 72   | 73    | 1   | 0      | 3903  | 3000 | [blank]   | [blank] | 99          |
      | 73   | 74    | 1   | 0      | 3904  | 3000 | [blank]   | [blank] | 99          |
      | 74   | 75    | 1   | 0      | 3905  | 3000 | [blank]   | [blank] | 99          |
      | 75   | 76    | 1   | 0      | 3906  | 3000 | [blank]   | [blank] | 99          |
      | 76   | 77    | 1   | 0      | 3907  | 3000 | [blank]   | [blank] | 99          |
      | 77   | 78    | 1   | 0      | 3908  | 3000 | [blank]   | [blank] | 99          |
      | 78   | 79    | 1   | 0      | 3909  | 3000 | [blank]   | [blank] | 99          |
      | 79   | 80    | 1   | 0      | 3910  | 3000 | [blank]   | [blank] | 99          |
      | 80   | 81    | 1   | 0      | 3911  | 3000 | [blank]   | [blank] | 99          |
      | 81   | 82    | 1   | 0      | 3912  | 3000 | [blank]   | [blank] | 99          |
      | 82   | 83    | 1   | 0      | 3913  | 3000 | [blank]   | [blank] | 99          |
      | 83   | 84    | 1   | 0      | 3914  | 3000 | [blank]   | [blank] | 99          |
      | 84   | 85    | 1   | 0      | 3915  | 3000 | [blank]   | [blank] | 99          |
      | 85   | 86    | 1   | 0      | 3916  | 3000 | [blank]   | [blank] | 99          |
      | 86   | 87    | 1   | 0      | 3917  | 3000 | [blank]   | [blank] | 99          |
      | 87   | 88    | 1   | 0      | 3918  | 3000 | [blank]   | [blank] | 99          |
      | 88   | 89    | 1   | 0      | 3919  | 3000 | [blank]   | [blank] | 99          |
      | 89   | 90    | 1   | 0      | 3920  | 3000 | [blank]   | [blank] | 99          |
      | 90   | 91    | 1   | 0      | 3921  | 3000 | [blank]   | [blank] | 99          |
      | 91   | 92    | 1   | 0      | 3922  | 3000 | [blank]   | [blank] | 99          |
      | 92   | 93    | 1   | 0      | 3923  | 3000 | [blank]   | [blank] | 99          |
      | 93   | 94    | 1   | 0      | 3924  | 3000 | [blank]   | [blank] | 99          |
      | 94   | 95    | 1   | 0      | 3925  | 3000 | [blank]   | [blank] | 99          |
      | 95   | 96    | 1   | 0      | 3926  | 3000 | [blank]   | [blank] | 99          |
      | 96   | 97    | 1   | 0      | 3927  | 3000 | [blank]   | [blank] | 99          |
      | 97   | 98    | 1   | 0      | 3928  | 3000 | [blank]   | [blank] | 99          |
      | 98   | 99    | 1   | 0      | 3929  | 3000 | [blank]   | [blank] | 99          |
      | 99   | 100   | 1   | 0      | 3930  | 3000 | [blank]   | [blank] | 99          |
      | 100  | 101   | 1   | 0      | 3932  | 3000 | [blank]   | [blank] | 99          |
      | 101  | 102   | 1   | 0      | 3933  | 3000 | [blank]   | [blank] | 99          |
      | 102  | 103   | 1   | 0      | 3934  | 3000 | [blank]   | [blank] | 99          |
      | 103  | 104   | 1   | 0      | 3935  | 3000 | [blank]   | [blank] | 99          |
      | 104  | 105   | 1   | 0      | 3936  | 3000 | [blank]   | [blank] | 99          |
      | 105  | 106   | 1   | 0      | 3937  | 3000 | [blank]   | [blank] | 99          |
      | 106  | 107   | 1   | 0      | 3938  | 3000 | [blank]   | [blank] | 99          |
      | 107  | 108   | 1   | 0      | 3939  | 3000 | [blank]   | [blank] | 99          |
      | 108  | 109   | 1   | 0      | 3940  | 3000 | [blank]   | [blank] | 99          |
      | 109  | 110   | 1   | 0      | 3941  | 3000 | [blank]   | [blank] | 99          |
      | 110  | 111   | 1   | 0      | 3942  | 3000 | [blank]   | [blank] | 99          |
      | 111  | 112   | 1   | 0      | 3943  | 3000 | [blank]   | [blank] | 99          |
      | 112  | 113   | 1   | 0      | 3944  | 3000 | [blank]   | [blank] | 99          |
      | 113  | 114   | 1   | 0      | 3945  | 3000 | [blank]   | [blank] | 99          |
      | 114  | 115   | 1   | 0      | 3946  | 3000 | [blank]   | [blank] | 99          |
      | 115  | 116   | 1   | 0      | 3947  | 3000 | [blank]   | [blank] | 99          |
      | 116  | 117   | 1   | 0      | 3948  | 3000 | [blank]   | [blank] | 99          |
      | 117  | 118   | 1   | 0      | 3949  | 3000 | [blank]   | [blank] | 99          |
      | 118  | 119   | 1   | 0      | 3950  | 3000 | [blank]   | [blank] | 99          |
      | 119  | 120   | 1   | 0      | 3951  | 3000 | [blank]   | [blank] | 99          |
      | 120  | 121   | 1   | 0      | 3952  | 3000 | [blank]   | [blank] | 99          |
      | 121  | 122   | 1   | 0      | 3953  | 3000 | [blank]   | [blank] | 99          |
      | 122  | 123   | 1   | 0      | 3954  | 3000 | [blank]   | [blank] | 99          |
      | 123  | 124   | 1   | 0      | 3955  | 3000 | [blank]   | [blank] | 99          |
      | 124  | 125   | 1   | 0      | 3956  | 3000 | [blank]   | [blank] | 99          |
      | 125  | 126   | 1   | 0      | 3957  | 3000 | [blank]   | [blank] | 99          |
      | 126  | 127   | 1   | 0      | 3958  | 3000 | [blank]   | [blank] | 99          |
      | 127  | 128   | 1   | 0      | 3959  | 3000 | [blank]   | [blank] | 99          |
      | 128  | 129   | 1   | 0      | 3960  | 3000 | [blank]   | [blank] | 99          |
      | 129  | 130   | 1   | 0      | 3961  | 3000 | [blank]   | [blank] | 99          |
      | 130  | 131   | 1   | 0      | 3962  | 3000 | [blank]   | [blank] | 99          |
      | 131  | 132   | 1   | 0      | 3963  | 3000 | [blank]   | [blank] | 99          |
      | 132  | 133   | 1   | 0      | 3964  | 3000 | [blank]   | [blank] | 99          |
      | 133  | 134   | 1   | 0      | 3965  | 3000 | [blank]   | [blank] | 99          |
      | 134  | 135   | 1   | 0      | 3966  | 3000 | [blank]   | [blank] | 99          |
      | 135  | 136   | 1   | 0      | 3967  | 3000 | [blank]   | [blank] | 99          |
      | 136  | 137   | 1   | 0      | 3968  | 3000 | [blank]   | [blank] | 99          |
      | 137  | 138   | 1   | 0      | 3969  | 3000 | [blank]   | [blank] | 99          |
      | 138  | 139   | 1   | 0      | 3970  | 3000 | [blank]   | [blank] | 99          |
      | 139  | 140   | 1   | 0      | 3971  | 3000 | [blank]   | [blank] | 99          |
      | 140  | 141   | 1   | 0      | 3972  | 3000 | [blank]   | [blank] | 99          |
      | 141  | 142   | 1   | 0      | 3973  | 3000 | [blank]   | [blank] | 99          |
      | 142  | 143   | 1   | 0      | 3974  | 3000 | [blank]   | [blank] | 99          |
      | 143  | 144   | 1   | 0      | 3975  | 3000 | [blank]   | [blank] | 99          |
      | 144  | 145   | 1   | 0      | 3976  | 3000 | [blank]   | [blank] | 99          |
      | 145  | 146   | 1   | 0      | 3977  | 3000 | [blank]   | [blank] | 99          |
      | 146  | 147   | 1   | 0      | 3978  | 3000 | [blank]   | [blank] | 99          |
      | 147  | 148   | 1   | 0      | 3979  | 3000 | [blank]   | [blank] | 99          |
      | 148  | 149   | 1   | 0      | 3980  | 3000 | [blank]   | [blank] | 99          |
      | 149  | 150   | 1   | 0      | 3981  | 3000 | [blank]   | [blank] | 99          |
      | 150  | 151   | 1   | 0      | 3982  | 3000 | [blank]   | [blank] | 99          |
      | 151  | 152   | 1   | 0      | 3983  | 3000 | [blank]   | [blank] | 99          |
      | 152  | 153   | 1   | 0      | 3987  | 3000 | [blank]   | [blank] | 99          |
      | 153  | 154   | 1   | 0      | 3985  | 3000 | [blank]   | [blank] | 99          |
      | 154  | 155   | 1   | 0      | 3986  | 3000 | [blank]   | [blank] | 99          |
      | 155  | 156   | 1   | 0      | 3987  | 3000 | [blank]   | [blank] | 99          |
      | 156  | 157   | 1   | 0      | 3988  | 3000 | [blank]   | [blank] | 99          |
      | 157  | 158   | 1   | 0      | 3989  | 3000 | [blank]   | [blank] | 99          |
      | 158  | 159   | 1   | 0      | 3990  | 3000 | [blank]   | [blank] | 99          |
      | 159  | 160   | 1   | 0      | 3991  | 3000 | [blank]   | [blank] | 99          |
      | 160  | 161   | 1   | 0      | 3992  | 3000 | [blank]   | [blank] | 99          |
      | 161  | 162   | 1   | 0      | 3993  | 3000 | [blank]   | [blank] | 99          |
      | 162  | 163   | 1   | 0      | 3994  | 3000 | [blank]   | [blank] | 99          |
      | 163  | 164   | 1   | 0      | 3995  | 3000 | [blank]   | [blank] | 99          |
      | 164  | 165   | 1   | 0      | 3996  | 3000 | [blank]   | [blank] | 99          |
      | 165  | 166   | 1   | 0      | 3997  | 3000 | [blank]   | [blank] | 99          |
      | 166  | 167   | 1   | 0      | 3998  | 3000 | [blank]   | [blank] | 99          |
      | 167  | 168   | 1   | 0      | 3999  | 3000 | [blank]   | [blank] | 99          |
      | 168  | 169   | 1   | 0      | 4000  | 3000 | [blank]   | [blank] | 99          |
      | 169  | 170   | 1   | 0      | 4001  | 3000 | [blank]   | [blank] | 99          |
      | 170  | 171   | 1   | 0      | 4002  | 3000 | [blank]   | [blank] | 99          |
      | 171  | 172   | 1   | 0      | 4003  | 3000 | [blank]   | [blank] | 99          |
      | 172  | 173   | 1   | 0      | 4004  | 3000 | [blank]   | [blank] | 99          |
      | 173  | 174   | 1   | 0      | 4005  | 3000 | [blank]   | [blank] | 99          |
      | 174  | 175   | 1   | 0      | 4006  | 3000 | [blank]   | [blank] | 99          |
      | 175  | 176   | 1   | 0      | 4007  | 3000 | [blank]   | [blank] | 99          |
      | 176  | 177   | 1   | 0      | 4008  | 3000 | [blank]   | [blank] | 99          |
      | 177  | 178   | 1   | 0      | 4009  | 3000 | [blank]   | [blank] | 99          |
      | 178  | 179   | 1   | 0      | 4010  | 3000 | [blank]   | [blank] | 99          |
      | 179  | 180   | 1   | 0      | 4011  | 3000 | [blank]   | [blank] | 99          |
      | 180  | 181   | 1   | 0      | 4012  | 3000 | [blank]   | [blank] | 99          |
      | 181  | 182   | 1   | 0      | 4013  | 3000 | [blank]   | [blank] | 99          |
      | 182  | 183   | 1   | 0      | 4014  | 3000 | [blank]   | [blank] | 99          |
      | 183  | 184   | 1   | 0      | 4015  | 3000 | [blank]   | [blank] | 99          |
      | 184  | 185   | 1   | 0      | 4016  | 3000 | [blank]   | [blank] | 99          |
      | 185  | 186   | 1   | 0      | 4017  | 3000 | [blank]   | [blank] | 99          |
      | 186  | 187   | 1   | 0      | 4018  | 3000 | [blank]   | [blank] | 99          |
      | 187  | 188   | 1   | 0      | 4019  | 3000 | [blank]   | [blank] | 99          |
      | 188  | 189   | 1   | 0      | 4020  | 3000 | [blank]   | [blank] | 99          |
      | 189  | 190   | 1   | 0      | 4021  | 3000 | [blank]   | [blank] | 99          |
      | 190  | 191   | 1   | 0      | 4022  | 3000 | [blank]   | [blank] | 99          |
      | 191  | 192   | 1   | 0      | 4023  | 3000 | [blank]   | [blank] | 99          |
      | 192  | 193   | 1   | 0      | 4024  | 3000 | [blank]   | [blank] | 99          |
      | 193  | 194   | 1   | 0      | 4025  | 3000 | [blank]   | [blank] | 99          |
      | 194  | 195   | 1   | 0      | 4026  | 3000 | [blank]   | [blank] | 99          |
      | 195  | 196   | 1   | 0      | 4027  | 3000 | [blank]   | [blank] | 99          |
      | 196  | 197   | 1   | 0      | 4028  | 3000 | [blank]   | [blank] | 99          |
      | 197  | 198   | 1   | 0      | 4029  | 3000 | [blank]   | [blank] | 99          |
      | 198  | 199   | 1   | 0      | 4030  | 3000 | [blank]   | [blank] | 99          |
      | 199  | 200   | 1   | 0      | 4031  | 3000 | [blank]   | [blank] | 99          |


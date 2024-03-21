@feature=AdminVendorClaims
Feature: Admin Vendor Claims

  #
  # Vendor Claim testcase
  #

  @VendorClaim_01 @VendorClaims
  Scenario: Verify vendor claim with sku
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
    # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 109246 | 26        | 47332              | 2000             | 2000       | in_stock     | active | [blank]                  |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Claims" by sidebar
    And Vendor go to create claims page
    And Vendor verify default in create vendor claim
    And Vendor fill info to create vendor claim
      | vendor             | region           | issue             | uploadFile  | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | anhJPEG.jpg | Issue Description | Admin Note |
    And Vendor add sku to create vendor claim
      | sku               | quantity |
      | AT SKU Claim 2 01 | 2        |
    And Vendor verify can not add sku added in create vendor
      | sku               |
      | AT SKU Claim 2 01 |
    And Vendor remove sku to create vendor claim
      | sku               |
      | AT SKU Claim 2 01 |
    And Vendor add sku to create vendor claim
      | sku               | quantity |
      | AT SKU Claim 2 01 | 2        |

    And Vendor create vendor claim success with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours. If you'd like to submit another claim, please do so"
    And Vendor get vendor claim number after create
    And Vendor click here after create claim
    And Vendor verify list claims
      | submitted   | number           | brand             | region           | status |
      | currentDate | create by vendor | AT Brand Claim 01 | New York Express | Open   |
    And Vendor go to detail claim ""
    And Vendor verify info in claim detail
      | status | issueType         | region           | type | additionalNote |
      | Open   | Damaged Inventory | New York Express | sku  | Admin Note     |
    And Vendor verify sku info in claim detail
      | sku               | skuId | quantity |
      | AT SKU Claim 2 01 | 47269 | 2        |
    And Vendor verify upload file in claim detail
      | index | file        |
      | 1     | anhJPEG.jpg |
    # verify in claim detail
    And Vendor edit info in vendor claim
      | region              | issue                       | uploadFile  | issueDescription       | adminNote       |
      | Chicagoland Express | Inventory Count Discrepancy | anhJPG2.jpg | Issue Description Edit | Admin Note Edit |
    And Vendor update vendor claim success with message "Claim updated successfully."
    # Add sku in claim detail
    And Vendor add sku to vendor claim detail
      | sku               | quantity |
      | AT SKU Claim 2 04 | 1        |
    And Vendor verify can not add sku added in create vendor
      | sku               |
      | AT SKU Claim 2 04 |
    And Vendor remove sku to create vendor claim
      | sku               |
      | AT SKU Claim 2 04 |
    And Vendor add sku to vendor claim detail
      | sku               | quantity |
      | AT SKU Claim 2 04 | 2        |

    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
       # Active product and sku
    And Admin change info of regions attributes with sku "inactive"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 109246 | 26        | 47332              | 2000             | 2000       | in_stock     | inactive | [blank]                  |

    And Vendor update vendor claim success with message "Claim updated successfully."

  @VendorClaim_02 @VendorClaims
  Scenario: Verify vendor claim with order
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "47269" by api
    And Admin delete order of sku "47269" by api
    # Delete order
    When Search order by sku "47281" by api
    And Admin delete order of sku "47281" by api
     # Delete order
    When Search order by sku "47332" by api
    And Admin delete order of sku "47332" by api
    # Delete order
    When Search order by sku "49718" by api
    And Admin delete order of sku "49718" by api
     # Active product and sku
    And Admin change info of regions attributes with sku "inactive"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 109172 | 53        | 47269              | 1000             | 1000       | in_stock     | inactive | [blank]                  |
    # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109172             | 47269              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
    # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109184             | 47281              | 1        | false     | [blank]          |
      | 109185             | 47282              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"
     # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109246             | 47332              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3563     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "3"
    # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 112154             | 49718              | 1        | false     | [blank]          |
      | 112155             | 49719              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3563     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "4"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Claims" by sidebar
    And Vendor go to create claims page
    And Vendor verify default in create vendor claim
    And Vendor fill info to create vendor claim
      | vendor             | region           | issue             | uploadFile  | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | anhJPEG.jpg | Issue Description | Admin Note |
    # Add order to claim
    And Vendor select order to add in create vendor claim
      | index | order         |
      | 1     | create by api |
    And Vendor verify line item in order of add popup in create vendor claim
      | product             | brand             | sku               | skuID | quantity |
      | AT Product Claim 02 | AT Brand Claim 01 | AT SKU Claim 2 01 | 47269 | 1        |
    And Vendor select line item in order to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 01 |
    And Vendor add "order" in create vendor claim
    And Vendor verify can not add order added in create vendor
      | index | order         |
      | 1     | create by api |
     # Remove order to claim
    And Vendor remove order to create vendor claim
      | index | order         |
      | 1     | create by api |
    # Add order to claim
    And Vendor select order to add in create vendor claim
      | index | order         |
      | 1     | create by api |
    And Vendor select line item in order to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 01 |
    And Vendor add "order" in create vendor claim
    And Vendor edit order in claim detail
      | index | order         | sku               | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 2        |
     # Add order to claim
    And Vendor select order to add in create vendor claim
      | index | order         |
      | 2     | create by api |
    And Vendor select line item in order to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 02 |
      | AT SKU Claim 2 03 |
    And Vendor add "order" in create vendor claim

    And Vendor create vendor claim success with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours. If you'd like to submit another claim, please do so"
    And Vendor get vendor claim number after create
    And Vendor click here after create claim
    And Vendor verify list claims
      | submitted   | number           | brand             | region           | status |
      | currentDate | create by vendor | AT Brand Claim 01 | New York Express | Open   |
    And Vendor go to detail claim ""
    And Vendor verify info in claim detail
      | status | issueType         | region           | type  | additionalNote |
      | Open   | Damaged Inventory | New York Express | order | Admin Note     |
    And Vendor verify order info in claim detail
      | index | order         | brand             | product             | sku               | skuID | quantity |
      | 1     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 01 | 47269 | 2        |
      | 2     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 02 | 47282 | 1        |
      | 2     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 03 | 47281 | 1        |
    And Vendor verify upload file in claim detail
      | index | file        |
      | 1     | anhJPEG.jpg |
  # verify in claim detail
    And Vendor edit info in vendor claim
      | region              | issue                       | uploadFile  | issueDescription       | adminNote       |
      | Chicagoland Express | Inventory Count Discrepancy | anhJPG2.jpg | Issue Description Edit | Admin Note Edit |
    And Vendor update vendor claim success with message "Claim updated successfully."
    And Admin wait 2000 mini seconds
  # Add order to claim
    And Vendor select order to add in create vendor claim
      | index | order         |
      | 3     | create by api |
    And Vendor verify line item in order of add popup in create vendor claim
      | product             | brand             | sku               | skuID | quantity |
      | AT Product Claim 02 | AT Brand Claim 01 | AT SKU Claim 2 04 | 47332 | 1        |
    And Vendor select line item in order to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 04 |
    And Vendor add "order" in create vendor claim
    And Vendor verify can not add order added in create vendor
      | index | order         |
      | 3     | create by api |
     # Remove order to claim
    And Vendor remove order to create vendor claim
      | index | order         |
      | 3     | create by api |
    # Add order to claim
    And Vendor select order to add in create vendor claim
      | index | order         |
      | 3     | create by api |
    And Vendor select line item in order to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 04 |
    And Vendor add "order" in create vendor claim
    And Vendor edit order in claim detail
      | index | order         | sku               | quantity |
      | 3     | create by api | AT SKU Claim 2 04 | 2        |
  # Add order to claim
    And Vendor select order to add in create vendor claim
      | index | order         |
      | 4     | create by api |
    And Vendor select line item in order to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 05 |
      | AT SKU Claim 2 06 |
    And Vendor add "order" in create vendor claim
    And Vendor update vendor claim success with message "Claim updated successfully."
    And Vendor verify order info in claim detail
      | index | order         | brand             | product             | sku               | skuID | quantity |
      | 3     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 04 | 47332 | 2        |
      | 4     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 05 | 49718 | 1        |
      | 4     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 06 | 49719 | 1        |
    And Vendor verify upload file in claim detail
      | index | file        |
      | 1     | anhJPEG.jpg |
      | 2     | anhJPG2.jpg |

  @VendorClaim_03 @VendorClaims
  Scenario: Check when adding orders but the order is deleted at the same time
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "47269" by api
    And Admin delete order of sku "47269" by api
    # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109172             | 47269              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin save order number by index "1"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Claims" by sidebar
    And Vendor go to create claims page
    And Vendor verify default in create vendor claim
    And Vendor fill info to create vendor claim
      | vendor             | region           | issue             | uploadFile  | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | anhJPEG.jpg | Issue Description | Admin Note |

    And Vendor select order to add in create vendor claim
      | index | order         |
      | 1     | create by api |
    And Vendor select line item in order to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 01 |
    And Vendor add "order" in create vendor claim

    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "47269" by api
    And Admin delete order of sku "47269" by api

    And Switch to actor VENDOR
    And Vendor create vendor claim success with message "Order must exist"

  @VendorClaim_04 @AdminVendorClaims
  Scenario: Verify vendor claim with inbound
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
    # Delete claim
    When Admin search vendor claim by api
      | q[vendor_company_id] | q[brand_id] | q[vendor_name]     | q[manager_id] | q[number]     | q[start_date] | q[end_date] |
      | 1937                 | 3113        | AT Vendor Order 01 | [blank]       | create by api | [blank]       | [blank]     |
    And Admin delete vendor claim "" by api
    # Delete inbound
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3113  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47269              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 53        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 121          |
    And Admin save inbound number by index "1"
    And Admin clear list sku inbound by API

     # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47282              | 1937              | 10       |
      | 47281              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 53        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 121          |
    And Admin save inbound number by index "2"
    And Admin clear list sku inbound by API

    # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47332              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    And Admin save inbound number by index "3"
    And Admin clear list sku inbound by API
     # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 49718              | 1937              | 10       |
      | 49719              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    And Admin save inbound number by index "4"
    And Admin clear list sku inbound by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Claims" by sidebar
    And Vendor go to create claims page
    And Vendor verify default in create vendor claim
    And Vendor fill info to create vendor claim
      | vendor             | region           | issue             | uploadFile  | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | anhJPEG.jpg | Issue Description | Admin Note |
    # Add order to claim
    And Vendor select inbound to add in create vendor claim
      | index | inbound       |
      | 1     | create by api |
    And Vendor verify line item in order of add popup in create vendor claim
      | product             | brand             | sku               | skuID | quantity |
      | AT Product Claim 02 | AT Brand Claim 01 | AT SKU Claim 2 01 | 47269 | 1        |
    And Vendor select line item in inbound to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 01 |
    And Vendor add "inbound inventory" in create vendor claim
    And Vendor verify can not add inbound added in create vendor
      | index | order         |
      | 1     | create by api |
     # Remove inbound to claim
    And Vendor remove inbound to create vendor claim
      | index | inbound       |
      | 1     | create by api |
    # Add order to claim
    And Vendor select inbound to add in create vendor claim
      | index | inbound       |
      | 1     | create by api |
    And Vendor select line item in inbound to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 01 |
    And Vendor add "inbound inventory" in create vendor claim
    And Vendor edit inbound in claim detail
      | index | inbound       | sku               | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 2        |
     # Add order to claim
    And Vendor select inbound to add in create vendor claim
      | index | inbound       |
      | 2     | create by api |
    And Vendor select line item in inbound to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 02 |
      | AT SKU Claim 2 03 |
    And Vendor add "inbound inventory" in create vendor claim

    And Vendor create vendor claim success with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours. If you'd like to submit another claim, please do so"
    And Vendor get vendor claim number after create
    And Vendor click here after create claim
    And Vendor verify list claims
      | submitted   | number           | brand             | region           | status |
      | currentDate | create by vendor | AT Brand Claim 01 | New York Express | Open   |
    And Vendor go to detail claim ""
    And Vendor verify info in claim detail
      | status | issueType         | region           | type    | additionalNote |
      | Open   | Damaged Inventory | New York Express | inbound | Admin Note     |
    And Vendor verify "inbound" info in claim detail
      | index | number        | brand             | product             | sku               | skuID | quantity |
      | 1     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 01 | 47269 | 2        |
      | 2     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 02 | 47282 | 1        |
      | 2     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 03 | 47281 | 1        |
    And Vendor verify upload file in claim detail
      | index | file        |
      | 1     | anhJPEG.jpg |

     # verify in claim detail
    And Vendor edit info in vendor claim
      | region              | issue                       | uploadFile  | issueDescription       | adminNote       |
      | Chicagoland Express | Inventory Count Discrepancy | anhJPG2.jpg | Issue Description Edit | Admin Note Edit |
    And Vendor update vendor claim success with message "Claim updated successfully."
    And Admin wait 2000 mini seconds
     # Add inbound to claim
    And Vendor select inbound to add in create vendor claim
      | index | inbound       |
      | 3     | create by api |
    And Vendor verify line item in order of add popup in create vendor claim
      | product             | brand             | sku               | skuID | quantity |
      | AT Product Claim 02 | AT Brand Claim 01 | AT SKU Claim 2 04 | 47332 | 1        |
    And Vendor select line item in inbound to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 04 |
    And Vendor add "inbound inventory" in create vendor claim
    And Vendor verify can not add inbound added in create vendor
      | index | order         |
      | 3     | create by api |
     # Remove inbound to claim
    And Vendor remove inbound to create vendor claim
      | index | inbound       |
      | 3     | create by api |
    # Add inbound to claim
    And Vendor select inbound to add in create vendor claim
      | index | inbound       |
      | 3     | create by api |
    And Vendor select line item in inbound to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 04 |
    And Vendor add "inbound inventory" in create vendor claim
    And Vendor edit inbound in claim detail
      | index | inbound       | sku               | quantity |
      | 3     | create by api | AT SKU Claim 2 04 | 2        |
     # Add order to claim
    And Vendor select inbound to add in create vendor claim
      | index | inbound       |
      | 4     | create by api |
    And Vendor select line item in inbound to add in create vendor claim
      | sku               |
      | AT SKU Claim 2 05 |
      | AT SKU Claim 2 06 |
    And Vendor add "inbound inventory" in create vendor claim
    And Vendor update vendor claim success with message "Claim updated successfully."
    And Vendor verify "inbound" info in claim detail
      | index | number        | brand             | product             | sku               | skuID | quantity |
      | 3     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 04 | 47332 | 2        |
      | 4     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 05 | 49718 | 1        |
      | 4     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 06 | 49719 | 1        |
    And Vendor verify upload file in claim detail
      | index | file        |
      | 1     | anhJPEG.jpg |
      | 2     | anhJPG2.jpg |

    Given NGOC_ADMIN_21 open web admin
    When NGOC_ADMIN_21 login to web with role Admin
    And NGOC_ADMIN_21 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin search vendor claim
      | vendorCompany   | brand             | vendor             | managedBy | status | claimNumber     | startDate | endDate     |
      | AT Vendor Order | AT Brand Claim 01 | AT Vendor Order 01 | [blank]   | Open   | create by admin | Minus1    | currentDate |
    And Admin verify vendor claim after result
      | claimNumber     | vendorCompany   | brand             | inbound | issue                       | status |
      | create by admin | AT Vendor Order | AT Brand Claim 01 | 1       | Inventory Count Discrepancy | Open   |
    And Admin go to detail vendor claim "create by admin"
    And Admin verify general information in vendor claim detail
      | name               | vendorCompany   | brand             | region              | issue                       | issueDescription | type                 | dateOfSubmission | status | adminNote |
      | AT Vendor Order 01 | AT Vendor Order | AT Brand Claim 01 | Chicagoland Express | Inventory Count Discrepancy | Admin Note Edit  | Inbound Inventory(s) | currentDate      | Open   | [blank]   |
    And Admin verify "inbound" in vendor claim detail
      | index | number        | sku               | skuID | quantity |
      | 3     | create by api | AT SKU Claim 2 04 | 47332 | 2        |
      | 4     | create by api | AT SKU Claim 2 05 | 49718 | 1        |
      | 4     | create by api | AT SKU Claim 2 06 | 49719 | 1        |
    And Admin verify uploaded file in vendor claim detail
      | fileName    |
      | anhJPEG.jpg |
      | anhJPG2.jpg |
    And Admin change status of vendor claim to "Resolved"

    And Switch to actor VENDOR
    And VENDOR refresh browser
    And Vendor verify resolved info in claim detail
      | status   | region              | issue                       | additionalNote  |
      | Resolved | Chicagoland Express | Inventory Count Discrepancy | Admin Note Edit |
    And Vendor verify "inbound" info in claim detail
      | index | number        | brand             | product             | sku               | skuID | quantity |
      | 3     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 04 | 47332 | 2        |
      | 4     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 05 | 49718 | 1        |
      | 4     | create by api | AT Brand Claim 01 | AT Product Claim 02 | AT SKU Claim 2 06 | 49719 | 1        |

  #
  # Admin Vendor Claim testcase
  #

  @AdminVendorClaims_01 @AdminVendorClaim
  Scenario: Verify vendor claim with sku
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
     # Delete claim
    When Admin search vendor claim by api
      | q[vendor_company_id] | q[brand_id] | q[vendor_name]     | q[manager_id] | q[number]     | q[start_date] | q[end_date] |
      | 1937                 | 3113        | AT Vendor Order 01 | [blank]       | create by api | [blank]       | [blank]     |
    And Admin delete vendor claim "" by api

    Given NGOC_ADMIN_20 open web admin
    When NGOC_ADMIN_20 login to web with role Admin
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin go to create claims page
    And Admin verify default in create vendor claim
    And Admin fill info to create vendor claim
      | vendor             | region           | issue             | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | Issue Description | Admin Note |
    And Admin upload file to create vendor claim
      | uploadFile  |
      | anhJPEG.jpg |
    And Admin add sku to create vendor claim
      | sku               | quantity |
      | AT SKU Claim 2 01 | 2        |
      | AT SKU Claim 2 01 | 2        |
    And Admin remove sku to create vendor claim
      | sku               |
      | AT SKU Claim 2 01 |
    And Admin add sku to create vendor claim
      | sku               | quantity |
      | AT SKU Claim 2 01 | 2        |
    Then Admin verify sku added in create vendor claim
      | sku               | skuID | quantity |
      | AT SKU Claim 2 01 | 47269 | 2        |
    And Admin create vendor claim success
    And Admin verify general information in vendor claim detail
      | name               | vendorCompany   | brand             | region           | issue             | issueDescription  | type   | dateOfSubmission | status | adminNote  |
      | AT Vendor Order 01 | AT Vendor Order | AT Brand Claim 01 | New York Express | Damaged Inventory | Issue Description | SKU(s) | currentDate      | Open   | Admin Note |
    And Admin get number of vendor claim in detail
    And Admin verify uploaded file in vendor claim detail
      | fileName    |
      | anhJPEG.jpg |
    And Admin verify sku info in vendor claim detail
      | sku               | skuID | quantity |
      | AT SKU Claim 2 01 | 47269 | 2        |
    # Edit general information
    And Admin edit general information in vendor claim detail
      | region              | issue                       | issueDescription  | adminNote  |
      | Chicagoland Express | Inventory Count Discrepancy | Issue Description | Admin Note |
    # Add sku in detail
    And Admin add sku to vendor claim detail
      | sku               | quantity |
      | AT SKU Claim 2 04 | 2        |
      | AT SKU Claim 2 05 | 2        |
    Then Admin verify sku added in create vendor claim
      | sku               | skuID | quantity |
      | AT SKU Claim 2 04 | 47332 | 2        |
      | AT SKU Claim 2 05 | 49718 | 2        |
    And Admin save action in vendor claim detail
    And Admin verify assigned to blank in vendor claim detail
    And Admin assigned to in vendor claim detail
      | assigned |
      | ngoctx21 |
      | ngoctx20 |
    And Admin verify assigned of vendor claim detail
      | assigned |
      | ngoctx21 |
      | ngoctx20 |
    # Verify in search with criteria vendor company
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin search vendor claim
      | vendorCompany        | brand   | vendor  | managedBy | status  | claimNumber | startDate | endDate |
      | ngoctx vcstatement01 | [blank] | [blank] | [blank]   | [blank] | [blank]     | [blank]   | [blank] |
    And Admin no found data in result
    And Admin search vendor claim
      | vendorCompany   | brand   | vendor  | managedBy | status  | claimNumber     | startDate | endDate |
      | AT Vendor Order | [blank] | [blank] | [blank]   | [blank] | create by admin | [blank]   | [blank] |
    And Admin verify vendor claim after result
      | claimNumber     | vendorCompany   | brand             | inbound | issue                       | status | assignedTo |
      | create by admin | AT Vendor Order | AT Brand Claim 01 | [blank] | Inventory Count Discrepancy | Open   | ngoctx21   |
     # Verify in search with criteria brand
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin search vendor claim
      | vendorCompany | brand                       | vendor  | managedBy | status  | claimNumber | startDate | endDate |
      | [blank]       | AT Brand Store Statement 01 | [blank] | [blank]   | [blank] | [blank]     | [blank]   | [blank] |
    And Admin no found data in result
    And Admin search vendor claim
      | vendorCompany | brand             | vendor  | managedBy | status  | claimNumber     | startDate | endDate |
      | [blank]       | AT Brand Claim 01 | [blank] | [blank]   | [blank] | create by admin | [blank]   | [blank] |
    And Admin verify vendor claim after result
      | claimNumber     | vendorCompany   | brand             | inbound | issue                       | status | assignedTo |
      | create by admin | AT Vendor Order | AT Brand Claim 01 | [blank] | Inventory Count Discrepancy | Open   | ngoctx21   |
     # Verify in search with criteria vendor name
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin search vendor claim
      | vendorCompany | brand   | vendor | managedBy | status  | claimNumber | startDate | endDate |
      | [blank]       | [blank] | state  | [blank]   | [blank] | [blank]     | [blank]   | [blank] |
    And Admin no found data in result
    And Admin search vendor claim
      | vendorCompany | brand   | vendor             | managedBy | status  | claimNumber     | startDate | endDate |
      | [blank]       | [blank] | AT Vendor Order 01 | [blank]   | [blank] | create by admin | [blank]   | [blank] |
    And Admin verify vendor claim after result
      | claimNumber     | vendorCompany   | brand             | inbound | issue                       | status | assignedTo |
      | create by admin | AT Vendor Order | AT Brand Claim 01 | [blank] | Inventory Count Discrepancy | Open   | ngoctx21   |

    And Admin go to detail vendor claim "create by admin"
    And Admin change status of vendor claim to "Under review"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Claims" by sidebar
    And Vendor verify list claims
      | submitted   | number           | brand             | region              | status       |
      | currentDate | create by vendor | AT Brand Claim 01 | Chicagoland Express | Under Review |
    And Vendor go to detail claim ""
    And Vendor verify info in claim detail
      | status       | issueType                   | region              | type | additionalNote    |
      | Under Review | Inventory Count Discrepancy | Chicagoland Express | sku  | Issue Description |
    And Vendor verify sku info in claim detail
      | sku                | skuId | quantity |
      | AT SKU Claim 2 04  | 47332 | 2        |
      | AT SKU Claim 2 050 | 49718 | 2        |
    And Vendor verify upload file in claim detail
      | index | file        |
      | 1     | anhJPEG.jpg |

  @AdminVendorClaims_02 @AdminVendorClaims
  Scenario: Verify vendor claim with inbound
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
    # Delete claim
    When Admin search vendor claim by api
      | q[vendor_company_id] | q[brand_id] | q[vendor_name]     | q[manager_id] | q[number]     | q[start_date] | q[end_date] |
      | 1937                 | 3113        | AT Vendor Order 01 | [blank]       | create by api | [blank]       | [blank]     |
    And Admin delete vendor claim "" by api
    # Delete inbound
    And Admin search Incoming Inventory by api
      | field       | value |
      | q[brand_id] | 3113  |
    And Admin cancel Incoming Inventory by api
      | reason   |
      | Autotest |
      # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47269              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 53        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 121          |
    And Admin save inbound number by index "1"
    And Admin clear list sku inbound by API

     # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47282              | 1937              | 10       |
      | 47281              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 53        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 121          |
    And Admin save inbound number by index "2"
    And Admin clear list sku inbound by API

    # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 47332              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    And Admin save inbound number by index "3"
    And Admin clear list sku inbound by API
     # Create inbound by index
    And Admin add SKU to Incoming Inventory api
      | product_variant_id | vendor_company_id | quantity |
      | 49718              | 1937              | 10       |
      | 49719              | 1937              | 10       |
    And Admin create Incoming Inventory api
      | region_id | vendor_company_id | num_of_pallet | num_of_sellable_retail_case | estimated_covered_period | notes | admin_note | warehouse_id |
      | 26        | 1937              | 10            | 10                          | 1                        | 1     | 1          | 99           |
    And Admin save inbound number by index "4"
    And Admin clear list sku inbound by API

    Given NGOC_ADMIN_20 open web admin
    When NGOC_ADMIN_20 login to web with role Admin
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin go to create claims page
    And Admin fill info to create vendor claim
      | vendor             | region           | issue             | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | Issue Description | Admin Note |
    And Admin upload file to create vendor claim
      | uploadFile  |
      | anhJPEG.jpg |
   # Add inbound
    And Admin add inbound to create vendor claim
      | index | inbound       |
      | 1     | create by api |
      | 2     | create by api |
    # Remove inbound
    And Admin remove inbound to create vendor claim
      | index | inbound       |
      | 1     | create by api |
      | 2     | create by api |
      # Add inbound
    And Admin add inbound to create vendor claim
      | index | inbound       |
      | 1     | create by api |
      | 2     | create by api |
    # Edit inbound
    And Admin edit line item of inbound to create vendor claim
      | index | inbound       | sku               | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 2        |
      | 2     | create by api | AT SKU Claim 2 02 | 2        |
      | 2     | create by api | AT SKU Claim 2 03 | 2        |
    Then Admin verify inbound added in create vendor claim
      | index | inbound       | sku               | skuID | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 47269 | 2        |
      | 2     | create by api | AT SKU Claim 2 02 | 47282 | 2        |
      | 2     | create by api | AT SKU Claim 2 03 | 47281 | 2        |

    And Admin create vendor claim success
    # Verify general information
    And Admin verify general information in vendor claim detail
      | name               | vendorCompany   | brand   | region           | issue             | issueDescription  | type                 | dateOfSubmission | status | adminNote  |
      | AT Vendor Order 01 | AT Vendor Order | [blank] | New York Express | Damaged Inventory | Issue Description | Inbound Inventory(s) | currentDate      | Open   | Admin Note |
    And Admin get number of vendor claim in detail
    And Admin verify "inbound" in vendor claim detail
      | index | number        | sku               | skuID | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 47269 | 2        |
      | 2     | create by api | AT SKU Claim 2 02 | 47282 | 2        |
      | 2     | create by api | AT SKU Claim 2 03 | 47281 | 2        |
    # verify in claim list
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin search vendor claim
      | vendorCompany   | brand             | vendor             | managedBy | status | claimNumber     | startDate | endDate     |
      | AT Vendor Order | AT Brand Claim 01 | AT Vendor Order 01 | [blank]   | Open   | create by admin | Minus1    | currentDate |
    And Admin verify vendor claim after result
      | claimNumber     | vendorCompany   | brand             | inbound | issue             | status  | assignedTo |
      | create by admin | AT Vendor Order | AT Brand Claim 01 | 1       | Damaged Inventory | Open    | [blank]    |
      | [blank]         | [blank]         | [blank]           | 2       | [blank]           | [blank] | [blank]    |
    And Admin go to detail vendor claim "create by admin"
    And Admin edit general information in vendor claim detail
      | region           | issue             | issueDescription  | adminNote  |
      | New York Express | Damaged Inventory | Issue Description | Admin Note |
    # Add inbound
    And Admin add inbound in vendor claim detail
      | index | inbound       |
      | 1     | create by api |
      | 2     | create by api |
    # Remove inbound
    And Admin remove inbound to create vendor claim
      | index | inbound       |
      | 1     | create by api |
      | 2     | create by api |
      # Add inbound
    And Admin add inbound in vendor claim detail
      | index | inbound       |
      | 1     | create by api |
      | 2     | create by api |
    # Edit inbound
    And Admin edit line item of inbound to create vendor claim
      | index | inbound       | sku               | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 2        |
      | 2     | create by api | AT SKU Claim 2 02 | 2        |
      | 2     | create by api | AT SKU Claim 2 03 | 2        |
    And Admin save action in vendor claim detail
    And Admin verify general information in vendor claim detail
      | name               | vendorCompany   | brand   | region           | issue             | issueDescription  | type                 | dateOfSubmission | status | adminNote  |
      | AT Vendor Order 01 | AT Vendor Order | [blank] | New York Express | Damaged Inventory | Issue Description | Inbound Inventory(s) | currentDate      | Open   | Admin Note |
    Then Admin verify inbound added in create vendor claim
      | index | inbound       | sku               | skuID | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 47269 | 2        |
      | 2     | create by api | AT SKU Claim 2 02 | 47282 | 2        |
      | 2     | create by api | AT SKU Claim 2 03 | 47281 | 2        |
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin search vendor claim
      | vendorCompany   | brand             | vendor             | managedBy | status | claimNumber     | startDate | endDate     |
      | AT Vendor Order | AT Brand Claim 01 | AT Vendor Order 01 | [blank]   | Open   | create by admin | Minus1    | currentDate |
    And Admin delete vendor claim ""
    And Admin search vendor claim
      | vendorCompany | brand   | vendor  | managedBy | status | claimNumber     | startDate | endDate |
      | [blank]       | [blank] | [blank] | [blank]   | Open   | create by admin | [blank]   | [blank] |
    And Admin no found data in result

  @AdminVendorClaims_03 @AdminVendorClaims
  Scenario: Verify vendor claim with blank upload file
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
     # Delete claim
    When Admin search vendor claim by api
      | q[vendor_company_id] | q[brand_id] | q[vendor_name]     | q[manager_id] | q[number]     | q[start_date] | q[end_date] |
      | 1937                 | 3113        | AT Vendor Order 01 | [blank]       | create by api | [blank]       | [blank]     |
    And Admin delete vendor claim "" by api
#    # Delete order
#    When Search order by sku "47262" by api
#    And Admin delete order of sku "47262" by api
#    # Create order of store 01
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | 109162             | 47262              | 8        | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_20 open web admin
    When NGOC_ADMIN_20 login to web with role Admin
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin go to create claims page
    And Admin fill info to create vendor claim
      | vendor             | region           | issue             | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | Issue Description | Admin Note |
    And Admin add sku to create vendor claim
      | sku               | quantity |
      | AT SKU Claim 2 01 | 2        |
    Then Admin verify sku added in create vendor claim
      | sku               | skuID | quantity |
      | AT SKU Claim 2 01 | 47269 | 2        |
    And Admin verify upload file
    And Admin create vendor claim success then see message "Vendor claim documents attachment can't be blank"

  @AdminVendorClaims_04 @AdminVendorClaims
  Scenario: Verify vendor claim with upload file 10 file
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
     # Delete claim
    When Admin search vendor claim by api
      | q[vendor_company_id] | q[brand_id] | q[vendor_name]     | q[manager_id] | q[number]     | q[start_date] | q[end_date] |
      | 1937                 | 3113        | AT Vendor Order 01 | [blank]       | create by api | [blank]       | [blank]     |
    And Admin delete vendor claim "" by api

    Given NGOC_ADMIN_20 open web admin
    When NGOC_ADMIN_20 login to web with role Admin
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin go to create claims page
    And Admin fill info to create vendor claim
      | vendor             | region           | issue             | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | Issue Description | Admin Note |
    And Admin upload file to create vendor claim
      | uploadFile  |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
    And Admin create vendor claim success
    And Admin verify general information in vendor claim detail
      | name               | vendorCompany   | brand   | region           | issue             | issueDescription  | type    | dateOfSubmission | status | adminNote  |
      | AT Vendor Order 01 | AT Vendor Order | [blank] | New York Express | Damaged Inventory | Issue Description | [blank] | currentDate      | Open   | Admin Note |
    And Admin get number of vendor claim in detail
    And Admin verify uploaded file in vendor claim detail
      | fileName    |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |
      | anhJPEG.jpg |

  @AdminVendorClaims_05 @AdminVendorClaims
  Scenario: Verify vendor claim with order
    Given NGOCTX20 login web admin by api
      | email                | password  |
      | ngoctx20@podfoods.co | 12345678a |
     # Delete claim
    When Admin search vendor claim by api
      | q[vendor_company_id] | q[brand_id] | q[vendor_name]     | q[manager_id] | q[number]     | q[start_date] | q[end_date] |
      | 1937                 | 3113        | AT Vendor Order 01 | [blank]       | create by api | [blank]       | [blank]     |
    And Admin delete vendor claim "" by api
    # Delete order
    When Search order by sku "47269" by api
    And Admin delete order of sku "47269" by api
    # Delete order
    When Search order by sku "47281" by api
    And Admin delete order of sku "47281" by api
     # Delete order
    When Search order by sku "47332" by api
    And Admin delete order of sku "47332" by api
     # Delete order
    When Search order by sku "49718" by api
    And Admin delete order of sku "49718" by api
     # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109172             | 47269              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "1"
    # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109184             | 47281              | 1        | false     | [blank]          |
      | 109185             | 47282              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "2"
     # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 109246             | 47332              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3563     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "3"
    # Create order with index
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 112154             | 49718              | 1        | false     | [blank]          |
      | 112155             | 49719              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3563     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Admin save order number by index "4"

    Given NGOC_ADMIN_20 open web admin
    When NGOC_ADMIN_20 login to web with role Admin
    And NGOC_ADMIN_20 navigate to "Claims" to "Vendor Claims" by sidebar
    And Admin go to create claims page
    And Admin fill info to create vendor claim
      | vendor             | region           | issue             | issueDescription  | adminNote  |
      | AT Vendor Order 01 | New York Express | Damaged Inventory | Issue Description | Admin Note |
      # Add order
    And Admin add order to create vendor claim
      | index | order         |
      | 1     | create by api |
      | 2     | create by api |
      # Edit order
    And Admin edit line item of order to create vendor claim
      | index | order         | sku               | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 2        |
      | 2     | create by api | AT SKU Claim 2 02 | 2        |
      | 2     | create by api | AT SKU Claim 2 03 | 2        |
    Then Admin verify order added in create vendor claim
      | index | order         | sku               | skuID | quantity |
      | 1     | create by api | AT SKU Claim 2 01 | 47269 | 2        |
      | 2     | create by api | AT SKU Claim 2 02 | 47282 | 2        |
      | 2     | create by api | AT SKU Claim 2 03 | 47281 | 2        |
    # Remove order
    And Admin remove order to create vendor claim
      | index | order         |
      | 1     | create by api |
      | 2     | create by api |
      # Add order
    And Admin add order to create vendor claim
      | index | order         |
      | 1     | create by api |
      | 2     | create by api |
    # Upload file
    And Admin upload file to create vendor claim
      | uploadFile  |
      | anhJPEG.jpg |
    And Admin create vendor claim success
    And Admin verify general information in vendor claim detail
      | name               | vendorCompany   | brand   | region           | issue             | issueDescription  | type     | dateOfSubmission | status | adminNote  |
      | AT Vendor Order 01 | AT Vendor Order | [blank] | New York Express | Damaged Inventory | Issue Description | Order(s) | currentDate      | Open   | Admin Note |
    And Admin get number of vendor claim in detail
    # Add inbound
    And Admin add order in vendor claim detail
      | index | order         |
      | 1     | create by api |
      | 2     | create by api |

    And Admin verify "order" in vendor claim detail
      | index | number        | sku               | skuID | quantity |
      | 3     | create by api | AT SKU Claim 2 04 | 47332 | 2        |
      | 4     | create by api | AT SKU Claim 2 05 | 49718 | 1        |
      | 4     | create by api | AT SKU Claim 2 06 | 49719 | 1        |













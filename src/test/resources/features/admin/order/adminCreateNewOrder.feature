@feature=AdminCreateNewOrder
Feature: Admin create new order - order list

  @AdminCreateNewOrder_01 @AdminCreateNewOrder
  Scenario: Check display of Create new order page
    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1001@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "Create new order" by sidebar
    And Admin verify error message when leave field blank in create new order
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_02 @AdminCreateNewOrder
  Scenario: Check display of section of line item - MOQ item
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1002@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 03 | 36181              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 04 | 36182              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date | out_of_stock_reason   |
      | 93980 | 53        | 36181              | 1000             | 1000       | sold_out     | active | [blank]                  | pending_replenishment |
    # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date | out_of_stock_reason   |
      | 93981 | 53        | 36182              | 1000             | 1000       | sold_out     | active | [blank]                  | pending_replenishment |

    Given NGOC_ADMIN_1002 open web admin
    When login to beta web with email "ngoctx1002@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1002 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                     | paymentType    | street              | city     | state    | zip   |
      | ngoctx stadminorder01ny01 | Pay by invoice | 281 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item is "AT SKU A Order 01"
    And Admin add line item is "AT SKU B Checkout 13"
    And Admin verify MOQ require of line items in create new ghost orders
      | itemMOQ        | message                                                                           |
      | ITEMS WITH MOQ | The line-item(s) highlighted below doesn't meet the minimum order quantity (MOQ). |
    Then Admin verify line item added
      | title          | brand                   | product               | sku               | tag   | upc          | unit         |
      | Items with MOQ | AT BRAND ADMIN ORDER 01 | AT Product A Order 01 | AT SKU A Order 01 | 36180 | 180219939999 | 1 units/case |
    And Admin edit line item in create new order page
      | skuID | quantity |
      | 36180 | 5        |

    And Admin verify MOV require of line items in create new ghost orders
      | companyName                  | totalPayment | movPrice    | message                                                                                                                                               |
      | AT VENDOR BUYER CHECKOUT 12C | $10.00       | $100.00 MOV | Please add more case(s) to any SKU below to meet the minimum order value required. This vendor may not fulfill if this minimum is not met. Thank you! |
    Then Admin verify line item added
      | title                    | brand                  | product                  | sku                  | tag   | upc          | unit         |
      | AT Product B Checkout 13 | AT BRAND B CHECKOUT 13 | AT Product B Checkout 13 | AT SKU B Checkout 13 | 35136 | 112312414213 | 1 units/case |
    And Admin edit line item in create new order page
      | skuID | quantity |
      | 35136 | 10       |
    And NGOC_ADMIN_1002 quit browser

  @AdminCreateNewOrder_03 @AdminCreateNewOrder
  Scenario: Check upload CSV
    Given NGOC_ADMIN_1003 open web admin
    When login to beta web with email "ngoctx1003@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1003 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                     | paymentType    | street              | city     | state    | zip   |
      | ngoctx stcheckout121chi01 | Pay by invoice | 281 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item is "AT SKU Upload08"
    Then Admin verify line item added
      | title          | brand           | product           | sku             | tag   | upc          | unit         |
      | Items with MOQ | AT BRAND UPLOAD | AT Product Upload | AT SKU Upload08 | 30645 | 180219931238 | 1 units/case |
    And Admin upload file order "autotest.csv"
    Then Admin verify info after upload file CSV
      | nameSKU              | info  | warning                                    | danger                                                | uploadedPrice | estimatedPrice | quantity | promoPrice |
      | AT SKU Upload01      | empty | empty                                      | empty                                                 | $10.00        | $10.00         | 1        | empty      |
      | AT SKU Upload02      | empty | empty                                      | empty                                                 | $15.00        | $20.00         | 2        | empty      |
      | AT SKU Upload03      | empty | empty                                      | This upc / ean not found                              | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload04      | empty | empty                                      | The UPC / EAN is used for multiple SKUs               | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload05      | empty | empty                                      | The UPC / EAN is used for multiple SKUs               | $15.00        | empty          | empty    | empty      |
      | empty                | empty | empty                                      | This item isn't available to the selected buyer/store | $15.00        | empty          | empty    | empty      |
      | empty                | empty | empty                                      | This upc / ean not found                              | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload08      | empty | empty                                      | This SKU was already uploaded                         | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload09      | empty | This item’s quantity doesn't meet the MOQs | Quantity should not be 0                              | $15.00        | $0.00          | 0        | empty      |
      | AT SKU Upload10      | empty | empty                                      | empty                                                 | $15.00        | $0.00          | 0        | empty      |
      | empty                | empty | empty                                      | This upc / ean not found                              | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload MOV 01 | empty | empty                                      | empty                                                 | $15.00        | $144.00        | 12       | empty      |
      | AT SKU MOV2 01       | empty | empty                                      | empty                                                 | $15.00        | $1,690.00      | 13       | empty      |
      | AT SKU Upload14      | empty | empty                                      | empty                                                 | $15.00        | $1,400.00      | 14       | empty      |
    And Admin verify price in create order upload file
      | type      | totalCase | totalOrderValue | discount | taxes | logisticsSurcharge | specialDiscount | totalPayment |
      | Total     | 42        | $3,264.00       | $0.00    | $0.00 | [blank]            | [blank]         | $3,264.00    |
      | In stock  | 40        | $3,244.00       | $0.00    | $0.00 | [blank]            | [blank]         | $3,244.00    |
      | OOS or LS | 2         | $20.00          | $0.00    | $0.00 | [blank]            | [blank]         | $20.00       |
    And Admin upload file CSV success
    And NGOC_ADMIN_1003 quit browser

  @AdminCreateNewOrder_04 @AdminCreateNewOrder
  Scenario: Verify summary section
    Given NGOC_ADMIN_1004 open web admin
    When login to beta web with email "ngoctx1004@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1004 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                     | paymentType    | street              | city     | state    | zip   |
      | ngoctx stadminorder01ny01 | Pay by invoice | 281 Columbus Avenue | New York | New York | 10023 |
    Then Verify price "total" in create new order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    Then Verify price "in stock" in create new order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    Then Verify price "OOS or LS" in create new order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | [blank]             | [blank]            | $0.00           | $0.00        |
    And Admin add line item is "AT SKU A Order 01"
    Then Admin verify summary in create new order
      | sos     | ls      |
      | $500.00 | [blank] |
    And NGOC_ADMIN_1004 quit browser

  @AdminCreateNewOrder_05 @AdminCreateNewOrder
  Scenario: Verify search and filter - Lack of POD
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1005@podfoods.co | 12345678a |
    When Search order by sku "36180" by api
    And Admin delete order of sku "36180" by api
      # Set pricing
    And Admin set Fixed pricing of brand "3368" with "0.25" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 01 | 36180              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 93979              | 36180              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_1005 open web admin
    When login to beta web with email "ngoctx1005@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1005 navigate to "Orders" to "All orders" by sidebar

    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And NGOC_ADMIN_1005 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | proof_1.jpg | adminNote | lpNote |

    And NGOC_ADMIN_1005 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | Yes | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin no found order in result
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | No  | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $2.50     | Pending      | Fulfilled   | Pending       |
    And NGOC_ADMIN_1005 quit browser

  @AdminCreateNewOrder_06 @AdminCreateNewOrder
  Scenario: Verify search and filter - Lack of Tracking
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1006@podfoods.co | 12345678a |
    When Search order by sku "36181" by api
    And Admin delete order of sku "36181" by api
       # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 93980 | 53        | 36181              | 1000             | 1000       | in_stock     | active | [blank]                  |
    # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 93981 | 53        | 36182              | 1000             | 1000       | in_stock     | active | [blank]                  |
    # Set pricing
    And Admin set Fixed pricing of brand "3368" with "0.25" by API
     # Change credit limit
    And Admin change credit limit of buyer company "2468" by API
      | buyer_company_id | id   | limit_value |
      | 2468             | 1060 | 100000000   |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 93985              | 36184              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | 24051998    | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName           | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU A Order 05 | 36184 | create by api buyer | [blank]  | pending       | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 03 | 36181              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 01 | 36180              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 04 | 36182              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_1006 open web admin
    When login to beta web with email "ngoctx1006@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_1006 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $1.00     | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    And Amin set deliverable for order "create by api"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | create by api | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU A Order 01 | 1        | [blank] |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName           |
      | AT SKU A Order 01 |
    And Admin add line item in order detail
      | skuName           | quantity | note    |
      | AT SKU A Order 03 | 1        | [blank] |
      # Verify custom po
    And NGOC_ADMIN_1006 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | 24051999    | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | Yes      | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin no found order in result
    And Admin search the orders by info
      | orderNumber | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate   | endDate     | temp | oos     | orderType | exProcess | pendingFinancial |
      | 24051998    | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | No       | currentDate | currentDate | Dry  | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $30.00 | $6.00     | Pending      | Pending     | Pending       |
    # Verify Lack of Tracking
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | Yes      | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin no found order in result
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate   | endDate     | temp | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | No       | currentDate | currentDate | Dry  | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $30.00 | $6.00     | Pending      | Pending     | Pending       |
    # Verify Lack of Start date, End Date, Temp
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp         | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | Yes      | [blank]   | [blank] | Refrigerated | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin no found order in result
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate   | endDate     | temp | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | No       | currentDate | currentDate | Dry  | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $30.00 | $6.00     | Pending      | Pending     | Pending       |
      # Verify OOS
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | Yes      | [blank]   | [blank] | [blank] | Yes | [blank]   | [blank]   | [blank]          |
    Then Admin no found order in result
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | No  | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $30.00 | $6.00     | Pending      | Pending     | Pending       |
      # Verify Order type
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | Express   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $30.00 | $6.00     | Pending      | Pending     | Pending       |
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | Direct    | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $30.00 | $6.00     | Pending      | Pending     | Pending       |
    And Admin delete order by order number by info
      | orderNumber   | reason           | note    | passkey |
      | create by api | Buyer adjustment | [blank] | [blank] |

    And Admin search the orders "create by api"
    And Admin no found order in result
    And NGOC_ADMIN_1006 navigate to "Orders" to "Deleted orders" by sidebar
    And Admin search the orders deleted by info
      | orderNumber   | orderSpecific | store   | buyer   | fulfillment | buyerPayment | vendorPayment | region  | startDate | endDate |
      | create by api | [blank]       | [blank] | [blank] | [blank]     | [blank]      | [blank]       | [blank] | [blank]   | [blank] |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                     | store                 | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadminorder01 | NY     | $30.00 | $6.00     | Pending      | Pending     | Pending       |
    And Admin go to order deleted detail number "create by api"
    And Admin verify general information of order deleted detail
      | customerPo | date        | region           | buyer                     | store                 | creator    | deletedBy         | deletedOn   | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment | showOnVendor |
      | [blank]    | currentDate | New York Express | ngoctx stadminorder01ny01 | ngoctx stadminorder01 | ngoctx1006 | Admin: ngoctx1006 | currentDate | Pending      | Payment via invoice | [blank]     | Pending       | Pending     | Yes          |
    And Admin verify price in order deleted details
      | orderValue | discount | taxes | smallOrderSurcharge | fuelSurcharge | total  | vendorServiceFee |
      | $30.00     | $0.00    | $0.00 | Not applied         | Not applied   | $30.00 | $6.00            |
    And Admin check line items non invoice in order deleted details
      | brand                   | product               | sku               | skuID | caseUnit     | casePrice | quantity | endQuantity | total  | distribution |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 03 | 36181 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 | Yes          |
    And Admin verify vendor payment in order deleted details
      | product               | fulfillment | paymentState | value  | discount | serviceFee | additionalFee | paidToVendor | payoutDate | payoutType |
      | AT Product A Order 01 | Pending     | Pending      | $30.00 | $0.00    | $6.00      | $0.00         | $24.00       | [blank]    | [blank]    |
    And NGOC_ADMIN_1006 quit browser

  @AdminCreateNewOrder_07 @AdminCreateNewOrder
  Scenario: Verify Dispatch
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1007@podfoods.co | 12345678a |
    When Search order by sku "59093" by api
    And Admin delete order of sku "59093" by api
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123616             | 59093              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 07 | 59093              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1007@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    When Admin verify history fulfillment status changelog don't display in order detail
    And NGOC_ADMIN_09 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |

    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                     | store                 | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx stadminorder01ny01 | ngoctx stadminorder01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    When Admin edit purchase order of order "create by api" with info
      | sub | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | 1   | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | anhJPEG.jpg | adminNote | lpNote |

    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $2.50     | Pending      | Fulfilled   | Pending       |
    When Admin go to order detail number "create by api"
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                     | store                 | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx stadminorder01ny01 | ngoctx stadminorder01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_08 @AdminCreateNewOrder
  Scenario: Check inventory flow and Availability Histories of a line-item in an in-process order when admin orders it with quantity which is less than end quantity
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1008@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "59094" by api
    And Admin delete order of sku "59094" by api
    When Search order by sku "59095" by api
    And Admin delete order of sku "59095" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order a08      | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order a08" from API
    And Admin delete inventory "all" by API
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order 08       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order 08" from API
    And Admin delete inventory "all" by API
       # Create inventory
    And Admin create inventory api1
      | index | sku                | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order a08 | 59095              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 08 | 59094              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123617             | 59094              | 1        | false     | [blank]          |
      | 123618             | 59095              | 1        | false     | [blank]          |
    Then Admin create in process order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin get id order from detail of order in process "" by API
    And Admin get number order from ID order "" by api

    Given NGOCTX26 login web admin by api
      | email                  | password  |
      | ngoctx1008@podfoods.co | 12345678a |
    # Reset search filter full textbox
    And Admin filter visibility with id "35" by api
      | q[order_number] |
      | q[customer_po]  |
      | q[buyer_id]     |
      | q[state]        |
      | q[admin_id]     |

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1008@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "In-process orders" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderInprocess | customPOInprocess | buyer   | createdByInprocess | status  |
      | [blank]        | [blank]           | [blank] | [blank]            | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | orderNumber | customerPOInprocess | buyer   | createdByInprocess | statusInprocess |
      | [blank]     | [blank]             | [blank] | [blank]            | [blank]         |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderInprocess | customPOInprocess | buyer   | createdByInprocess | status  |
      | [blank]        | [blank]           | [blank] | [blank]            | [blank] |
    Then Admin verify field search in edit visibility
      | orderNumber | customerPOInprocess | buyer   | createdByInprocess | statusInprocess |
      | [blank]     | [blank]             | [blank] | [blank]            | [blank]         |
    # Verify save new filter
    And Admin search the in-process orders by info
      | orderNumber | customerPO | buyer                     | createdBy  | status  |
      | 124123123   | customerPO | ngoctx stadminorder01ny01 | ngoctx1008 | Success |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | number    | customPOInprocess | buyer                     | createdByInprocess | statusInprocess |
      | 124123123 | customerPO        | ngoctx stadminorder01ny01 | ngoctx1008         | Success         |
    # Verify save as filter
    And Admin search the in-process orders by info
      | orderNumber | customerPO | buyer                     | createdBy  | status  |
      | 1241231231  | customerPO | ngoctx stadminorder01ny01 | ngoctx1008 | Success |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | number     | customPOInprocess | buyer                     | createdByInprocess | statusInprocess |
      | 1241231231 | customerPO        | ngoctx stadminorder01ny01 | ngoctx1008         | Success         |

    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $210.00 | $52.50    | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                   | product               | sku                | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 08  | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order a08 | 1 units/case | $10.00    | 1        | 9           | $10.00 |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku                | delivery        | preferWarehouse         |
      | 1     | AT SKU A Order a08 | Pod Consignment | Auto Distribute NewYork |
    # Verify in-process order
    And NGOC_ADMIN_09 navigate to "Orders" to "In-process orders" by sidebar
    And Admin search the in-process orders by info
      | orderNumber   | customerPO | buyer                     | createdBy  | status  |
      | create by api | [blank]    | ngoctx stadminorder01ny01 | ngoctx1008 | Success |
    And Admin verify result order in in-process order
      | order         | customerPO | creator    | status  | buyer                     | region |
      | create by api | [blank]    | ngoctx1008 | Success | ngoctx stadminorder01ny01 | NY     |
    # Verify inventory
    And NGOC_ADMIN_09 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU A Order a08 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName           | skuName            | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter      | vendorCompany         | region | createdBy |
      | 1     | AT Product A Order 01 | AT SKU A Order a08 | randomIndex | 20               | 20              | 19       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Distribute NewYork | AT Product A Order 01 | NY     | Admin     |
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_09 @AdminCreateNewOrder
  Scenario: Verify Dispatch
    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1009@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                     | paymentType                | street              | city     | state    | zip   |
      | ngoctx stadminorder01ny01 | Pay by bank or credit card | 281 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT SKU A Order 01" and quantities "100"
    And Admin create order then see message "Cannot update payment method since there is no credit card registered for the buyer"
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_10 @AdminCreateNewOrder
  Scenario: Check inventory flow and Availability Histories of a line-item in an in-process order when admin orders it with quantity which is more than end quantity
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1010@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "59096" by api
    And Admin delete order of sku "59096" by api
    When Search order by sku "59097" by api
    And Admin delete order of sku "59097" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order a10      | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order a10" from API
    And Admin delete inventory "all" by API
        # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order 10       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order 10" from API
    And Admin delete inventory "all" by API
     # Create inventory
    And Admin create inventory api1
      | index | sku                | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order a10 | 59097              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 10 | 59096              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123619             | 59096              | 1        | false     | [blank]          |
      | 123620             | 59097              | 15       | false     | [blank]          |
    Then Admin create in process order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin get id order from detail of order in process "" by API
    And Admin get number order from ID order "" by api

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1010@podfoods.co" pass "12345678a" role "Admin"

    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $350.00 | $87.50    | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                   | product               | sku                | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 10  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order a10 | 1 units/case | $10.00    | 15       | 5           | $150.00 |
#    Then Admin verify pod consignment and preferment warehouse
#      | index | sku                | delivery            | preferWarehouse |
#      | 1     | AT SKU A Order a10 | Deliverable not set | [blank]         |
    # Verify in-process order
    And NGOC_ADMIN_09 navigate to "Orders" to "In-process orders" by sidebar
    And Admin search the in-process orders by info
      | orderNumber   | customerPO | buyer                     | createdBy  | status  |
      | create by api | [blank]    | ngoctx stadminorder01ny01 | ngoctx1010 | Success |
    And Admin verify result order in in-process order
      | order         | customerPO | creator    | status  | buyer                     | region |
      | create by api | [blank]    | ngoctx1010 | Success | ngoctx stadminorder01ny01 | NY     |
    # Verify inventory
    And NGOC_ADMIN_09 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU A Order a10 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName           | skuName            | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter      | vendorCompany         | region | createdBy |
      | 1     | AT Product A Order 01 | AT SKU A Order a10 | randomIndex | 20               | 20              | 5        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Distribute NewYork | AT Product A Order 01 | NY     | Admin     |
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_11 @AdminCreateNewOrder
  Scenario: Check inventory flow and Availability Histories of a line-item in an in-process order when admin orders it with quantity which is equal to end quantity
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1011@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "59098" by api
    And Admin delete order of sku "59098" by api
    When Search order by sku "59099" by api
    And Admin delete order of sku "59099" by api
    # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 123622 | 53        | 59099              | 1000             | 1000       | in_stock     | active | [blank]                  |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order a11      | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order a11" from API
    And Admin delete inventory "all" by API
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order 11       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order 11" from API
    And Admin delete inventory "all" by API
      # Create inventory
    And Admin create inventory api1
      | index | sku                | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order a11 | 59099              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 11 | 59098              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123621             | 59098              | 1        | false     | [blank]          |
      | 123622             | 59099              | 20       | false     | [blank]          |
    Then Admin create in process order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin get id order from detail of order in process "" by API
    And Admin get number order from ID order "" by api
    # Create inventory
    And Admin create inventory api1
      | index | sku                | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order a11 | 59099              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
#
    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1011@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $400.00 | $100.00   | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                   | product               | sku                | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 11  | 1 units/case | $10.00    | 1        | 0           | $10.00  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order a11 | 1 units/case | $10.00    | 20       | 0           | $200.00 |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku                | delivery        | preferWarehouse         |
      | 1     | AT SKU A Order a11 | Pod Consignment | Auto Distribute NewYork |
    # Verify in-process order
    And NGOC_ADMIN_09 navigate to "Orders" to "In-process orders" by sidebar
    And Admin search the in-process orders by info
      | orderNumber   | customerPO | buyer                     | createdBy  | status  |
      | create by api | [blank]    | ngoctx stadminorder01ny01 | ngoctx1011 | Success |
    And Admin verify result order in in-process order
      | order         | customerPO | creator    | status  | buyer                     | region |
      | create by api | [blank]    | ngoctx1011 | Success | ngoctx stadminorder01ny01 | NY     |
    # Verify inventory
    And NGOC_ADMIN_09 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName            | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU A Order a11 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName           | skuName            | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter      | vendorCompany         | region | createdBy |
      | 1     | AT Product A Order 01 | AT SKU A Order a11 | randomIndex | 10               | 10              | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Distribute NewYork | AT Product A Order 01 | NY     | Admin     |
    # Verify sku
    And NGOC_ADMIN_09 go to product "9229" with sku "59099" by link
    And Admin go to region-specific of SKU then verify
      | regionName       | casePrice | msrpunit | availability |
      | New York Express | 10        | 10       | Out of stock |
    And Admin check availability history of region "New York Express" of SKU
      | availability          | updateBy          | updateOn    |
      | In stock→Out of stock | Admin: ngoctx1011 | currentDate |
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_12 @AdminCreateNewOrder
  Scenario: Check inventory flow and Availability Histories of a line-item in an in-process order when admin orders it more than 1 line in a order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1012@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "59100" by api
    And Admin delete order of sku "59100" by api
    # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 123623 | 53        | 59100              | 1000             | 1000       | in_stock     | active | [blank]                  |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order 12       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order 12" from API
    And Admin delete inventory "all" by API
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 12 | 59100              | 21       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
      | 123623             | 59100              | 1        | false     | [blank]          |
    Then Admin create in process order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    And Admin get id order from detail of order in process "" by API
    And Admin get number order from ID order "" by api

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1012@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $210.00 | $52.50    | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    And Admin check line items "sub invoice" in order details
      | brand                   | product               | sku               | unitCase     | casePrice | quantity | endQuantity | total  |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
      | AT Brand Admin Order 01 | AT Product A Order 01 | AT SKU A Order 12 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
    Then Admin verify pod consignment and preferment warehouse
      | index | sku               | delivery        | preferWarehouse         |
      | 1     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 2     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 3     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 4     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 5     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 6     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 7     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 8     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 9     | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 10    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 11    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 12    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 13    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 14    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 15    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 16    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 17    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 18    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 19    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 20    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
      | 21    | AT SKU A Order 12 | Pod Consignment | Auto Distribute NewYork |
    # Verify in-process order
    And NGOC_ADMIN_09 navigate to "Orders" to "In-process orders" by sidebar
    And Admin search the in-process orders by info
      | orderNumber   | customerPO | buyer                     | createdBy  | status  |
      | create by api | [blank]    | ngoctx stadminorder01ny01 | ngoctx1012 | Success |
    And Admin verify result order in in-process order
      | order         | customerPO | creator    | status  | buyer                     | region |
      | create by api | [blank]    | ngoctx1012 | Success | ngoctx stadminorder01ny01 | NY     |
    # Verify inventory
    And NGOC_ADMIN_09 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT SKU A Order 12 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName           | skuName           | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter      | vendorCompany         | region | createdBy |
      | 1     | AT Product A Order 01 | AT SKU A Order 12 | randomIndex | 21               | 21              | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Distribute NewYork | AT Product A Order 01 | NY     | Admin     |
    # Verify sku
    And NGOC_ADMIN_09 go to product "9229" with sku "59100" by link
    And Admin go to region-specific of SKU then verify
      | regionName       | casePrice | msrpunit | availability |
      | New York Express | 10        | 10       | Out of stock |
    And Admin check availability history of region "New York Express" of SKU
      | availability          | updateBy                | updateOn    |
      | In stock→Out of stock | HandleInProcessOrderJob | currentDate |
     # Verify Order type
    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $210.00 | $52.50    | Pending      | Pending     | Pending       |
    And Admin delete order by order number by info
      | orderNumber   | reason           | note    | passkey |
      | create by api | Buyer adjustment | [blank] | [blank] |
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_13 @AdminCreateNewOrder
  Scenario: Admin delete order with Fulfillment = Pending but have at least a PO in-progress, PO fulfilled
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1013@podfoods.co | 12345678a |
    When Search order by sku "59101" by api
    And Admin delete order of sku "59101" by api
      # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 123624 | 53        | 59101              | 1000             | 1000       | in_stock     | active | [blank]                  |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU A Order 13       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU A Order 13" from API
    And Admin delete inventory "all" by API
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 13 | 59101              | 20       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123624             | 59101              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1013@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    When Admin go to order detail number "create by api"
    And NGOC_ADMIN_09 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | proof_1.jpg | adminNote | lpNote |
    And Admin delete order from order detail and verify message "Can not delete this order because it is related to statement items"
      | reason           | note     | showEdit | passkey      |
      | Buyer adjustment | Autotest | Yes      | pizza4cheese |
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_14 @AdminCreateNewOrder
  Scenario: Verify customer po with order had customer po
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1014@podfoods.co | 12345678a |
    When Search order by sku "59102" by api
    And Admin delete order of sku "59102" by api
      # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 123625 | 53        | 59102              | 1000             | 1000       | in_stock     | active | [blank]                  |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123625             | 59102              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | 18021993    | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 14 | 59102              | 200      | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1014@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                     | paymentType    | street              | city     | state    | zip   |
      | ngoctx stadminorder01ny01 | Pay by invoice | 281 Columbus Avenue | New York | New York | 10023 |
    And Admin fill info optional to create new order
      | customerPO | attn    | department | noteAdmin |
      | 18021993   | [blank] | [blank]    | AT Note   |
    And Admin add line item "AT SKU A Order 14" and quantities "100"
    And Admin create order success with customer already used of order ""
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_15 @AdminCreateNewOrder
  Scenario: Verify customer po with order had customer po and dont remind
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1015@podfoods.co | 12345678a |
    When Search order by sku "59103" by api
    And Admin delete order of sku "59103" by api
      # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 123626 | 53        | 59103              | 1000             | 1000       | in_stock     | active | [blank]                  |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123626             | 59103              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | 18021993    | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 15 | 59102              | 200      | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1015@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                     | paymentType    | street              | city     | state    | zip   |
      | ngoctx stadminorder01ny01 | Pay by invoice | 281 Columbus Avenue | New York | New York | 10023 |
    And Admin fill info optional to create new order
      | customerPO | attn    | department | noteAdmin |
      | 18021993   | [blank] | [blank]    | AT Note   |
    And Admin add line item "AT SKU A Order 15" and quantities "100"
    And Admin create order success with customer already used of order ""
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_16 @AdminCreateNewOrder
  Scenario: Verify subcribe button
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1016@podfoods.co | 12345678a |
      # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 123627 | 53        | 59104              | 1000             | 1000       | in_stock     | active | [blank]                  |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 123627             | 59104              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3485     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU A Order 15 | 59104              | 200      | random   | 91           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1016@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber   | orderSpecific | store   | buyer   | buyerCompany | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | create by api | [blank]       | [blank] | [blank] | [blank]      | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order         | checkout    | buyer                     | store            | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stadminorder01ny01 | ngoctx stadmino… | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And Admin subscribe order
    And Admin unsubscribe order
    When Admin go to order detail number "create by api"
    And Admin subscribe order
    And Admin unsubscribe order
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_17 @AdminCreateNewOrder
  Scenario: If admin create a new order for sub-buyer but line item is not available to this sub-buyer (item is not added to whitelist)
    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1017@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                    | paymentType                | street              | city     | state    | zip   |
      | ngoctx stcheckout01sNY01 | Pay by bank or credit card | 281 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT SKU A Order 01" and quantities "100"
    And Admin create order then see message "Line items The itemcode #36180 is not available to this sub-buyer. Please visit here (https://adminbeta.podfoods.co/buyers/3530?head_buyer=false) and update his/her allowlist"
    And NGOC_ADMIN_09 quit browser

  @AdminCreateNewOrder_18 @AdminCreateNewOrder
  Scenario: Buyer creates order has more than 20 line items
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx09@podfoods.co | 12345678a |
    When Search order by sku "36180" by api
    And Admin delete order of sku "36180" by api
      # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 93981 | 53        | 36182              | 1000             | 1000       | in_stock     | active | [blank]                  |
    # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inprocess Order 01 | 51586              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inprocess Order 02 | 51587              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inprocess Order 03 | 51588              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inprocess Order 03 | 51589              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inprocess Order 03 | 51590              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inprocess Order 03 | 51591              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stadminorder01ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 01 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 02 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 03 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 04 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 05 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 06 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 07 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 08 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 09 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 10 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 11 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 12 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 13 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 14 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 15 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 16 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 17 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 18 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 19 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch                   | brand                       | name                      | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product Inprocess Order 01 | AT Brand InProcess Order 01 | AT SKU Inprocess Order 20 | 1      |

    And Go to Cart detail
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order

    Given NGOC_ADMIN_09 open web admin
    When login to beta web with email "ngoctx1017@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_09 navigate to "Orders" to "In-process orders" by sidebar
    And Admin search the in-process orders by info
      | orderNumber | customerPO | buyer                     | createdBy | status  |
      | [blank]     | [blank]    | ngoctx stadminorder01ny01 | ngoctx09  | Success |
    Then Admin no found order in result

#Multiple Order

  @AD_CREATE_MULTIPLE_ORDERS @AD_CREATE_MULTIPLE_ORDERS_1 @AD_CREATE_MULTIPLE_ORDERS_13 @AD_CREATE_MULTIPLE_ORDERS_3 @AD_CREATE_MULTIPLE_ORDERS_4
  Scenario: Check information shown in the Upload your CSV file popup
    Given BAO_AUTO18 open web admin
    When login to beta web with email "bao18@podfoods.co" pass "12345678a" role "Admin"
    And BAO_AUTO18 navigate to "Orders" to "Create multiple orders" by sidebar
    And Admin go to create new multiple order
    And Admin edit instruction create multiple order
      | random |
    And Admin check instruction create multiple order
      | content | history                        | date        |
      | random  | ( Last edit by Admin: bao18 on | currentDate |
    And Admin create multiple order with upload CSV file "empty_file.csv"
    And Admin verify no order uploaded in multi order
    And Check any text "is" showing on screen
      | The payment options will be set as pay by invoice                                                                           |
      | The default store addresses will be used                                                                                    |
      | Make sure you enter the same customer PO # by order by buyer. Different customer PO #s will be treated as different orders. |
    And Admin go back with button
    And Admin verify list multiple order
      | id      | name           | creator | date        | status |
      | [blank] | empty_file.csv | bao18   | currentDate | 0 / 0  |
    And Admin search multiple order
      | creator |
      | bao17   |
    And Admin check no data found
    And Admin reset filter
    And Admin search multiple order
      | creator |
      | bao18   |
    And Admin verify list multiple order
      | id      | name           | creator | date        | status |
      | [blank] | empty_file.csv | bao18   | currentDate | 0 / 0  |
    And Admin reset filter
    Then Admin verify pagination function
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_require_filed.csv"
    And Admin verify no order uploaded in multi order
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                                        | creator | date        | status |
      | [blank] | incorrect_format_file_not_require_filed.csv | bao18   | currentDate | 0 / 0  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_item.csv"
    And Admin verify line item in multiple order detail
      | product | sku     | skuID   | state | upc     | status  | price | quantity | error                                                 |
      | [blank] | [blank] | [blank] | 0 / 1 | [blank] | Pending | $0.00 | 1        | This item isn't available to the selected buyer/store |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin check line items not available in multiple order detail
      | sku     |
      | [blank] |
    And Admin go back with button
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_buyer.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | [blank] | 250419980001 | Pending | $0.00 | 1        | Buyer must be filled\nThis item isn't available to the selected buyer/store |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store   | customPO | lineItems | status | quantity |
      | [blank] | [blank] | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin check line items not available in multiple order detail
      | sku                      |
      | AT SKU Multiple Order 01 |
    And Admin go back with button
    And Admin verify list multiple order
      | id      | name                                | creator | date        | status |
      | [blank] | incorrect_format_file_not_buyer.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_price.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin search multiple order
      | creator |
      | bao18   |
    And Admin verify list multiple order
      | id      | name                                | creator | date        | status |
      | [blank] | incorrect_format_file_not_price.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_quantity.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price | quantity | error                                                               |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $0.00 | 0        | Quantity must be filled\nThis item's quantity doesn't meet the MOQs |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 0        |
    And Admin check line items not available in multiple order detail
      | sku                      |
      | AT SKU Multiple Order 01 |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                                   | creator | date        | status |
      | [blank] | incorrect_format_file_not_quantity.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_UPC.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin search multiple order
      | creator |
      | bao18   |
    And Admin verify list multiple order
      | id      | name                              | creator | date        | status |
      | [blank] | incorrect_format_file_not_UPC.csv | bao18   | currentDate | 0 / 1  |

    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_PO.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | [blank]  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin search multiple order
      | creator |
      | bao18   |
    And Admin verify list multiple order
      | id      | name                             | creator | date        | status |
      | [blank] | incorrect_format_file_not_PO.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_item_code.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | [blank]  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                                    | creator | date        | status |
      | [blank] | incorrect_format_file_not_item_code.csv | bao18   | currentDate | 0 / 1  |
    And Admin delete multi order record "incorrect_format_file_not_item_code.csv"
    And Admin delete multi order record "incorrect_format_file_not_PO.csv"
    And Admin delete multi order record "incorrect_format_file_not_UPC.csv"
    And Admin delete multi order record "incorrect_format_file_not_quantity.csv"
    And Admin delete multi order record "incorrect_format_file_not_price.csv"
    And Admin delete multi order record "incorrect_format_file_not_buyer.csv"
    And Admin delete multi order record "incorrect_format_file_not_item.csv"

  @AD_CREATE_MULTIPLE_ORDERS @AD_CREATE_MULTIPLE_ORDERS_26
  Scenario: Check validation of the fields after upload CSV file template
    Given BAO_AUTO24 open web admin
    When login to beta web with email "bao24@podfoods.co" pass "12345678a" role "Admin"
    And BAO_AUTO24 navigate to "Orders" to "Create multiple orders" by sidebar
#    And Admin go to create new multiple order
#    And Admin create multiple order with upload CSV file "incorrect_data_file_buyer.csv"
#    And Admin verify info of order number 1 in multiple order detail
#      | number  | store   | customPO         | lineItems | status | quantity |
#      | [blank] | [blank] | Auto Customer PO | 1         | 0 / 1  | 1        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                       |
#      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | [blank] | 250419980001 | Pending | $0.00 | 1        | Buyer must be filled\nThis item isn't available to the selected buyer/store |
#    And Admin verify info of order number 2 in multiple order detail
#      | number  | store   | customPO         | lineItems | status | quantity |
#      | [blank] | [blank] | Auto Customer PO | 1         | 0 / 1  | 2        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                                               |
#      | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | [blank] | 250419980002 | Pending | $0.00 | 2        | Buyer must be an integer\nThis item isn't available to the selected buyer/store\nBuyer is not found |
#    And Admin verify info of order number 3 in multiple order detail
#      | number  | store   | customPO         | lineItems | status | quantity |
#      | [blank] | [blank] | Auto Customer PO | 1         | 0 / 1  | 3        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 03 | 44182 | [blank] | 250419980003 | Pending | $0.00 | 3        | This item isn't available to the selected buyer/store\nBuyer is not found |
#    And Admin verify info of order number 4 in multiple order detail
#      | number  | store    | customPO         | lineItems | status | quantity |
#      | [blank] | ngoc st1 | Auto Customer PO | 1         | 0 / 1  | 4        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
#      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | In stock | 250419980004 | Pending | $40.00 | 4        | [blank] |
#    And Admin go back with button
#    And Admin reset filter
#    And Admin verify list multiple order
#      | id      | name                          | creator | date        | status |
#      | [blank] | incorrect_data_file_buyer.csv | bao18   | currentDate | 0 / 4  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_data_item_code_file.csv"
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 6         | 0 / 6  | 6        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 26 | 65652 | Out of stock | 250419980026 | Pending | $20.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 25 | 65651 | Out of stock | 250419980025 | Pending | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 24 | 65650 | Out of stock | 250419980024 | Pending | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 22 | 65648 | [blank]      | 250419980022 | Pending | $0.00  | 1        | This item isn't available to the selected buyer/store       |
      | Auto Product Multiple Order | AT SKU Multiple Order 23 | 65649 | [blank]      | 250419980023 | Pending | $0.00  | 1        | This item isn't available to the selected buyer/store       |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock     | 250419980001 | Pending | $10.00 | 1        | [blank]                                                     |
    And Admin verify info of order number 2 in multiple order detail
      | number  | store               | customPO | lineItems | status | quantity |
      | [blank] | Auto Store Chicago1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin choose line item to convert to order in multi
      | sku                      | quantity |
      | AT SKU Multiple Order 01 | 1        |
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Click on button "Create order"
    And Admin check alert message
      | Line items The itemcode #44180 is not available to this sub-buyer. Please visit here (https://adminbeta.podfoods.co/buyers/3365?head_buyer=false) and update his/her allowlist |
    And Admin go back with button
    And Admin reset filter
    And Admin search multiple order
      | creator |
      | bao24   |
    And Admin verify list multiple order
      | id      | name                              | creator | date        | status |
      | [blank] | incorrect_data_item_code_file.csv | bao24   | currentDate | 0 / 2  |

#    And Admin create multiple order with upload CSV file "empty_file.csv"
#    And Admin delete multi order record "empty_file.csv"
#    And Admin upload CSV file "multiple_order_file.csv" to create multiple order
#    And Admin verify order uploaded of file "multiple_order_file.csv" in multi order
#      | store    | customerPO | lineItem | status | quantity |
#      | ngoc st1 | Auto PO    | 21       | 0 / 21 | 21       |
#    And Admin go to detail of multiple order
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                       |
#      | Auto Product Multiple Order | AT SKU Multiple Order 21 | 44200 | In stock     | 250419980021 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 20 | 44199 | In stock     | 250419980020 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 19 | 44198 | In stock     | 250419980019 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 18 | 44197 | In stock     | 250419980018 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 17 | 44196 | In stock     | 250419980017 | Pending | $10.00 | 1        | [blank]                                                     |
#   And Admin verify "total" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
#    And Admin verify "in stock" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
#    And Admin verify "OOS or LS" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
#    And Admin choose line item to convert to order in multi
#      | sku                      | quantity |
#      | AT SKU Multiple Order 20 | 1        |
#      | AT SKU Multiple Order 19 | 1        |
#      | AT SKU Multiple Order 18 | 1        |
#      | AT SKU Multiple Order 17 | 1        |
#      | AT SKU Multiple Order 16 | 1        |
#
#    And Admin verify "total" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 20        | $200.00         | $0.00    | $0.00 | $0.00           | $200.00      |
#    And Admin verify "in stock" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 19        | $190.00         | $0.00    | $0.00 | $0.00           | $190.00      |
#    And Admin verify "OOS or LS" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
#    And Admin create multiple order from detail with customer PO
  @AD_CREATE_MULTIPLE_ORDERS @AD_CREATE_MULTIPLE_ORDERS_66
  Scenario: Check convert the uploaded CSV file 2
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao25@podfoods.co | 12345678a |
    When Search order by sku "65651" by api
    And Admin delete order of sku "65651" by api
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 134012             | 65651              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2840     | [blank]    | Auto PO     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | IL                 | Illinois           |

    Given BAO_AUTO25 open web admin
    When login to beta web with email "bao25@podfoods.co" pass "12345678a" role "Admin"
    And BAO_AUTO25 navigate to "Orders" to "Create multiple orders" by sidebar
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "multiple_order_file.csv"
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 4         | 0 / 4  | 4        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 25 | 65651 | Out of stock | 250419980025 | Pending | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | In stock     | 250419980004 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | In stock     | 250419980002 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock     | 250419980001 | Pending | $10.00 | 1        | [blank]                                                     |
    And Admin choose all line item to convert multiple order
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 4         | $40.00          | $0.00    | $0.00 | $0.00           | $40.00       |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 3         | $30.00          | $0.00    | $0.00 | $0.00           | $30.00       |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Admin choose all line item to convert multiple order
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
      | AT SKU Multiple Order 25 | 1        |
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Click on button "Create order"
    And Admin check dialog message
      | The customer PO number was used by the order(s) listed below. Do you still want to continue? |
    And Click on any text "Don’t remind me for the next 30 mins"
    And Click on dialog button "Understand & Continue"
    And Admin check alert message
      | Selected items have been converted successfully! |

    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 4         | 1 / 4  | 4        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status    | price  | quantity | error                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 25 | 65651 | Out of stock | 250419980025 | Converted | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | In stock     | 250419980004 | Pending   | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | In stock     | 250419980002 | Pending   | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock     | 250419980001 | Pending   | $10.00 | 1        | [blank]                                                     |
    And Admin choose all line item to convert multiple order
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 3         | $30.00          | $0.00    | $0.00 | $0.00           | $30.00       |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 3         | $30.00          | $0.00    | $0.00 | $0.00           | $30.00       |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin check line items not available in multiple order detail
      | sku                      |
      | AT SKU Multiple Order 25 |
    And Admin go back with button
    And Admin reset filter
    And Admin search multiple order
      | creator |
      | bao25   |
    And Admin verify list multiple order
      | id      | name                    | creator | date        | status |
      | [blank] | multiple_order_file.csv | bao25   | currentDate | 0 / 2  |
    And Admin delete multi order record "multiple_order_file.csv"
    And Admin check alert message
      | This csv cannot be deleted since it is associated converted items |
#    # Verify in order detail
    And BAO_AUTO25 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber | orderSpecific | store    | buyer        | buyerCompany | vendorCompany | brand   | sku                      | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | empty       | [blank]       | ngoc st1 | ngoctx N_CHI | [blank]      | [blank]       | [blank] | AT SKU Multiple Order 25 | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order | customerPO | creator | checkout    | buyer        | store    | region | total | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | Auto PO    | bao25   | currentDate | ngoctx N_CHI | ngoc st1 | CHI    | $0.00 | $0.00     | Pending      | Pending     | Pending       |
    When Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store    | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Auto PO    | currentDate | Chicagoland Express | ngoctx N_CHI | ngoc st1 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $0.00      | $0.00    | $0.00 | Not applied         | $0.00              | $0.00            | $0.00 |
    And Admin check line items "deleted or shorted items" in order details
      | brand                      | product                     | sku                      | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 25 | 1 units/case | $10.00    | 1        | 0           | $10.00 | 65651 |

  @AD_CREATE_MULTIPLE_ORDERS @AD_CREATE_MULTIPLE_ORDERS_67
  Scenario: Check convert the uploaded CSV file
    Given BAO_AUTO25 login web admin by api
      | email             | password  |
      | bao26@podfoods.co | 12345678a |
    When Search order by sku "66289" by api
    And Admin delete order of sku "66289" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name]  | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Multiple Order 28 | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto Product Multiple Order" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code                 | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 28 | 66289              | 5        | AT SKU Multiple Order 28 | 99           | Plus1        | Plus1       | [blank] |
#
    Given BAO_AUTO26 open web admin
    When login to beta web with email "bao26@podfoods.co" pass "12345678a" role "Admin"
    Then BAO_AUTO26 navigate to "Orders" to "Create multiple orders" by sidebar
    And Admin go to create new multiple order
    * Admin create multiple order with upload CSV file "multiple_order_file3.csv"
    * Admin verify info of order number 2 in multiple order detail
      | number  | store               | customPO | lineItems | status | quantity |
      | [blank] | Auto Store Chicago1 | Auto PO  | 1         | 0 / 1  | 1        |
    * Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                                                                               |
      | Auto Product Multiple Order | AT SKU Multiple Order 27 | 66288 | Out of stock | 250419980027 | Pending | $10.00 | 1        | UPC/EAN is used for multiple SKUsClick here to resolve\nThis SKU is out of stock but it will be added on the order. |
    * Admin resolve UPC of item multiple order
      | oldSKU                   | newSKU                   | upc          |
      | AT SKU Multiple Order 27 | AT SKU Multiple Order 28 | 250419980027 |
    * Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price         | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 28 | 66289 | In stock | 250419980027 | Pending | $9.00\n$10.00 | 1        | [blank] |
    * Admin choose line item to convert to order in multi
      | sku                      | quantity |
      | AT SKU Multiple Order 28 | 5        |
    * Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 5         | $50.00          | $5.00    | $0.00 | $0.00           | $45.00       |
    * Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 5         | $50.00          | $5.00    | $0.00 | $0.00           | $45.00       |
    * Admin create multiple order from detail with customer PO
    * Admin verify info of order number 2 in multiple order detail
      | number  | store               | customPO | lineItems | status | quantity |
      | [blank] | Auto Store Chicago1 | Auto PO  | 1         | 1 / 1  | 5        |
       # Verify in order detail
    Then BAO_AUTO26 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber | orderSpecific | store               | buyer        | buyerCompany | vendorCompany | brand   | sku                      | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | empty       | [blank]       | Auto Store Chicago1 | Auto Buyer59 | [blank]      | [blank]       | [blank] | AT SKU Multiple Order 28 | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    * Admin verify result order in all order
      | order | customerPO | creator | checkout    | buyer        | store      | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | Auto PO    | bao26   | currentDate | Auto Buyer59 | Auto Store | CHI    | $50.00 | $11.50    | Pending      | Pending     | Pending       |
    * Admin go to detail first result search
    * Verify general information of order detail
      | customerPo | date        | region              | buyer        | store               | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Auto PO    | currentDate | Chicagoland Express | Auto Buyer59 | Auto Store Chicago1 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    * Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | fuelSurcharge | vendorServiceFee | total  |
      | $50.00     | $5.00    | $0.00 | $30.00              | [blank]            | $0.00         | $11.50           | $75.00 |
    * Admin check line items "sub invoice" in order details
      | brand                      | product                     | sku                      | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 28 | 1 units/case | $10.00    | 5        | 0           | $45.00 | 66289 |
    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    Then VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region              | store               | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | Auto Store Chicago1 | Pending       | Express   | currentDate  |
    * Vendor Check orders in dashboard order
      | ordered     | number | store               | payment | fullfillment | total  | orderType |
      | currentDate | 2      | Auto Store Chicago1 | Pending | Pending      | $33.50 | Express   |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    Then BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    * Search Order in tab "Pending" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Multiple Order 01 | currentDate   | [blank]        |
    * Go to order detail with order number ""
    * Check information in order detail
      | buyerName    | storeName           | shippingAddress                               | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | $50.00     | $75.00 | By invoice | Pending | [blank]           | $30.00     | -$5.00   |
    * Buyer check items in order detail have multi sub invoice
      | sub | index | brandName                  | productName                 | skuName                  | unitPerCase | casePrice | quantity | total  | addCart | unitUPC                      | priceUnit   | caseUnit    | eta     |
      | 1   | 1     | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 28 | 1 unit/case | $10.00    | 5        | $45.00 | [blank] | Unit UPC / EAN: 250419980027 | $10.00/unit | 1 unit/case | [blank] |



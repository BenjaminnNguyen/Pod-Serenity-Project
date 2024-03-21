#mvn clean verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart" -Denvironments=product
@feature=vendorOrders
Feature: Vendor Orders

  @TC_01 @VENDOR_ORDER_17
  Scenario: Verify the filter function
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 1762      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 1664              |
    And Admin set all receiving weekday of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin search product name "random product vendor order 1 api" by api
    And Admin delete product name "random product vendor order 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product vendor order 1 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 1 api" of product ""
#    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region                   | store   | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express      | [blank] | [blank]       | [blank]   | [blank]      |
      | Florida Express          | [blank] | [blank]       | [blank]   | [blank]      |
      | Mid Atlantic Express     | [blank] | [blank]       | [blank]   | [blank]      |
      | New York Express         | [blank] | [blank]       | [blank]   | [blank]      |
#      | North California Express       | [blank] | [blank]       | [blank]   | [blank]      |
      | South California Express | [blank] | [blank]       | [blank]   | [blank]      |
#      | Dallas Express                 | [blank] | [blank]       | [blank]   | [blank]      |
#      | Pod Direct Midwest             | [blank] | [blank]       | [blank]   | [blank]      |
#      | Pod Direct Northeast           | [blank] | [blank]       | [blank]   | [blank]      |
#      | Pod Direct East          | [blank] | [blank]       | [blank]   | [blank]      |
#      | Pod Direct Southwest & Rockies | [blank] | [blank]       | [blank]   | [blank]      |
#      | Pod Direct West                | [blank] | [blank]       | [blank]   | [blank]      |
    And VENDOR clear filter on field "Region"
    And VENDOR input invalid "Region"
      | value |
      | 1     |
      | @     |
      | abc   |
    And Vendor search order "Unconfirmed"
      | region  | store                              | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto store Florida                 | [blank]       | [blank]   | [blank]      |
      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | [blank]      |
      | [blank] | Bao store                          | [blank]       | [blank]   | [blank]      |
    And VENDOR clear filter on field "Store"
    And VENDOR input invalid "Store"
      | value     |
      | 1 1       |
      | @@@       |
      | abc@@@123 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | [blank] | Pending       | [blank]   | [blank]      |
      | [blank] | [blank] | Paid          | [blank]   | [blank]      |
    And VENDOR input invalid "Payment status"
      | value |
      | 1     |
      | @     |
      | abc   |
    And VENDOR clear filter on field "Payment status"
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | [blank] | [blank]       | Direct    | [blank]      |
      | [blank] | [blank] | [blank]       | Express   | [blank]      |
    And Vendor input invalid "Order type"
      | value |
      | 1     |
      | @     |
      | abc   |
    And VENDOR clear filter on field "Order type"
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | [blank] | [blank]       | [blank]   | currentDate  |
      | [blank] | [blank] | [blank]       | [blank]   | Plus1        |
      | [blank] | [blank] | [blank]       | [blank]   | Minus1       |
    And VENDOR clear filter on field "Checkout date (from)"
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate | fulfillmentFrom | fulfillmentTo |
      | [blank] | [blank] | [blank]       | Direct    | [blank]      | Minus1          | currentDate   |
    And VENDOR clear filter on field "Fulfillment date (from)"
    And VENDOR clear filter on field "Fulfillment date (to)"
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate | fulfillmentFrom | fulfillmentTo |
      | [blank] | [blank] | [blank]       | Direct    | [blank]      | Plus1           | Minus1        |
    And VENDOR clear filter on field "Fulfillment date (from)"
    And VENDOR clear filter on field "Fulfillment date (to)"
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate | fulfillmentFrom | fulfillmentTo |
      | [blank] | [blank] | [blank]       | Direct    | [blank]      | currentDate     | currentDate   |
    And Vendor clear search all filters

    And Vendor "Collapse" search order
    And Check field "Region" is invisible
    And Check field "Store" is invisible
    And Check field "Payment status" is invisible
    And Check field "Order type" is invisible
    And Check field "Checkout date (from)" is invisible
    And Check field "Checkout date (to)" is invisible
    And Vendor "Show filters" search order
    And Check field "Region" is visible
    And Check field "Store" is visible
    And Check field "Payment status" is visible
    And Check field "Order type" is visible
    And Check field "Checkout date (from)" is visible
    And Check field "Checkout date (to)" is visible
#    And Vendor search order with all filter "Unconfirmed"
#      | region                         | store   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Chicagoland Express            | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Florida Express                | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Mid Atlantic Express           | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | New York Express               | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | North California Express       | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | South California Express       | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Texas Express                  | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Pod Direct Midwest             | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Pod Direct Northeast           | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Pod Direct Southeast           | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Pod Direct Southwest & Rockies | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#      | Pod Direct West                | [blank] | [blank]       | [blank]   | [blank]          | [blank]        |
#    And VENDOR clear filter on field "Region"
#    And Vendor clear search all filters
#    And Vendor search order with all filter "Unconfirmed"
#      | region  | store                              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | [blank] | Auto store Florida                 | [blank]       | [blank]   | [blank]          | [blank]        |
#      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | [blank]          | [blank]        |
#      | [blank] | Bao store                          | [blank]       | [blank]   | [blank]          | [blank]        |
#    And Vendor input invalid "Store"
#      | value     |
#      | 1 1       |
#      | @@@       |
#      | abc@@@123 |
#    And Vendor clear search all filters
#    And Vendor search order with all filter "Unconfirmed"
#      | region  | store   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | [blank] | [blank] | Pending       | [blank]   | [blank]          | [blank]        |
#      | [blank] | [blank] | Paid          | [blank]   | [blank]          | [blank]        |
#    And Vendor input invalid "Payment status"
#      | value     |
#      | 1 1       |
#      | @@@       |
#      | abc@@@123 |
#    And Vendor clear search all filters
#    And Vendor search order with all filter "Unconfirmed"
#      | region  | store   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | [blank] | [blank] | [blank]       | Direct    | [blank]          | [blank]        |
#      | [blank] | [blank] | [blank]       | Express   | [blank]          | [blank]        |
#    And Vendor input invalid "Order type"
#      | value |
#      | 1     |
#      | @     |
#      | abc   |
#    And Vendor clear search all filters
#    And Vendor search order with all filter "Unconfirmed"
#      | region  | store   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | [blank] | [blank] | [blank]       | [blank]   | currentDate      | [blank]        |
#      | [blank] | [blank] | [blank]       | [blank]   | Plus1            | [blank]        |
#      | [blank] | [blank] | [blank]       | [blank]   | Minus1           | [blank]        |
#    And Vendor clear search all filters
#    And Vendor search order with all filter "Unconfirmed"
#      | region  | store   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | [blank] | [blank] | [blank]       | [blank]   | [blank]          | currentDate    |
#      | [blank] | [blank] | [blank]       | [blank]   | [blank]          | Plus1          |
#      | [blank] | [blank] | [blank]       | [blank]   | [blank]          | Minus1         |
#    And Vendor close search all filters

  @VENDOR_ORDER_17_2 @VENDOR_ORDER_13_2
  Scenario: Verify the filter function 2
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 1 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 1 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product vendor order 1 api" by api
    And Admin search product name "random product vendor order 1 api" by api
    And Admin delete product name "random product vendor order 1 api" by api
     # Set PRICING Brand
    And Admin set Fixed pricing of brand "3018" with "0.25" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product vendor order 1 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 1 api" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code                      | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 1 api | random             | 5        | random sku vendor order 1 api | 95           | currentDate  | Plus1       | [blank] |
    And Admin create a "active" SKU from admin with name "random sku vendor order 2 api" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code                      | warehouse_id | receive_date | expiry_date | comment |
      | 2     | random sku vendor order 2 api | random             | 5        | random sku vendor order 2 api | 95           | currentDate  | Plus1       | [blank] |

#    Admin create order
    And Admin create line items attributes by API
      | skuName                       | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 1 api | create by api63    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 2 api | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
# Với Express item thì tạo order luôn auto confirm Pod Consignment (update 01/09/23)
   # Set invoice
    And Admin set Invoice by API
      | skuName                       | skuId         | order_id      | eta_date | payment_state | surfix |
      | random sku vendor order 1 api | create by api | create by api | [blank]  | pending       | 1      |
       # Set invoice
    And Admin set Invoice by API
      | skuName                       | skuId         | order_id      | eta_date | payment_state | surfix |
      | random sku vendor order 2 api | create by api | create by api | [blank]  | pending       | 2      |
#
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $15.00 | Express   |
    And VENDOR clear filter on field "Region"
    And VENDOR clear filter on field "Store"
    And VENDOR clear filter on field "Payment status"
    And VENDOR clear filter on field "Order type"
    And VENDOR clear filter on field "Checkout date (from)"

    And Vendor search order "Unfulfilled"
      | fulfillmentState | region  | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Pending          | [blank] | [blank] | [blank]       | [blank]   | currentDate  | Plus1          |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $15.00 | Express   | Plus9        |

#    Create PO -> Awaiting POD
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | Minus1           | in_progress       | adminNote  | lpNote                 | [blank]                        | 99                   |
    And Admin create purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | Minus1           | in_progress       | adminNote  | lpNote                 | [blank]                        | 99                   |

    And Vendor clear search all filters
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Awaiting POD     | Florida Express | [blank] | [blank]       | [blank]   | currentDate  | Plus1          |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | Awaiting POD | $15.00 | Express   | Minus1       |
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region  | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Pending          | [blank] | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And VENDOR check no order found
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region  | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | In Progress      | [blank] | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And VENDOR check no order found
    And Vendor search order "All"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Awaiting POD     | Florida Express | [blank] | [blank]       | [blank]   | currentDate  | Plus1          |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | Awaiting POD | $15.00 | Express   | Minus1       |

#  Create PO -> Pending
    And Admin update purchase order of sub-invoice "create by api" suffix "2" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | Plus1            | in_progress       | adminNote  | lpNote                 | [blank]                        | 99                   |
    And Vendor clear search all filters
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Awaiting POD     | Florida Express | [blank] | [blank]       | [blank]   | currentDate  | Plus1          |
    And VENDOR check no order found
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | In Progress      | Florida Express | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And VENDOR check no order found
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Pending          | Florida Express | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $15.00 | Express   | Minus1       |
    And Vendor search order "All"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Pending          | Florida Express | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $15.00 | Express   | Minus1       |

##  Create PO -> In progress
    And Admin update purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | currentDate      | fulfilled         | adminNote  | lpNote                 | [blank]                        | 99                   |
    Then Admin update line item in order by api
      | index | skuName                       | skuId         | order_id      | fulfilled | fulfillmentDate |
      | 1     | random sku vendor order 1 api | create by api | create by api | true      | currentDate     |

    And Vendor clear search all filters
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region  | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Awaiting POD     | [blank] | [blank] | [blank]       | [blank]   | currentDate  | Plus1          |
    And VENDOR check no order found
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region  | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | In Progress      | [blank] | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | In Progress  | $15.00 | Express   | currentDate  |
    And Vendor search order "All"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | In Progress      | Florida Express | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | In Progress  | $15.00 | Express   | currentDate  |

#  -> Fulfilled
    Then Admin update line item in order by api
      | index | skuName                       | skuId         | order_id      | fulfilled | fulfillmentDate |
      | 1     | random sku vendor order 1 api | create by api | create by api | true      | currentDate     |
    Then Admin update line item in order by api
      | index | skuName                       | skuId         | order_id      | fulfilled | fulfillmentDate |
      | 2     | random sku vendor order 2 api | create by api | create by api | true      | currentDate     |

    And Vendor clear search all filters
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region  | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Awaiting POD     | [blank] | [blank] | [blank]       | [blank]   | currentDate  | Plus1          |
    And VENDOR check no order found
    And Vendor search order "Unfulfilled"
      | fulfillmentState | region  | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | In Progress      | [blank] | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And VENDOR check no order found
    And Vendor search order "All"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Fulfilled        | Florida Express | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto store Florida | Pending | Fulfilled    | $15.00 | Express   | currentDate  |
    And Vendor search order "Fulfilled"
      | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo | fulfillmentFrom |
      | Florida Express | [blank] | [blank]       | [blank]   | [blank]      | [blank]        | currentDate     |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType | fulfilled   |
      | currentDate | create by api | Auto store Florida | Pending | Fulfilled    | $15.00 | Express   | currentDate |

  @VENDOR_ORDER_1
  Scenario: Check information displayed in the Orders list
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Hover on any text on screen
      | Fulfilled |
    And Check any text "is" showing on screen
      | Once POD is confirmed, the status will change to Fulfilled. |
#    And Click on any text "Get Fast Pay"
#    And Switch to tab by title "Fast Pay with Pod Foods"
#    And Verify URL of current site
#      | https://www.support.podfoods.co/fast-pay |
#    And Switch to default tab
#    And Switch to tab by title "Orders - Pod Foods"
#    Nếu nhiều hơn 120 items -> gửi về email
    And Vendor export order "detail"
    And Vendor check export order "details" success
    And Vendor check content file export order "detail"
      | Checkout date | Week # | Order number | Region | Store | Product name | SKU name | UPC/EAN | Quantity | Order Value | Discount | Service Fee | Payout amount | Order type | Fulfillment date | Vendor payment | Street | City | State | Zip |
    And Vendor export order "summary"
    And Vendor check export order "summary" success
    And Vendor check content file export order "summary"
      | Order number | Order date | Delivery date | Store name | Order value | Service fee | Total | Fulfillment status | Payment status |
    And Vendor delete file export order "details"
    And Vendor delete file export order "summary"
    And Vendor search order "All"
      | fulfillmentState | region          | store   | paymentStatus | orderType | checkoutDate | checkoutDateTo |
      | Pending          | Florida Express | [blank] | [blank]       | [blank]   | [blank]      | [blank]        |
    And Vendor export order "summary"
    And Vendor check export order "summary" success
    And Vendor check content file export order "summary"
      | Order number | Order date | Delivery date | Store name | Order value | Service fee | Total   | Fulfillment status | Payment status |
      | [blank]      | [blank]    | [blank]       | [blank]    | [blank]     | [blank]     | [blank] | Pending            | [blank]        |
    And Vendor export order "detail"
    And Vendor check export order "details" success
    And Vendor check content file export order "detail"
      | Checkout date | Week #  | Order number | Region          | Store   | Product name | SKU name | UPC/EAN | Quantity | Order Value | Discount | Service Fee | Payout amount | Order type | Fulfillment date | Vendor payment | Street  | City    | State   | Zip     |
      | [blank]       | [blank] | [blank]      | Florida Express | [blank] | [blank]      | [blank]  | [blank] | [blank]  | [blank]     | [blank]  | [blank]     | [blank]       | [blank]    | [blank]          | [blank]        | [blank] | [blank] | [blank] | [blank] |
    And Vendor clear search all filters
#    Check pagination
    And Vendor check 12 number record on pagination
    And Vendor click "2" on pagination
    And Vendor check 12 number record on pagination
    And Vendor click "back" on pagination
    And Vendor check 12 number record on pagination
    And Vendor click "next" on pagination
    And Vendor check 12 number record on pagination

  @VENDOR_ORDER_13
  Scenario: Check display condition of a new order by created by PE buyers in the Orders list
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 13 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 13 api" from API
    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 13 api" by api
    And Admin search product name "random product vendor order 13 api" by api
    And Admin delete product name "random product vendor order 13 api" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 13 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 13 api" of product ""
    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 13 api | random             | 5        | random sku vendor order 13 api | 95           | Plus1        | [blank]     | [blank] |
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer62@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "Unfulfilled"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |
    And Vendor search order "Fulfilled"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "All"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |

#    And Vendor search order with all filter "Unconfirmed"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |
#    And Vendor search order with all filter "Unfulfilled"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "Fulfilled"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "All"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store              | payment | fullfillment | total | orderType |
#      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 13 api | random             | 10       | random   | 95           | currentDate  | [blank]     | [blank] |
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "Unfulfilled"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |
    And Vendor search order "Fulfilled"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "All"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Express   | currentDate  |
#    And Vendor check order number "create by api" is "not show"
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |
#
#    And Vendor search order with all filter "Unconfirmed"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "Unfulfilled"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store              | payment | fullfillment | total | orderType |
#      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |
#    And Vendor search order with all filter "Fulfilled"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "All"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Express   | currentDate      | currentDate    |
#    And Vendor close search all filters
##    And Vendor check order number "create by api" is "not show"
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store              | payment | fullfillment | total | orderType |
#      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |

  @VENDOR_ORDER_13_2
  Scenario: Check display condition of a new order by created by PE buyers in the Orders list 2
     ##Create order with PD Item
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                      | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 13 2 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 13 2 api" from API
    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 13 2 api" by api
    And Admin search product name "random product vendor order 13 2 api" by api
    And Admin delete product name "random product vendor order 13 3 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product vendor order 13 2 api | 3018     |
   ##Create order with PD Item
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 13 2 api" of product ""
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer62@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Direct    |
    And Vendor search order "Unfulfilled"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "Fulfilled"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "All"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Direct    |
#
#    And Vendor search order with all filter "Unconfirmed"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store              | payment | fullfillment | total | orderType |
#      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Direct    |
#    And Vendor search order with all filter "Unfulfilled"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "Fulfilled"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "All"
#      | region          | store              | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Florida Express | Auto store Florida | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store              | payment | fullfillment | total | orderType |
#      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Direct    |

  @VENDOR_ORDER_13_3
  Scenario: Check display condition of a new order by created by PD buyers in the Orders list
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                      | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 13 3 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 13 3 api" from API
    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 13 3 api" by api
    And Admin search product name "random product vendor order 13 3 api" by api
    And Admin delete product name "random product vendor order 13 3 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product vendor order 13 3 api | 3018     |
   ##Create order with PD Item
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 13 3 api" of product ""
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+autobuyerbaopdst6@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | [blank]   | [blank] | 1        |
    And Checkout cart with payment by "invoice" by API

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store                   | paymentStatus | orderType | checkoutDate |
      | Pod Direct East | Auto store pd southeast | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                   | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store pd southeast | Pending | Pending      | $9.00 | Direct    |
    And Vendor search order "Unfulfilled"
      | region          | store                   | paymentStatus | orderType | checkoutDate |
      | Pod Direct East | Auto store pd southeast | Pending       | Direct    | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "Fulfilled"
      | region          | store                   | paymentStatus | orderType | checkoutDate |
      | Pod Direct East | Auto store pd southeast | Pending       | Direct    | currentDate  |
    And Vendor check order number "create by api" is "not show"
    And Vendor search order "All"
      | region          | store                   | paymentStatus | orderType | checkoutDate |
      | Pod Direct East | Auto store pd southeast | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                   | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store pd southeast | Pending | Pending      | $9.00 | Direct    |

#    And Vendor search order with all filter "Unconfirmed"
#      | region               | store                   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Pod Direct Southeast | Auto store pd southeast | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store                   | payment | fullfillment | total | orderType |
#      | currentDate | create by api | Auto store pd southeast | Pending | Pending      | $9.00 | Direct    |
#    And Vendor search order with all filter "Unfulfilled"
#      | region               | store                   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Pod Direct Southeast | Auto store pd southeast | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "Fulfilled"
#      | region               | store                   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Pod Direct Southeast | Auto store pd southeast | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor check order number "create by api" is "not show"
#    And Vendor search order with all filter "All"
#      | region               | store                   | paymentStatus | orderType | checkoutDateFrom | checkoutDateTo |
#      | Pod Direct Southeast | Auto store pd southeast | Pending       | Direct    | currentDate      | currentDate    |
#    And Vendor close search all filters
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store                   | payment | fullfillment | total | orderType |
#      | currentDate | create by api | Auto store pd southeast | Pending | Pending      | $9.00 | Direct    |
#    And Vendor check counter order tab "Unconfirmed" is equal ""
#    And Vendor check counter order tab "Unfulfilled" is equal ""

  @VENDOR_ORDER_38
  Scenario: Check overview of displayed information of an order created by Admin
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 38 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 38 api" from API
#    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 38" by api
    And Admin search product name "random product vendor order 38" by api
    And Admin delete product name "random product vendor order 38" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 38 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 38 api" of product ""
    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 38 api | random             | 5        | random sku vendor order 38 api | 95           | currentDate  | Plus1       | [blank] |

    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 38 2 api" of product ""
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 2        | false     | [blank]          |
      | create by api55    | create by api      | 2        | false     | [blank]          |
      | create by api55    | create by api      | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType      |
#      | currentDate | create by api | Auto store Florida | Pending | Pending      | $51.00 | Direct/Express |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $51.00 | Direct/Express |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $60.00     | $51.00     | -$9.00     | -$0.00    | Pending |
    And Vendor Check "2" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 38 api | random sku vendor order 38 2 api | $10.00    | 2        | $20.00 | not set        | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | random product vendor order 38 api | random sku vendor order 38 2 api | $10.00    | 2        | $20.00 | not set        | Unit UPC / EAN: 123123123123 |

    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 38 api | random sku vendor order 38 api | $10.00    | 2        | $20.00 | not set        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_41
  Scenario: Check overview of displayed information of an order created by Buyer
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin set all receiving weekday of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin delete order by sku of product "random product vendor order 41" by api
    And Admin search product name "random product vendor order 41" by api
    And Admin delete product name "random product vendor order 41" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 41 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 41 api" of product ""
    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 41 api | random             | 5        | random sku vendor order 41 api | 95           | currentDate  | Plus1       | [blank] |

    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 41 2 api" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                            | sku                              | amount |
      | random product vendor order 41 api | random sku vendor order 41 api   | 1      |
      | random product vendor order 41 api | random sku vendor order 41 2 api | 1      |
    And Go to Cart detail
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store              | payment | fullfillment | total  | orderType      |
      | currentDate | [blank] | Auto store Florida | Pending | Pending      | $16.50 | Direct/Express |
    And Vendor Go to order detail with order number ""
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $20.00     | $16.50     | -$3.50     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 41 api | random sku vendor order 41 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |

    And Vendor Check items in sub invoice "create by buyer" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 41 api | random sku vendor order 41 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |

    And Admin set all receiving weekday of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day     |
      | [blank] |
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Go to order detail with order number ""
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | $20.00     | $16.50     | -$3.50     | -$0.00    | Pending |

    And Admin set all possible delivery days of store "2859" by api
      | day     |
      | monday  |
      | tuesday |
    And Admin set all receiving weekday of store "2859" by api
      | day     |
      | monday  |
      | tuesday |
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Go to order detail with order number ""
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday        | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Every Mon, Tue | $20.00     | $16.50     | -$3.50     | -$0.00    | Pending |

    And Admin set all receiving weekday of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2859" by api
      | day                    |
      | within 7 business days |
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Go to order detail with order number ""
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $20.00     | $16.50     | -$3.50     | -$0.00    | Pending |

  @VENDOR_ORDER_42
  Scenario: Check overview of displayed information of an order created by Buyer - Check display of Fulfillment status of Order
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 42 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 42 api" from API
#    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 42" by api
    And Admin delete order by sku of product "random product vendor order 42" by api
    And Admin search product name "random product vendor order 42" by api
    And Admin delete product name "random product vendor order 42" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 42 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 42 api" of product ""
    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code                       | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 42 api | random             | 5        | random sku vendor order 42 api | 95           | currentDate  | Plus1       | [blank] |
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 42 2 api" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                            | sku                              | amount |
      | random product vendor order 42 api | random sku vendor order 42 api   | 1      |
      | random product vendor order 42 api | random sku vendor order 42 2 api | 1      |
    And Go to Cart detail
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    #Create PO with unconfirm
    And Admin create purchase order of sub-invoice "create by buyer" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store              | payment | fullfillment | total  | orderType      |
      | currentDate | [blank] | Auto store Florida | Pending | Pending      | $16.50 | Direct/Express |
    And Vendor Go to order detail with order number ""
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $20.00     | $16.50     | -$3.50     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 42 api | random sku vendor order 42 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
    And Vendor Check items in sub invoice "create by buyer" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 42 api | random sku vendor order 42 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_42_2
  Scenario: Check overview of displayed information of an order created by Buyer - Check display of Fulfillment status of Order PD item
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 42" by api
    And Admin search product name "random product vendor order 42" by api
    And Admin delete product name "random product vendor order 42" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 42 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku vendor order 42 2 api" of product ""

    #      Create order
    And Admin create line items attributes by API
      | skuName                   | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | sku vendor order 42 2 api | create by api55    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

     #Create PO with unconfirm
    And Admin set Invoice by API
      | skuName                   | skuId | order_id      | eta_date | payment_state | surfix  |
      | sku vendor order 42 2 api | 1     | create by api | [blank]  | pending       | [blank] |
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 94                   |
#
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Direct    |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Check any text "is" showing on screen
      | Once you start the order confirmation process as described above, you will be provided with a store delivery address. |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                   | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 42 api | sku vendor order 42 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_48
  Scenario: Verify the Pod Express Items section by details (Quantity order = End quantity)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin set all receiving weekday of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day     |
      | [blank] |
    And Admin set all possible delivery days of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin set all receiving weekday of store "2859" by api
      | day                    |
      | within 7 business days |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 48 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 48 api" from API
    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 48" by api
    And Admin search product name "random product vendor order 48" by api
    And Admin delete product name "random product vendor order 48" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 48 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 48 api" of product ""
    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 48 api | random             | 1        | random   | 95           | currentDate  | [blank]     | [blank] |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 48 2 api" of product ""

    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 48 api   | create by api63    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 48 2 api | create by api55    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType      |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $16.50 | Direct/Express |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $20.00     | $16.50     | -$3.50     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 48 api | random sku vendor order 48 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 48 api | random sku vendor order 48 api | $10.00    | 1        | $10.00 | [blank]        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_48_2
  Scenario: Verify the Pod Express Items section by details 2 (Quantity order > End quantity)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 48 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 48 api" from API
    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 48" by api
    And Admin search product name "random product vendor order 48" by api
    And Admin delete product name "random product vendor order 48" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 48 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 48 api" of product ""

    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 48 api | random             | 5        | random   | 95           | currentDate  | [blank]     | [blank] |
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Pod Direct East | 55 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 48 2 api" of product ""

    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 48 api   | create by api63    | create by api      | 2        | false     | [blank]          |
      | random sku vendor order 48 2 api | create by api55    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType      |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $24.00 | Direct/Express |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $30.00     | $24.00     | -$6.00     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 48 api | random sku vendor order 48 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 48 api | random sku vendor order 48 api | $10.00    | 2        | $20.00 | not set        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_48_3
  Scenario: Verify the Pod Express Items section by details 3 (Quantity order < End quantity)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product vendor order 48 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product vendor order 48 api" from API
    And Admin delete all inventory by API
    And Admin delete order by sku of product "random product vendor order 48" by api
    And Admin search product name "random product vendor order 48" by api
    And Admin delete product name "random product vendor order 48" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 48 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 48 api" of product ""
    And Admin set Fixed pricing of brand "3018" with "0.25" by API
    And Admin create inventory api1
      | index | sku                            | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 48 api | random             | 3        | random   | 95           | currentDate  | [blank]     | [blank] |

    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
     # Increase quantity of line item
    And Admin edit line item in order detail
      | sub | order         | subID         | quantity | reason           | note     | action | deduction | showEdit |
      | 1   | create by api | create by api | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And Admin check line items "sub invoice" in order details
      | brand                     | product                            | sku                            | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product vendor order 48 api | random sku vendor order 48 api | 1 units/case | $10.00    | 2        | [blank]     | $20.00 |
    And Admin verify history change quantity of line item in order detail
      | sub | order         | subID         | quantity | reason           | updateBy                | updateOn    | note     | showOnVendor |
      | 1   | create by api | create by api | 1 → 2    | Buyer adjustment | Admin: bao3@podfoods.co | currentDate | Autotest | Yes          |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region          | store              | paymentStatus | orderType | checkoutDate |
      | Florida Express | Auto store Florida | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total  | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $15.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check order detail info
      | region          | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Florida Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $20.00     | $15.00     | -$5.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 48 api | random sku vendor order 48 api | $10.00    | 2        | $20.00 | [blank]        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_53
  Scenario: Verify the Pod Direct Items section by details
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 53" by api
    And Admin search product name "random product vendor order 53" by api
    And Admin delete product name "random product vendor order 53" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 53 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 53 api" of product ""
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |


    Given BAO_ADMIN3 open web admin
    When BAO_ADMIN3 login to web with role Admin
    And BAO_ADMIN3 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
     # Increase quantity of line item
    And Admin edit line item in order detail
      | sub         | order        | subID         | quantity | reason           | note     | action | deduction | showEdit |
      | Non Invoice | Non-invoiced | create by api | 2        | Buyer adjustment | Autotest | Change | [blank]   | Yes      |
    And Admin "Change" quantity line item in order detail
    And Admin save action in order detail

    And Admin check line items "non invoice" in order details
      | brand                     | product                            | sku                            | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product vendor order 53 api | random sku vendor order 53 api | 1 units/case | $10.00    | 2        | [blank]     | $20.00 |
    And Admin verify history change quantity of line item in order detail
      | sub         | order        | subID         | quantity | reason           | updateBy                | updateOn    | note     | showOnVendor |
      | Non Invoice | Non-invoiced | create by api | 1 → 2    | Buyer adjustment | Admin: bao3@podfoods.co | currentDate | Autotest | Yes          |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store          | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto Store PDM | Pending | Pending      | $19.00 | Direct    | -            |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region             | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Pod Direct Central | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store          | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer63 | Auto Store PDM | ngoctx+autobuyer63@podfoods.co | $20.00     | $19.00     | -$1.00     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 53 api | random sku vendor order 53 api | $10.00    | 2        | $20.00 | not set        | Unit UPC / EAN: 123123123123 |
    And Vendor check history of quantity items in Unconfirmed Pod Direct Items
      | skuName                        | quantity | reason           | editDate    |
      | random sku vendor order 53 api | 1 → 2    | Buyer adjustment | currentDate |
    And Vendor select items to confirm in order
      | sku                            | date   |
      | random sku vendor order 53 api | Minus1 |
    And Check any text "is" showing on screen
      | 2/5 steps                                                                                  |
      | Products need to be delivered to the retailer with at least 75% total shelf life remaining |
    And Vendor select items to confirm in order
      | sku     | date        |
      | [blank] | currentDate |
    And Check any text "is" showing on screen
      | Products need to be delivered to the retailer with at least 75% total shelf life remaining |
    And Vendor select items to confirm in order
      | sku     | date  |
      | [blank] | Plus1 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 1 selected |
    And Vendor confirm with delivery method with info
      | delivery              | store          | address                                       |
      | Self-deliver to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
#    And Hover on any text on screen
#      | Delivery date |
#    And Check any text "is" showing on screen
#      | When your items will arrive at our distribution center. We use this to plan our routes and communicate ETAs to buyers. |
#      | If not entered, we’ll assume you’re not fulfilling and remove your items from the order.                               |
    And Vendor close popup
    And Vendor confirm with delivery method with info
      | delivery              | store          | address                                       |
      | Self-deliver to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |

  @VENDOR_ORDER_68 @VENDOR_ORDER_75
  Scenario: Check displayed information when select Delivery method = Ship direct to Store/ Use my own shipping label
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 68" by api
    And Admin search product name "random product vendor order 68" by api
    And Admin delete product name "random product vendor order 68" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 68 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 68 api" of product ""
    And Admin create a "active" SKU from admin with name "random sku vendor order 68 2 api" of product ""
    And Admin create a "active" SKU from admin with name "random sku vendor order 68 3 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 68 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 68 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 68 3 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store          | payment | fullfillment | total  | orderType |
      | currentDate | create by api | Auto Store PDM | Pending | Pending      | $28.50 | Direct    |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region             | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Pod Direct Central | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store          | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer63 | Auto Store PDM | ngoctx+autobuyer63@podfoods.co | $30.00     | $28.50     | -$1.50     | -$0.00    | Pending |

    And Vendor select items to confirm in order
      | sku                            | date  |
      | random sku vendor order 68 api | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 1 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! Please print invoice & packing slip |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 68 api | random sku vendor order 68 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
    And Vendor Check "2" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 68 api | random sku vendor order 68 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | random product vendor order 68 api | random sku vendor order 68 3 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
    And Vendor view delivery detail of "Ship Direct to Store"
      | item                           | quantity | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
      | random sku vendor order 68 api | 1        | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor close popup
    And VENDOR back to Orders
    And Vendor search order "All"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store          | payment | fullfillment | total  | orderType | deliveryDate |
      | currentDate | create by api | Auto Store PDM | Pending | Pending      | $28.50 | Direct    | currentDate  |

  @VENDOR_ORDER_69
  Scenario: Check validation of all fields displayed Delivery method
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 69" by api
    And Admin search product name "random product vendor order 69" by api
    And Admin delete product name "random product vendor order 69" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 69 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "random sku vendor order 69 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |

    And Admin create SKU from admin with name "random sku vendor order 69 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 69 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 69 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Click on any text "Select all"
    And Check button "Confirm" is enable
    And Click on any text "Unselect all"
    And Check button "Confirm" is disable
    And Click on any text "Select all"
    And Check any text "is" showing on screen
      | 1/5 steps  |
      | 2 selected |
    And Click on any text "Unselect all"
    And Vendor select items to confirm in order
      | sku                              | date  |
      | random sku vendor order 69 api   | Plus7 |
      | random sku vendor order 69 2 api | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 2 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! Please print invoice & packing slip |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 69 api | random sku vendor order 69 2 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | random product vendor order 69 api | random sku vendor order 69 api   | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |

    And Vendor print Invoice & Packing Slip
    And Switch to tab by title "Order #"
    And Vendor view delivery detail of sub invoice "create by api" suffix "1"
    And Vendor check items on Confirm Delivery method
      | item                             | quantity |
      | random sku vendor order 69 2 api | 1        |
      | random sku vendor order 69 api   | 1        |
    And Vendor check instructions of delivery method "Ship Direct to Store" on Confirm Delivery method
      | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | currentDate  | USPS    | 12345678       | Auto    |

    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | Minus1       | UPS     | 1              | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! |
    And Vendor view delivery detail of sub invoice "create by api" suffix "1"
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | Minus1       | FedEx   | 1              | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! |
    And Vendor view delivery detail of sub invoice "create by api" suffix "1"
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | Plus1        | DHL     | 1              | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! |
    And Vendor view delivery detail of sub invoice "create by api" suffix "1"
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | Plus30       | Others  | 1              | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! |

  @VENDOR_ORDER_69_2 @VENDOR_ORDER_114
  Scenario: Check validation of all fields displayed Tracking number
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 69" by api
    And Admin search product name "random product vendor order 69" by api
    And Admin delete product name "random product vendor order 69" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 69 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 69 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp |
#      | Pod Direct Midwest | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 69 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 69 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 69 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku                            | date  |
      | random sku vendor order 69 api | Plus7 |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | [blank] | [blank]        | [blank] |
    And Vendor check alert message
      | Delivery information updated successfully! Please print invoice & packing slip |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 69 api | random sku vendor order 69 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
    And Check any text "is" showing on screen
      | 4/5 steps                           |
      | Please print Invoice & Packing Slip |
    And Vendor print Invoice & Packing Slip
    And Switch to tab by title "Order #"
    And Check any text "is" showing on screen
      | 5/5 steps                         |
      | Please enter the tracking number. |
    And Click on button "Edit"
    And Vendor check items on Confirm Delivery method
      | item                           | quantity |
      | random sku vendor order 69 api | 1        |
    And Vendor check instructions of delivery method "Ship Direct to Store" on Confirm Delivery method
      | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | currentDate  | [blank] | [blank]        | [blank] |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | [blank] | 12345678       | [blank] |
    And Vendor check alert message
      | Delivery information updated successfully! |
    And Check any text "is" showing on screen
      | Great job! You have completed all fulfillment steps. |
    And Vendor view delivery detail of sub invoice "create by api" suffix "1"
    And Vendor check instructions of delivery method "Ship Direct to Store" on Confirm Delivery method
      | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | currentDate  | [blank] | 12345678       | [blank] |
    And Vendor close popup
    And Vendor select items to confirm in order
      | sku                              | date  |
      | random sku vendor order 69 2 api | Plus7 |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | [blank] | 12345678       | [blank] |
    And Vendor check alert message
      | Delivery information updated successfully! Please print invoice & packing slip |
    And Vendor Check items in sub invoice "create by api" number "2" with status is "Pending"
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 69 api | random sku vendor order 69 2 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
    And Vendor print Invoice & Packing Slip
    And Switch to tab by title "Order #"
    And Vendor view delivery detail of sub invoice "create by api" suffix "2"
    And Vendor check instructions of delivery method "Ship Direct to Store" on Confirm Delivery method
      | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | currentDate  | [blank] | 12345678       | [blank] |

  @VENDOR_ORDER_76
  Scenario: Check display of the confirmed sub-invoice when admin deletes the delivery method
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 76" by api
    And Admin search product name "random product vendor order 76" by api
    And Admin delete product name "random product vendor order 76" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 76 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 76 api" of product ""
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp |
#      | Pod Direct Midwest | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 76 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 76 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 76 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Click on any text "Select all"
    And Check button "Confirm" is enable
    And Click on any text "Unselect all"
    And Vendor select items to confirm in order
      | sku                              | date  |
      | random sku vendor order 76 2 api | Plus7 |
      | random sku vendor order 76 api   | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 2 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! Please print invoice & packing slip |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 76 api | random sku vendor order 76 2 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | random product vendor order 76 api | random sku vendor order 76 api   | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
    And Vendor print Invoice & Packing Slip
    And Switch to tab by title "Order #"
    And Vendor view delivery detail of sub invoice "create by api" suffix "1"
    And Vendor check items on Confirm Delivery method
      | item                             | quantity |
      | random sku vendor order 76 2 api | 1        |
      | random sku vendor order 76 api   | 1        |
    And Vendor check instructions of delivery method "Ship Direct to Store" on Confirm Delivery method
      | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor close popup

#    Admin delete delivery
    Given BAO_ADMIN2 open web admin
    When BAO_ADMIN2 login to web with role Admin
    And BAO_ADMIN2 navigate to "Orders" to "All orders" by sidebar
    And Admin go to order detail number "create by api"
    And Admin expand line item in order detail
    And Admin open delivery detail of sub invoice "create by api" suffix "1"
    And Admin check delivery detail
      | deliveryMethod       | deliveryDate | carrier | trackingNumber | comment |
      | Ship Direct to Store | currentDate  | USPS    | 12345678       | Auto    |
    And Admin "OK" delete delivery detail

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 76 api | random sku vendor order 76 2 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | random product vendor order 76 api | random sku vendor order 76 api   | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
    And Check any text "is" showing on screen
      | 5/5 steps                         |
      | Please enter the tracking number. |
    And Vendor Show more action of sub invoice "create by api" suffix "1" and then "Show instruction"
    And Vendor check instructions with contents
      | type    | store   | address |
      | [blank] | [blank] | [blank] |
#      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Click on dialog button "OK"
    And Click on button "Edit"
    And Vendor check items on Confirm Delivery method
      | item                             | quantity |
      | random sku vendor order 76 2 api | 1        |
      | random sku vendor order 76 api   | 1        |
    And Vendor check instructions of delivery method "" on Confirm Delivery method
      | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | [blank]      | [blank] | [blank]        | [blank] |
    And Vendor choose delivery method "Ship Direct to Store"
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | [blank] | 12345678       | [blank] |
    And Vendor check alert message
      | Delivery information updated successfully! |
    And Check any text "is" showing on screen
      | Great job! You have completed all fulfillment steps. |
    And Vendor Show more action of sub invoice "create by api" suffix "1" and then "Show instruction"
    And Vendor check instructions with contents
      | type                 | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |

  @VENDOR_ORDER_78 @VENDOR_ORDER_133 @VENDOR_ORDER_113
  Scenario: Check functions on the drop-down list of the Show more actions button
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 78" by api
    And Admin search product name "random product vendor order 78" by api
    And Admin delete product name "random product vendor order 78" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 78 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 78 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp |
#      | Pod Direct Midwest | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 78 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 78 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 78 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku                            | date  |
      | random sku vendor order 78 api | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 1 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
    And Vendor check alert message
      | Delivery information updated successfully! Please print invoice & packing slip |
    And Vendor get ID sub invoice
      | index | sku                            |
      | 1     | random sku vendor order 78 api |
    And Vendor Show more action of sub invoice "create by api" suffix "1" and then "Show instruction"
    And Vendor check instructions with contents
      | type                 | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Click on dialog button "OK"
    And Vendor Show more action of sub invoice "create by api" suffix "1" and then "View/Edit sub-invoice"
#    And Vendor confirm with delivery method with info
#      | delivery             | store          | address                                       | date  |
#      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | Plus1 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | Auto    |
#    And Vendor choose shipping method
#      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state | country |email           |
#      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York    | US      |bao@podfoods.co |
    And Vendor close popup
    And Vendor print invoice packing slip "create by api"
#    And Vendor Show more action of sub invoice "create by api" suffix "1" and then "Print invoice/Packing slip"
    And Vendor verify info in Invoice
      | orderDate   | invoiceNumber    | customerPO | deliveryDate | department | deliverTo                                                                    | paymentMethod       |
      | currentDate | create by vendor | [blank]    | [blank]      | [blank]    | Auto Buyer63 - Auto Store PDM, 455 Madison Avenue, New York, New York, 10022 | Payment via invoice |
    And Vendor verify items info in Invoice
      | storage | unitUPC       | pack | unitSize | description                                               | temp          | caseQty | casePrice | discount | bottleDeposit | total |
      | Dry     | 12312312312 3 | 1    | 1.0 g    | Auto brand create product, random sku vendor order 78 api | 1.0 F - 1.0 F | 1       | 0.10      | - 0.00   | 0.00          | 10.00 |
#      | Dry     | 12312312312 3 | 1    | USD 40.00 | Auto brand create product, random sku vendor order 38 2 api | 1.0 F - 1.0 F | 2       | 0.10      | - 0.00   | 0.00          | 20.00 |
    And Vendor verify summary items info in Invoice
      | totalQuantity | discount   | tax      | totalPrice | subTotal  | bottleDeposit | promotionDiscount | invoiceTotal |
      | 1             | - USD 0.00 | USD 0.00 | USD 10.00  | USD 10.00 | USD 0.00      | - USD 0.00        | USD 10.00    |
    And Vendor verify packing slip
      | index | store          | buyer        | orderDate   | customerPO |
      | 1     | Auto Store PDM | Auto Buyer63 | currentDate | [blank]    |
      | 2     | Auto Store PDM | Auto Buyer63 | currentDate | [blank]    |
    And Vendor verify items on packing slip
      | brand                     | product                            | variant                        | unitUPC      | caseUPC      | caseUnit        | temperature   | storage | quantity |
      | Auto brand create product | random product vendor order 78 api | random sku vendor order 78 api | 123123123123 | 123123123123 | 1 unit per case | 1.0 F - 1.0 F | Dry     | 1        |

    And Switch to tab by title "Order #"
    And Vendor Show more action of sub invoice "create by api" suffix "1" and then "Delete this shipment"
    And Vendor check dialog message
      | Deleting a shipment will clear all delivery details of its line items. Continue? |
    And Click on dialog button "Cancel"
    And Vendor Show more action of sub invoice "create by api" suffix "1" and then "Delete this shipment"
    And Vendor check dialog message
      | Deleting a shipment will clear all delivery details of its line items. Continue? |
    And Click on dialog button "OK"
    And Vendor check alert message
      | Shipment deleted successfully! |
    And Vendor Check "2" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 78 api | random sku vendor order 78 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | random product vendor order 78 api | random sku vendor order 78 api   | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_105 @VENDOR_ORDER_111
  Scenario: Check displayed information when select Delivery method = Self-deliver to Store
    Given ADMIN login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 105" by api
    And Admin search product name "random product vendor order 105" by api
    And Admin delete product name "random product vendor order 105" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product vendor order 105 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 105 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp |
#      | Pod Direct Midwest | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 105 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                           | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 105 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 105 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku                             | date  |
      | random sku vendor order 105 api | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 1 selected |

    And Vendor confirm with delivery method with info
      | delivery              | store          | address                                       |
      | Self-deliver to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
#    And Hover on any text on screen
#      | Delivery date |
#    And Check any text "is" showing on screen
#      | When your items will arrive at our distribution center. We use this to plan our routes and communicate ETAs to buyers. |
#      | If not entered, we’ll assume you’re not fulfilling and remove your items from the order.                               |
    And Hover on any text on screen
      | Comments |
    And Check any text "is" showing on screen
      | For special storage instructions, email orders@podfoods.co to reach with questions, etc. |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from    | to      | comment |
      | [blank]      | [blank] | [blank] | [blank] |
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from  | to    | comment |
      | [blank]      | 00:00 | 00:30 | comment |
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check estimated arrival time to is disable from "01:30"
      | to    |
      | 00:00 |
      | 00:30 |
      | 01:00 |
      | 01:30 |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from    | to      | comment |
      | currentDate  | [blank] | [blank] | [blank] |
    And Vendor check alert message
      | Validation failed: Self delivery to store info min delivery time must be before 00:30 |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from  | to    | comment |
      | currentDate  | 00:00 | 00:30 | comment |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 105 api | random sku vendor order 105 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                         | skuName                           | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 105 api | random sku vendor order 105 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
    And Vendor get ID sub invoice
      | index | sku                             |
      | 1     | random sku vendor order 105 api |
    And Vendor print invoice packing slip "create by api"
    And Vendor verify info in Invoice
      | orderDate   | invoiceNumber    | customerPO | deliveryDate | department | deliverTo                                                                    | paymentMethod       |
      | currentDate | create by vendor | [blank]    | [blank]      | [blank]    | Auto Buyer63 - Auto Store PDM, 455 Madison Avenue, New York, New York, 10022 | Payment via invoice |
    And Vendor verify items info in Invoice
      | storage | unitUPC       | pack | unitSize | description                                                | temp          | caseQty | casePrice | discount | bottleDeposit | total |
      | Dry     | 12312312312 3 | 1    | 1.0 g    | Auto brand create product, random sku vendor order 105 api | 1.0 F - 1.0 F | 1       | 10.00     | - 0.00   | 0.00          | 10.00 |
    And Vendor verify summary items info in Invoice
      | totalQuantity | discount   | tax      | totalPrice | subTotal  | bottleDeposit | promotionDiscount | invoiceTotal |
      | 1             | - USD 0.00 | USD 0.00 | USD 10.00  | USD 10.00 | USD 0.00      | - USD 0.00        | USD 10.00    |
    And Vendor verify packing slip
      | index | store          | buyer        | orderDate   | customerPO |
      | 1     | Auto Store PDM | Auto Buyer63 | currentDate | [blank]    |
      | 2     | Auto Store PDM | Auto Buyer63 | currentDate | [blank]    |
    And Vendor verify items on packing slip
      | brand                     | product                             | variant                         | unitUPC      | caseUPC      | caseUnit        | temperature   | storage | quantity |
      | Auto brand create product | random product vendor order 105 api | random sku vendor order 105 api | 123123123123 | 123123123123 | 1 unit per case | 1.0 F - 1.0 F | Dry     | 1        |
    And Switch to tab by title "Order #"
    And Check any text "is" showing on screen
      | Please upload Proof of Delivery |
    And Hover on any text on screen
      | Please upload Proof of Delivery |
    And Check any text "is" showing on screen
      | Proof of delivery if you are self-delivering to the store. |
    And Vendor upload proof of delivery with file "samplepdf10mb.pdf"
    And Vendor check alert message
      | Maximum file size exceeded. (10MB) |
    And Vendor upload proof of delivery with file "autotest.csv"
    And Vendor check alert message
      | Validation failed: Self delivery to store info self delivery to store proofs attachment content type is invalid, Self delivery to store info self delivery to store proofs attachment can't be blank |
    And Vendor upload proof of delivery with file "ProofOfDelivery.pdf"
    And Vendor check alert message
      | Proof of delivery uploaded successfully! |
    And Vendor check proof of delivery
      | proof_of_delivery   |
      | ProofOfDelivery.pdf |
    And Vendor Show more action of sub invoice "create by api" suffix "1" and upload proof of delivery with file "AutotestFile.pdf"
    And Vendor check alert message
      | Proof of delivery uploaded successfully! |
    And Vendor check proof of delivery
      | proof_of_delivery   |
      | ProofOfDelivery.pdf |
      | AutotestFile.pdf    |
    And Vendor Show more action of sub invoice "create by api" suffix "1" and upload proof of delivery with file "gif.gif"
    And Vendor check alert message
      | Proof of delivery uploaded successfully! |
    And Vendor check proof of delivery
      | proof_of_delivery   |
      | ProofOfDelivery.pdf |
      | AutotestFile.pdf    |
      | gif.gif             |

  @VENDOR_ORDER_112
  Scenario: Check upload Proof of Delivery function when click on the Upload button
    Given ADMIN login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 105" by api
    And Admin search product name "random product vendor order 105" by api
    And Admin delete product name "random product vendor order 105" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product vendor order 105 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 105 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp |
#      | Pod Direct Midwest | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 105 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                           | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 105 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 105 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor select items to confirm in order
      | sku                             | date  |
      | random sku vendor order 105 api | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 1 selected |
    And Vendor confirm with delivery method with info
      | delivery              | store          | address                                       |
      | Self-deliver to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from    | to      | comment |
      | currentDate  | [blank] | [blank] | [blank] |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      |
      | Auto brand create product | random product vendor order 105 api | random sku vendor order 105 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                         | skuName                           | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 105 api | random sku vendor order 105 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
    And Vendor get ID sub invoice
      | index | sku                             |
      | 1     | random sku vendor order 105 api |
    And Vendor print invoice packing slip "create by api"
    And Switch to tab by title "Order #"
    And Vendor upload proof of delivery with file "ProofOfDelivery.pdf"
    And Vendor check proof of delivery
      | proof_of_delivery   |
      | ProofOfDelivery.pdf |
    And Vendor Show more action of sub invoice "create by api" suffix "1" and upload proof of delivery with file "AutotestFile.pdf"
    And Vendor check proof of delivery
      | proof_of_delivery   |
      | ProofOfDelivery.pdf |
      | AutotestFile.pdf    |
    And Vendor Show more action of sub invoice "create by api" suffix "1" and upload proof of delivery with file "gif.gif"
    And Vendor check proof of delivery
      | proof_of_delivery   |
      | ProofOfDelivery.pdf |
      | AutotestFile.pdf    |
      | gif.gif             |
    And Vendor delete proof of delivery file "gif.gif"
    And Vendor check alert message
      | Proof of delivery deleted successfully! |
    And Vendor check proof of delivery
      | proof_of_delivery   |
      | ProofOfDelivery.pdf |
      | AutotestFile.pdf    |
    And Vendor delete proof of delivery file "ProofOfDelivery.pdf"
    And Vendor check alert message
      | Proof of delivery deleted successfully! |
    And Vendor delete proof of delivery file "AutotestFile.pdf"
    And Vendor check alert message
      | Proof of delivery deleted successfully! |

  @VENDOR_ORDER_83
  Scenario: Check validation of all fields displayed Delivery method 2 - Buy and Print shipping label
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 83" by api
    And Admin search product name "random product vendor order 83" by api
    And Admin delete product name "random product vendor order 83" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 83 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 83 api" of product ""
    And Admin create a "active" SKU from admin with name "random sku vendor order 83 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 83 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 83 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Click on any text "Select all"
    And Check any text "is" showing on screen
      | 1/5 steps  |
      | 2 selected |
    And Click on any text "Unselect all"
    And Vendor select items to confirm in order
      | sku                              | date  |
      | random sku vendor order 83 2 api | Plus7 |
      | random sku vendor order 83 api   | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 2 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email           |
      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@podfoods.co |
    And Vendor select shippo and then confirm
    And Check any text "is" showing on screen
      | Once you purchase a shipping label, you will not be able to change the delivery method. Please contact at |
    And Click on button "Buy"
#    And Vendor check information after confirm
#      | provider | tracking                    | eta    | status                    | size                       | weight     | line                 | price     |
#      | USPS     | #92701901755477000000000011 | ETA: - | Tracking status:  UNKNOWN | Size: 4.00 x 3.00 x 2.00cm | Weight: 5g | 1 line item (1 case) | 23.50 USD |

    And Vendor check alert message
      | You can't use this method until a chargeable credit card is set |
    And Vendor close popup
    And Vendor Check "2" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
      | Auto brand create product | random product vendor order 83 api | random sku vendor order 83 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
      | Auto brand create product | random product vendor order 83 api | random sku vendor order 83 api   | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |

  @VENDOR_ORDER_83_3
  Scenario: Check validation of all fields displayed Delivery method 3
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 83" by api
    And Admin search product name "random product vendor order 83" by api
    And Admin delete product name "random product vendor order 83" by api
    And Admin change state of brand "3087" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 83 api | 3087     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 83 api" of product ""
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 83 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 83 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 83 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor61@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Click on any text "Select all"
    And Check any text "is" showing on screen
      | 1/5 steps  |
      | 2 selected |
    And Click on any text "Unselect all"
    And Vendor select items to confirm in order
      | sku                              | date  |
      | random sku vendor order 83 2 api | Plus7 |
      | random sku vendor order 83 api   | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 2 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email           |
      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@podfoods.co |
#    And Click on dialog button "Get Rates"
    And Vendor select shippo and then confirm
    And Click on button "Buy"
    And Vendor check alert message
      | Delivery information updated successfully! Please print invoice & packing slip! |
    And Vendor check information after confirm
      | provider | tracking | eta    | status                    | size                       | weight     | line                   | price |
      | USPS     | #        | ETA: - | Tracking status:  UNKNOWN | Size: 4.00 x 3.00 x 2.00cm | Weight: 5g | 2 line items (2 cases) | USD   |
#     23.75 USD
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName              | productName                        | skuName                          | casePrice | quantity | total  | unitUPC                      |
      | Auto Brand product mov | random product vendor order 83 api | random sku vendor order 83 2 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
      | Auto Brand product mov | random product vendor order 83 api | random sku vendor order 83 api   | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |

    And Check any text "is" showing on screen
      | 4/4 steps |
    And Vendor print Invoice & Packing Slip
    And Switch to tab by title "Order #"
    And Vendor view delivery detail of sub invoice "create by api" suffix "1"
    And Vendor check items on Confirm Delivery method
      | item                             | quantity |
      | random sku vendor order 83 2 api | 1        |
      | random sku vendor order 83 api   | 1        |
    And Vendor check instructions with contents
      | type                 | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor check shipping label on delivery detail
      | provider | tracking | eta | status  | size                       | from                                            | to                                            | price |
      | USPS     | [blank]  | N/A | UNKNOWN | Size: 4.00 x 3.00 x 2.00cm | 3740 White Plains Rd, Bronx, NY, 10467-5724, US | 455 Madison Ave, New York, NY, 10022-6845, US | USD   |
    And Vendor close popup

  @VENDOR_ORDER_83_4
  Scenario: Check validation of all fields displayed Delivery method 4
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 83" by api
    And Admin search product name "random product vendor order 83" by api
    And Admin delete product name "random product vendor order 83" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 83 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 83 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Info of Region
#      | region             | id | state  | availability | casePrice | msrp |
#      | Pod Direct Midwest | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 83 2 api" of product ""
    And Admin create line items attributes by API
      | skuName                          | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku vendor order 83 api   | create by api58    | create by api      | 1        | false     | [blank]          |
      | random sku vendor order 83 2 api | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Click on any text "Select all"
    And Check any text "is" showing on screen
      | 1/5 steps  |
      | 2 selected |
    And Click on any text "Unselect all"
    And Vendor select items to confirm in order
      | sku                              | date  |
      | random sku vendor order 83 2 api | Plus7 |
      | random sku vendor order 83 api   | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 2 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod               | width   | height  | length  | weight  | distance | mass    | name    | company | address1 | city    | zipcode | state   | country | email   |
      | Buy and Print shipping label | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] | [blank] | [blank]  | [blank] | [blank] | [blank] | [blank] | [blank] |
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field            | message                    |
      | Width            | This field cannot be blank |
      | Height           | This field cannot be blank |
      | Length           | This field cannot be blank |
      | Weight           | This field cannot be blank |
      | Distance Unit    | This field cannot be blank |
      | Mass Unit        | This field cannot be blank |
      | Name             | This field cannot be blank |
      | Address street 1 | This field cannot be blank |
      | City             | This field cannot be blank |
#      | State            | This field cannot be blank |
      | Zipcode          | This field cannot be blank |
      | Country          | This field cannot be blank |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email           |
      | Buy and Print shipping label | 0     | 1      | 1      | 1      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@podfoods.co |
    And Vendor check alert message
      | Parcels width must be greater than 0 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email           |
      | Buy and Print shipping label | 1     | 0      | 1      | 1      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@podfoods.co |
    And Vendor check alert message
      | Parcels height must be greater than 0 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email           |
      | Buy and Print shipping label | 1     | 1      | 0      | 1      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@podfoods.co |
    And Vendor check alert message
      | Parcels length must be greater than 0 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email           |
      | Buy and Print shipping label | 1     | 1      | 1      | 0      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@podfoods.co |
    And Vendor check alert message
      | Parcels weight must be greater than 0 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email |
      | Buy and Print shipping label | 1     | 1      | 1      | 1      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | 1ba   |
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field | message                    |
      | Email | Please enter a valid email |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email     |
      | Buy and Print shipping label | 1     | 1      | 1      | 1      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@pod.c |
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field | message                    |
      | Email | Please enter a valid email |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email      |
      | Buy and Print shipping label | 1     | 1      | 1      | 1      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 1111    | New York | US      | bao@pod.co |
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field   | message                                |
      | Zipcode | Please enter a valid 5-digits zip code |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email      |
      | Buy and Print shipping label | 1     | 1      | 1      | 1      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | a       | New York | US      | bao@pod.co |
    And Vendor check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field   | message                                |
      | Zipcode | Please enter a valid 5-digits zip code |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email      |
      | Buy and Print shipping label | 1     | 1      | 1      | 1      | cm       | g    | name | company | 9999 White Plains Rd | Bronx | 10467   | New York | US      | bao@pod.co |
    And Vendor check alert message
      | The address as submitted could not be found. Please check for excessive abbreviations in the street address line or in the City name. |

  @VENDOR_ORDER_122
  Scenario: Check the Fee display priority for each PE line-item
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |
#    Set pricing
    And Admin set Fixed pricing of brand "3018" with "0.2" by API
    And Admin set Store specific pricing of brand by API
      | brand_id | percentage | start_date  | expiry_date | store_ids |
      | 3018     | 0.15       | currentDate | Plus1       | 2859      |
    And Admin set Company specific pricing of brand by API
      | brand_id | percentage | start_date  | expiry_date | buyer_company_ids |
      | 3018     | 0.10       | currentDate | Plus1       | 2215              |

    And Admin delete order by sku of product "random product vendor order 122" by api
    And Admin search product name "random product vendor order 122" by api
    And Admin delete product name "random product vendor order 122" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product vendor order 122 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 122 api" of product ""
    And Admin create inventory api1
      | index | sku                             | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 122 api | random             | 10       | random sku vendor order 122 api | 95           | Plus1        | Plus1       | [blank] |
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
#    Fee ăn theo Store pricing
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $8.50 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $8.50      | -$1.50     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 15% |
#Xóa pricing
#    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    #    Order cũ k thay đổi
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $8.50 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $8.50      | -$1.50     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 15% |

#   Create new order -> Fee ăn theo Buyer company specific pricing
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 10% |
#Xóa pricing
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |
      #    Order cũ k thay đổi
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 10% |
#  Create new order -> Fee ăn theo Brand fixed pricing
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $8.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $8.00      | -$2.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 20% |
#Xóa pricing
    And Admin delete Fixed pricing of brand "3018" by API
      #    Order cũ k thay đổi
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $8.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $8.00      | -$2.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 20% |
#  Create new order -> Fee ăn theo Brand tier-base pricing 25%
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $7.50 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $7.50      | -$2.50     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 25% |

    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |

  @VENDOR_ORDER_124
  Scenario: Check display of Fee field for each PE line-item when Admin changes Pricing
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |
#    Set pricing
    And Admin set Fixed pricing of brand "3018" with "0.2" by API
    And Admin set Store specific pricing of brand by API
      | brand_id | percentage | start_date  | expiry_date | store_ids |
      | 3018     | 0.15       | currentDate | Plus1       | 2859      |
    And Admin set Company specific pricing of brand by API
      | brand_id | percentage | start_date  | expiry_date | buyer_company_ids |
      | 3018     | 0.10       | currentDate | Plus1       | 2215              |
    And Admin delete order by sku of product "random product vendor order 122" by api
    And Admin search product name "random product vendor order 122" by api
    And Admin delete product name "random product vendor order 122" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product vendor order 122 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 122 api" of product ""
    And Admin create inventory api1
      | index | sku                             | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 122 api | random             | 10       | random sku vendor order 122 api | 95           | Plus1        | Plus1       | [blank] |

    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
#    Fee ăn theo Store pricing
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $8.50 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $8.50      | -$1.50     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 15% |
#Changes pricing
    And Admin set Store specific pricing of brand by API
      | brand_id | percentage | start_date  | expiry_date | store_ids |
      | 3018     | 0.12       | currentDate | Plus1       | 2859      |
    #    Order cũ k thay đổi
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $8.50 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $8.50      | -$1.50     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 15% |

  @VENDOR_ORDER_125
  Scenario: Check display of Fee field for each PE line-item when Admin changes Pricing 2
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |
    And Admin set Company specific pricing of brand by API
      | brand_id | percentage | expiry_date | start_date  | buyer_company_ids |
      | 3018     | 0.10       | Plus1       | currentDate | 2215              |

    And Admin delete order by sku of product "random product vendor order 122" by api
    And Admin search product name "random product vendor order 122" by api
    And Admin delete product name "random product vendor order 122" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product vendor order 122 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 122 api" of product ""
    And Admin create inventory api1
      | index | sku                             | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 122 api | random             | 10       | random sku vendor order 122 api | 95           | Plus1        | Plus1       | [blank] |

    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
#    Fee ăn theo Company pricing
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 10% |

    #Changes pricing
    And Admin set Company specific pricing of brand by API
      | brand_id | percentage | expiry_date | start_date  | buyer_company_ids |
      | 3018     | 0.8        | Plus1       | currentDate | 2215              |
      #    Order cũ k thay đổi
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 10% |

  @VENDOR_ORDER_126
  Scenario: Check display of Fee field for each PE line-item when Admin changes Pricing 3
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |
#    Set pricing
    And Admin set Fixed pricing of brand "3018" with "0.1" by API

    And Admin delete order by sku of product "random product vendor order 122" by api
    And Admin search product name "random product vendor order 122" by api
    And Admin delete product name "random product vendor order 122" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product vendor order 122 api | 3018     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 122 api" of product ""
    And Admin create inventory api1
      | index | sku                             | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku vendor order 122 api | random             | 10       | random sku vendor order 122 api | 95           | Plus1        | Plus1       | [blank] |

    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
#    Fee ăn theo Company pricing
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 10% |

    #Changes pricing
    And Admin set Fixed pricing of brand "3018" with "0.15" by API
      #    Order cũ k thay đổi
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region          | store   | paymentStatus | orderType | checkoutDate |
      | Florida Express | [blank] | Pending       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store              | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store Florida | Pending | Pending      | $9.00 | Express   |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store              | email                          | weekday                | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer62 | Auto store Florida | ngoctx+autobuyer62@podfoods.co | Within 7 business days | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 122 api | random sku vendor order 122 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 | 10% |

    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |

  @VENDOR_ORDER_127
  Scenario: Check the Fee display priority for each PD line-item
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2563      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2216              |
    And Admin delete order by sku of product "random product vendor order 127" by api
    And Admin search product name "random product vendor order 127" by api
    And Admin delete product name "random product vendor order 127" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product vendor order 127 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 127 api" of product ""
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api60    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2883     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store                                      | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto store pod direct southeast an rockies | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                                      | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store pod direct southeast an rockies | Pending | Pending      | $7.50 | Direct    |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store                                      | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer31 | Auto store pod direct southeast an rockies | ngoctx+autobuyer31@podfoods.co | $10.00     | $7.50      | -$2.50     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | podConsignment | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 127 api | random sku vendor order 127 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 | 25% |
#    Set pricing
    And Admin set Fixed pricing of brand "3018" with "0.2" by API
    And Admin set Store specific pricing of brand by API
      | brand_id | percentage | start_date  | expiry_date | store_ids |
      | 3018     | 0.15       | currentDate | Plus1       | 2563      |
    And Admin set Company specific pricing of brand by API
      | brand_id | percentage | start_date  | expiry_date | buyer_company_ids |
      | 3018     | 0.10       | currentDate | Plus1       | 2216              |
#    Create order
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2883     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    #    Fee ăn theo Store pricing
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store                                      | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto store pod direct southeast an rockies | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                                      | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store pod direct southeast an rockies | Pending | Pending      | $8.50 | Direct    |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store                                      | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer31 | Auto store pod direct southeast an rockies | ngoctx+autobuyer31@podfoods.co | $10.00     | $8.50      | -$1.50     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | podConsignment | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 127 api | random sku vendor order 127 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 | 15% |

    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2563      |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2883     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    #    Fee ăn theo Company pricing
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store                                      | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto store pod direct southeast an rockies | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                                      | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store pod direct southeast an rockies | Pending | Pending      | $9.00 | Direct    |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store                                      | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer31 | Auto store pod direct southeast an rockies | ngoctx+autobuyer31@podfoods.co | $10.00     | $9.00      | -$1.00     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | podConsignment | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 127 api | random sku vendor order 127 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 | 10% |

    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2216              |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2883     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    #    Fee ăn theo Fixed pricing
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store                                      | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto store pod direct southeast an rockies | Pending       | Direct    | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                                      | payment | fullfillment | total | orderType |
      | currentDate | create by api | Auto store pod direct southeast an rockies | Pending | Pending      | $8.00 | Direct    |
    And Vendor Go to order detail with order number "create by api"
    And Vendor check general info
      | buyer        | store                                      | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer31 | Auto store pod direct southeast an rockies | ngoctx+autobuyer31@podfoods.co | $10.00     | $8.00      | -$2.00     | -$0.00    | Pending |
    And Vendor Check "1" items in Unconfirmed Pod Direct Items
      | brandName                 | productName                         | skuName                         | casePrice | quantity | total  | podConsignment | unitUPC                      | fee |
      | Auto brand create product | random product vendor order 127 api | random sku vendor order 127 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 | 20% |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2563      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2216              |

  @VENDOR_ORDER_116
  Scenario: Confirm PD line-items with Delivery method = Ship direct to Store/ Buy and Print shipping label
#  Check cannot confirm line-items when the vendor has not set chargeable credit card yet
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product vendor order 68" by api
    And Admin search product name "random product vendor order 68" by api
    And Admin delete product name "random product vendor order 68" by api
    And Admin change state of brand "3018" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product vendor order 68 api | 3018     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku vendor order 68 api" of product ""
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Admin create a "active" SKU from admin with name "random sku vendor order 68 2 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |
#    And Admin create a "active" SKU from admin with name "random sku vendor order 68 3 api" of product ""
#    And Admin create line items attributes by API
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store          | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store          | payment | fullfillment | total  | orderType |
#      | currentDate | create by api | Auto Store PDM | Pending | Pending      | $28.50 | Direct    |
    And Vendor Go to order detail with order number "create by api"
#    And Vendor check step confirm
#      | step1             | step2            | step3                       | step4              | step5                      |
#      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor check order detail info
      | region             | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Pod Direct Central | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer        | store          | email                          | orderValue | orderTotal | serviceFee | promotion | payment |
      | Auto Buyer63 | Auto Store PDM | ngoctx+autobuyer63@podfoods.co | $10.00     | $9.50      | -$0.50     | -$0.00    | Pending |
#
    And Vendor select items to confirm in order
      | sku                            | date  |
      | random sku vendor order 68 api | Plus7 |
    And Check any text "is" showing on screen
      | 2/5 steps  |
      | 1 selected |
    And Vendor confirm with delivery method with info
      | delivery             | store          | address                                       |
      | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state    | country | email           |
      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | New York | US      | bao@podfoods.co |
#    And Click on dialog button "Get Rates"
    And Vendor select shippo and then confirm
    And Click on button "Buy"
    And Vendor check alert message
      | You can't use this method until a chargeable credit card is set |
#    And Vendor check alert message
#      | Delivery information updated successfully! Please print invoice & packing slip! |
#    And Vendor Check items in sub invoice "create by api" number "1" with status is "Pending"
#      | brandName                 | productName                        | skuName                        | casePrice | quantity | total  | unitUPC                      |
#      | Auto brand create product | random product vendor order 68 api | random sku vendor order 68 api | $10.00    | 1        | $10.00 | Unit UPC / EAN: 123123123123 |
#    And Vendor Check "2" items in Unconfirmed Pod Direct Items
#      | brandName                 | productName                        | skuName                          | casePrice | quantity | total  | podConsignment | unitUPC                      |
#      | Auto brand create product | random product vendor order 68 api | random sku vendor order 68 2 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
#      | Auto brand create product | random product vendor order 68 api | random sku vendor order 68 3 api | $10.00    | 1        | $10.00 | not set        | Unit UPC / EAN: 123123123123 |
#    And Vendor view delivery detail of "Ship Direct to Store"
#      | item                           | quantity | deliveryMethod       | store          | address                                       | deliveryDate | carrier | trackingNumber | comment |
#      | random sku vendor order 68 api | 1        | Ship Direct to Store | Auto Store PDM | 455 Madison Avenue, New York, New York, 10022 | currentDate  | USPS    | 12345678       | Auto    |
#    And Vendor close popup
#    And VENDOR back to Orders
#    And Vendor search order "All"
#      | region             | store          | paymentStatus | orderType | checkoutDate |
#      | Pod Direct Central | Auto Store PDM | Pending       | Direct    | currentDate  |
#    And Vendor Check orders in dashboard order
#      | ordered     | number        | store          | payment | fullfillment | total  | orderType | deliveryDate |
#      | currentDate | create by api | Auto Store PDM | Pending | Pending      | $28.50 | Direct    | currentDate  |

  @VENDOR_ORDER_RESET
  Scenario: RESET DATA
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao10@podfoods.co | 12345678a |
    And Admin delete Fixed pricing of brand "3018" by API
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2563      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2216              |
    And Admin delete Store specific pricing of brand by API
      | brand_id | store_ids |
      | 3018     | 2859      |
    And Admin delete Company specific pricing of brand by API
      | brand_id | buyer_company_ids |
      | 3018     | 2215              |
@feature=buyer-PreOrder
Feature: Buyer PreOrder

  @B_PRE_ORDERS_DETAILS_01 @B_PRE_ORDERS_DETAILS_04 @BUYER_PRE_ORDER
  Scenario Outline: Check overview of displayed information on the Pre-order details - PE item
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Search order by sku "33702" by api
    And Admin delete order of sku "33702" by api
    # Create pre order
    Given BUYER open web user
    When login to beta web with email "<email>" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product by name "AT Product B PreOrder 01" and pre order with info
      | sku                  | amount |
      | AT SKU B PreOrder 01 | 1      |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator   | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | <creator> | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName | storeName                  | buyerEmail | shippingAddress                                | total   |
      | <creator> | ngoctx stbpreorderdetail01 | <email>    | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 01 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled |
    # Verify in head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator   | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | <creator> | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName | storeName                  | buyerEmail | shippingAddress                                | total   |
      | <creator> | ngoctx stbpreorderdetail01 | <email>    | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 01 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled |
    Examples:
      | email                                        | creator                          |
      | ngoctx+stbpreorderdetail01chi01@podfoods.co  | ngoctx stbpreorderdetail01chi01  |
      | ngoctx+stbpreorderdetail01schi01@podfoods.co | ngoctx stbpreorderdetail01schi01 |

  @B_PRE_ORDERS_DETAILS_02 @BUYER_PRE_ORDER
  Scenario: Check overview of displayed information on the Pre-order details - PD item and PE item
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Search order by sku "33703" by api
    And Admin delete order of sku "33703" by api

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product by name "AT Product B PreOrder 01" and pre order with info
      | sku                  | amount |
      | AT SKU B PreOrder 01 | 1      |
      | AT SKU B PreOrder 03 | 1      |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 03 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled | currentDate       |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 01 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled | currentDate       |
     # Verify in head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator   | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | <creator> | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName | storeName                  | buyerEmail | shippingAddress                                | total   |
      | <creator> | ngoctx stbpreorderdetail01 | <email>    | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 03 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled | currentDate       |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 01 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled | currentDate       |

  @B_PRE_ORDERS_DETAILS_03 @BUYER_PRE_ORDER
  Scenario: Check overview of displayed information on the Pre-order details - PD item
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Search order by sku "33703" by api
    And Admin delete order of sku "33703" by api

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product by name "AT Product B PreOrder 01" and pre order with info
      | sku                  | amount |
      | AT SKU B PreOrder 03 | 1      |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 03 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled |
     # Verify in head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator   | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | <creator> | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName | storeName                  | buyerEmail | shippingAddress                                | total   |
      | <creator> | ngoctx stbpreorderdetail01 | <email>    | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 03 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled |

  @B_PRE_ORDERS_DETAILS_04 @BUYER_PRE_ORDER
  Scenario: Check displayed information on each PE item with inventory arriving date with quantity = n (n>1) and has a promotion
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Search order by sku "33709" by api
    And Admin delete order of sku "33709" by api
    And Admin search promotion by Promotion Name "AT Promo Buyer Pre Order 01"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 33709 | 3007      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                        | description                 | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Buyer Pre Order 01 | AT Promo Buyer Pre Order 01 | currentDate | currentDate | 2           | [blank]    | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product by name "AT Product B PreOrder 01" and pre order with info
      | sku                  | amount |
      | AT SKU B PreOrder 04 | 2      |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 04 | $100.00   | 2        | $200.00 | Unit UPC / EAN: 123412512312 | disabled |
     # Verify in head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 04 | $100.00   | 2        | $200.00 | Unit UPC / EAN: 123412512312 | disabled |

  @B_PRE_ORDERS_DETAILS_07 @BUYER_PRE_ORDER
  Scenario: Check the item information is changed or not on the pre-order details when admin/vendor edits them
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Search order by sku "33710" by api
    And Admin delete order of sku "33710" by api
    # Edit brand
    And Admin edit brand "3109" by API
      | name                       | description                | micro_description | city    | address_state_id | vendor_company_id |
      | AT Brand Buyer PreOrder 02 | AT Brand Buyer PreOrder 02 | [blank]           | [blank] | 33               | 1937              |
   # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail01chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7802      | 33710 | 1        |
    # Edit brand
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin edit brand "3109" by API
      | name                        | description                 | micro_description | city    | address_state_id | vendor_company_id |
      | AT Brand Buyer PreOrder 02a | AT Brand Buyer PreOrder 02a | [blank]           | [blank] | 33               | 1937              |
    # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product by name "AT Product B PreOrder 02" and pre order with info
      | sku                  | amount |
      | AT SKU B PreOrder 07 | 1      |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart  | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 02 | AT SKU B PreOrder 07 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | disabled | currentDate       |

  @B_PRE_ORDERS_DETAILS_08 @BUYER_PRE_ORDER
  Scenario: Check display of the Availability field when Availability changed
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    When Search order by sku "33710" by api
    And Admin delete order of sku "33710" by api
    # Change availability field
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88852 | 53        | 33710              | 10000            | 10000      | coming_soon  | active | 2023-08-30               |
   # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail01chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7802      | 33710 | 1        |
    # Change availability field
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 88852 | 53        | 33710              | 10000            | 10000      | in_stock     | active |
    # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | unitUPC                      | addCart | statusTag |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 02 | AT SKU B PreOrder 07 | $100.00   | 1        | $100.00 | Unit UPC / EAN: 123412512312 | [blank] | In stock  |

  @B_PRE_ORDERS_DETAILS_09 @BUYER_PRE_ORDER
  Scenario: Check display of price/case shown for SKU activates on both region, store and buyer company specific
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    # Active store spec
    Then Admin choose store's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 7159 | 88859              | 2022-08-31 | 2023-08-31 |
    And Admin choose stores attributes to inactive
      | id    | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88859 | 55        | 3013     | 33715              | 30000            | 30000      | coming_soon  | active | 2023-08-30               |
    Then Admin active selected stores specific
     # Active buyer company spec
    And Admin choose company's config attributes
      | id  | variants_region_id | start_date | end_date   |
      | 546 | 88860              | 2022-08-31 | 2023-08-31 |
    Then Admin choose company attributes to active
      | id    | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88860 | 55        | 2452             | 33715              | 20000            | 20000      | coming_soon  | active | 2023-08-30               |
    Then Admin active selected company specific
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail02chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7779      | 33715 | 1        |
     # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail02chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $300.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $300.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 09 | $300.00   | 1        | $300.00 | $300.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
   # Verify head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $300.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $300.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 09 | $300.00   | 1        | $300.00 | $300.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
    # Inactive store spec
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    Then Admin choose store's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 7159 | 88859              | 2022-08-31 | 2022-08-31 |
    And Admin choose stores attributes to inactive
      | id    | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 88859 | 55        | 3013     | 33715              | 30000            | 30000      | coming_soon  | inactive | 2023-08-30               |
    Then Admin inactive selected stores specific
    # Verify buyer
    And BUYER refresh page
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 09 | $200.00   | 1        | $200.00 | $200.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
     # Verify head buyer
    And HEAD_BUYER refresh page
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 09 | $200.00   | 1        | $200.00 | $200.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
    # Inactive buyer company spec
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin choose company's config attributes
      | id  | variants_region_id | start_date | end_date   |
      | 546 | 88860              | 2022-08-31 | 2022-08-31 |
    Then Admin choose company attributes to active
      | id    | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 88860 | 55        | 2452             | 33715              | 20000            | 20000      | coming_soon  | inactive | 2023-08-30               |
    Then Admin inactive selected company specific
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail02chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7779      | 33715 | 1        |
    # Verify buyer
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 09 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
    # Verify head buyer
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 09 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |

  @B_PRE_ORDERS_DETAILS_10a @BUYER_PRE_ORDER
  Scenario: Check display of price/case shown for SKU (PE item) active on both the child region and parent region
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail01chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7779      | 33724 | 1        |
     # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 10 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
   # Verify head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 10 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |

  @B_PRE_ORDERS_DETAILS_10b @BUYER_PRE_ORDER
  Scenario: Check display of price/case shown for SKU (PD item) active on both the child region and parent region
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail02chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7779      | 33724 | 1        |
     # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail02chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 10 | $200.00   | 1        | $200.00 | $200.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
   # Verify head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 10 | $200.00   | 1        | $200.00 | $200.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
  # xem lại giá của region child
  @B_PRE_ORDERS_DETAILS_11a @BUYER_PRE_ORDER
  Scenario: Check display of price/case shown for SKU (PE item) active on both the child region and parent region of buyer company specific
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail01chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7779      | 33725 | 1        |
         # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 11 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
   # Verify head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 11 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |

  @B_PRE_ORDERS_DETAILS_11b @BUYER_PRE_ORDER
  Scenario: Check display of price/case shown for SKU (PD item) active on both the child region and parent region of buyer company specific
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail02chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7779      | 33725 | 1        |
     # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail02chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 11 | $200.00   | 1        | $200.00 | $200.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
   # Verify head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail02 | ngoctx stbpreorderdetail02chi01 | [blank] | [blank]     | $200.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail02chi01 | ngoctx stbpreorderdetail02 | ngoctx+stbpreorderdetail02chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $200.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 01 | AT SKU B PreOrder 11 | $200.00   | 1        | $200.00 | $200.00/unit | Unit UPC / EAN: 123412512312 | [blank] | 08/30/23          |
  # xem lại thông tin store specific có cả PD và PE region
  @B_PRE_ORDERS_DETAILS_12 @BUYER_PRE_ORDER
  Scenario: Check the display of Express badge for PD buyers
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail02chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7779      | 33726 | 1        |

  @B_PRE_ORDERS_DETAILS_14 @BUYER_PRE_ORDER
  Scenario: Check redirection when tap on any line-items
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88886 | 53        | 33728              | 10000            | 10000      | coming_soon  | active | 2023-08-30               |
     # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail01chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7823      | 33728 | 1        |
      # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart        | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 03 | AT SKU B PreOrder 14 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | Launching soon | 08/30/23          |
    # Change SKU to instock
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88886 | 53        | 33728              | 10000            | 10000      | in_stock     | active | 2023-08-30               |
   # Verify add to cart tooltip
    And BUYER refresh page
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart                | statusTag |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 03 | AT SKU B PreOrder 14 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | Add 1 quantity to cart | In stock  |
    # Change SKU to out of stock
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88886 | 53        | 33728              | 10000            | 10000      | sold_out     | active | 2023-08-30               |
   # Verify add to cart tooltip
    And BUYER refresh page
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart                 | statusTag |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 03 | AT SKU B PreOrder 14 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | Currently out of stock. | Sold out  |
    # Change SKU to inactive
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "inactive"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 88886 | 53        | 33728              | 10000            | 10000      | sold_out     | inactive | 2023-08-30               |
   # Verify add to cart tooltip
    And BUYER refresh page
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart                 |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 03 | AT SKU B PreOrder 14 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | Currently out of stock. |
    # Inactive product
    And Change state of product id: "7823" to "inactive"
    # Verify
    And BUYER refresh page
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart                 |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 03 | AT SKU B PreOrder 14 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | Currently out of stock. |

  @B_PRE_ORDERS_DETAILS_17 @BUYER_PRE_ORDER
  Scenario: Check system response when tapping on Add to cart button of an items applied a MOQ request
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88890 | 53        | 33731              | 10000            | 10000      | coming_soon  | active | 2023-08-30               |
    # Create Pre order
    Given Buyer login web with by api
      | email                                       | password  |
      | ngoctx+stbpreorderdetail01chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 7824      | 33731 | 1        |
    # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbpreorderdetail01chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Buyer PreOrder 01 | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                      | creator                         | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stbpreorderdetail01 | ngoctx stbpreorderdetail01chi01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName                       | storeName                  | buyerEmail                                  | shippingAddress                                | total   |
      | ngoctx stbpreorderdetail01chi01 | ngoctx stbpreorderdetail01 | ngoctx+stbpreorderdetail01chi01@podfoods.co | 280 Columbus Avenue, New York, New York, 10023 | $100.00 |
    And Check items in pre order detail
      | brandName                  | productName              | skuName              | casePrice | quantity | total   | priceUnit    | unitUPC                      | addCart        | dateLaunchingSoon |
      | AT Brand Buyer PreOrder 01 | AT Product B PreOrder 04 | AT SKU B PreOrder 17 | $100.00   | 1        | $100.00 | $100.00/unit | Unit UPC / EAN: 123412512312 | Launching soon | 08/30/23          |
    # Change SKU to in stock
    Given NGOCTX7 login web admin by api
      | email                | password  |
      | ngoctx07@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88890 | 53        | 33731              | 10000            | 10000      | in_stock     | active | 2023-08-30               |
     # Verify Buyer
    And BUYER refresh page
    And Buyer add to cart of sku "AT SKU B PreOrder 17" in order detail
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 1        | 4        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check Items in MOQ alert
      | productName              | skuName              | unitCase    | price   | quantity |
      | AT Product B PreOrder 04 | AT SKU B PreOrder 17 | 1 unit/case | $100.00 | 0        |
    And Check button update cart is "disabled" in MOQ alert
    And Change quantity of skus in MOQ alert
      | skuName               | quantity |
      | aAT SKU B PreOrder 17 | 4        |
    And Check button update cart is "enable" in MOQ alert
    And Check notice disappear in MOQ alert
    And Update cart MOQ Alert
    And Buyer add to cart of sku "AT SKU B PreOrder 17" in order detail
    And Check notice disappear in MOQ alert
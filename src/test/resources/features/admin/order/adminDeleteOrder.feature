@feature=AdminDeletedOrder
Feature: Admin delete order

  @AdminDeleteOrder_01 @AdminDeleteOrder
  Scenario: Verify search and filter
    Given NGOCTX26 login web admin by api
      | email                  | password  |
      | ngoctx2600@podfoods.co | 12345678a |
    # Delete promo
    And Admin search promotion by Promotion Name "AT Promo Delete Order 01"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Sponsor Delete 01"
    And Admin delete promotion by skuName ""
    # Delete order
    When Search order by sku "64336" by api
    And Admin delete order of sku "64336" by api

      #  Delete tax
    Then Admin delete all tax of product '31470'
    # Add tax
    Then Admin add tax to product '31470'
      | id | value |
      | 52 | 100   |

    # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 64336 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                     | description              | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Delete Order 01 | AT Promo Delete Order 01 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

      # Create pod-sponsor promotion
    And Admin add region by API
      | region          | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Pod Direct East | 55        | [blank] | 3042      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                       | description                | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Sponsor Delete 01 | AT Promo Sponsor Delete 01 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132288             | 64336              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3847     | [blank]    | delete01    | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    When Search order by sku "64336" by api
    And Admin delete order of sku "64336" by api

    Given NGOC_ADMIN_26 open web admin
    When login to beta web with email "ngoctx2600@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_26 navigate to "Orders" to "Deleted orders" by sidebar
    # Search by order number
    And Admin search the orders deleted by info
      | orderNumber |
      | 1241231254  |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   |
      | create by api |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by subinvoice
    And Admin search the orders deleted by info
      | sub | orderNumber |
      | 1   | sub         |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by customer po
    And Admin search the orders deleted by info
      | orderNumber |
      | delete01    |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
     # Search by store
    And Admin search the orders deleted by info
      | orderNumber   | store            |
      | create by api | ngoctx ststate04 |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | store             |
      | create by api | ngoctx stdelete01 |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
     # Search by buyer
    And Admin search the orders deleted by info
      | orderNumber   | buyer                        |
      | create by api | ngoctx stborderdetail56chi01 |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | buyer                 |
      | create by api | ngoctx stdelete01ny01 |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by vendor company
    And Admin search the orders deleted by info
      | orderNumber   | vendorCompany |
      | create by api | ngoc vc2      |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | vendorCompany |
      | create by api | ngoc vc 1     |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by brand
    And Admin search the orders deleted by info
      | orderNumber   | brand                       |
      | create by api | AT Brand A Order Summary 01 |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | brand              |
      | create by api | AT Brand Delete 01 |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by sku
    And Admin search the orders deleted by info
      | orderNumber   | sku               |
      | create by api | AT SKU A Order 11 |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | sku              |
      | create by api | AT SKU Delete 01 |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by sku - item code
    And Admin search the orders deleted by info
      | orderNumber   | sku              | skuID |
      | create by api | AT SKU Delete 01 | 64336 |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
     # Search by upc/earn
    And Admin search the orders deleted by info
      | orderNumber   | upc          |
      | create by api | 123124123123 |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | upc          |
      | create by api | 123125412001 |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
     # Search by fulfillment
    And Admin search the orders deleted by info
      | orderNumber   | fulfillment  |
      | create by api | Awaiting POD |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | fulfillment |
      | create by api | Pending     |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
     # Search by buyer payment
    And Admin search the orders deleted by info
      | orderNumber   | buyerPayment |
      | create by api | Paid         |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | buyerPayment |
      | create by api | Pending      |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by vendor payment
    And Admin search the orders deleted by info
      | orderNumber   | vendorPayment |
      | create by api | In progress   |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | vendorPayment |
      | create by api | Pending       |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    # Search by region
    And Admin search the orders deleted by info
      | orderNumber   | region              |
      | create by api | Chicagoland Express |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | region           |
      | create by api | New York Express |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
     # Search by start date
    And Admin search the orders deleted by info
      | orderNumber   | startDate |
      | create by api | Plus1     |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | startDate   |
      | create by api | currentDate |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
     # Search by end date
    And Admin search the orders deleted by info
      | orderNumber   | endDate |
      | create by api | Minus1  |
    Then Admin no found order in result
    And Admin search the orders deleted by info
      | orderNumber   | endDate     |
      | create by api | currentDate |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |

    And Admin go to order detail number "create by admin"
    And Admin verify general information of order deleted detail
      | customerPo | date        | region           | buyer                 | store             | creator    | deletedBy         | deletedOn   | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment | showOnVendor |
      | delete01   | currentDate | New York Express | ngoctx stdelete01ny01 | ngoctx stdelete01 | ngoctx2600 | Admin: ngoctx2600 | currentDate | Pending      | Payment via invoice | [blank]     | Pending       | Pending     | No           |
    And Admin verify price in order deleted details
      | orderValue | discount | taxes | smallOrderSurcharge | fuelSurcharge | total  | vendorServiceFee |
      | $10.00     | $0.00    | $1.00 | $30.00              | Not applied   | $41.00 | $2.50            |
    And Admin check line items non invoice in order deleted details
      | brand              | product              | sku              | skuID | caseUnit     | casePrice | quantity | endQuantity | total  | distribution |
      | AT Brand Delete 01 | AT Product Delete 01 | AT SKU Delete 01 | 64336 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 | Yes          |
    And Admin verify vendor payment in order deleted details
      | product   | fulfillment | paymentState | value  | discount | serviceFee | additionalFee | paidToVendor | payoutDate | payoutType |
      | ngoc vc 1 | Pending     | Pending      | $10.00 | $0.00    | $2.50      | $0.00         | $7.50        | [blank]    | [blank]    |
    # Verify how to use button
    And Admin verify how to use button detail
    # Verify refresh page
    And Admin refresh page by button
    And Admin verify general information of order deleted detail
      | customerPo | date        | region           | buyer                 | store             | creator    | deletedBy         | deletedOn   | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment | showOnVendor |
      | delete01   | currentDate | New York Express | ngoctx stdelete01ny01 | ngoctx stdelete01 | ngoctx2600 | Admin: ngoctx2600 | currentDate | Pending      | Payment via invoice | [blank]     | Pending       | Pending     | No           |
    And Admin go to "buyer" by redirect icon and verify
    And NGOC_ADMIN_26 go back
    And Admin go to "store" by redirect icon and verify
    And NGOC_ADMIN_26 go back

  @AdminDeleteOrder_02 @AdminDeleteOrder
  Scenario: Verify All possible delivery day
    Given NGOCTX26 login web admin by api
      | email                  | password  |
      | ngoctx2601@podfoods.co | 12345678a |
      # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Delete 02 | 64363              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132315             | 64363              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3848     | [blank]    | delete01    | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |
    # Reset search filter full textbox
    And Admin filter visibility with id "32" by api
      | q[number]               |
      | q[custom_store_name]    |
      | q[store_id]             |
      | q[buyer_id]             |
      | q[vendor_company_id]    |
      | q[brand_id]             |
      | q[product_variant_ids]  |
      | q[upc]                  |
      | q[fulfillment_state]    |
      | q[buyer_payment_state]  |
      | q[vendor_payment_state] |
      | q[region_id]            |
      | start_date              |
      | end_date                |

    Given NGOC_ADMIN_26 open web admin
    When login to beta web with email "ngoctx2601@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_26 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin delete order by order number by info
      | orderNumber   | reason           | note      | passkey      |
      | create by api | Buyer adjustment | Auto Test | pizza4cheese |

    And NGOC_ADMIN_26 navigate to "Orders" to "Deleted orders" by sidebar
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderNumber | customStore | store   | buyer   | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | vendorPayment | region  | startDate | endDate |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank]       | [blank] | [blank]   | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | orderNumber | customStore | store   | buyer   | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | vendorPayment | region  | startDate | endDate |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank]       | [blank] | [blank]   | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | orderNumber | customStore | store   | buyer   | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | vendorPayment | region  | startDate | endDate |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank]       | [blank] | [blank]   | [blank] |
    Then Admin verify field search in edit visibility
      | orderNumber | customStore | store   | buyer   | vendorCompany | brand   | sku     | upc     | fulfillment | buyerPayment | vendorPayment | region  | startDate | endDate |
      | [blank]     | [blank]     | [blank] | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank]     | [blank]      | [blank]       | [blank] | [blank]   | [blank] |
    # Verify save new filter
    And Admin search the orders deleted by info
      | orderNumber | orderSpecific | store             | buyer                 | vendorCompany | fulfillment | buyerPayment | vendorPayment | brand              | sku              | upc          | region           | startDate   | endDate     |
      | 123124123   | orderSpecific | ngoctx stdelete01 | ngoctx stdelete01ny01 | ngoc vc 1     | Pending     | Pending      | Pending       | AT Brand Delete 01 | AT SKU Delete 01 | 123125412001 | New York Express | currentDate | currentDate |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | orderNumber | orderSpecific | store             | buyer                 | vendorCompany | fulfillmentOrder | buyerPayment | vendorPayment | brand              | sku              | upc          | region           | startDate   | endDate     |
      | 123124123   | orderSpecific | ngoctx stdelete01 | ngoctx stdelete01ny01 | ngoc vc 1     | Pending          | Pending      | Pending       | AT Brand Delete 01 | AT SKU Delete 01 | 123125412001 | New York Express | currentDate | currentDate |
    # Verify save as filter
    And Admin search the orders deleted by info
      | orderNumber | orderSpecific | store             | buyer                 | vendorCompany | fulfillment | buyerPayment | vendorPayment | brand              | sku              | upc          | region           | startDate   | endDate     |
      | 21412312123 | orderSpecific | ngoctx stdelete01 | ngoctx stdelete01ny01 | ngoc vc 1     | Pending     | Pending      | Pending       | AT Brand Delete 01 | AT SKU Delete 01 | 123125412001 | New York Express | currentDate | currentDate |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    And Admin search the orders deleted by info
      | orderNumber | orderSpecific | store             | buyer                 | vendorCompany | fulfillmentOrder | buyerPayment | vendorPayment | brand              | sku              | upc          | region           | startDate   | endDate     |
      | 21412312123 | orderSpecific | ngoctx stdelete01 | ngoctx stdelete01ny01 | ngoc vc 1     | Pending          | Pending      | Pending       | AT Brand Delete 01 | AT SKU Delete 01 | 123125412001 | New York Express | currentDate | currentDate |

     # Search by order number
    And Admin search the orders deleted by info
      | orderNumber   |
      | create by api |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete02ny01 | ngoctx stdelete02 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And Admin go to order detail number "create by api"
    And Admin verify general information of order deleted detail
      | customerPo | date        | region           | buyer                 | store             | creator    | deletedBy         | deletedOn   | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment | showOnVendor |
      | delete01   | currentDate | New York Express | ngoctx stdelete02ny01 | ngoctx stdelete02 | ngoctx2601 | Admin: ngoctx2601 | currentDate | Pending      | Payment via invoice | [blank]     | Pending       | Pending     | Yes          |
    And Admin verify receiving info
      | possibleReceiving | setReceiving | receivingTime              | receivingNote          | directReceivingNote   |
      | Full Day          | Full Day     | Pacific Time (US & Canada) | Express receiving note | Direct receiving note |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | adminNote | lpNote |

  @AdminDeleteOrder_03 @AdminDeleteOrder
  Scenario: Verify Admin delete order with fulfillment = Inprogress, Fulfilled
    Given NGOCTX26 login web admin by api
      | email                  | password  |
      | ngoctx2600@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Delete 01 | 64336              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132288             | 64336              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3847     | [blank]    | delete01    | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
   # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName          | skuId | order_id      | fulfilled |
      | 1     | AT SKU Delete 01 | 64336 | create by api | true      |

    Given NGOC_ADMIN_26 open web admin
    When login to beta web with email "ngoctx2600@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_26 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete order from order detail and verify message "Can not delete this order because it is related to statement items"
      | reason           | note     | showEdit | passkey |
      | Buyer adjustment | Autotest | Yes      | [blank] |
    And NGOC_ADMIN_09 quit browser

  @AdminDeleteOrder_04 @AdminDeleteOrder
  Scenario: Verify Admin delete order with fulfillment = Pending
    Given NGOCTX26 login web admin by api
      | email                  | password  |
      | ngoctx2600@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Delete 01 | 64336              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 132288             | 64336              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3847     | [blank]    | delete01    | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_26 open web admin
    When login to beta web with email "ngoctx2600@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_26 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete order from order detail
      | reason           | note     | showEdit | passkey |
      | Buyer adjustment | Autotest | Yes      | [blank] |

    And NGOC_ADMIN_26 navigate to "Orders" to "Deleted orders" by sidebar
     # Search by order number
    And Admin search the orders deleted by info
      | orderNumber   |
      | create by api |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete01ny01 | ngoctx stdelete01 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And Admin go to order detail number "create by api"
    And Admin verify general information of order deleted detail
      | customerPo | date        | region           | buyer                 | store             | creator    | deletedBy         | deletedOn   | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment | showOnVendor |
      | delete01   | currentDate | New York Express | ngoctx stdelete01ny01 | ngoctx stdelete01 | ngoctx2600 | Admin: ngoctx2600 | currentDate | Pending      | Payment via invoice | [blank]     | Pending       | Pending     | Yes          |
    And Admin verify ETA email not set is not display in delete order detail

  @AdminDeleteOrder_05 @AdminDeleteOrder
  Scenario: Verify Admin delete order with PD item
    Given NGOCTX26 login web admin by api
      | email                  | password  |
      | ngoctx2600@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 137179             | 67858              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3848     | [blank]    | delete01    | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
    # Set invoice
    And Admin set Invoice by API
      | skuName          | skuId | order_id      | eta_date | payment_state | surfix |
      | AT SKU Delete 03 | 67858 | create by api | [blank]  | pending       | 1      |
   # Create purchase order
    And Admin create purchase order of sub-invoice "create by api" suffix "1" by API
      | fulfillment_date | fulfillment_state | admin_note | logistics_partner_note | proof_of_deliveries_attributes | logistics_company_id |
      | [blank]          | unconfirmed       | adminNote  | lpNote                 | [blank]                        | 99                   |

    Given NGOC_ADMIN_26 open web admin
    When login to beta web with email "ngoctx2600@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_26 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete order from order detail
      | reason           | note     | showEdit | passkey      |
      | Buyer adjustment | Autotest | Yes      | pizza4cheese |

    And NGOC_ADMIN_26 navigate to "Orders" to "Deleted orders" by sidebar
         # Search by order number
    And Admin search the orders deleted by info
      | orderNumber   |
      | create by api |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete02ny01 | ngoctx stdelete02 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And Admin go to order detail number "create by api"
    And Admin verify general information of order deleted detail
      | customerPo | date        | region           | buyer                 | store             | creator    | deletedBy         | deletedOn   | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment | showOnVendor |
      | delete01   | currentDate | New York Express | ngoctx stdelete02ny01 | ngoctx stdelete02 | ngoctx2600 | Admin: ngoctx2600 | currentDate | Pending      | Payment via invoice | [blank]     | Pending       | Pending     | Yes          |
    And Admin verify Purchase order
      | logisticPartner     | status      | dateFulfill | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed | [blank]     | adminNote | lpNote |
    And Admin verify price in order deleted details
      | orderValue | discount | taxes | smallOrderSurcharge | fuelSurcharge | total  | vendorServiceFee |
      | $10.00     | $0.00    | $1.00 | Not applied         | Not applied   | $11.00 | $2.50            |
    And Admin check line items non invoice in order deleted details
      | brand              | product              | sku              | skuID | caseUnit     | casePrice | quantity | endQuantity | total  | distribution |
      | AT Brand Delete 01 | AT Product Delete 01 | AT SKU Delete 03 | 67858 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 | No           |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total   | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $100.00 | 1             | 1.00 lbs    | Awaiting POD      | Yes         |

  @AdminDeleteOrder_06 @AdminDeleteOrder
  Scenario: Verify Admin delete order with PD item - non invoice
    Given NGOCTX26 login web admin by api
      | email                  | password  |
      | ngoctx2600@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 137179             | 67858              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1        | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3848     | [blank]    | delete01    | invoice      | [blank]      | [blank] | 281 9th Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_26 open web admin
    When login to beta web with email "ngoctx2600@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_26 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin delete order from order detail
      | reason           | note     | showEdit | passkey |
      | Buyer adjustment | Autotest | Yes      | [blank] |

    And NGOC_ADMIN_26 navigate to "Orders" to "Deleted orders" by sidebar
         # Search by order number
    And Admin search the orders deleted by info
      | orderNumber   |
      | create by api |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete02ny01 | ngoctx stdelete02 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And Admin go to order detail number "create by api"
    # Verify back button
    And Admin go back with button
     # Search by order number
    And Admin search the orders deleted by info
      | orderNumber   |
      | create by api |
    Then Admin verify result order in deleted order
      | order         | checkout    | buyer                 | store             | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | create by api | currentDate | ngoctx stdelete02ny01 | ngoctx stdelete02 | NY     | $10.00 | $2.50     | Pending      | Pending     | Pending       |
    And Admin go to order detail number "create by api"
    And Admin verify general information of order deleted detail
      | customerPo | date        | region           | buyer                 | store             | creator    | deletedBy         | deletedOn   | buyerPayment | paymentType         | paymentDate | vendorPayment | fulfillment | showOnVendor |
      | delete01   | currentDate | New York Express | ngoctx stdelete02ny01 | ngoctx stdelete02 | ngoctx2600 | Admin: ngoctx2600 | currentDate | Pending      | Payment via invoice | [blank]     | Pending       | Pending     | Yes          |
    And Admin verify price in order deleted details
      | orderValue | discount | taxes | smallOrderSurcharge | fuelSurcharge | total  | vendorServiceFee |
      | $10.00     | $0.00    | $1.00 | Not applied         | Not applied   | $11.00 | $2.50            |
    And Admin check line items non invoice in order deleted details
      | brand              | product              | sku              | skuID | caseUnit     | casePrice | quantity | endQuantity | total  | distribution |
      | AT Brand Delete 01 | AT Product Delete 01 | AT SKU Delete 03 | 67858 | 1 units/case | $10.00    | 1        | [blank]     | $10.00 | No           |
    # Verify how to use button
    And Admin verify how to use button detail
    # Verify export CSV button
    And Admin export delete order detail
    And Admin check content file export "delete order detail"
      | customerPO | date    | store             | shippingAddress                           | receivingDate | earlestReceivingTime | latestReceivingTime | buyer                 | paymentMethod   | region          | brandID | brand              | product              | sku              | priceCase | unitCase | taxes   | quantity | promotion | itemValue | itemPrice | fulfillmentDate | deliveryMethod | deliveryDetail | sub     |
      | [blank]    | [blank] | ngoctx stdelete02 | 281 9th Avenue, New York, New York, 10001 | [blank]       | [blank]              | [blank]             | ngoctx stdelete02ny01 | Pay via invoice | Pod Direct East | 4124    | AT Brand Delete 01 | AT Product Delete 01 | AT SKU Delete 03 | 10        | 1        | [blank] | 1        | $0.00     | [blank]   | [blank]   | [blank]         | Undelivery     | [blank]        | [blank] |



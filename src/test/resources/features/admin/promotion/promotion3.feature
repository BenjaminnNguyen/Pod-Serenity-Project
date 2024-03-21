#mvn verify -Dtestsuite="PromotionTestSuite3" -Dcucumber.options="src/test/resources/features/promotion"

@feature=Promotion3
Feature: Promotion3

  @Promotion @PROMOTION_134
  Scenario: Buyer checkout with a SKU which is applied TPR promotion successfully
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 134 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Change state of SKU id: "35093" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
#    Set PRICING Brand
    And Admin set Fixed pricing of brand "3002" with "0.25" by API

    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 134 Promotion | Test API    | currentDate | currentDate | 2           | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    Then Verify promo preview "TPR" of product "Auto product promotion" in "Catalog page"
      | name                   | type | price | caseLimit |
      | Auto SKU 138 promotion | TPR  | $5.00 | 3         |
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice |  | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails | caseMinimum | expireDate |
      | $10.00    |  | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                | 3           | [blank]    |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region              | store     | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |
#
    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    And  Verify tag "TPR" promotion is "show" on product "Auto product promotion"
#    //Check on order summary
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 134 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_135
  Scenario: Buyer checkout with a SKU which is applied Buy-in promotion successfully
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto product api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto product api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"
    And Admin search promotion by Promotion Name "Auto Buy-in 135 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name               | brand_id |
      | Auto product api 1 | 3002     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random" of product ""
    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 3        | sku random | 99           | Plus1        | [blank]     | [blank] |
#    Set PRICING Brand
    And Admin set Fixed pricing of brand "3002" with "0.25" by API

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                      | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto Buy-in 135 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product api 1"
    And Verify Promotional Discount of "Auto product api 1" and sku "random" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo        | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | Buy-in Promotion | 50% off  | $5.00    | 3         | 50%                |
    And Search product by name "Auto product api 1", sku "random" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 123123123123 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product api 1"
    And  Verify tag "Buy in" promotion is "not show" on product "Auto product api 1"

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product            | sku    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product api 1 | random | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 3.00 lbs    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $15.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api
    And Admin search promotion by Promotion Name "Auto Buy-in 135 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"

  @Promotion @PROMOTION_136
  Scenario: Buyer checkout with a SKU which is applied Short-dated promotion successfully
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 136 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 134 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy-in 135 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |

    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto Short-dated 136 Promotion | Test API    | currentDate | currentDate | 2           | 3          | 3                | true           | [blank] | default    | currentDate   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | 3         | 50%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    Then Verify promo preview "Short dated" of product "Auto product promotion" in "Catalog page"
      | name                   | type        | price | caseLimit |
      | Auto SKU 138 promotion | SHORT-DATED | $5.00 | 3         |
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails | caseMinimum | expireDate |
      | $10.00    | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | 3         | 50%                | 3           | [blank]    |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    And  Verify tag "Short dated" promotion is "show" on product "Auto product promotion"
#    //Check on order summary
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 136 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 134 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_137
  Scenario: Buyer checkout a cart have only Pod-sponsored discount
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 137 Promotion"
    And Admin delete promotion by skuName ""

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                             | description      | type          | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Pod-sponsored 137 Promotion | Auto Description | Pod-sponsored | [blank]   | [blank]    | [blank]   | [blank]     | currentDate | currentDate | [blank]    | [blank] | Bao store | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Search promotion by info
      | name                             | type          | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Pod-sponsored 137 Promotion | Pod-sponsored | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                             | type          | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Pod-sponsored 137 Promotion | Pod-sponsored | CHI    | currentDate | currentDate | [blank]    | [blank]   |
#
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 3        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
      | [blank]            | $30.00              | -$15.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $30.00   | -$15.00         |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00         |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $0.00    | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 | $15.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $30.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $22.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$0.00    | $30.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $30.00   | -$15.00         |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 137 Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_138
  Scenario: Buyer checkout a cart have 2 Pod-sponsored promotion
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 137 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Short-dated 138 Promotion"
    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "Auto TPR Promotion"
#    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
#    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::PodSponsored | Auto Short-dated 138 Promotion | Test API    | currentDate | currentDate | 2           | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::PodSponsored | Auto Short-dated 138 Promotion 2 | Test API    | currentDate | currentDate | 2           | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 3        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
      | [blank]            | $30.00              | -$15.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $30.00   | -$15.00         |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00         |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $0.00    | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 | $15.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $30.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $22.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$0.00    | $30.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $30.00   | -$15.00         |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 138 Promotion"
    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "Auto TPR Promotion"
#    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
#    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_139
  Scenario: Buyer checkout with a SKU which is applied 2 normal promotions at the same time and that 2 promotions have different case minimums
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 138 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
          # Set pricing
    And Admin set Fixed pricing of brand "3002" with "0.25" by API
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 139 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Short-dated 139 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | currentDate   | false   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | 3         | 50%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 1        |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $10.00   |
#    And and check price on cart detail
#      | logisticsSurcharge | smallOrderSurcharge |
#      | $20.00             | $30.00              |

    And Update quantity item "Auto SKU 138 promotion" to "2" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$4.00   | $16.00   |

    And Update quantity item "Auto SKU 138 promotion" to "3" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |

    And Update quantity item "Auto SKU 138 promotion" to "2" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$4.00   | $16.00   |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 46.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $20.00     | $46.00 | By invoice | Pending | $20.00            | $30.00     | -$4.00   |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 2        | $16.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $20.00     | $4.00    | $0.00 | $30.00              | $0.00              | $5.00            | $46.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 2        | [blank]     | $16.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $16.00 | 2             | 24.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $11.00 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$4.00    | $16.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 2        | $16.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 139 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 139 Promotion"
    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
#    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_140
  Scenario: Buyer checkout a cart have both Pod-sponsored discount and Normal promotional discount
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 139 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 139 Promotion"
    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
#    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 140 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |

    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | Auto Pod-sponsored 140 Promotion | Test API    | currentDate | currentDate | 2           | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $8.00        | $10.00   | TPR Promotion | 20% off  | $8.00    | 3         | 20%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 1        |
#    And and verify price on cart tab on right side
#      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
#      | $20.00             | $30.00              | -$12.00         |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | specialDiscount |
      | [blank]  | [blank]  | [blank]  | -$5.00          |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 35.00 |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $10.00   | -$5.00          |
    And Buyer close popup

    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 35.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $10.00     | $35.00 | By invoice | Pending | $20.00            | $30.00     | -$5.00          |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 1        | $10.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $35.00 | $5.00           |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $5.00 | 1             | 12.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$0.00    | $10.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 1        | $10.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $8.00    | -$6.00   | $24.00   | -$12.00         |
    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 42.00 |

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $6.00    | $0.00 | $30.00              | $0.00              | $7.50            | $42.00 | $12.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $24.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $12.00 | 3             | 36.00 lbs   |

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $16.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$6.00    | $24.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $24.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 140 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 140 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 140 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_141
  Scenario: Buyer checkout a cart have both Pod-sponsored discount and Normal promotional discount 2
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 140 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 140 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 140 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 141 Promotion | Test API    | currentDate | currentDate | [blank]     | 2          | 2                | true           | [blank] | default    | [blank]       |

    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | Auto Pod-sponsored 141 Promotion | Test API    | currentDate | currentDate | 2           | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $0.00        | $10.00   | TPR Promotion | 100% off | $0.00    | 2         | 100%               |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 1        |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | specialDiscount |
      | [blank]  | [blank]  | [blank]  | -$5.00          |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 35.00 |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $10.00   | -$5.00          |
    And Update quantity item "Auto SKU 138 promotion" to "2" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$20.00  | $0.00    |
    And Update quantity item "Auto SKU 138 promotion" to "3" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $3.33    | -$20.00  | $10.00   | -$5.00          |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 35.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $35.00 | By invoice | Pending | $20.00            | $30.00     | -$20.00  | -$5.00          |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $10.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $20.00   | $0.00 | $30.00              | $0.00              | $7.50            | $35.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $10.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $5.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $2.50 |
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | Pending           | currentDate     |
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$20.00   | $10.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $10.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $3.33    | -$20.00  | $10.00   | -$5.00          |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 141 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 141 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 141 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_142
  Scenario: Buyer checkout with a SKU which is applied TPR promotion 100%
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 141 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 141 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 142 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $0.00        | $10.00   | TPR Promotion | 100% off | $0.00    | 3         | 100%               |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 2        |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 50.00 |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |
    And Update quantity item "Auto SKU 138 promotion" to "3" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$30.00  | $0.00    |
    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 30.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $30.00 | By invoice | Pending | $20.00            | $30.00     | -$30.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $30.00   | $0.00 | $30.00              | $0.00              | $7.50            | $30.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $0.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $0.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | -$7.50 |
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | Pending           | currentDate     |
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$30.00   | $0.00        |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$30.00  | $0.00    |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 142 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_143
  Scenario: Buyer checkout with a SKU which is applied Buy-in promotion 100%
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto product api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto product api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api

    And Create product by api with file "CreateProduct.json" and info
      | name               | brand_id |
      | Auto product api 1 | 3002     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random" of product ""

    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"

    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 3        | sku random | 99           | Plus1        | [blank]     | [blank] |
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type              | name                  | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto Buy-in Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product api 1"
    And Verify Promotional Discount of "Auto product api 1" and sku "random" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo        | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $0.00        | $10.00   | Buy-in Promotion | 100% off | $0.00    | 3         | 100%               |
    And Search product by name "Auto product api 1", sku "random" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$30.00  | $0.00    |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 30.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $30.00 | By invoice | Pending | $20.00            | $30.00     | -$30.00  |
    And Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $0.00 | [blank] | In Progress   | Unit UPC / EAN: 123123123123 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product api 1"
    And  Verify tag "Buy in" promotion is "not show" on product "Auto product api 1"

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $30.00   | $0.00 | $30.00              | $0.00              | $7.50            | $30.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product            | sku    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand promotion | Auto product api 1 | random | 1 units/case | $10.00    | 3        | [blank]     | $0.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $0.00 | 3             | 3.00 lbs    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | -$7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$30.00   | $0.00        |
    And Vendor Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total | podConsignment  |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $0.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"

  @Promotion @PROMOTION_144
  Scenario: Buyer checkout with a SKU which is applied Short-dated promotion 100%
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto Short-dated 144 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | currentDate   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $0.00        | $10.00   | Short-dated Promotion | 100% off | $0.00    | 3         | 100%               |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$30.00  | $0.00    |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 30.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $30.00 | By invoice | Pending | $20.00            | $30.00     | -$30.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    Then Verify promo preview "Short dated" of product "Auto product promotion" in "Catalog page"
      | name                   | type        | price | caseLimit |
      | Auto SKU 138 promotion | SHORT-DATED | $0.00 | 3         |
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails | caseMinimum | expireDate  |
      | $10.00    | $0.00        | $10.00   | Short-dated Promotion | 100% off | $0.00    | 3         | 100%               | 3           | currentDate |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $30.00   | $0.00 | $30.00              | $0.00              | $7.50            | $30.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $0.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $0.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | -$7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$30.00   | $0.00        |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$30.00  | $0.00    |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 30.00 |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    And  Verify tag "Short dated" promotion is "show" on product "Auto product promotion"
#    //Check on order summary
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 144 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_145
  Scenario: Buyer checkout a cart have only Pod-sponsored discount 2
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
#    And Admin delete promotion by skuName ""
#    And Admin search promotion by Promotion Name "Auto Short-dated 144 Promotion"
#    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 145 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::PodSponsored | Auto Pod-sponsored 145 Promotion | Test API    | currentDate | currentDate | 2           | [blank]    | 3                | [blank]        | [blank] | default    | [blank]       |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 3        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
      | [blank]            | $30.00              | -$30.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $30.00   | -$30.00         |
    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 30.00 |

    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $30.00 | By invoice | Pending | $20.00            | $30.00     | -$30.00         |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $0.00    | $0.00 | $30.00              | $0.00              | $7.50            | $30.00 | $30.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $30.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $0.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $22.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$0.00    | $30.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $30.00   | -$30.00         |
    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 30.00 |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 145 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_146
  Scenario: Admin creates an order with a SKU which is applied TPR promotion successfully
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Admin search promotion by Promotion Name "Auto Pod-sponsored 145 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 146 Promotion | Test API    | currentDate | currentDate | 2           | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "Auto SKU 138 promotion" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | 45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    Then Verify promo preview "TPR" of product "Auto product promotion" in "Catalog page"
      | name                   | type | price | caseLimit |
      | Auto SKU 138 promotion | TPR  | $5.00 | 3         |
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails | caseMinimum | expireDate |
      | $10.00    | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                | 3           | [blank]    |

    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 146 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_147
  Scenario: Admin creates an order with a SKU which is applied Short-dated promotion successfully
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto Short-dated 147 Promotion | Test API    | currentDate | currentDate | 2           | 3          | 3                | true           | [blank] | default    | currentDate   |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "Auto SKU 138 promotion" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | 3         | 50%                |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    Then Verify promo preview "Short dated" of product "Auto product promotion" in "Catalog page"
      | name                   | type        | price | caseLimit |
      | Auto SKU 138 promotion | SHORT-DATED | $5.00 | 3         |
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails | caseMinimum | expireDate  |
      | $10.00    | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | 3         | 50%                | 3           | currentDate |

    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    And  Verify tag "Short dated" promotion is "show" on product "Auto product promotion"
#    //Check on order summary
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 147 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_148
  Scenario: Admin creates an order with a SKU which is applied Buy-in promotion successfully
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto product api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto product api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name               | brand_id |
      | Auto product api 1 | 3002     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random" of product ""
    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 3        | sku random | 99           | Plus1        | [blank]     | [blank] |

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                  | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto Buy-in Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "random" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product            | sku    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product api 1 | random | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 3.00 lbs    |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 123123123123 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product api 1"
    And  Verify tag "Buy in" promotion is "not show" on product "Auto product api 1"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $15.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"

  @Promotion @PROMOTION_149
  Scenario: Admin create an order have both Pod-sponsored discount and Normal promotional discount
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 149 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | Auto Pod-sponsored 149 Promotion | Test API    | currentDate | currentDate | 2           | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "Auto SKU 138 promotion" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $6.00    | $0.00 | $30.00              | $0.00              | $7.50            | $42.00 | $12.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $24.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $12.00 | 3             | 36.00 lbs   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $8.00        | $10.00   | TPR Promotion | 20% off  | $8.00    | 3         | 20%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | specialDiscount |
      | [blank]  | -$6.00   | [blank]  | -$12.00         |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 42.00 |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $8.00    | -$6.00   | $24.00   | -$12.00         |

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $42.00 | By invoice | Pending | $20.00            | $30.00     | -$6.00   | -$12.00         |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $24.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $16.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$6.00    | $24.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $24.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 149 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 149 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 149 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_150
  Scenario: Admin create an order with a SKU which is applied TPR promotion 100%
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 149 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 150 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "Auto SKU 138 promotion" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $30.00   | $0.00 | $30.00              | $0.00              | $7.50            | $30.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $0.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $0.00 | 3             | 36.00 lbs   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $30.00 | By invoice | Pending | $20.00            | $30.00     | -$30.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $0.00        | $10.00   | TPR Promotion | 100% off | $0.00    | 3         | 100%               |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 2        |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 50.00 |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |
    And Update quantity item "Auto SKU 138 promotion" to "3" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$30.00  | $0.00    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | -$7.50 |
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | Pending           | currentDate     |
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$30.00   | $0.00        |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by Promotion Name "Auto TPR 150 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @Admin_order_details_431
  Scenario: Check promoting the shorted line item but the order has only Non-invoiced section
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order detail 431 api" by api
    And Admin search promotion by Promotion Name "Auto TPR 431 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "random product order detail 431 api"
    And Admin delete promotion by skuName "random product order detail 431 api"
    And Admin search product name "random product order detail 431 api" by api
    And Admin delete product name "random product order detail 431 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product order detail 431 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku order detail 431 api" of product ""
#    And Admin create inventory api1
#      | index | sku                             | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | random sku order detail 431 api | random             | 5        | random sku order detail 431 api | 99           | Plus1        | [blank]     | [blank] |

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 431 Promotion | Test API    | currentDate | currentDate | [blank]     | 5          | 1                | true           | [blank] | default    | [blank]       |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given ADMIN open web admin
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "Admin"
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "deleted or shorted items" in order details
      | brand                     | product                             | sku                             | unitCase     | casePrice | quantity | endQuantity | total  | oldTotal |
      | Auto brand create product | random product order detail 431 api | random sku order detail 431 api | 1 units/case | $10.00    | 2        | [blank]     | $10.00 | $20.00   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $0.00      | $0.00    | $0.00 | Not applied         | $0.00              | $0.00            | $0.00 |

  @Promotion @Admin_order_details_432
  Scenario: Check promoting the shorted line item but the order has only Non-invoiced section 2
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order detail 432 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product order detail 432 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product order detail 432 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product order detail 432 api" by api
    And Admin delete product name "random product order detail 432 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product order detail 432 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku order detail 432 api 1" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku order detail 432 api 1 | random             | 5        | random sku order detail 432 api 1 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create a "active" SKU from admin with name "random sku order detail 432 api 2" of product ""

    And Admin create line items attributes by API
      | skuName                           | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku order detail 432 api 1 | create by api26    | create by api      | 1        | false     | [blank]          |
      | random sku order detail 432 api 2 | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given ADMIN open web admin
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "Admin"
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 432 api | random sku order detail 432 api 1 | 1 units/case | $10.00    | 1        | 4           | $10.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $10.00 | 1             | 1.00 lbs    |
    And Admin check line items "deleted or shorted items" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 432 api | random sku order detail 432 api 2 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
    And Admin remove sub-invoice with info
      | index | skuName                           | type    | subinvoice |
      | 1     | random sku order detail 432 api 1 | express | 1          |
    And Admin check line items "non invoice" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 432 api | random sku order detail 432 api 1 | 1 units/case | $10.00    | 1        | 4           | $10.00 |
# Create inventory for SKU_A in order to sufficient to fulfill all shorted quantity
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku order detail 432 api 2 | random             | 3        | random sku order detail 432 api 2 | 99           | Plus1        | [blank]     | [blank] |
    And Admin refresh page by button
    And Admin check line items "sub invoice" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 432 api | random sku order detail 432 api 2 | 1 units/case | $10.00    | 1        | 2           | $10.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $10.00 | 1             | 1.00 lbs    |
    And Admin check line items "non invoice" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 432 api | random sku order detail 432 api 1 | 1 units/case | $10.00    | 1        | 4           | $10.00 |


  @Promotion @Admin_order_details_433
  Scenario: Check promoting the shorted line item when the order has multiple sub-invoices
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order detail 433 api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product order detail 433 api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product order detail 433 api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search product name "random product order detail 433 api" by api
    And Admin delete product name "random product order detail 433 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                | brand_id |
      | random product order detail 433 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku order detail 433 api 1" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku order detail 433 api 1 | random             | 5        | random sku order detail 433 api 1 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create a "active" SKU from admin with name "random sku order detail 433 api 2" of product ""
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku order detail 433 api 2 | random             | 5        | random sku order detail 433 api 2 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create a "active" SKU from admin with name "random sku order detail 433 api 3" of product ""

    And Admin create line items attributes by API
      | skuName                           | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | random sku order detail 433 api 1 | create by api26    | create by api      | 1        | false     | [blank]          |
      | random sku order detail 433 api 2 | create by api26    | create by api      | 1        | false     | [blank]          |
      | random sku order detail 433 api 3 | create by api26    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given ADMIN open web admin
    When login to beta web with email "bao@podfoods.co" pass "12345678a" role "Admin"
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 433 api | random sku order detail 433 api 1 | 1 units/case | $10.00    | 1        | 4           | $10.00 |
      | Auto brand create product | random product order detail 433 api | random sku order detail 433 api 2 | 1 units/case | $10.00    | 1        | 4           | $10.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $20.00 | 2             | 2.00 lbs    |
    And Admin check line items "deleted or shorted items" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 433 api | random sku order detail 433 api 3 | 1 units/case | $10.00    | 1        | 0           | $10.00 |
  # Set invoice
    And Admin set Invoice by API
      | skuName                           | skuId         | order_id      | eta_date | payment_state | surfix |
      | random sku order detail 433 api 2 | create by api | create by api | [blank]  | pending       | 2      |
    And Admin refresh page by button
    And Admin check line items "sub invoice" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 433 api | random sku order detail 433 api 1 | 1 units/case | $10.00    | 1        | 4           | $10.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $10.00 | 1             | 1.00 lbs    |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 1   | [blank] | Pending       | $10.00 | 1             | 1.00 lbs    | Pending           | Yes         |
#    And Admin check line items "sub invoice" in order details
#      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
#      | Auto brand create product | random product order detail 433 api | random sku order detail 433 api 2 | 1 units/case | $10.00    | 1        | 4           | $10.00 |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 2   | [blank] | Pending       | $10.00 | 1             | 1.00 lbs    | Pending           | Yes         |
  # Create inventory for SKU_A in order to sufficient to fulfill all shorted quantity
    And Admin create inventory api1
      | index | sku                               | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku order detail 433 api 2 | random             | 3        | random sku order detail 433 api 2 | 99           | Plus1        | [blank]     | [blank] |
    And Admin refresh page by button
    And Admin check line items of sub invoice "create by api" with suffix "2" in order details
      | brand                     | product                             | sku                               | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto brand create product | random product order detail 433 api | random sku order detail 433 api 2 | 1 units/case | $10.00    | 1        | 4           | $10.00 |
      | Auto brand create product | random product order detail 433 api | random sku order detail 433 api 3 | 1 units/case | $10.00    | 1        | 2           | $10.00 |
    And Admin check sub invoice of order "create by api" in order detail
      | sub | eta     | paymentStatus | total  | totalQuantity | totalWeight | fulfillmentStatus | markFulfill |
      | 2   | [blank] | Pending       | $20.00 | 2             | 2.00 lbs    | Pending           | Yes         |

  @Promotion @PROMOTION_152
  Scenario: Admin create an order with a SKU which is applied Short-dated promotion 100%
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto Short-dated 152 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | currentDate   |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "Auto SKU 138 promotion" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $30.00   | $0.00 | $30.00              | $0.00              | $7.50            | $30.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $0.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $0.00 | 3             | 36.00 lbs   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $30.00 | By invoice | Pending | $20.00            | $30.00     | -$30.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $0.00        | $10.00   | SHORT-DATED Promotion | 100% off | $0.00    | 3         | 100%               |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "2"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 2        |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 50.00 |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $20.00   |
    And Update quantity item "Auto SKU 138 promotion" to "3" in Cart detail
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$30.00  | $0.00    |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | -$7.50 |
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | Pending           | currentDate     |
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$30.00   | $0.00        |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $0.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 152 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_151
  Scenario: Admin create an order with a SKU which is applied Buy-in promotion 100%
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto product api 1 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto product api 1" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name               | brand_id |
      | Auto product api 1 | 3002     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random" of product ""
    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code   | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 3        | sku random | 99           | Plus1        | [blank]     | [blank] |

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 1           | false | 1      |
    And Admin create promotion by api with info
      | type              | name                      | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto Buy-in 151 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "random" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $30.00   | $0.00 | $30.00              | $0.00              | $7.50            | $30.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product            | sku    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand promotion | Auto product api 1 | random | 1 units/case | $10.00    | 3        | [blank]     | $0.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $0.00 | 3             | 3.00 lbs    |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product api 1"
    And  Verify tag "Buy in" promotion is "not show" on product "Auto product api 1"

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $30.00 | By invoice | Pending | $20.00            | $30.00     | -$30.00  |
    And Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $0.00 | [blank] | In Progress   | Unit UPC / EAN: 123123123123 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | -$7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$30.00   | $0.00        |
    And Vendor Check items in order detail
      | brandName            | productName        | skuName | casePrice | quantity | total | podConsignment  |
      | Auto Brand promotion | Auto product api 1 | random  | $10.00    | 3        | $0.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product api 1" by api
    And Admin search product name "Auto product api 1" by api
    And Admin delete product name "Auto product api 1" by api
    And Admin search promotion by Promotion Name "Auto Buy-in 151 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "Auto product api 1"
    And Admin delete promotion by skuName "Auto product api 1"

  @Promotion @PROMOTION_154
  Scenario: Admin/Buyer create order for multiple stores apply the same TPR promotion and have usage limit > 1
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093   | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | [blank]   | [blank] | 2561      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 154 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE go to catalog "All"
    And Search item "Auto product promotion"
    Then Verify promo preview "TPR" of product "Auto product promotion" in "Catalog page"
      | name                   | type | price | caseLimit |
      | Auto SKU 138 promotion | TPR  | $5.00 | 3         |
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails | caseMinimum | expireDate |
      | $10.00    | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                | 3           | [blank]    |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |

    Given HEAD_BUYER_PE_2 open web user
    When login to beta web with email "ngoctx+autobuyer51@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$15.00  | $15.00   |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |
    And Check information in order detail
      | buyerName    | storeName               | shippingAddress                                 | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer51 | Auto Bao Store Express1 | 12132 Sitka Street, El Monte, California, 91732 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Then HEAD_BUYER_PE_2 go to catalog "All"
    And Search item "Auto product promotion"
    Then Verify promo preview "TPR" of product "Auto product promotion" in "Catalog page"
      | name                   | type | price | caseLimit |
      | Auto SKU 138 promotion | TPR  | $5.00 | 3         |
#      | Auto SKU 2 promotion   | TPR  | $5.00 | 3         |
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails | caseMinimum | expireDate |
      | $10.00    | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | 3         | 50%                | 3           | [blank]    |

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store                   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer51 | Auto Bao Store Express1 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                   | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Bao Store Express1 | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store                   | payment | fullfillment | total |
      | currentDate | [blank] | Auto Bao Store Express1 | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 154 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_156
  Scenario: Admin/Buyer create a order with Pod-sponsored promotion: Usage limit = 1 => Admin delete order > Buyer/Admin create order again
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 154 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 5 Promotions"
    And Admin delete promotion by skuName "Auto_Check 5 Promotions"
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | Auto Pod-sponsored 156 Promotion | Test API    | currentDate | currentDate | 1           | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                    | city    | state    | zip   |
      | Auto Buyer50 | Pay by invoice | 1757 North Kimball Avenue | Chicago | Illinois | 60647 |
    And Admin add line item "Auto SKU 138 promotion" and quantities "3"
    And Admin create order success

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $0.00    | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 | $15.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $30.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    And Admin delete order from order detail
      | reason  | note    | showEdit | passkey |
      | [blank] | [blank] | [blank]  | [blank] |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 3        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge | specialDiscount |
      | [blank]            | $30.00              | -$15.00         |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU | specialDiscount |
      | $10.00   | [blank]  | $30.00   | -$15.00         |
    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 45.00 |

    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00         |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $0.00    | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 | $15.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $30.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $22.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$0.00    | $30.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | Pod Consignment |

    Given HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "3"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $30.00   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 156 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check 5 Promotions"
    And Admin delete promotion by skuName "Auto_Check 5 Promotions"

  @Promotion @PROMOTION_157
  Scenario: Admin edit quantity/add line item of Order has multiple Normal promotion
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 154 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 156 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 157 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Short-dated 157 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | currentDate   | false   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | 3         | 50%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "2"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$4.00   | $16.00   |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 46.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $20.00     | $46.00 | By invoice | Pending | $20.00            | $30.00     | -$4.00   |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 2        | $16.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $20.00     | $4.00    | $0.00 | $30.00              | $0.00              | $5.00            | $46.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 2        | [blank]     | $16.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $16.00 | 2             | 24.00 lbs   |

    And Admin update quantity of line items
      | item                   | quantity |
      | Auto SKU 138 promotion | 3        |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $30.00     | $15.00   | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $15.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    And Switch to actor HEAD_BUYER_PE
    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00  |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total |
      | currentDate | [blank] | Bao store | Pending | Pending      | $7.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$15.00   | $15.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $15.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 157 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 157 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_158
  Scenario: Admin edit quantity/add line item of Order has a Pod-sponsored promotion
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | Auto Pod-sponsored 158 Promotion | Test API    | currentDate | currentDate | 2           | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                | product                | sku                    | price  | quantity |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00 | 1        |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $10.00   | [blank]  | $10.00   |
    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 35.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $10.00     | $35.00 | By invoice | Pending | $20.00            | $30.00     | -$5.00          |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 1        | $10.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $10.00     | $0.00    | $0.00 | $30.00              | $0.00              | $2.50            | $35.00 | $5.00           |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 1        | [blank]     | $10.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total | totalQuantity | totalWeight |
      | [blank] | Pending       | $5.00 | 1             | 12.00 lbs   |
    And Admin update quantity of line items
      | item                   | quantity |
      | Auto SKU 138 promotion | 3        |
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  | specialDiscount |
      | $30.00     | $0.00    | $0.00 | $30.00              | $0.00              | $7.50            | $45.00 | $15.00          |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 3        | [blank]     | $30.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $15.00 | 3             | 36.00 lbs   |

    And Switch to actor HEAD_BUYER_PE
    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | specialDiscount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $30.00     | $45.00 | By invoice | Pending | $20.00            | $30.00     | -$15.00         |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $22.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$0.00    | $30.00       |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 3        | $30.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by Promotion Name "Auto Pod-sponsored 158 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_159
  Scenario: Order applied Normal promotion promotions on Order detail but admin delete this Normal promotions
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Pod-sponsored 158 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | [blank]   | 31259 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 159 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer50@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search item "Auto product promotion"
    And Verify Promotional Discount of "Auto product promotion" and sku "Auto SKU 138 promotion" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $10.00    | $8.00        | $10.00   | TPR Promotion | 20% off  | $8.00    | 3         | 20%                |
    And Search product by name "Auto product promotion", sku "Auto SKU 138 promotion" and add to cart with amount = "2"
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$4.00   | $16.00   |

    And Buyer close popup
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | 30.00              | [blank]           | [blank] | 46.00 |
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $20.00     | $46.00 | By invoice | Pending | $20.00            | $30.00     | -$4.00   |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 2        | $16.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $20.00     | $4.00    | $0.00 | $30.00              | $0.00              | $5.00            | $46.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 2        | [blank]     | $16.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $16.00 | 2             | 24.00 lbs   |

    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
#Add line item
    And Switch to actor ADMIN
    And Admin add line item in order detail
      | skuName              | quantity | note    |
      | Auto SKU 2 promotion | 3        | [blank] |

    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store     | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer50 | Bao store | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $50.00     | $4.00    | $0.00 | $30.00              | $0.00              | $12.50           | $76.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                | sku                    | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | 1 units/case | $10.00    | 2        | [blank]     | $16.00 |
    And Admin check line items "non invoice" in order details
      | brand                | product                | sku                  | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 2 promotion | 1 units/case | $10.00    | 3        | [blank]     | $30.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total  | totalQuantity | totalWeight |
      | [blank] | Pending       | $16.00 | 2             | 24.00 lbs   |

    And Switch to actor HEAD_BUYER_PE
    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName    | storeName | shippingAddress                                     | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer50 | Bao store | 1757 North Kimball Avenue, Chicago, Illinois, 60647 | $50.00     | $76.00 | By invoice | Pending | $20.00            | $30.00     | -$4.00   |
    And Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 2        | $16.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |
      | Auto Brand promotion | Auto product promotion | Auto SKU 2 promotion   | $10.00    | 3        | $30.00 | [blank] | In Progress   | Unit UPC / EAN: 121212121212 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store     | paymentStatus | orderType | checkoutDate |
      | [blank] | Bao store | Pending       | Express   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store     | payment | fullfillment | total  |
      | currentDate | [blank] | Bao store | Pending | Pending      | $33.50 |
    And Vendor Go to order detail with order number ""
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$4.00    | [blank]      |
    And Vendor Check items in order detail
      | brandName            | productName            | skuName                | casePrice | quantity | total  | podConsignment  |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | $10.00    | 2        | $16.00 | Pod Consignment |
      | Auto Brand promotion | Auto product promotion | Auto SKU 2 promotion   | $10.00    | 3        | $30.00 | Pod Consignment |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR 159 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_174_180
  Scenario: Vendor check filter promotion 1
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                       | description | starts_at | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Short-dated Promotion | Test API    | Plus1     | Plus1      | [blank]     | 3          | 3                | true           | [blank] | default    | currentDate   | false   |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                  | description | starts_at | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::BuyIn | Auto Buy-in Promotion | Test API    | Minus1    | Minus1     | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       | false   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check records promotions
      | number | name                       | type        | regions             | stores  | start       | end         | discount |
      | random | Auto TPR Promotion         | TPR         | Chicagoland Express | 1 store | currentDate | currentDate | 50%      |
      | random | Auto Short-dated Promotion | Short-dated | Chicagoland Express | 1 store | Plus1       | Plus1       | 50%      |
      | random | Auto Buy-in Promotion      | Buy-in      | Chicagoland Express | 1 store | Minus1      | Minus1      | 50%      |
    And Vendor search promotion on tab "All"
      | type | brand   | regions | stores  | startDate |
      | TPR  | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check records promotions
      | number  | name               | type | regions             | stores  | start       | end         | discount |
      | [blank] | Auto TPR Promotion | TPR  | Chicagoland Express | 1 store | currentDate | currentDate | 50%      |
    And Vendor search promotion on tab "All"
      | type        | brand                | regions | stores    | startDate |
      | Short-dated | Auto Brand promotion | [blank] | Bao store | Plus1     |
    And Vendor check records promotions
      | number  | name                       | type        | regions             | stores  | start | end   | discount |
      | [blank] | Auto Short-dated Promotion | Short-dated | Chicagoland Express | 1 store | Plus1 | Plus1 | 50%      |
    And Vendor search promotion on tab "All"
      | type   | brand                | regions | stores    | startDate |
      | Buy-in | Auto Brand promotion | [blank] | Bao store | Minus1    |
    And Vendor check records promotions
      | number  | name                  | type   | regions             | stores  | start  | end    | discount |
      | [blank] | Auto Buy-in Promotion | Buy-in | Chicagoland Express | 1 store | Minus1 | Minus1 | 50%      |
    And Vendor search promotion on tab "Active"
      | type | brand                | regions | stores    | startDate |
      | TPR  | Auto Brand promotion | [blank] | Bao store | [blank]   |
    And Vendor check records promotions
      | number  | name               | type | regions             | stores  | start       | end         | discount |
      | [blank] | Auto TPR Promotion | TPR  | Chicagoland Express | 1 store | currentDate | currentDate | 50%      |
    And Vendor search promotion on tab "Active"
      | type        | brand                | regions | stores    | startDate |
      | Short-dated | Auto Brand promotion | [blank] | Bao store | [blank]   |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Active"
      | type   | brand                | regions | stores    | startDate |
      | Buy-in | Auto Brand promotion | [blank] | Bao store | [blank]   |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type        | brand                | regions | stores    | startDate |
      | Short-dated | Auto Brand promotion | [blank] | Bao store | [blank]   |
    And Vendor check records promotions
      | number  | name                       | type        | regions             | stores  | start | end   | discount |
      | [blank] | Auto Short-dated Promotion | Short-dated | Chicagoland Express | 1 store | Plus1 | Plus1 | 50%      |
    And Vendor search promotion on tab "Expired"
      | type   | brand                | regions | stores    | startDate |
      | Buy-in | Auto Brand promotion | [blank] | Bao store | [blank]   |
    And Vendor check records promotions
      | number  | name                  | type   | regions             | stores  | start  | end    | discount |
      | [blank] | Auto Buy-in Promotion | Buy-in | Chicagoland Express | 1 store | Minus1 | Minus1 | 50%      |
    And Vendor search promotion on tab "All"
      | type   | brand                | regions             | stores    | startDate |
      | Buy-in | Auto Brand promotion | Chicagoland Express | Bao store | Minus1    |
    And Vendor check records promotions
      | number  | name                  | type   | regions             | stores  | start  | end    | discount |
      | [blank] | Auto Buy-in Promotion | Buy-in | Chicagoland Express | 1 store | Minus1 | Minus1 | 50%      |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_181
  Scenario: Vendor check filter promotion 2
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region  | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | [blank] | [blank]   | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 181 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions | stores    | startDate   |
      | TPR  | [blank] | [blank] | Bao store | currentDate |
    And Vendor check records promotions
      | number | name                   | type | regions     | stores  | start       | end         | discount |
      | random | Auto TPR 181 Promotion | TPR  | All regions | 1 store | currentDate | currentDate | 50%      |

    And Admin search promotion by Promotion Name "Auto TPR 181 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_183
  Scenario: Vendor check filter promotion 3
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093   | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | 63        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 182 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions | stores    | startDate   |
      | TPR  | [blank] | [blank] | Bao store | currentDate |
    And Vendor check records promotions
      | number | name                   | type | regions   | stores  | start       | end         | discount |
      | random | Auto TPR 182 Promotion | TPR  | 2 regions | 1 store | currentDate | currentDate | 50%      |
    And Vendor go to promotion detail with number or name: "Auto TPR 182 Promotion"
    And Vendor check promotion detail
      | title                  | type | regions   | stores  | start-date  | end-date    | discount | includeStore | caseLimit | caseMinimum |
      | Auto TPR 182 Promotion | TPR  | 2 regions | 1 store | currentDate | currentDate | 50%      | Bao store    | 3         | 2           |

    And Vendor Check applied SKUs on promotion detail
      | brand                | product                | sku                    | region              | originalPrice | discountPrice |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | Chicagoland Express | $10.00        | $5.00         |

    And Admin search promotion by Promotion Name "Auto TPR 182 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_182
  Scenario: Vendor check filter promotion 4
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093   | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | 63        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 182 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions | stores    | startDate   |
      | TPR  | [blank] | [blank] | Bao store | currentDate |
    And Vendor check records promotions
      | number | name                   | type | regions   | stores  | start       | end         | discount |
      | random | Auto TPR 182 Promotion | TPR  | 2 regions | 1 store | currentDate | currentDate | 50%      |
    And Vendor go to promotion detail with number or name: "Auto TPR 182 Promotion"
    And Vendor check promotion detail
      | title                  | type | regions   | stores  | start-date  | end-date    | discount | includeStore | caseLimit | caseMinimum |
      | Auto TPR 182 Promotion | TPR  | 2 regions | 1 store | currentDate | currentDate | 50%      | Bao store    | 3         | 2           |

    And Vendor Check applied SKUs on promotion detail
      | brand                | product                | sku                    | region              | originalPrice | discountPrice |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | Chicagoland Express | $10.00        | $5.00         |
    And Admin search promotion by Promotion Name "Auto TPR 182 Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_185
  Scenario: Vendor check filter promotion 5
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093   | [blank]   | [blank]                    | [blank]           | 2465               | PromotionRules::LineItem |
      | [blank]             | 63        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 185 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions | stores    | startDate   |
      | TPR  | [blank] | [blank] | Bao store | currentDate |
    And Vendor check records promotions
      | number | name                   | type | regions   | stores    | start       | end         | discount |
      | random | Auto TPR 185 Promotion | TPR  | 2 regions | All store | currentDate | currentDate | 50%      |
    And Vendor go to promotion detail with number or name: "Auto TPR 185 Promotion"
    And Vendor check promotion detail
      | title                  | type | regions   | stores    | start-date  | end-date    | discount | excludeStore | caseLimit | caseMinimum |
      | Auto TPR 185 Promotion | TPR  | 2 regions | All store | currentDate | currentDate | 50%      | Bao store    | 3         | 2           |

    And Vendor Check applied SKUs on promotion detail
      | brand                | product                | sku                    | region              | originalPrice | discountPrice |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | Chicagoland Express | $10.00        | $5.00         |

    And Admin search promotion by Promotion Name "Auto TPR 185 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_196
  Scenario: Vendor check filter promotion 6
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093   | [blank]   | [blank]                    | 2215              | 2465               | PromotionRules::LineItem |
      | [blank]             | 63        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 196 Promotion | Test API    | currentDate | [blank]    | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number | name                   | type | regions   | stores  | start       | end | discount |
      | random | Auto TPR 196 Promotion | TPR  | 2 regions | 1 store | currentDate | -   | 50%      |
    And Vendor go to promotion detail with number or name: "Auto TPR 196 Promotion"
    And Vendor check promotion detail
      | title                  | type | regions   | stores  | start-date  | end-date | discount | excludeStore | caseLimit | caseMinimum | appliedBuyerCompany |
      | Auto TPR 196 Promotion | TPR  | 2 regions | 1 store | currentDate | -        | 50%      | Bao store    | 3         | 2           | Bao Buyer Company   |

    And Vendor Check applied SKUs on promotion detail
      | brand                | product                | sku                    | region              | originalPrice | discountPrice |
      | Auto Brand promotion | Auto product promotion | Auto SKU 138 promotion | Chicagoland Express | $10.00        | $5.00         |

    And Admin search promotion by Promotion Name "Auto TPR 196 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_200
  Scenario: Admin create a Normal promotion (Buy-in/ TPR/ Short-dated) have a Specific SKUs > Admin inactive this SKU's region applied promotion but SKU's state still active
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |
    And Change state of SKU id: "35093" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83338 | 26        | 35093              | 1000             | 1000       | in_stock     | active |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 200 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |

    And Change state of SKU id: "35093" to "inactive"
#    And Admin change info of regions attributes with sku "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
#      | 83338 | 26        | 35093              | 1000             | 1000       | in_stock     | inactive |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |

    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Active"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Expired"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Change state of SKU id: "35093" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83338 | 26        | 35093              | 1000             | 1000       | in_stock     | active |

    And Admin search promotion by Promotion Name "Auto TPR 200 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_199
  Scenario: Admin create a Normal promotion (Buy-in/ TPR/ Short-dated) have a Specific SKUs > Admin inactive/draft this SKU applied promotion
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Change state of SKU id: "35093" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83338 | 26        | 35093              | 1000             | 1000       | in_stock     | active |

    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 35093 | 2465      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 500         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR 199 Promotion | Test API    | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |

#    And Change state of SKU id: "35093" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83338 | 26        | 35093              | 1000             | 1000       | in_stock     | inactive |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number | name                   | type | regions             | stores  | start       | end         | discount |
      | random | Auto TPR 199 Promotion | TPR  | Chicagoland Express | 1 store | currentDate | currentDate | $5.00    |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Expired"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Active"
      | type | brand   | regions             | stores  | startDate   |
      | TPR  | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number | name                   | type | regions             | stores  | start       | end         | discount |
      | random | Auto TPR 199 Promotion | TPR  | Chicagoland Express | 1 store | currentDate | currentDate | $5.00    |
    And Vendor go to promotion detail with number or name: "Auto TPR 199 Promotion"
    And Vendor check promotion detail
      | title                  | type | regions             | stores  | start-date  | end-date    | discount | includeStore | caseLimit | caseMinimum |
      | Auto TPR 199 Promotion | TPR  | Chicagoland Express | 1 store | currentDate | currentDate | $5.00    | Bao store    | 3         | 2           |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Change state of SKU id: "35093" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92363 | 26        | 35093              | 1000             | 1000       | in_stock     | active |

    And Admin search promotion by Promotion Name "Auto TPR 200 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"

  @Promotion @PROMOTION_199.1
  Scenario: Clear data
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao2@podfoods.co | 12345678a |

    And Admin search promotion by Promotion Name "Auto TPR 200 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR 199 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU 138 promotion"
    And Admin delete promotion by skuName "Auto SKU 138 promotion"
#mvn verify -Dtestsuite="PromotionTestSuite" -Dcucumber.options="src/test/resources/features/promotion"

@feature=Promotion
Feature: Promotion

  @Promotion @Promotion01 @PROMOTION_38
  Scenario: Head buyer checks out with buy-in promotion
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Product Buy In api" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]    | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Product Buy In api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Product Buy In api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy In Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "Product Buy In api" by api
    And Admin delete product name "Product Buy In api" by api
    And Admin create product by api with info
      | fileName           | product            | brandID |
      | CreateProduct.json | Product Buy In api | 2857    |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
      | New York Express    | 53 | active | in_stock     | 13000     | 13000 |
    And Admin create SKU from admin with name "sku random" of product ""
    And Admin create inventory api1
      | index | sku        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | sku random | random             | 10       | random   | 99           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                  | description      | type   | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | specSKU | store    | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]   | [blank]    | 10        | 1           | Minus1   | currentDate | Yes        | random  | ngoc st1 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU |
      | random  |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Search promotion by info
      | name                  | type   | store    | brand   | productName | skuName | region              | startAt | expireAt    | isStackDeal |
      | Auto Buy In Promotion | Buy-in | ngoc st1 | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type   | region | startAt | expireAt    | usageLimit | CaseLimit |
      | Auto Buy In Promotion | Buy-in | CHI    | Minus1  | currentDate | [blank]    | 10        |
    And Verify promotion info in Promotion detail
      | name                  | description      | type   | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | store    |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]    | 10        | 1           | Minus1   | currentDate | is-checked | ngoc st1 |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 10     |
    And Check item on Promotion detail
      | product            | sku        |
      | Product Buy In api | sku random |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName              | orderBrand | time    |
      | AutoTest Promo BuyIn 2 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type   | pricePromoted | minimumPurchase | limitedTo                   | start  | expired     |
      | Buy in | $90.00        | 1 Case          | 10 cases of the first order | Minus1 | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Promo BuyIn 2"
    Then Verify promo preview "Buy in" of product "Product Buy In api" in "Product page"
      | name   | type   | price  | caseLimit |
      | random | BUY-IN | $90.00 | 10        |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product Buy In api", sku "random" and add to cart with amount = "1"
    Then Verify promo preview "Buy in" of product "Product Buy In api" in "Catalog page"
      | name   | type   | price  | caseLimit |
      | random | BUY-IN | $90.00 | 10        |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product Buy In api" and sku "random" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo        | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00       | $100.00  | Buy-in Promotion | 10% off  | $90.00   | 10        | 10%                |
    When Add product "Product Buy In api" to favorite
    Then Verify promo preview "Buy in" of product "Product Buy In api" in "Favorite page"
      | name   | type   | price  | caseLimit |
      | random | BUY-IN | $90.00 | 10        |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Buyer close popup
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Verify price promo in order buyer is "-$10.00"
    And See invoice
    Then Verify price promo in Invoice is "- USD 10.00"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then NGOC_ADMIN verify price promo in order details of Admin is "$10.00"
    And Admin verify price promo in sku "random" of order
      | endQuantity | total  |
      | $90.00      | $90.00 |
    And NGOC_ADMIN create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | [blank]   | [blank] |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store    | fulFilledDate | order           | po      |
      | Ordered, Latest first | In progress  | ngoc st1 | [blank]       | create by buyer | [blank] |
    And See invoice then check promotion
      | promoDiscount |
      | - USD 10.00   |

  @Promotion @Promotion02
  Scenario: Head buyer/Sub buyer PE and Head buyer PD checks out with on-going promotion

    Given Buyer login web with by api
      | email                 | password  |
      | ngoc+chi1@podfoods.co | 12345678a |
    And Buyer set favorite product "30125" by API

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName             | orderBrand | time    |
      | AutoTest Brand Ngoc01 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo        | start    | expired  |
      | TPR  | $90.00        | 1 Case          | 10000 cases only | 06/13/22 | 06/13/25 |
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Brand Ngoc01"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Product page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product On Going api", sku "Autotest sku ongoing" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Catalog page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product On Going api" and sku "Autotest sku ongoing" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00       | $100.00  | TPR Promotion | 10% off  | $90.00   | 10,000    | 10%                |
#    When Add product "Product On Going api" to favorite
    When Go to favorite page of "Product On Going api"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Favorite page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Buyer close popup
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Verify price promo in order buyer is "-$10.00"
    And See invoice
    Then Verify price promo in Invoice is "- USD 10.00"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then NGOC_ADMIN verify price promo in order details of Admin is "$10.00"
    And Admin verify price promo in sku "Autotest sku ongoing" of order
      | endQuantity | total  |
      | $90.00      | $90.00 |
    And NGOC_ADMIN create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | [blank]   | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And Vendor search order "Fulfilled"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And See detail order by idInvoice
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$10.00   | $90.00       |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store    | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | ngoc st1 | [blank]       | create by buyer | [blank] |
    And See invoice then check promotion
      | promoDiscount |
      | - USD 10.00   |

  @Promotion @Promotion03
  Scenario: Head buyer/Sub buyer PE and Head buyer PD checks out with shorted-date promotion
    Given Buyer login web with by api
      | email                 | password  |
      | ngoc+chi1@podfoods.co | 12345678a |
    And Buyer set favorite product "30126" by API

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto ShortDate 03 Promotion"
    And Admin delete promotion by skuName "Auto ShortDate 03 Promotion"
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 30126 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                        | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto ShortDate 03 Promotion | Test        | currentDate | currentDate | 1           | 10000      | 1                | true           | [blank] | default    | currentDate   | false   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                | orderBrand | time    |
      | AutoTest Promo ShortDate | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo        | start       | expired     |
      | Short dated | $90.00        | 1 Case          | 10000 cases only | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Promo ShortDate"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Product page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product Short Dated api", sku "Autotest sku shortdate" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Catalog page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product Short Dated api" and sku "Autotest sku shortdate" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00       | $100.00  | Short-dated Promotion | 10% off  | $90.00   | 10,000    | 10%                |
#    When Add product "Product Short Dated api" to favorite
    When Go to favorite page of "Product Short Dated api"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Favorite page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Buyer close popup
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Verify price promo in order buyer is "-$10.00"
    And See invoice
    Then Verify price promo in Invoice is "- USD 10.00"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then NGOC_ADMIN verify price promo in order details of Admin is "$10.00"
    And Admin verify price promo in sku "Product Short Dated api" of order
      | endQuantity | total  |
      | $90.00      | $90.00 |
    And NGOC_ADMIN create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | [blank]   | [blank] |
    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And Vendor search order "Fulfilled"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And See detail order by idInvoice
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$10.00   | $90.00       |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store    | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | ngoc st1 | [blank]       | create by buyer | [blank] |
    And See invoice then check promotion
      | promoDiscount |
      | - USD 10.00   |

    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto ShortDate 03 Promotion"
    And Admin delete promotion by skuName "Auto ShortDate 03 Promotion"

  @Promotion @Promotion04
  Scenario: Head buyer/Sub buyer PE and Head buyer PD checks out with Pod-sponsored promotion
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin

#    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
#    And Create promotion
#      | name                         | description      | type          | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | specSKU                | store    | typePromo  | amount |
#      | Auto Pod Sponsored Promotion | Auto Description | Pod-sponsored | currentDate | 10         | [blank]  | [blank]  | 05/04/22 | currentDate | Yes        | Autotest sku shortdate | ngoc st1 | Percentage | 10     |
#    And Choose regions to promo
#      | region              |
#      | Chicagoland Express |
#    And Create promo success
#    And Search promotion by info
#      | name                         | type          | region | startAt    | expireAt    | usageLimit | CaseLimit |   isStackDeal |
#      | Auto Pod Sponsored Promotion | Pod-sponsored | CHI    | 2022-05-04 | currentDate | [blank]  | 10        |     [blank]     |
#    Then Verify promotion show in All promotion page
#      | name                         | type          | region | startAt    | expireAt    | usageLimit | CaseLimit |
#      | Auto Pod Sponsored Promotion | Pod-sponsored | CHI    | 2022-05-04 | currentDate | [blank]  | 10        |
#    And Verify promotion info in Promotion detail
#      | name                         | description      | type          | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | specSKU                | store    | typePromo  | amount |
#      | Auto Pod Sponsored Promotion | Auto Description | Pod-sponsored | 10         | [blank]  | [blank]  | 05/04/22 | currentDate | is-checked | Autotest sku shortdate | ngoc st1 | Percentage | 10     |
#    And Verify amount of promotion with "no" stack deal
#      | type | amount |
#      | %    | 10     |
#    Given HEAD_BUYER_PE open web user
#    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
##    And Go to tab "Promotions"
##    And Search promotions by info
##      | brandName | orderBrand | time |
##      | [blank]  | Yes        | [blank]  |
##    And Show details of promotion then verify info
##      | type    | pricePromoted | minimumPurchase | limitedTo                   | start    | expired     |
##      | Ongoing | $90.00        | 1 Case          | 10 cases of the first order | 05/04/22 | currentDate |
#    And Clear cart to empty in cart before
#    And Search Brands by name "AutoTest Promo BuyIn 2"
#    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Product page"
#      | name                   | type        | price  | caseLimit |
#      | Autotest sku shortdate | Short-dated | $90.00 | 10        |
#    And HEAD_BUYER_PE go to catalog "All"
#    And Search product by name "Product Short Dated api", sku "Autotest sku shortdate" and add to cart with amount = "1"
#    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Catalog page"
#      | name                   | type        | price  | caseLimit |
#      | Autotest sku shortdate | Short-dated | $90.00 | 10        |
#    And Verify Promotional Discount in "before cart"
#      | priceSKU | discount | totalSKU |
#      | $90.00   | -$10.00  | $90.00   |
#    And Verify Promotional Discount of "Product Short Dated api" in product detail
#      | unitPrice | casePrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
#      | $90.00    | $90.00    | Short-dated Promotion | 10% off  | $90.00   | 10        | 10%                |
#    When Add product "Product On Going api" to favorite
#    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Favorite page"
#      | name                   | type        | price  | caseLimit |
#      | Autotest sku shortdate | Short-dated | $90.00 | 10        |
#    And Verify Promotional Discount in "details"
#      | priceSKU | discount | totalSKU |
#      | $90.00   | -$10.00  | $90.00   |
#    And Buyer close popup
#    And Buyer check out cart
#    And Buyer place order cart "Pay by invoice"
#    And Buyer view order after palce order
#    Then Verify price promo in order buyer is "-$10.00"
#    And See invoice
#    Then Verify price promo in Invoice is "- USD 10.00"
#
#    Given NGOC_ADMIN open web admin
#    When NGOC_ADMIN login to web with role Admin
#    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
#    And Search the orders by info then system show result
#    Then NGOC_ADMIN verify price promo in order details of Admin is "$10.00"
#    And Admin verify price promo in sku "Product Short Dated api" of order
#      | endQuantity | total  |
#      | $90.00      | $90.00 |
#    When Add purchase order with driver "lp2 company"
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
#    And See detail order by idInvoice
#    Then Verify promotion in order of vendor
#      | promotion | currentPrice |
#      | -$10.00   | $90.00       |
#
#    Given USER_LP open web LP
#    When login to beta web with email "thuy+lp2@podfoods.co" pass "12345678a" role "LP"
#    And USER_LP filter order by info
#      | orderBy               | fulFillState | store    | fulFilledDate | order | po |
#      | Ordered, Latest first | Unconfirmed  | ngoc st1 | [blank]  |  create by buyer     | [blank]  |
#    And See invoice then check promotion
#      | promoDiscount |
#      | - USD 10.00   |

#  @Promotion @Promotion_01
#  Scenario: Check default UI of promotion list when a new registered buyer A logins website
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+autoonboard01@podfoods.co" pass "12345678a" role "buyer"
#    And BUYER Go to Dashboard
#    Then Buyer onboard verify tab promotion not show

  @Promotion @Promotion_02
  Scenario: Check default UI of promotion list when a buyer with an approved store logins website
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName "Auto TPR Promotion"

    Given BUYER open web user
    When login to beta web with email "ngoctx+promochi01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                    | orderBrand | time    |
      | AT Brand Financial Pending01 | [blank]    | [blank] |
    Then Buyer verify no promotion requests found

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU       | store            | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | 10         | 10        | 1           | currentDate | currentDate | Yes        | AT SKU Ngoc01 | ngoctx stPromo01 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU       |
      | AT SKU Ngoc01 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success

    And BUYER Go to Dashboard
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                    | orderBrand | time    |
      | AT Brand Financial Pending01 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo     | start       | expired     |
      | TPR  | $90.00        | 1 Case          | 10 cases only | currentDate | currentDate |

#  @Promotion @Promotion_04
#  Scenario: Check the Filter by Brand
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+promochi01@podfoods.co" pass "12345678a" role "buyer"
#    And Go to tab "Promotions"
#    And Buyer verify default value and placeholder of the search box
#    And Search promotions by info
#      | brandName                    | orderBrand | time |
#      | AT Brand Financial Pending01 | [blank]  | [blank]  |
#    And Show details of promotion then verify info
#      | type | pricePromoted | minimumPurchase | limitedTo     | start       | expired     |
#      | TPR  | $90.00        | 1 Case          | 10 cases only | currentDate | currentDate |

  @Promotion @Promotion_05
  Scenario: Check filtering with brand that has no promotion on selected month
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion06"
    And Admin delete promotion by skuName "Auto TPR Promotion06"
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion06"
    And Admin delete promotion by skuName "Auto TPR Promotion06"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate       | toDate         | showVendor | specSKU       | store            | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion06 | Auto Description | TPR  | [blank]   | 10         | 10        | 1           | currentMonth+1 | currentMonth+1 | Yes        | AT SKU Ngoc01 | ngoctx stPromo01 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU       |
      | AT SKU Ngoc01 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success

    Given BUYER open web user
    When login to beta web with email "ngoctx+promochi01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Buyer verify default value and placeholder of the search box
    And Search promotions by info
      | brandName                    | orderBrand | time           |
      | AT Brand Financial Pending01 | [blank]    | currentMonth+1 |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo     | start          | expired        |
      | TPR  | $90.00        | 1 Case          | 10 cases only | currentMonth+1 | currentMonth+1 |
    And Admin search promotion by Promotion Name "Auto TPR Promotion06"
    And Admin delete promotion by skuName "Auto TPR Promotion06"

  @Promotion @Promotion_06
  Scenario: Check filtering with brand that has any promotion on selected month
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion07"
    And Admin delete promotion by skuName "Auto TPR Promotion07"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate       | toDate         | showVendor | specSKU       | store            | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion07 | Auto Description | TPR  | [blank]   | 10         | 10        | 1           | currentMonth+1 | currentMonth+1 | Yes        | AT SKU Ngoc01 | ngoctx stPromo01 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU       |
      | AT SKU Ngoc01 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success

    Given BUYER open web user
    When login to beta web with email "ngoctx+promochi01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Buyer verify default value and placeholder of the search box
    And Search promotions by info
      | brandName                    | orderBrand | time           |
      | AT Brand Financial Pending01 | [blank]    | currentMonth+1 |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo     | start          | expired        |
      | TPR  | $90.00        | 1 Case          | 10 cases only | currentMonth+1 | currentMonth+1 |

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion07"
    And Admin delete promotion by skuName "Auto TPR Promotion07"

  @Promotion @Promotion_07
  Scenario: Check filter by Ordered brands criteria
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU       | store            | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion08 | Auto Description | TPR  | [blank]   | 10         | 10        | 1           | currentDate | currentDate | Yes        | AT SKU Ngoc01 | ngoctx stPromo01 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU       |
      | AT SKU Ngoc01 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success

    Given BUYER open web user
    When login to beta web with email "ngoctx+promochi01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Buyer verify default value and placeholder of the search box
    And Search promotions by info
      | brandName                    | orderBrand | time    |
      | AT Brand Financial Pending01 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo     | start       | expired     |
      | TPR  | $90.00        | 1 Case          | 10 cases only | currentDate | currentDate |
    And Search promotions by info
      | brandName                    | orderBrand | time    |
      | AT Brand Financial Pending01 | Yes        | [blank] |
    Then Buyer verify no promotion requests found
    And Search promotions by info
      | brandName                    | orderBrand | time    |
      | AT Brand Financial Pending01 | No         | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo     | start       | expired     |
      | TPR  | $90.00        | 1 Case          | 10 cases only | currentDate | currentDate |

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion08"
    And Admin delete promotion by skuName "Auto TPR Promotion08"

  @Promotion @Promotion_10
  Scenario: Check displayed information on a brand record
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion10"
    And Admin delete promotion by skuName "Auto TPR Promotion10"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU       | store            | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion10 | Auto Description | TPR  | [blank]   | 10         | 10        | 1           | currentDate | currentDate | Yes        | AT SKU Ngoc01 | ngoctx stPromo02 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU       |
      | AT SKU Ngoc01 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success

    Given BUYER open web user
    When login to beta web with email "ngoctx+st2promo01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                    | orderBrand | time    |
      | AT Brand Financial Pending01 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo     | start       | expired     |
      | TPR  | $90.00        | 1 Case          | 10 cases only | currentDate | currentDate |
    Then Buyer verify total of promotion in promotion tab is "promotion"

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion10"
    And Admin delete promotion by skuName "Auto TPR Promotion10"

  @Promotion @Promotion_11
  Scenario: Check the # of promotions on a brand record
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion11"
    And Admin delete promotion by skuName "Auto TPR Promotion11"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU       | store            | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion11 | Auto Description | TPR  | [blank]   | 10         | 10        | 1           | currentDate | currentDate | Yes        | AT SKU Ngoc01 | ngoctx stPromo02 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU       |
      | AT SKU Ngoc01 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success

    Given BUYER open web user
    When login to beta web with email "ngoctx+st2promo01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                    | orderBrand | time    |
      | AT Brand Financial Pending01 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo     | start       | expired     |
      | TPR  | $90.00        | 1 Case          | 10 cases only | currentDate | currentDate |
    Then Buyer verify total of promotion in promotion tab is " promotion"

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto TPR Promotion11"
    And Admin delete promotion by skuName "Auto TPR Promotion11"

  @Promotion @PROMOTION_12
  Scenario: Check whether the buyer ordered the brand before or not.
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
#    And Admin search promotion by product Name "Product Promotion2"
#    And Admin delete promotion by skuName "Product Promotion2"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName "Auto TPR Promotion"
#  //Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Florida Express | 63        | 30902 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto TPR Promotion | Test        | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+st2promo01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName         | orderBrand | time    |
      | AT Brand Promo 12 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired |
      | TPR  | $90.00        | 1 Case          | [blank]   | currentDate | [blank] |

    And BUYER go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Product Promotion2", sku "AT SKU Promo12" and add to cart with amount = "1"
    And Go to Cart detail
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | total   |
      | [blank]            | [blank]           | $120.00 |

    And Go to tab "Promotions"
    And Search promotions by info
      | brandName         | orderBrand | time    |
      | AT Brand Promo 12 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired |
      | TPR  | $90.00        | 1 Case          | [blank]   | currentDate | [blank] |
    Then Buyer verify text "You ordered this brand before." in tab promotion

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    When Search order by sku "30902" by api
    And Admin delete order of sku "AT Brand Promo 12" by api
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName "Auto TPR Promotion"

  @Promotion @PROMOTION_12 @PROMOTION_18
  Scenario: Check displayed type of promotion on a brand record when admin creates a buy-in promotion
    Given BAO_AUTO login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy-in 18 Promotion"
    And Admin delete promotion by skuName "Auto Buy-in 18 Promotion"
#  //Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Florida Express | 63        | 30904 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::BuyIn | Auto Buy-in 18 Promotion | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+st2promo01@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName         | orderBrand | time    |
      | AT Brand Promo 13 | No         | [blank] |
    And Show details of promotion then verify info
      | type   | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | Buy in | $90.00        | 1 Case          | [blank]   | currentDate | currentDate |
    And BUYER go to catalog "All"
    And Clear cart to empty in cart before
    And Search Brands by name "AT Brand Promo 13"
    Then Verify promo preview "Buy in" of product "Test Product Promotion" in "Product page"
      | name           | type   | price  | caseLimit |
      | AT SKU Promo13 | BUY-IN | $90.00 | [blank]   |

    And Admin search promotion by Promotion Name "Auto Buy-in 18 Promotion"
    And Admin delete promotion by skuName "Auto Buy-in 18 Promotion"

  @Promotion @PROMOTION_13 @PROMOTION_19
  Scenario: Check displayed type of promotion on a brand record when admin creates a TPR promotion
    Given Buyer login web with by api
      | email                 | password  |
      | ngoc+chi1@podfoods.co | 12345678a |
    And Buyer set favorite product "30126" by API

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName             | orderBrand | time    |
      | AutoTest Brand Ngoc01 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo        | start    | expired  |
      | TPR  | $90.00        | 1 Case          | 10000 cases only | 06/13/22 | 06/13/25 |
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Brand Ngoc01"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Product page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product On Going api", sku "Autotest sku ongoing" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Catalog page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product On Going api" and sku "Autotest sku ongoing" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00       | $100.00  | TPR Promotion | 10% off  | $90.00   | 10,000    | 10%                |
#    When Add product "Product On Going api" to favorite
    When Go to favorite page of "Product On Going api"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Favorite page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |

  @Promotion @PROMOTION_14 @PROMOTION_15 @PROMOTION_16 @PROMOTION_17 @PROMOTION_19 @PROMOTION_20 @PROMOTION_22 @PROMOTION_23 @PROMOTION_24
  Scenario: Check displayed type of promotion on a brand record when admin creates a Short-dated promotion
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by product Name "Product Short Dated api"
    And Admin delete promotion by skuName "Product Short Dated api"
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 30126 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto ShortDate Promotion | Test        | currentDate | currentDate | 1           | 10000      | 1                | true           | [blank] | default    | currentDate   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                | orderBrand | time    |
      | AutoTest Promo ShortDate | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo        | start       | expired     |
      | Short dated | $90.00        | 1 Case          | 10000 cases only | currentDate | currentDate |
#    And Verify Express badge in promotion tab of sku "Autotest sku shortdate"
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Promo ShortDate"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Product page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    When HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product Short Dated api", sku "Autotest sku shortdate" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Catalog page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product Short Dated api" and sku "Autotest sku shortdate" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00       | $100.00  | Short-dated Promotion | 10% off  | $90.00   | 10,000    | 10%                |
#    When Add product "Product Short Dated api" to favorite
    When Go to favorite page of "Product Short Dated api"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Favorite page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    When Remove product "Product Short Dated api" from favorite
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |

    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"

  @PROMOTION_21
  Scenario: Check the price information of SKU on a SKU line with stack deal Promotion
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by product Name "Product Short Dated api"
    And Admin delete promotion by skuName "Product Short Dated api"
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 30126 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | true  | 10     |
      | PromotionActions::PercentageAdjustment | 0.15        | true  | 15     |
    And Admin create promotion by api with info
      | type                  | name                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto ShortDate Promotion | Test        | currentDate | currentDate | 1           | 100        | 1                | true           | [blank] | stacked    | currentDate   |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                     | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | No          |
    And Admin verify no data in result after search promotion
    And Admin reset filter
    And Search promotion by info
      | name                     | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    Then Verify promotion show in All promotion page
      | name                     | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto ShortDate Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 100       |
    And Admin reset filter
    And Search promotion by info
      | name                     | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | Yes         |
    Then Verify promotion show in All promotion page
      | name                     | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto ShortDate Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 100       |
    And Verify promotion info in Promotion detail
      | name                     | description | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto ShortDate Promotion | Test        | Short-dated | 1          | 100       | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 15          | 15     |
    And Verify amount stack deal description
      | description                |
      | Quantity 1 ~ 14:10.00% off |
      | Quantity 15 ~ :15.00% off  |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                | orderBrand | time    |
      | AutoTest Promo ShortDate | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted   | minimumPurchase | limitedTo      | start       | expired     | skuExpiryDate |
      | Short dated | $85.00 ~ $90.00 | 1 Case          | 100 cases only | currentDate | currentDate | currentDate   |
    And Verify stack case detail on Promotion tab
      | stackCase             |
      | 10 - 14 cases: 10% OI |
      | 15+ cases: 15% OI     |
    And Verify Express badge in promotion tab of sku "Autotest sku shortdate"
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Promo ShortDate"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Product page"
      | name                   | type        | price           | caseLimit | expiryDate  | oldPrice |
      | Autotest sku shortdate | SHORT-DATED | $85.00 ~ $90.00 | 100       | currentDate | $100.00  |

    When HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product Short Dated api", sku "Autotest sku shortdate" and add to cart with amount = "10"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Catalog page"
      | name                   | type        | price           | caseLimit | expiryDate  | oldPrice |
      | Autotest sku shortdate | SHORT-DATED | $85.00 ~ $90.00 | 100       | currentDate | $100.00  |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | oldPrice | oldTotalPrice | orderValue | cartTotal |
      | $90.00   | -$100.00 | $900.00  | $100.00  | $1,000.00     | $1,000.00  | $900.00   |
    And Verify Promotional Discount of "Product Short Dated api" and sku "Autotest sku shortdate" in product detail
      | unitPrice       | currentPrice    | oldPrice | typePromo             | caseLimit | discountThumbnails | expireDate  |
      | $85.00 ~ $90.00 | $85.00 ~ $90.00 | $100.00  | Short-dated Promotion | 100       | 10% ~ 15%          | currentDate |
    And Verify Stack case promotion on product detail
      | stackCase             |
      | 10 - 14 cases: 10% OI |
      | 15+ cases: 15% OI     |
    Then Add product "Product Short Dated api" to favorite
    And Go to favorite page of "Product Short Dated api"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Favorite page"
      | name                   | type        | price           | caseLimit | expiryDate  | oldPrice |
      | Autotest sku shortdate | SHORT-DATED | $85.00 ~ $90.00 | 100       | currentDate | $100.00  |

    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"

  @PROMOTION_124 @PROMOTION_21
  Scenario: Check the price information of SKU on a SKU line with stack deal Promotion 2
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by product Name "Product Short Dated api"
    And Admin delete promotion by skuName "Product Short Dated api"
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 30126 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | true  | 10     |
      | PromotionActions::FixRateAdjustment | 1500        | true  | 15     |
    And Admin create promotion by api with info
      | type                  | name                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto ShortDate Promotion | Test        | currentDate | currentDate | 1           | 100        | 10               | true           | [blank] | stacked    | currentDate   |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                     | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | No          |
    And Admin verify no data in result after search promotion
    And Admin reset filter
    And Search promotion by info
      | name                     | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    Then Verify promotion show in All promotion page
      | name                     | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto ShortDate Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 100       |
    And Admin reset filter
    And Search promotion by info
      | name                     | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | Yes         |
    Then Verify promotion show in All promotion page
      | name                     | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto ShortDate Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 100       |
    And Verify promotion info in Promotion detail
      | name                     | description | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto ShortDate Promotion | Test        | Short-dated | 1          | 100       | 10          | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 10          | 10     |
      | 15          | 15     |
    And Verify amount stack deal description
      | description                     |
      | Quantity 10 ~ 14:$10.00 USD off |
      | Quantity 15 ~ :$15.00 USD off   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                | orderBrand | time    |
      | AutoTest Promo ShortDate | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted   | minimumPurchase | limitedTo      | start       | expired     | skuExpiryDate |
      | Short dated | $85.00 ~ $90.00 | 10 Case         | 100 cases only | currentDate | currentDate | currentDate   |
    And Verify stack case detail on Promotion tab
      | stackCase                |
      | 10 - 14 cases: $10.00 OI |
      | 15+ cases: $15.00 OI     |
    And Verify Express badge in promotion tab of sku "Autotest sku shortdate"
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Promo ShortDate"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Product page"
      | name                   | type        | price           | caseLimit | expiryDate  | oldPrice |
      | Autotest sku shortdate | SHORT-DATED | $85.00 ~ $90.00 | 100       | currentDate | $100.00  |

    When HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product Short Dated api", sku "Autotest sku shortdate" and add to cart with amount = "10"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Catalog page"
      | name                   | type        | price           | caseLimit | expiryDate  | oldPrice |
      | Autotest sku shortdate | SHORT-DATED | $85.00 ~ $90.00 | 100       | currentDate | $100.00  |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | oldPrice | oldTotalPrice | orderValue | cartTotal |
      | $90.00   | -$100.00 | $900.00  | $100.00  | $1,000.00     | $1,000.00  | $900.00   |
    And Verify Promotional Discount of "Product Short Dated api" and sku "Autotest sku shortdate" in product detail
      | unitPrice       | currentPrice    | oldPrice | typePromo             | caseLimit | discountThumbnails | expireDate  |
      | $85.00 ~ $90.00 | $85.00 ~ $90.00 | $100.00  | Short-dated Promotion | 100       | -$10 ~ -$15        | currentDate |
    And Verify Stack case promotion on product detail
      | stackCase                |
      | 10 - 14 cases: $10.00 OI |
      | 15+ cases: $15.00 OI     |
    Then Add product "Product Short Dated api" to favorite
    And Go to favorite page of "Product Short Dated api"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Favorite page"
      | name                   | type        | price           | caseLimit | expiryDate  | oldPrice |
      | Autotest sku shortdate | SHORT-DATED | $85.00 ~ $90.00 | 100       | currentDate | $100.00  |

    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"

  @PROMOTION_65_1
  Scenario: Check validation of Is this a case stack deal? field on Create new Promotion form
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by product Name "Product Short Dated api "
    And Admin delete promotion by skuName "Product Short Dated api"
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                       | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   | typePromo  | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto ShortDate Promotion65 | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | Percentage | [blank] | [blank]      | [blank]              | [blank]              |
    And Admin search SKU to add promotion popup
      | sku                    | brand   | upc     |
      | Autotest sku shortdate | [blank] | [blank] |
    And Admin add SKU to promotion
      | specSKU                |
      | Autotest sku shortdate |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount  |
      | [blank]     | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 0      |
    And Verify amount stack deal description
      | description             |
      | Quantity 1 ~ :0.00% off |
    And Create promo success

    And Search promotion by info
      | name                       | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion65 | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    Then Verify promotion show in All promotion page
      | name                       | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto ShortDate Promotion65 | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                       | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto ShortDate Promotion65 | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 0      |
    And Verify amount stack deal description
      | description             |
      | Quantity 1 ~ :0.00% off |
    Then Admin close dialog form
#    Đang có bug nếu k reset filter
    And Admin reset filter

    And Create promotion
      | name                         | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto ShortDate Promotion65 2 | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | Fix rate  | [blank] | [blank]      | [blank]              | [blank]              |
    And Admin search SKU to add promotion popup
      | sku                    | brand   | upc     |
      | Autotest sku shortdate | [blank] | [blank] |
    And Admin add SKU to promotion
      | specSKU                |
      | Autotest sku shortdate |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
      | 10          | 20     |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
      | 10          | 20     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ 9:$15.00 USD off |
      | Quantity 10 ~ :$20.00 USD off |
    And Delete stack deal number "3"
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Create promo success
    And Admin process overlap promotion
    And Search promotion by info
      | name                         | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto ShortDate Promotion65 2 | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    Then Verify promotion show in All promotion page
      | name                         | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto ShortDate Promotion65 2 | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                         | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto ShortDate Promotion65 2 | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion65"
    And Admin delete promotion by skuName "Auto ShortDate Promotion65"

  @PROMOTION_65_2
  Scenario: Check validation of Is this a case stack deal? field on Create new Promotion form 2
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by product Name "Product Short Dated api "
    And Admin delete promotion by skuName "Product Short Dated api"
    And Admin search promotion by Promotion Name "Auto TPR Promotion65"
    And Admin delete promotion by skuName "Auto TPR Promotion"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName "Auto TPR Promotion"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   | typePromo  | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion65 | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | Percentage | [blank] | [blank]      | [blank]              | [blank]              |
    And Admin search SKU to add promotion popup
      | sku                    | brand   | upc     |
      | Autotest sku shortdate | [blank] | [blank] |
    And Admin add SKU to promotion
      | specSKU                |
      | Autotest sku shortdate |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount  |
      | [blank]     | [blank] |
      | [blank]     | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 0      |
      | 0           | 0      |
    And Verify amount stack deal description
      | description             |
      | Quantity 1 ~ :0.00% off |
    And Check any text "is" showing on screen
      | Min quantity must be a valid number and cannot be lower than case minimum |
    And Admin edit case stack deal on promotion
      | minQuantity | amount |
      | 5           | 10     |
      | 4           | 15     |
    And Verify amount stack deal description
      | description              |
      | Quantity 5 ~ :10.00% off |
    And Check any text "is" showing on screen
      | Min quantity must be a valid number and cannot be lower than case minimum |
    And Create promo success

    Given NGOC_ADMIN_02 open web admin
    When NGOC_ADMIN_02 login to web with role Admin
    And NGOC_ADMIN_02 navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                 | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion65 | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    And Admin check no data found

    And Switch to actor NGOC_ADMIN
    And Admin edit case stack deal on promotion
      | minQuantity | amount |
      | 5           | 10     |
      | 10          | 15     |
    And Verify amount stack deal description
      | description               |
      | Quantity 5 ~ 9:10.00% off |
      | Quantity 10 ~ :15.00% off |
    And Check any text "not" showing on screen
      | Min quantity must be a valid number and cannot be lower than case minimum |
    And Create promo success
    And Search promotion by info
      | name                 | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion65 | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    Then Verify promotion show in All promotion page
      | name                 | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion65 | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type | brand   | regions | stores  | startDate   |
      | TPR  | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                 | type | regions             | stores     | start       | end         | discount  |
      | [blank] | Auto TPR Promotion65 | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 10% ~ 15% |
    And Vendor go to promotion detail with number or name: "Auto TPR Promotion65"
    And Vendor check promotion detail
      | title                | type | regions             | stores     | start-date  | end-date    | discount                             | caseMinimum |
      | Auto TPR Promotion65 | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 5 - 9 cases: 10% OI10+ cases: 15% OI | 5           |
    And Vendor Check applied SKUs on promotion detail
      | brand                    | product                 | sku                    | region              | originalPrice | discountPrice   |
      | AutoTest Promo ShortDate | Product Short Dated api | Autotest sku shortdate | Chicagoland Express | $100.00       | $85.00 ~ $90.00 |

    And Admin search promotion by Promotion Name "Auto TPR Promotion65"
    And Admin delete promotion by skuName "Auto TPR Promotion65"

  @PROMOTION_65_3
  Scenario: Check validation of Is this a case stack deal? field on Create new Promotion form 3
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by product Name "Product Short Dated api "
    And Admin delete promotion by skuName "Product Short Dated api"
    And Admin search promotion by Promotion Name "Auto TPR Promotion65"
    And Admin delete promotion by skuName "Auto TPR Promotion"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type   | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion65 | Auto Description | Buy-in | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | Fix rate  | [blank] | [blank]      | [blank]              | [blank]              |
    And Admin search SKU to add promotion popup
      | sku                    | brand   | upc     |
      | Autotest sku shortdate | [blank] | [blank] |
    And Admin add SKU to promotion
      | specSKU                |
      | Autotest sku shortdate |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount  |
      | [blank]     | [blank] |
      | [blank]     | [blank] |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 0      |
      | 0           | 0      |
    And Verify amount stack deal description
      | description                 |
      | Quantity 1 ~ :$0.00 USD off |
    And Check any text "is" showing on screen
      | Min quantity must be a valid number and cannot be lower than case minimum |
    And Admin edit case stack deal on promotion
      | minQuantity | amount |
      | 5           | 10     |
      | 4           | 15     |
    And Verify amount stack deal description
      | description                  |
      | Quantity 5 ~ :$10.00 USD off |
    And Check any text "is" showing on screen
      | Min quantity must be a valid number and cannot be lower than case minimum |
    And Create promo success

    Given NGOC_ADMIN_02 open web admin
    When NGOC_ADMIN_02 login to web with role Admin
    And NGOC_ADMIN_02 navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                 | type        | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion65 | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    And Admin check no data found

    And Switch to actor NGOC_ADMIN
    And Admin edit case stack deal on promotion
      | minQuantity | amount |
      | 5           | 10     |
      | 10          | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 5 ~ 9:$10.00 USD off |
      | Quantity 10 ~ :$15.00 USD off |
    And Check any text "not" showing on screen
      | Min quantity must be a valid number and cannot be lower than case minimum |
    And Create promo success
    And Search promotion by info
      | name                 | type   | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion65 | Buy-in | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | -           |
    Then Verify promotion show in All promotion page
      | name                 | type   | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion65 | Buy-in | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "All"
      | type   | brand   | regions | stores  | startDate   |
      | Buy-in | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                 | type   | regions             | stores     | start       | end         | discount        |
      | [blank] | Auto TPR Promotion65 | Buy-in | Chicagoland Express | All stores | currentDate | currentDate | $10.00 ~ $15.00 |
    And Vendor go to promotion detail with number or name: "Auto TPR Promotion65"
    And Vendor check promotion detail
      | title                | type   | regions             | stores     | start-date  | end-date    | discount                                   | caseMinimum |
      | Auto TPR Promotion65 | Buy-in | Chicagoland Express | All stores | currentDate | currentDate | 5 - 9 cases: $10.00 OI10+ cases: $15.00 OI | 5           |
    And Vendor Check applied SKUs on promotion detail
      | brand                    | product                 | sku                    | region              | originalPrice | discountPrice   |
      | AutoTest Promo ShortDate | Product Short Dated api | Autotest sku shortdate | Chicagoland Express | $100.00       | $85.00 ~ $90.00 |

    And Admin search promotion by Promotion Name "Auto TPR Promotion65"
    And Admin delete promotion by skuName "Auto TPR Promotion65"

  @Promotion @PROMOTION_25
  Scenario: Check the attached link when Click SKU name or Product name
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 30126 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto ShortDate Promotion | Test        | currentDate | currentDate | 1           | 10000      | 1                | true           | [blank] | default    | currentDate   | false   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                | orderBrand | time    |
      | AutoTest Promo ShortDate | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo        | start       | expired     |
      | Short dated | $90.00        | 1 Case          | 10000 cases only | currentDate | currentDate |
    And Buyer click SKU name and verify info
      | unitPrice | casePrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails | expireDate  |
      | $90.00    | $90.00    | SHORT-DATED PROMOTION | 10% off  | $90.00   | 10,000    | 10%                | currentDate |
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                | orderBrand | time    |
      | AutoTest Promo ShortDate | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo        | start       | expired     |
      | Short dated | $90.00        | 1 Case          | 10000 cases only | currentDate | currentDate |
#    And Buyer click Product name and verify info
#      | unitPrice | casePrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails | expireDate  |
#      | $90.00    | $90.00    | SHORT-DATED PROMOTION | 10% off  | $90.00   | 10,000    | 10%                | currentDate |
    And Admin search promotion by Promotion Name "Auto ShortDate Promotion"
    And Admin delete promotion by skuName "Auto ShortDate Promotion"

  @Promotion @PROMOTION_31
  Scenario: Check displayed of promotion when Admin changes SKU state
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 82839 | 26        | 30930              | 10000            | 10000      | in_stock     | inactive |
      | 82838 | 63        | 30930              | 10000            | 10000      | in_stock     | active   |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    Then Buyer verify brand "AT Brand Promo 31" not display in promotion tab

    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82839 | 26        | 30930              | 10000            | 10000      | in_stock     | active |
      | 82838 | 63        | 30930              | 10000            | 10000      | in_stock     | active |


#-------------------------------ADMIN DASHBOARD > PROMOTIONS TAB ----------------------------------
  @Promotion @PROMOTION_33
  Scenario: Check displayed of promotion which has usage = 1 after buyer checkouts with applied SKU
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And NGOC_ADMIN navigate to "Promotions" to "Upcoming" by sidebar
    And NGOC_ADMIN navigate to "Promotions" to "Expired" by sidebar

  @Promotion @PROMOTION_39 @PROMOTION_41
  Scenario: Check the promotion list when admin filters with entered criteria
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name          | type | store    | brand                 | productName          | skuName              | region              | startAt  | expireAt | isStackDeal |
      | Auto Ngoc TPR | TPR  | ngoc st1 | AutoTest Brand Ngoc01 | Product On Going api | Autotest sku ongoing | Chicagoland Express | 06/13/22 | 06/13/25 | [blank]     |
    Then Verify promotion show in All promotion page
      | name          | type | region | startAt    | expireAt   | usageLimit | CaseLimit |
      | Auto Ngoc TPR | TPR  | CHI    | 2022-06-13 | 2025-06-13 | 1          | 10000     |
    And Search promotion by info
      | name           | type | store    | brand                 | productName          | skuName              | region              | startAt  | expireAt | isStackDeal |
      | Auto Ngoc Test | TPR  | ngoc st1 | AutoTest Brand Ngoc01 | Product On Going api | Autotest sku ongoing | Chicagoland Express | 06/13/22 | 06/13/25 | Yes         |
    And Admin verify no data in result after search promotion
    And Search promotion by info
      | name           | type | store    | brand                 | productName          | skuName              | region              | startAt  | expireAt | isStackDeal |
      | Auto Ngoc Test | TPR  | ngoc st1 | AutoTest Brand Ngoc01 | Product On Going api | Autotest sku ongoing | Chicagoland Express | 06/13/22 | 06/13/25 | No          |
    And Admin verify no data in result after search promotion
    And Search promotion by info
      | name           | type | store    | brand                 | productName          | skuName              | region              | startAt  | expireAt | isStackDeal | excludedStore | includedBuyerCompany   | excludedBuyerCompany   |
      | Auto Ngoc Test | TPR  | ngoc st1 | AutoTest Brand Ngoc01 | Product On Going api | Autotest sku ongoing | Chicagoland Express | 06/13/22 | 06/13/25 | No          | Bao store     | Auto Buyer Company Bao | Auto Buyer Company Bao |
    And Admin verify no data in result after search promotion

  @Promotion @PROMOTION_59
  Scenario: Check display of popup Add specific SKUs
    Given NGOCTX login web admin by api
      | email           | password  |
      | bao@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion11"
    And Admin delete promotion by skuName "Auto TPR Promotion11"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion11 | Auto Description | TPR  | [blank]   | 10         | 10        | 1           | currentDate | currentDate | Yes        | [blank] | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Admin search SKU to add promotion popup
      | sku           | brand                        | upc          |
      | AT SKU Ngoc01 | AT Brand Financial Pending01 | 951632984012 |
    And Admin add SKU to promotion
      | specSKU       |
      | AT SKU Ngoc01 |
    And Admin search SKU to add promotion popup
      | sku   | brand   | upc     |
      | 30752 | [blank] | [blank] |
    And Admin add SKU to promotion
      | specSKU       |
      | AT SKU Ngoc01 |
    And Admin search SKU to add promotion popup
      | sku     | brand                        | upc     |
      | [blank] | AT Brand Financial Pending01 | [blank] |
    And Admin add SKU to promotion
      | specSKU       |
      | AT SKU Ngoc01 |
    And Admin search SKU to add promotion popup
      | sku     | brand   | upc          |
      | [blank] | [blank] | 951632984012 |
    And Admin add SKU to promotion
      | specSKU       |
      | AT SKU Ngoc01 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success
    And Search promotion by info
      | name                 | type | store   | brand                        | productName                  | skuName       | region          | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion11 | TPR  | [blank] | AT Brand Financial Pending01 | AT Product Financial Pending | AT SKU Ngoc01 | Florida Express | currentDate | currentDate | No          |
    Then Verify promotion show in All promotion page
      | name                 | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion11 | TPR  | FL     | currentDate | currentDate | 10         | 10        |
    And Verify promotion info in Promotion detail
      | name                 | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion11 | Auto Description | TPR  | 10         | 10        | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 10     |
    And Check item on Promotion detail
      | product                      | sku           | brand                        |
      | AT Product Financial Pending | AT SKU Ngoc01 | AT Brand Financial Pending01 |

  @Promotion @PROMOTION_40
  Scenario: Check the pagination function
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Click on button "Search"
    Then Admin verify pagination function

  @Promotion @PROMOTION_42
  Scenario: Check display of Create new Promotion form when admin creates a buy-in promotion
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                       |
      | Chicagoland Express | 26        | 30752   | 2557      | 2376                       | 2296              | 2376               | "PromotionRules::LineItem" |
      | Florida Express     | 53        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | [blank]                    |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | false | 1      |
    And Admin create promotion by api with info
      | type              | name            | description | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | AT PROMOTION_42 | Test API    | 2022-06-14 | 2022-06-14 | [blank]     | 1000       | 1                | true           | [blank] | default    | [blank]       |

    And Admin search promotion by skuName "AT PROMOTION_42"
    And Admin delete promotion by skuName "AT PROMOTION_42"

  @Promotion @PROMOTION_43
  Scenario: Check display of Create new Promotion form when admin creates an TPR promotion
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                       |
      | Chicagoland Express | 26        | 30752   | 2557      | 2376                       | 2296              | 2376               | "PromotionRules::LineItem" |
      | Florida Express     | 53        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | [blank]                    |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name            | description     | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT PROMOTION_43 | AT PROMOTION_43 | 2022-06-14 | 2022-06-14 | 1000        | 1000       | 1                | true           | [blank] | default    | [blank]       |

    And Admin search promotion by Promotion Name "AT PROMOTION_43"
    And Admin delete promotion by skuName "AT PROMOTION_43"

  @Promotion @PROMOTION_44
  Scenario: Check display of Create new Promotion form when admin creates a Short-dated promotion
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                       |
      | Chicagoland Express | 26        | 30752   | 2557      | 2376                       | 2296              | 2376               | "PromotionRules::LineItem" |
      | Florida Express     | 53        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | [blank]                    |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | false | 1      |
    And Admin create promotion by api with info
      | type                  | name            | description | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | AT PROMOTION_44 | Test API    | 2022-06-14 | 2022-06-14 | [blank]     | 1000       | 1                | true           | [blank] | default    | 2025-06-13    |

    And Admin search promotion by Promotion Name "AT PROMOTION_44"
    And Admin delete promotion by skuName "AT PROMOTION_44"

  @Promotion @PROMOTION_45
  Scenario: Check display of Create new Promotion form when admin creates a Pod-sponsored promotion
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT PROMOTION_45"
    And Admin delete promotion by skuName "AT PROMOTION_45"

    And Admin add region by API
      | region              | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Chicagoland Express | 26        | [blank] | 2557      | 2376                       | 2296              | 2376               | PromotionRules::Order |
      | Florida Express     | 53        | [blank] | [blank]   | [blank]                    | [blank]           | [blank]            | [blank]               |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name            | description | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::PodSponsored | AT PROMOTION_45 | Test API    | 2022-06-14 | 2022-06-14 | 1000        | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       |

    And Admin search promotion by Promotion Name "AT PROMOTION_45"
    And Admin delete promotion by skuName "AT PROMOTION_45"

  @Promotion @PROMOTION_46
  Scenario: Check validation of field on Create new Promotion form
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    Then Admin verify field in Create New Promotion form
      | name                 | value                |
      | !@#$%^&*()_+{}[]"?>: | !@#$%^&*()_+{}[]"?>: |
      | 1000                 | 100                  |
    And Admin verify type field in Create New Promotion form

  @Promotion @PROMOTION_48
  Scenario: Check validation of SKU expiry date field on Create new Promotion form if select type Short-dated
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Admin choose type of promotion is "Short-dated"
    And Click on dialog button "Create"
#    And Admin check message is showing of field "SKU expiry date"
#      | Please select a specific expiry date for this promotion SKUs |
    And Admin verify value of field in Create New Promotion form
      | field           | value   |
      | SKU expiry date | [blank] |
    And Admin choose "SKU expiry date" of promotion is "Plus1"
    And Admin verify value of field in Create New Promotion form
      | field           | value |
      | SKU expiry date | Plus1 |
    And Admin check message not showing of field "SKU expiry date"
      | message |
#    And Admin Clear field "SKU expiry date"

  @Promotion @PROMOTION_49
  Scenario: Check validation of Usage limit field on Create new Promotion form
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Admin edit info of promo
      | field       | value |
      | Usage limit | a     |
    And Admin verify value of field in Create New Promotion form
      | field       | value   |
      | Usage limit | [blank] |
    And Admin edit info of promo
      | field       | value |
      | Usage limit | -1    |
    And Click on dialog button "Create"
    And Admin check message is showing of field "Usage limit"
      | Please select a positive usage limit for this promotion |
    And Admin choose type of promotion is "Buy-in"
    And Admin verify value of field in Create New Promotion form
      | field       | value | status  |
      | Usage limit | -1    | disable |
    And Admin choose type of promotion is "Short-dated"
    And Admin edit info of promo
      | field       | value |
      | Usage limit | -1    |
    And Click on dialog button "Create"
    And Admin check message is showing of field "Usage limit"
      | Please select a positive usage limit for this promotion |

  @Promotion @PROMOTION_50
  Scenario: Check validation of Case limit field on Create new Promotion form
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Admin edit info of promo
      | field      | value |
      | Case limit | a     |
    And Admin verify value of field in Create New Promotion form
      | field      | value   |
      | Case limit | [blank] |
    And Admin edit info of promo
      | field      | value |
      | Case limit | -1    |
    And Click on dialog button "Create"
    And Admin check message is showing of field "Case limit"
      | Please select a positive case limit for this promotion |
    And Admin choose type of promotion is "Buy-in"
    And Admin edit info of promo
      | field      | value |
      | Case limit | -1    |
    And Click on dialog button "Create"
    And Admin check message is showing of field "Case limit"
      | Please select a positive case limit for this promotion |
    And Admin choose type of promotion is "Short-dated"
    And Admin edit info of promo
      | field      | value |
      | Case limit | -1    |
    And Click on dialog button "Create"
    And Admin check message is showing of field "Case limit"
      | Please select a positive case limit for this promotion |

  @Promotion @PROMOTION_51
  Scenario: Check validation of Case minimum field on Create new Promotion form
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
#    And Admin edit info of promo
#      | field        | value |
#      | Case minimum | a     |
#    And Admin check value of field
#      | field        | value   |
#      | Case minimum | [blank] |
#    And Click on dialog button "Create"
#    And Admin check message is showing of field "Case minimum"
#      | Please enter a valid minimum case value for this promotion |
    And Admin edit info of promo
      | field        | value |
      | Case minimum | 0     |
    And Admin check message is showing of field "Case minimum"
      | Please enter a valid minimum case value for this promotion |
    And Admin edit info of promo
      | field        | value |
      | Case minimum | -1    |
    And Admin check message is showing of field "Case minimum"
      | Please enter a valid minimum case value for this promotion |
    And Admin edit info of promo
      | field        | value |
      | Case minimum | 1     |
    And Admin check message not showing of field "Case minimum"
      | Please enter a valid minimum case value for this promotion |
    And Admin choose type of promotion is "Buy-in"
#    And Admin edit info of promo
#      | field        | value |
#      | Case minimum | a     |
#    And Admin check message is showing of field "Case minimum"
#      | Please enter a valid minimum case value for this promotion |
    And Admin edit info of promo
      | field        | value |
      | Case minimum | 0     |
    And Admin check message is showing of field "Case minimum"
      | Please enter a valid minimum case value for this promotion |
    And Admin edit info of promo
      | field        | value |
      | Case minimum | -1    |
    And Admin check message is showing of field "Case minimum"
      | Please enter a valid minimum case value for this promotion |
    And Admin edit info of promo
      | field        | value |
      | Case minimum | 1     |
    And Admin check message not showing of field "Case minimum"
      | Please enter a valid minimum case value for this promotion |

  @Promotion @PROMOTION_52
  Scenario: Check validation of From field on Create new Promotion form if select type Short-dated
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Admin choose type of promotion is "Short-dated"
    And Click on dialog button "Create"
    And Admin check message is showing of field "From"
      | Please select a specific start date for this promotion |

    And Admin verify value of field in Create New Promotion form
      | field | value   |
      | From  | [blank] |
    And Admin choose "From" of promotion is "Plus1"
    And Admin verify value of field in Create New Promotion form
      | field | value |
      | From  | Plus1 |
    And Admin check message not showing of field "From"
      | message |
    And Admin Clear field "From"
    And Admin verify value of field in Create New Promotion form
      | field | value   |
      | From  | [blank] |
    And Admin Clear field "From"
    And Admin choose type of promotion is "Buy-in"
    And Admin choose "From" of promotion is "Plus1"
    And Admin verify value of field in Create New Promotion form
      | field | value |
      | From  | Plus1 |
    And Admin check message not showing of field "From"
      | message |
    And Admin Clear field "From"
    And Click on dialog button "Create"
#    And Admin check message is showing of field "From"
#      | Please select a specific start date for this promotion |
    And Admin choose type of promotion is "TPR"
    And Admin verify value of field in Create New Promotion form
      | field | value   |
      | From  | [blank] |
    And Admin choose "From" of promotion is "Plus1"
    And Admin verify value of field in Create New Promotion form
      | field | value |
      | From  | Plus1 |
    And Admin check message not showing of field "From"
      | message |
    And Admin Clear field "From"
    And Click on dialog button "Create"
#    And Admin check message is showing of field "From"
#      | Please select a specific start date for this promotion |
    And Admin choose type of promotion is "Pod-sponsored"
    And Admin verify value of field in Create New Promotion form
      | field | value   |
      | From  | [blank] |
    And Admin choose "From" of promotion is "Plus1"
    And Admin verify value of field in Create New Promotion form
      | field | value |
      | From  | Plus1 |
    And Admin check message not showing of field "From"
      | message |
    And Admin Clear field "From"
    And Click on dialog button "Create"
#    And Admin check message is showing of field "From"
#      | Please select a specific start date for this promotion |
    And Admin choose type of promotion is "TPR"
    And Admin verify value of field in Create New Promotion form
      | field | value   |
      | From  | [blank] |
    And Admin choose "From" of promotion is "Plus1"
    And Admin verify value of field in Create New Promotion form
      | field | value |
      | From  | Plus1 |
    And Admin check message not showing of field "From"
      | message |
    And Admin Clear field "From"
    And Click on dialog button "Create"
#    And Admin check message is showing of field "From"
#      | Please select a specific start date for this promotion |

  @Promotion @PROMOTION_53
  Scenario: Check validation of To field on Create new Promotion form if select type Short-dated
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Admin choose type of promotion is "Short-dated"
    And Admin verify value of field in Create New Promotion form
      | field | value   |
      | To    | [blank] |
    And Admin choose "To" of promotion is "Plus1"
    And Admin verify value of field in Create New Promotion form
      | field | value |
      | To    | Plus1 |
    And Admin check message not showing of field "To"
      | message |
    And Admin Clear field "To"
    And Admin check message not showing of field "To"
      | message |
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | Plus2    | currentDate | Yes        | [blank] | [blank] | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Check any text "is" showing on screen
      | Tips: if you do not select any region, the promotion will be applied for all regions. |
    And Choose regions to promo
      | region                   |
      | Florida Express          |
      | Chicagoland Express      |
      | Mid Atlantic Express     |
      | New York Express         |
      | North California Express |
      | South California Express |
      | Dallas Express           |
#      | Texas Express                  |
      | Pod Direct Central       |
      | Pod Direct East          |
#      | Pod Direct Southeast           |
#      | Pod Direct Southwest & Rockies |
      | Pod Direct West          |
    And Click on dialog button "Create"
#    And Create promo success
    And Admin process non SKU promotion
    And Admin process overlap promotion
#    And Admin verify content of alert
#      | Expires at must be after or equal to |

  @Promotion @PROMOTION_54_to_59
  Scenario: Check validation of SpecificSKUs field, Included stores, Excluded stores, Included buyer companies, Excluded buyer companies on Create new Promotion form if select type Short-dated
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU        | store         | typePromo  | amount | excludeStore  | includedBuyerCompany   | excludedBuyerCompany   |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | AT SKU Promo13 | ngoc st promo | Percentage | 10     | ngoc st promo | Auto Buyer Company Bao | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU        |
      | AT SKU Promo13 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Click on dialog button "Create"
#    And Admin process non SKU promotion
#    And Admin process overlap promotion
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |

    And Admin Close the Create promotion form
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store         | typePromo  | amount | excludeStore  | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | ngoc st promo | Percentage | 10     | ngoc st promo | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU        |
      | AT SKU Promo13 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Click on dialog button "Create"
#    And Admin process non SKU promotion
#    And Admin process overlap promotion
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin Close the Create promotion form
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany   | excludedBuyerCompany   |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | [blank] | Percentage | 10     | [blank]      | Auto Buyer Company Bao | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU        |
      | AT SKU Promo13 |
    And Click on dialog button "Create"
#    And Admin process non SKU promotion
#    And Admin process overlap promotion
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |

  @Promotion @PROMOTION_60
  Scenario:Verify that admin created a buy-in promotion successfully (Create with only Included store)
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer47@podfoods.co | 12345678a |
    And Buyer set favorite product "29645" by API
#    And Buyer set favorite product 31098 by API
#    And Buyer set favorite product 31110 by API
#    And Buyer set favorite product 35091 by API
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy In Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type   | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                  | type   | store     | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Buy In Promotion | Buy-in | Bao store | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type   | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Buy In Promotion | Buy-in | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | createdBy        | createdOn   |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Auto_Check Promotions | Bao store | Admin: NgocTX on | currentDate |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | USD  | 5      |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type   | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | Buy in | $5.00         | 1 Case          | [blank]   | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Product page"
      | name                  | type   | price | caseLimit |
      | Auto_Check Promotions | BUY-IN | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Catalog page"
      | name                  | type   | price | caseLimit |
      | Auto_Check Promotions | BUY-IN | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo        | discount    | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Buy-in Promotion | -$5.00/case | $5.00    | [blank]   | -$5                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Favorite page"
      | name                  | type   | price | caseLimit |
      | Auto_Check Promotions | BUY-IN | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy In Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_72_M_Added_12/07/22
  Scenario:Verify that admin created a buy-in promotion successfully (Create with only Included store) - With Case stack deal
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer47@podfoods.co | 12345678a |
    And Buyer set favorite product "29645" by API
#    And Buyer set favorite product 31098 by API
#    And Buyer set favorite product 31110 by API
#    And Buyer set favorite product 35091 by API
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy In Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type   | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Create promo success

    And Search promotion by info
      | name                  | type   | store     | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Buy In Promotion | Buy-in | Bao store | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                  | type   | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Buy In Promotion | Buy-in | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                  | description      | type   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | createdBy        | createdOn   |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Auto_Check Promotions | Bao store | Admin: NgocTX on | currentDate |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type   | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | Buy in | $5.00 ~ $0.00 | 1 Case          | [blank]   | currentDate | currentDate |
    And Verify stack case detail on Promotion tab
      | stackCase              |
      | 1 - 4 cases: $10.00 OI |
      | 5+ cases: $15.00 OI    |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Product page"
      | name                  | type   | price          | caseLimit |
      | Auto_Check Promotions | BUY-IN | -$5.00 ~ $0.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Catalog page"
      | name                  | type   | price          | caseLimit |
      | Auto_Check Promotions | BUY-IN | -$5.00 ~ $0.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | oldPrice | oldTotalPrice | orderValue | cartTotal |
      | $0.00    | -$10.00  | $0.00    | $10.00   | $10.00        | $10.00     | $30.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice      | currentPrice   | oldPrice | typePromo        | caseLimit | discountThumbnails | expireDate |
      | -$5.00 ~ $0.00 | -$5.00 ~ $0.00 | $10.00   | Buy-in Promotion | [blank]   | -$10 ~ -$15        | [blank]    |
    And Verify Stack case promotion on product detail
      | stackCase              |
      | 1 - 4 cases: $10.00 OI |
      | 5+ cases: $15.00 OI    |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Buy in" of product "Auto Check promotions" in "Favorite page"
      | name                  | type   | price          | caseLimit |
      | Auto_Check Promotions | BUY-IN | -$5.00 ~ $0.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$10.00  | $0.00    |
    And Verify Case Stack Deals on cart detail tab
      | stackCase | discount |
      | 4 more    | $15.00   |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy In Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_74_M_Added_12/07/22 @aaa
  Scenario:Verify that admin created a TPR promotion successfully (Create with only Included store) - With Case stack deal
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer47@podfoods.co | 12345678a |
    And Buyer set favorite product "29645" by API
#    And Buyer set favorite product 31098 by API
#    And Buyer set favorite product 31110 by API
#    And Buyer set favorite product 35091 by API
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy In Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Fix rate  | 5      | [blank]      | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Create promo success

    And Search promotion by info
      | name               | type | store     | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | Bao store | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | createdBy        | createdOn   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Auto_Check Promotions | Bao store | Admin: NgocTX on | currentDate |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | TPR  | $5.00 ~ $0.00 | 1 Case          | [blank]   | currentDate | currentDate |
    And Verify stack case detail on Promotion tab
      | stackCase              |
      | 1 - 4 cases: $10.00 OI |
      | 5+ cases: $15.00 OI    |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                  | type | price          | caseLimit |
      | Auto_Check Promotions | TPR  | -$5.00 ~ $0.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                  | type | price          | caseLimit |
      | Auto_Check Promotions | TPR  | -$5.00 ~ $0.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | oldPrice | oldTotalPrice | orderValue | cartTotal |
      | $0.00    | -$10.00  | $0.00    | $10.00   | $10.00        | $10.00     | $30.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice      | currentPrice   | oldPrice | typePromo     | caseLimit | discountThumbnails | expireDate |
      | -$5.00 ~ $0.00 | -$5.00 ~ $0.00 | $10.00   | TPR Promotion | [blank]   | -$10 ~ -$15        | [blank]    |
    And Verify Stack case promotion on product detail
      | stackCase              |
      | 1 - 4 cases: $10.00 OI |
      | 5+ cases: $15.00 OI    |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                  | type | price          | caseLimit |
      | Auto_Check Promotions | TPR  | -$5.00 ~ $0.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$10.00  | $0.00    |
    And Verify Case Stack Deals on cart detail tab
      | stackCase | discount |
      | 4 more    | $15.00   |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_61
  Scenario:Verify that admin created a TPR promotion successfully (Create with only Included store)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 50     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Auto_Check Promotions | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | TPR  | $5.00         | 1 Case          | [blank]   | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_62 @aaa
  Scenario:Verify that admin created a Short-dated promotion successfully (Create with both Included store and Included buyer company)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                       | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Percentage | 50     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                       | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                       | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                       | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     | createdBy        | createdOn   |
      | Auto Short-dated Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Bao store | Admin: NgocTX on | currentDate |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start       | expired     | skuExpiryDate |
      | Short dated | $5.00         | 1 Case          | [blank]   | currentDate | currentDate | currentDate   |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                  | type        | price | caseLimit |
      | Auto_Check Promotions | SHORT-DATED | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                  | type        | price | caseLimit |
      | Auto_Check Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                  | type        | price | caseLimit |
      | Auto_Check Promotions | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_76 @aaa
#    _Added_12/07/22
  Scenario: Verify that admin created a Short-dated promotion successfully (Create with both Included store and Included buyer company) - With Case stack deal
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                       | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Fix rate  | 5      | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Admin add case stack deal to promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Create promo success

    And Search promotion by info
      | name                       | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                       | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                       | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto Short-dated Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Bao store |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 5           | 15     |
    And Verify amount stack deal description
      | description                   |
      | Quantity 1 ~ 4:$10.00 USD off |
      | Quantity 5 ~ :$15.00 USD off  |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
      | Short dated | $5.00 ~ $0.00 | 1 Case          | [blank]   | currentDate | currentDate |
    And Verify stack case detail on Promotion tab
      | stackCase              |
      | 1 - 4 cases: $10.00 OI |
      | 5+ cases: $15.00 OI    |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Product page"
      | name                  | type        | price          | caseLimit |
      | Auto_Check Promotions | SHORT-DATED | -$5.00 ~ $0.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"

    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Catalog page"
      | name                  | type        | price          | caseLimit |
      | Auto_Check Promotions | SHORT-DATED | -$5.00 ~ $0.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU | oldPrice | oldTotalPrice | orderValue | cartTotal |
      | $0.00    | -$10.00  | $0.00    | $10.00   | $10.00        | $10.00     | $30.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice      | currentPrice   | oldPrice | typePromo             | caseLimit | discountThumbnails | expireDate |
      | -$5.00 ~ $0.00 | -$5.00 ~ $0.00 | $10.00   | Short-dated Promotion | [blank]   | -$10 ~ -$15        | [blank]    |
    And Verify Stack case promotion on product detail
      | stackCase              |
      | 1 - 4 cases: $10.00 OI |
      | 5+ cases: $15.00 OI    |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "Short dated" of product "Auto Check promotions" in "Favorite page"
      | name                  | type        | price          | caseLimit |
      | Auto_Check Promotions | SHORT-DATED | -$5.00 ~ $0.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $0.00    | -$10.00  | $0.00    |
    And Verify Case Stack Deals on cart detail tab
      | stackCase | discount |
      | 4 more    | $15.00   |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_63
  Scenario: Verify that admin created multiple normal promotion with different type for a SKU successfully (Create with both Included store and Excluded store, but Included store # Excluced store)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                       | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo  | amount | excludeStore            | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Percentage | 20     | Auto Bao Store Express1 | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
#    promotion 2
    And Admin process overlap promotion
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo  | amount | excludeStore            | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Percentage | 50     | Auto Bao Store Express1 | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Admin process overlap promotion
    And Search promotion by info
      | name                       | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                       | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                       | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto Short-dated Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Bao store |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin Close the Create promotion form
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Bao store |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
#    And Show details of promotion then verify info
#      | type        | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
#      | TPR         | $5.00         | 1 Case          | [blank]  | currentDate | currentDate |
#      | Short dated | $8.00         | 1 Case          | [blank]  | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Promotions" of product "Auto Check promotions" in "Product page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Promotions" of product "Auto Check promotions" in "Catalog page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_64 @aaa
  Scenario: Verify that admin created multiple normal promotion with different type for a SKU successfully (Create with both Excluded store and Excluded buyer company)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                       | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore            | includedBuyerCompany | excludedBuyerCompany   |
      | Auto Short-dated Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | Auto Bao Store Express1 | [blank]              | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
#    promotion 2
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore            | includedBuyerCompany | excludedBuyerCompany   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 50     | Auto Bao Store Express1 | [blank]              | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Admin process overlap promotion
    And Search promotion by info
      | name                       | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                       | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                       | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin Close the Create promotion form
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
#    And Show details of promotion then verify info
#      | type        | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
#      | TPR         | $5.00         | 1 Case          | [blank]  | currentDate | currentDate |
#      | Short dated | $8.00         | 1 Case          | [blank]  | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "Promotions" of product "Auto Check promotions" in "Product page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "Promotions" of product "Auto Check promotions" in "Catalog page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | TPR Promotion | 50% off  | $5.00    | [blank]   | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_65
  Scenario: Verify that admin created multiple normal promotion with same type for a SKU sucessfully (Create with both Included buyer company and Excluded buyer company , but Included buyer company # Excluced buyer company)
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by product Name "Auto Check promotions"
    And Admin delete promotion by skuName "Auto Check promotions"
    And Admin search promotion by Promotion Name "Auto TPR 2 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
#    promotion 2
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany   |
      | Auto TPR 2 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 50     | [blank]      | Bao Buyer Company    | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Admin process overlap promotion
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin Close the Create promotion form
    And Search promotion by info
      | name                 | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 2 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                 | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 2 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                 | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 2 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
#    And Show details of promotion then verify info
#      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
#      | TPR  | $8.00         | 1 Case          | [blank]  | currentDate | currentDate |
#      | TPR  | $5.00         | 1 Case          | [blank]  | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
#    And Buyer Search product by name "Auto Check promotions"
#    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
#      | unitPrice | casePrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
#      | $5.00     | $5.00     | TPR Promotion | 50% off  | $5.00    | [blank]  | 50%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $5.00    | -$5.00   | $5.00    |
    Given HEAD_BUYER_PE2 open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    Then Buyer verify brand "Auto_Brand_Inventory" not display in promotion tab

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 2 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_66
  Scenario: Verify that admin created same types of normal promotion for SKUs of a product sucessfully
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer48@podfoods.co | 12345678a |
    And Buyer set favorite product "29645" by API

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 2 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
#    promotion 2
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                 | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU                 | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR 2 Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 2           | currentDate | currentDate | Yes        | Auto_Check 2 Promotions | [blank] | Percentage | 50     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU                 |
      | Auto_Check 2 Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin Close the Create promotion form
    And Search promotion by info
      | name                 | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR 2 Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                 | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR 2 Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                 | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR 2 Promotion | Auto Description | TPR  | [blank]    | [blank]   | 2           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                     |
      | Auto Check promotions | Auto_Check 2 Promotions |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer48@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName            | orderBrand | time    |
      | Auto_Brand_Inventory | No         | [blank] |
#    And Show details of promotion then verify info
#      | type | pricePromoted | minimumPurchase | limitedTo | start       | expired     |
#      | TPR  | $5.00         | 2 Case          | [blank]  | currentDate | currentDate |
#      | TPR  | $8.00         | 1 Case          | [blank]  | currentDate | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto_Brand_Inventory"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Product page"
      | name                    | type | price | caseLimit |
      | Auto_Check Promotions   | TPR  | $8.00 | [blank]   |
      | Auto_Check 2 Promotions | TPR  | $5.00 | [blank]   |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Auto Check promotions", sku "Auto_Check Promotions" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Catalog page"
      | name                    | type | price | caseLimit |
      | Auto_Check Promotions   | TPR  | $8.00 | [blank]   |
      | Auto_Check 2 Promotions | TPR  | $5.00 | [blank]   |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |
    And Verify Promotional Discount of "Auto Check promotions" and sku "Auto_Check Promotions" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $8.00     | $8.00        | $10.00   | TPR Promotion | 20% off  | $8.00    | [blank]   | 20%                |
    And Go to favorite page of "Auto Check promotions"
    Then Verify promo preview "TPR" of product "Auto Check promotions" in "Favorite page"
      | name                  | type | price | caseLimit |
      | Auto_Check Promotions | TPR  | $8.00 | [blank]   |

    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $8.00    | -$2.00   | $8.00    |

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"
    And Admin search promotion by Promotion Name "Auto TPR 2 Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_67_68_69
  Scenario: Verify that admin creates normal promotion with Included (or buyer companies) store and Exclude (or buyer companies) store is same store
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "AT SKU Promo13"
    And Admin delete promotion by skuName ""
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU        | store         | typePromo  | amount | excludeStore  | includedBuyerCompany   | excludedBuyerCompany   |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | AT SKU Promo13 | ngoc st promo | Percentage | 10     | ngoc st promo | Auto Buyer Company Bao | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU        |
      | AT SKU Promo13 |
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Create promo success
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin Close the Create promotion form
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store         | typePromo  | amount | excludeStore  | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | ngoc st promo | Percentage | 10     | ngoc st promo | [blank]              | [blank]              |
    And Add SKU to promo
      | specSKU        |
      | AT SKU Promo13 |
    And Create promo success
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin Close the Create promotion form
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany   | excludedBuyerCompany   |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | [blank] | Percentage | 10     | [blank]      | Auto Buyer Company Bao | Auto Buyer Company Bao |
    And Add SKU to promo
      | specSKU        |
      | AT SKU Promo13 |
    And Create promo success
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin Close the Create promotion form
    And Create promotion
      | name                  | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | Bao store | Percentage | 10     | [blank]      | [blank]              | Bao Buyer Company    |
    And Add SKU to promo
      | specSKU        |
      | AT SKU Promo13 |
    And Create promo success
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |

  @Promotion @PROMOTION_70
  Scenario: Verify display of a promotion on Active child tabs when admin created it successfully
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"

    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | [blank]     |
    And Admin verify no data in result after search promotion
    And NGOC_ADMIN navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | [blank]     |
    And Admin verify no data in result after search promotion

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"

    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_71
  Scenario: Verify display of a promotion on Upcoming child tabs when admin created it successfully
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"

    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | Plus1    | Plus1  | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | Plus1   | Plus1    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Plus1    | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | Plus1    | [blank]     |
    And Admin verify no data in result after search promotion

    And NGOC_ADMIN navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | Plus1   | Plus1    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Plus1    | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    And Admin Close the Create promotion form

    And NGOC_ADMIN navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | [blank]     |
    And Admin verify no data in result after search promotion
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"

    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_72
  Scenario: Verify display of a promotion on Expired child tabs when admin created it successfully
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"

    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | Minus1   | Minus1 | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Minus1   | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | Minus1  | Minus1   | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus1   | Minus1 | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Minus1   | [blank]     |
    And Admin verify no data in result after search promotion

    And NGOC_ADMIN navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | [blank]     |
    And Admin verify no data in result after search promotion

    And NGOC_ADMIN navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | Minus1  | Minus1   | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus1   | Minus1 | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    And Admin Close the Create promotion form

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by skuName "Auto_Check 2 Promotions"
    And Admin delete promotion by skuName "Auto_Check 2 Promotions"

    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_74_75
  Scenario: Verify that admin edits information of a normal promotion successfully
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin edit info of promo
      | field | value                     |
      | Name  | Auto TPR Promotion Edited |
    And Admin click Update
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion Edited | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                      | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion Edited | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                      | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion Edited | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin edit info of promo
      | field        | value |
      | Usage limit  | 1     |
      | Case limit   | 1     |
      | Case minimum | 1     |
    And Admin click Update
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion Edited | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                      | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion Edited | TPR  | CHI    | currentDate | currentDate | 1          | 1         |
    And Verify promotion info in Promotion detail
      | name                      | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion Edited | Auto Description | TPR  | 1          | 1         | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_76
  Scenario: Verify display of a promotion on Upcoming child tabs when admin created it successfully
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin choose type of promotion is "Short-dated"

    And Admin edit info of promo
      | field           | value       |
      | SKU expiry date | currentDate |
    And Admin click Update
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    And Admin verify no data in result after search promotion
    And Search promotion by info
      | name               | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto TPR Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto TPR Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_77
  Scenario: Verify display of a promotion on Expired child tabs when admin created it successfully
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Edited"
    And Admin delete promotion by skuName ""

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name               | description      | type | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | specSKU               | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]   | [blank]    | [blank]   | 1           | Minus2   | Plus1  | Yes        | Auto_Check Promotions | [blank] | Percentage | 20     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | Minus2  | Plus1    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus2   | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin edit info of promo
      | field | value  |
      | From  | Minus1 |

    And Admin click Update
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | Minus1  | Plus1    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus1   | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Admin Close the Create promotion form
    And NGOC_ADMIN navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name               | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal |
      | Auto TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Plus1    | [blank]     |
    Then Verify promotion show in All promotion page
      | name               | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto TPR Promotion | TPR  | CHI    | Minus1  | Plus1    | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name               | description      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto TPR Promotion | Auto Description | TPR  | [blank]    | [blank]   | 1           | Minus1   | Plus1  | is-checked | [blank] |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |

    And Admin search promotion by skuName "Auto_Check Promotions"
    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Edited"
    And Admin delete promotion by skuName ""

  @Promotion @PROMOTION_50_1
  Scenario: Check display of Create new Promotion form when admin creates a Short-dated promotion
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 50 Promotion"
    And Admin delete promotion by skuName ""
   # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product promotion 50 inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product promotion 50 inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product promotion 50 inventory api" by api
    And Admin search product name "random product promotion 50 inventory api" by api
    And Admin delete product name "random product promotion 50 inventory api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product promotion 50 inventory api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku promotion inventory api" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku promotion inventory api | random             | 5        | random sku lot promotion 50 inventory api | 99           | Plus1        | Plus1       | [blank] |

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | [blank] | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Add Inventory lot to promo
      | lotCode                                   |
      | random sku lot promotion 50 inventory api |
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         |
    And Check item on Promotion detail
      | product                                   | sku                                | brand                     |
      | random product promotion 50 inventory api | random sku promotion inventory api | Auto brand create product |
    And Check field "SKU expiry date" is disabled
    And Admin go to inventory on promotion form and check info
      | lotCode                                   |
      | random sku lot promotion 50 inventory api |
    And Switch to tab by title "Inventory #"
    And Verify inventory detail
      | index | product                                   | sku                                | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode                                   | storageShelfLife | temperature   | originalQty | currentQty | endQty | comment |
      | 1     | random product promotion 50 inventory api | random sku promotion inventory api | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | Plus1       | Plus1      | [blank]  | random sku lot promotion 50 inventory api | Dry 1 day(s)     | 1.0 F - 1.0 F | 5           | 5          | 5      | [blank] |

    And Switch to tab by title "Promotions"
    And Admin remove value on Input "Inventory lot"
    And Admin choose options on dropdown "Inventory lot" input with value "Auto brand create product"
      | option                                    |
      | random sku lot promotion 50 inventory api |
    And Admin remove value on Input "Inventory lot"
    And Admin choose options on dropdown "Inventory lot" input with value "random product promotion 50 inventory api"
      | option                                    |
      | random sku lot promotion 50 inventory api |
    And Admin remove value on Input "Inventory lot"
    And Admin choose options on dropdown "Inventory lot" input with value "random sku promotion inventory api"
      | option                                    |
      | random sku lot promotion 50 inventory api |

    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal |
      | Auto Short-dated 50 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 50 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin go to promotion detail "Auto Short-dated 50 Promotion"
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         |
    And Check item on Promotion detail
      | product                                   | sku                                | brand                     |
      | random product promotion 50 inventory api | random sku promotion inventory api | Auto brand create product |

#    Create subtraction
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 5        | Autotest |

    And Admin close dialog form
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | [blank] | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And BAO_ADMIN9 input invalid "Inventory lot"
      | value                                     |
      | random product promotion 50 inventory api |

    And Admin search promotion by Promotion Name "Auto Short-dated 50 Promotion"
    And Admin delete promotion by skuName ""
   # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product promotion 50 inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product promotion 50 inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product promotion 50 inventory api" by api
    And Admin search product name "random product promotion 50 inventory api" by api
    And Admin delete product name "random product promotion 50 inventory api" by api

  @Promotion @PROMOTION_96
  Scenario:Verify that admin edits information of a normal promotion successfully: Edit Inventory Lot
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 96 Promotion"
    And Admin delete promotion by skuName ""
   # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product promotion inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product promotion inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product promotion inventory api" by api
    And Admin search product name "random product promotion inventory api" by api
    And Admin delete product name "random product promotion inventory api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product promotion inventory api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku promotion inventory api" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                               | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku promotion inventory api | random             | 5        | random sku lot promotion inventory api | 99           | Plus1        | Plus1       | [blank] |

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU   | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU               | store     | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 96 Promotion | Auto Description | Short-dated | currentDate | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | Auto_Check Promotions | Bao store | Percentage | 50     | [blank]      | Bao Buyer Company    | [blank]              |
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Admin process overlap promotion
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal |
      | Auto Short-dated 96 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 96 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     | createdBy                  | createdOn   |
      | Auto Short-dated 96 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Bao store | Admin: bao9@podfoods.co on | currentDate |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Add Inventory lot to promo
      | lotCode                                |
      | random sku lot promotion inventory api |
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate |
      | Auto Short-dated 96 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         |
    And Check item on Promotion detail
      | product                                | sku                                | brand                     |
      | random product promotion inventory api | random sku promotion inventory api | Auto brand create product |
    And Admin remove value on Input "Inventory lot"
    And Admin close dialog form
    And Verify promotion info in Promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store     | createdBy                  | createdOn   |
      | Auto Short-dated 96 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Bao store | Admin: bao9@podfoods.co on | currentDate |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 50     |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |

    And Add Inventory lot to promo
      | lotCode                                |
      | random sku lot promotion inventory api |
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate |
      | Auto Short-dated 96 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         |
    And Check item on Promotion detail
      | product                                | sku                                | brand                     |
      | random product promotion inventory api | random sku promotion inventory api | Auto brand create product |
    And Update promo success

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+autobuyer47@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                 | orderBrand | time    |
      | Auto brand create product | No         | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo | start       | expired     | skuExpiryDate |
      | Short dated | $5.00         | 1 Case          | [blank]   | currentDate | currentDate | Plus1         |
    And Clear cart to empty in cart before
    And Search Brands by name "Auto brand create product"
    Then Verify promo preview "Short dated" of product "random product promotion inventory api" in "Product page"
      | name                               | type        | price | caseLimit | expiryDate |
      | random sku promotion inventory api | SHORT-DATED | $5.00 | [blank]   | Plus1      |
    And HEAD_BUYER_PE go to catalog "All"
    And Buyer Search product by name "random product promotion inventory api"
    Then Verify promo preview "Short dated" of product "random product promotion inventory api" in "Catalog page"
      | name                               | type        | price | caseLimit |
      | random sku promotion inventory api | SHORT-DATED | $5.00 | [blank]   |
    And Verify Promotional Discount of "random product promotion inventory api" and sku "random sku promotion inventory api" in product detail
      | unitPrice | currentPrice | oldPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $5.00     | $5.00        | $10.00   | Short-dated Promotion | 50% off  | $5.00    | [blank]   | 50%                |

  @Promotion @PROMOTION_117
  Scenario: Verify that admin duplicate a Short-dated promotion and edit with value information
    Given NGOCTX login web admin by api
      | email             | password  |
      | bao22@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Short-dated 50 Promotion"
    And Admin delete promotion by skuName ""
   # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product promotion 50 inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product promotion 50 inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product promotion 50 inventory api" by api
    And Admin search product name "random product promotion 50 inventory api" by api
    And Admin delete product name "random product promotion 50 inventory api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                      | brand_id |
      | random product promotion 50 inventory api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku promotion inventory api" of product ""
    And Admin create inventory api1
      | index | sku                                | product_variant_id | quantity | lot_code                                  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random sku promotion inventory api | random             | 5        | random sku lot promotion 50 inventory api | 99           | Plus1        | Plus1       | [blank] |

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Admin click Create New Promotion to show form
    And Create promotion
      | name                          | description      | type        | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | specSKU | store   | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]   | [blank]    | [blank]   | 1           | currentDate | currentDate | Yes        | [blank] | [blank] | Percentage | 50     | [blank]      | [blank]              | [blank]              |
    And Add Inventory lot to promo
      | lotCode                                   |
      | random sku lot promotion 50 inventory api |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success

    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal |
      | Auto Short-dated 50 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 50 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto Short-dated 50 Promotion"
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate | inventoryLot                              |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         | random sku lot promotion 50 inventory api |
    And Check item on Promotion detail
      | product                                   | sku                                | brand                     |
      | random product promotion 50 inventory api | random sku promotion inventory api | Auto brand create product |
    And Duplicate promo success
    And Admin process overlap promotion
    And Search promotion by info
      | name                          | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal |
      | Auto Short-dated 50 Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     |
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 50 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Short-dated 50 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |

    And Admin click duplicate promotion "Auto Short-dated 50 Promotion"
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate | inventoryLot                              |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         | random sku lot promotion 50 inventory api |
    And Check item on Promotion detail
      | product                                   | sku                                | brand                     |
      | random product promotion 50 inventory api | random sku promotion inventory api | Auto brand create product |
    And Admin remove value on Input "Inventory lot"
    And Click on dialog button "Duplicate"
    And BAO_ADMIN9 check dialog message
      | No SKU is selected for this promotion. |
    And Click on dialog button "Cancel"
    And Add SKU to promo
      | specSKU               |
      | Auto_Check Promotions |
    And Click on dialog button "Duplicate"
    And Admin process overlap promotion
    Then Verify promotion show in All promotion page
      | name                          | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Short-dated 50 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Short-dated 50 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
      | Auto Short-dated 50 Promotion | Short-dated | CHI    | currentDate | currentDate | [blank]    | [blank]   |
    And Admin click duplicate promotion "Auto Short-dated 50 Promotion"
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | store   |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | [blank] |
    And Check item on Promotion detail
      | product               | sku                   |
      | Auto Check promotions | Auto_Check Promotions |
    And Add Inventory lot to promo
      | lotCode                                   |
      | random sku lot promotion 50 inventory api |
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         |
    And Check item on Promotion detail
      | product                                   | sku                                | brand                     |
      | random product promotion 50 inventory api | random sku promotion inventory api | Auto brand create product |
    And Click on dialog button "Duplicate"
    And Admin process overlap promotion
    And Admin click duplicate promotion "Auto Short-dated 50 Promotion"
    And Admin verify promotion detail
      | name                          | description      | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | skuExpiryDate | inventoryLot                              |
      | Auto Short-dated 50 Promotion | Auto Description | Short-dated | [blank]    | [blank]   | 1           | currentDate | currentDate | is-checked | Plus1         | random sku lot promotion 50 inventory api |
    And Check item on Promotion detail
      | product                                   | sku                                | brand                     |
      | random product promotion 50 inventory api | random sku promotion inventory api | Auto brand create product |
    And Admin search promotion by Promotion Name "Auto Short-dated 50 Promotion"
    And Admin delete promotion by skuName ""
   # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                           | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | random product promotion 50 inventory api | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "random product promotion 50 inventory api" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin delete order by sku of product "random product promotion 50 inventory api" by api
    And Admin search product name "random product promotion 50 inventory api" by api
    And Admin delete product name "random product promotion 50 inventory api" by api

  @Promotion @PROMOTION_39_
  Scenario: Check the filter function
     # Reset search filter full textbox
    Given BAO_ADMIN20 login web admin by api
      | email             | password  |
      | bao20@podfoods.co | 12345678a |
    And Admin filter visibility with id "91" by api
      | q[name]                      |
      | q[store_id]                  |
      | q[buyer_company_id]          |
      | q[product_name]              |
      | q[brand_id]                  |
      | q[expires_at]                |
      | q[promo_action_type]         |
      | q[type]                      |
      | q[excluded_store_id]         |
      | q[excluded_buyer_company_id] |
      | q[starts_at]                 |
      | q[product_variant_id]        |
      | q[region_id]                 |
    And Admin delete filter preset of screen id "91" by api
    Given BAO_ADMIN20 open web admin
    When BAO_ADMIN20 login to web with role Admin
    And BAO_ADMIN20 navigate to "Promotions" to "All promotions" by sidebar
#    And Search promotion by info
#      | name                          | type    | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal |
#      | Auto Short-dated 50 Promotion | [blank] | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     |

    And Admin uncheck field of edit visibility in search
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore | isStackDeal | type    | excludeStore | excludeBuyerCompany | productName | startAfter | region  |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       | [blank]     | [blank] | [blank]      | [blank]             | [blank]     | [blank]    | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore | isStackDeal | type    | excludeStore | excludeBuyerCompany | productName | startAfter | region  |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       | [blank]     | [blank] | [blank]      | [blank]             | [blank]     | [blank]    | [blank] |

    # Verify uncheck all field search
    When Admin uncheck field of edit visibility in search
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore | isStackDeal | type    | excludeStore | excludeBuyerCompany | productName | startAfter | region  |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       | [blank]     | [blank] | [blank]      | [blank]             | [blank]     | [blank]    | [blank] |
    Then Admin verify field search in edit visibility
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore | isStackDeal | type    | excludeStore | excludeBuyerCompany | productName | startAfter | region  |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       | [blank]     | [blank] | [blank]      | [blank]             | [blank]     | [blank]    | [blank] |
    And Admin uncheck field of edit visibility in search
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       |
    Then Admin verify field search uncheck all in edit visibility
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       |
    Then Admin verify field search in edit visibility
      | isStackDeal | type    | excludeStore | excludeBuyerCompany | productName | startAfter | region  |
      | [blank]     | [blank] | [blank]      | [blank]             | [blank]     | [blank]    | [blank] |
    And Admin uncheck field of edit visibility in search
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       |
    Then Admin verify field search in edit visibility
      | name    | includeStore | includeBuyerCompany | brand   | skuNameItemCode | expiresBefore |
      | [blank] | [blank]      | [blank]             | [blank] | [blank]         | [blank]       |
    And Search promotion by info
      | name                                | type | store   | brand   | productName                 | skuName | region  | startAt | expireAt | isStackDeal |
      | Auto Promotion check multiple order | TPR  | [blank] | [blank] | Auto Product Multiple Order | [blank] | [blank] | [blank] | [blank]  | [blank]     |

    And Admin save filter by info
      | filterName | type               |
      | [blank]    | Save as new preset |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field       | message                         |
      | Preset name | Please enter name filter preset |
    And Admin close dialog form
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin reset filter
    And BAO_ADMIN20 check value of field
      | field | value   |
      | Name  | [blank] |
      | Type  | -       |
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN20 check value of field
      | field        | value                               |
      | Name         | Auto Promotion check multiple order |
      | Type         | TPR                                 |
      | Product name | Auto Product Multiple Order         |

    And Admin save filter by info
      | filterName | type                  |
      | [blank]    | Reset existing preset |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field       | message                       |
      | Preset name | Please select a filter preset |
    And Admin close dialog form
    And Admin reset filter
    And Search promotion by info
      | name                                | type    | store   | brand   | productName | skuName                  | region  | startAt | expireAt | isStackDeal |
      | Auto Promotion check multiple order | [blank] | [blank] | [blank] | [blank]     | AT SKU Multiple Order 28 | [blank] | [blank] | [blank]  | [blank]     |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin reset filter
    And Admin choose filter preset is "AutoTest1"
    And BAO_ADMIN20 check value of field
      | field                | value                               |
      | Name                 | Auto Promotion check multiple order |
      | Type                 | -                                   |
      | SKU name / Item code | AT SKU Multiple Order 28            |
    Then Verify promotion show in All promotion page
      | name                                | type | region | startAt    | expireAt | usageLimit | CaseLimit |
      | Auto Promotion check multiple order | TPR  | CHI    | 2023-10-02 | [blank]  | [blank]    | [blank]   |
    And Admin delete filter preset is "AutoTest1"

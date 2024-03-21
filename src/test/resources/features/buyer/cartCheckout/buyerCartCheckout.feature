@feature=buyer-cart-checkout
Feature: Buyer Cart Checkout
  # Warehouse 91 - NewYork

  @B_CART_01
  Scenario: Check the Cart side-bar and Cart button on the header bar is NOT displayed
    # xóa promo trong feature
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx805@podfoods.co | 12345678a |
    And Admin search promotion by product Name "AT Product B Checkout 01"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "AT Product B Checkout 14"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "AT Product B Checkout 47b"
    And Admin delete promotion by skuName ""
    And Admin search promotion by product Name "AT Product B Checkout 70"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Pod sponsor B Cart 71"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Pod sponsor B Cart 103"
    And Admin delete promotion by skuName ""

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stcheckout01hny01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And Head buyer verify cart button is not display
    And HEAD_BUYER quit browser

  @B_CART_02
  Scenario: Check information displayed on the Items list on the Cart page
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01b | 1      |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01  | $10.00 | 1        |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 1        |
    And BUYER quit browser

  @B_CART_03
  Scenario: Check displayed position of items shown on the Pod Direct Items section
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout12pdn01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout12pdn01@podfoods.co" pass "12345678a" role "buyer"
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01b | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 02 | AT Brand B Checkout 01 | AT SKU B Checkout 02 | 3      |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 1        | $20.00 |
      | AT Brand B Checkout 01 | AT Product B Checkout 02 | AT SKU B Checkout 02  | $20.00 | 3        | $60.00 |
    And BUYER quit browser

  @B_CART_012
  Scenario: Check displayed position of items shown on the Pod Direct Items section
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout12pdn02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout12pdn02@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 12a", sku "AT SKU B Checkout 12a" and add to cart with amount = "5"
    And Search product by name "AT Product B Checkout 12b", sku "AT SKU B Checkout 12b" and add to cart with amount = "5"
    And Search product by name "AT Product B Checkout 12c", sku "AT SKU B Checkout 12c" and add to cart with amount = "10"
    And Search product by name "AT Product B Checkout 12d", sku "AT SKU B Checkout 12d" and add to cart with amount = "10"
    And Search product by name "AT Product B Checkout 12c", sku "AT SKU B Checkout 12e" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                   | product                   | sku                   | price  | quantity |
      | AT Brand B Checkout 01  | AT Product B Checkout 12a | AT SKU B Checkout 12a | $20.00 | 5        |
      | AT Brand B Checkout 01  | AT Product B Checkout 12b | AT SKU B Checkout 12b | $20.00 | 5        |
      | AT Brand B Checkout 12c | AT Product B Checkout 12c | AT SKU B Checkout 12c | $10.00 | 10       |
      | AT Brand B Checkout 12d | AT Product B Checkout 12d | AT SKU B Checkout 12d | $10.00 | 10       |
      | AT Brand B Checkout 12c | AT Product B Checkout 12c | AT SKU B Checkout 12e | $10.00 | 1        |
    And BUYER quit browser

  @B_CART_033
  Scenario: Verify the Other brands with MOQ block by details
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout01ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout01ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout 01b" and add to cart with amount = "1"
    And Search product by name "AT Product B Checkout 02", sku "AT SKU B Checkout 02" and add to cart with amount = "3"
    And Search product by name "AT Product B Checkout 02", sku "AT SKU B Checkout 02b" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 1        |
      | AT Brand B Checkout 01 | AT Product B Checkout 02 | AT SKU B Checkout 02  | $20.00 | 3        |
      | AT Brand B Checkout 01 | AT Product B Checkout 02 | AT SKU B Checkout 02b | $20.00 | 1        |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35096 | AT SKU B Checkout 02 | 1        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity | moq     |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 1        | [blank] |
      | AT Brand B Checkout 01 | AT Product B Checkout 02 | AT SKU B Checkout 02  | $20.00 | 1        | 3       |
      | AT Brand B Checkout 01 | AT Product B Checkout 02 | AT SKU B Checkout 02b | $20.00 | 1        | 3       |
    And BUYER quit browser

  @B_CART_034
  Scenario: Check display of price/case shown for each SKU
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx800@podfoods.co | 12345678a |
       # Active store spec
    Then Admin choose store's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 1759 | 92400              | 2022-09-20 | 2025-09-24 |
    And Admin choose stores attributes to inactive
      | id    | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 92400 | 53        | 3029     | 35105              | 3000             | 3000       | in_stock     | active | [blank]                  |
    Then Admin active selected stores specific
     # Active buyer company spec
    And Admin choose company's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 2877 | 92399              | 2022-09-20 | 2024-09-25 |
    Then Admin choose company attributes to active
      | id    | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 92399 | 53        | 2468             | 35105              | 2000             | 2000       | in_stock     | active | [blank]                  |
    Then Admin active selected company specific
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout 34 | 35105              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

       # Create Order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout34ny02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8478      | 35105 | 1        |
    And Checkout cart with payment by "invoice" by API
     # Verify Buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny02@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch               | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 12a | AT Brand B Checkout 01 | AT SKU B Checkout 34 | 1      |
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 12a | AT SKU B Checkout 34 | $30.00 | 1        |
      # Active store spec
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx800@podfoods.co | 12345678a |
    Then Admin choose store's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 1759 | 92400              | 2022-08-20 | 2022-08-20 |
    And Admin choose stores attributes to inactive
      | id    | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 92400 | 53        | 3029     | 35105              | 3000             | 3000       | in_stock     | inactive | [blank]                  |
    Then Admin inactive selected stores specific
    # Verify Buyer
    And BUYER refresh page
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 12a | AT SKU B Checkout 34 | $20.00 | 1        |
    And BUYER quit browser

  @B_CART_037
  Scenario: Check validate of quantity box
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx801@podfoods.co | 12345678a |
    And Change state of SKU id: "35095" to "active"
    And Update regions info of SKU "35095"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92366 | 55        | 35095              | 2000             | 2000       | in_stock     | active |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout01ny02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout01ny02@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout 01b" and add to cart with amount = "1"
    And Buyer change quantity of sku with info
      | skuID | sku                   | quantity |
      | 35095 | AT SKU B Checkout 01b | 1        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 1        |
    And Buyer change quantity of sku by button in before cart
      | skuID | sku                   | increase | decrease |
      | 35095 | AT SKU B Checkout 01b | 1        | [blank]  |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 2        |
    And Buyer change quantity of sku by button in before cart
      | skuID | sku                   | increase | decrease |
      | 35095 | AT SKU B Checkout 01b | [blank]  | 1        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 1        |
    And Buyer change quantity of sku with info
      | skuID | sku                   | quantity   |
      | 35095 | AT SKU B Checkout 01b | 1000000000 |
    Then Buyer verify message after change quantity in before cart is "is out of range for ActiveModel::Type::Integer with limit 4 bytes"
    And Buyer change quantity of sku by button in before cart
      | skuID | sku                   | increase | decrease |
      | 35095 | AT SKU B Checkout 01b | [blank]  | 1        |
    # update sku to launching soon
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx801@podfoods.co | 12345678a |
    And Update regions info of SKU "30949"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92366 | 55        | 35095              | 2000             | 2000       | coming_soon  | active |
    # Buyer verify
    And BUYER refresh page
    And Buyer change quantity of sku with info
      | skuID | sku                   | quantity |
      | 35095 | AT SKU B Checkout 01b | 2        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 2        |
    # Change SKU to inactive
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx801@podfoods.co | 12345678a |
    And Change state of SKU id: "35122" to "inactive"
     # Buyer verify
    And BUYER refresh page
    And Buyer change quantity of sku with info
      | skuID | sku                   | quantity |
      | 35095 | AT SKU B Checkout 01b | 3        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01b | $20.00 | 3        |
    And BUYER quit browser

  @B_CART_043
  Scenario: Check display condition of pre-promotion price/case, Item Total, and post-promotion price/case, Item Total (when has promotion)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx802@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 01"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 35130 | 3031      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description            | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Checkout 01 | AT Promo B Checkout 01 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout 43" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 43 | $18.00   | $20.00   | 1        |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35130 | AT SKU B Checkout 43 | 2        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 43 | $18.00   | $20.00   | 2        |
    # Delete promotion after testcase
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx802@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 01"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_044
  Scenario: Check display condition of pre-promotion price/case, Item Total, and post-promotion price/case, Item Total (when promotion has case minimum < case limit)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx803@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 02"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 35133 | 3031      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description            | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Checkout 02 | AT Promo B Checkout 02 | currentDate | currentDate | [blank]     | 2          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn02@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout 44" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 44 | $18.00   | $20.00   | 1        |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35133 | AT SKU B Checkout 44 | 2        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 44 | $18.00   | $20.00   | 2        |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35133 | AT SKU B Checkout 44 | 3        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 44 | $20.00 | 3        | $56.00 |
    # Delete promotion after testcase
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx803@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 02"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_045
  Scenario: Check display condition of pre-promotion price/case, Item Total, and post-promotion price/case, Item Total (when promotion has case minimum < case limit)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx804@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 03"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 61909 | 3031      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description            | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Checkout 03 | AT Promo B Checkout 03 | currentDate | currentDate | [blank]     | 3          | 4                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn03@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout 45" and add to cart with amount = "3"
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 45 | $20.00 | 3        |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61909 | AT SKU B Checkout 45 | 4        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 45 | $20.00 | 4        | $74.00 |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61909 | AT SKU B Checkout 45 | 6        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total   |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 45 | $20.00 | 6        | $114.00 |
    # Delete promotion after testcase
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx803@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 03"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_013
  Scenario: Check information displayed on each brand with MOV block
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn04@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product "AT Product B Checkout 13" with sku "AT SKU B Checkout 13" then open popup cart
    And Buyer add sku to cart in popup cart
      | sku                  | quantity |
      | AT SKU B Checkout 13 | 1        |
    And Buyer add to cart in popup cart
    And Buyer verify MOV alert in popup cart
      | title                          | more   | notice                                                                                                                                                               |
      | Minimum Order Value is not met | $90.00 | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |
    And Buyer update cart of MOV alert with info
      | sku                   | quantity |
      | AT SKU B Checkout 13  | 5        |
      | AT SKU B Checkout 13b | 5        |
    And Buyer update cart of MOV alert success
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                   | price  | quantity | total  |
      | AT Brand B Checkout 13 | AT Product B Checkout 13 | AT SKU B Checkout 13  | $10.00 | 5        | $50.00 |
      | AT Brand B Checkout 13 | AT Product B Checkout 13 | AT SKU B Checkout 13b | $10.00 | 5        | $50.00 |
    And BUYER quit browser

  @B_CART_014 @B_CART_015
  Scenario: Check display of block name field on a brand with MOV block
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn05@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn05@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 13", sku "AT SKU B Checkout 13" and add to cart with amount = "10"
    And Search product by name "AT Product B Checkout 14", sku "AT SKU B Checkout 14" and add to cart with amount = "1"
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total   |
      | AT Brand B Checkout 13 | AT Product B Checkout 13 | AT SKU B Checkout 13 | $10.00 | 10       | $100.00 |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 14 | $10.00 | 1        | $10.00  |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35136 | AT SKU B Checkout 13 | 7        |
    And Buyer verify mov alert in catalog
      | title                           | brand                  | current | target      | description                                                                         |
      | Minimum order value is not met. | AT Brand B Checkout 13 | $80.00  | $100.00 MOV | Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |
    And BUYER quit browser

  @B_CART_016
  Scenario: Check display condition of The MOV message on a Brand with MOV block when MOV for buyer region is set - promotion no limit
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx804@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 16"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 40960 | 3031      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Cart 16 | AT Promo B Cart 16 | Minus1    | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn06@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn06@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 14", sku "AT SKU B Checkout 15" and add to cart with amount = "10"
    Then Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 15 | $9       | $10.00   | 10       | $90.00 |
    And Buyer verify mov alert in catalog
      | title                           | brand                  | current | target      | description                                                                         |
      | Minimum order value is not met. | AT Brand B Checkout 14 | $90.00  | $100.00 MOV | Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |
    And Buyer verify button Explore SKUs from this brand of product "AT Brand B Checkout 14's products"

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx804@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 16"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_017
  Scenario: Check display condition of The MOV message on a Brand with MOV block when MOV for buyer region is set - promotion case minimum < case limit
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx805@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 17"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 40961 | 3031      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Cart 17 | AT Promo B Cart 17 | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |

    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn07@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn07@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 14", sku "AT SKU B Checkout 17" and add to cart with amount = "10"
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 17 | $9       | $10.00   | 10       | $97.00 |
    And Buyer verify mov alert in catalog
      | title                           | brand                  | current | target      | description                                                                         |
      | Minimum order value is not met. | AT Brand B Checkout 14 | $97.00  | $100.00 MOV | Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx805@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 17"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_018
  Scenario: Check display condition of The MOV message on a Brand with MOV block when MOV for buyer region is set - promotion case minimum >= case limit
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx806@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 18"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 61910 | 3031      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Cart 18 | AT Promo B Cart 18 | currentDate | currentDate | [blank]     | 3          | 4                | true           | [blank] | default    | [blank]       |

    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn08@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn08@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 14", sku "AT SKU B Checkout 18" and add to cart with amount = "11"
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61910 | AT SKU B Checkout 18 | 10       |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 18 | $9       | $10.00   | 10       | $97.00 |
    And Buyer verify mov alert in catalog
      | title                           | brand                  | current | target      | description                                                                         |
      | Minimum order value is not met. | AT Brand B Checkout 14 | $97.00  | $100.00 MOV | Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx806@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 18"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_020
  Scenario: Check information displayed for each line-items on a brand with MOV block (overview)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx806@podfoods.co | 12345678a |
     # Active store spec
    Then Admin choose store's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 9784 | 106607             | 2022-09-20 | 2025-09-24 |
    And Admin choose stores attributes to inactive
      | id     | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 106607 | 55        | 3031     | 35135              | 3000             | 3000       | in_stock     | active | [blank]                  |
    Then Admin active selected stores specific
     # Active buyer company spec
    And Admin choose company's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 9783 | 106606             | 2022-09-20 | 2024-09-25 |
    Then Admin choose company attributes to active
      | id     | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 106606 | 55        | 2468             | 35135              | 2000             | 2000       | in_stock     | active | [blank]                  |
    Then Admin active selected company specific
    # Clear cart before
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn09@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn09@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 13 | AT Brand B Checkout 13 | AT SKU B Checkout 19 | 4      |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total   |
      | AT Brand B Checkout 13 | AT Product B Checkout 13 | AT SKU B Checkout 19 | $30.00 | 4        | $120.00 |
    # Deactive store spec
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx806@podfoods.co | 12345678a |
    Then Admin choose store's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 9784 | 106607             | 2022-09-20 | 2022-09-20 |
    And Admin choose stores attributes to inactive
      | id     | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 106607 | 55        | 3031     | 35135              | 3000             | 3000       | in_stock     | inactive | [blank]                  |
    Then Admin inactive selected stores specific
    # Verify
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35135 | AT SKU B Checkout 19 | 5        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total   |
      | AT Brand B Checkout 13 | AT Product B Checkout 13 | AT SKU B Checkout 19 | $20.00 | 5        | $100.00 |
    #  Deactive buyer company spec
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx806@podfoods.co | 12345678a |
    And Admin choose company's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 9783 | 106606             | 2022-09-19 | 2022-09-20 |
    Then Admin choose company attributes to inactive
      | id     | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 106606 | 55        | 2468             | 35135              | 2000             | 2000       | in_stock     | inactive | [blank]                  |
    Then Admin inactive selected company specific

     # Verify
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35135 | AT SKU B Checkout 19 | 10       |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total   |
      | AT Brand B Checkout 13 | AT Product B Checkout 13 | AT SKU B Checkout 19 | $10.00 | 10       | $100.00 |
    And BUYER quit browser

  @B_CART_021
  Scenario: Check validate of quantity box
     # update sku to launching soon
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx807@podfoods.co | 12345678a |
    And Change state of SKU id: "40963" to "active"
    And Update regions info of SKU "40963"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 100564 | 55        | 40963              | 1000             | 1000       | in_stock     | active |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout01ny03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout01ny03@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 14", sku "AT SKU B Checkout 20" and add to cart with amount = "10"
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 40963 | AT SKU B Checkout 20 | 1        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 20 | $10.00 | 1        |
    And Buyer change quantity of sku by button in before cart
      | skuID | sku                  | increase | decrease |
      | 40963 | AT SKU B Checkout 20 | 2        | [blank]  |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 20 | $10.00 | 2        | $20.00 |
    And Buyer change quantity of sku by button in before cart
      | skuID | sku                  | increase | decrease |
      | 40963 | AT SKU B Checkout 20 | [blank]  | 1        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 20 | $10.00 | 1        | $10.00 |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity   |
      | 40963 | AT SKU B Checkout 20 | 1000000000 |
    Then Buyer verify message after change quantity in before cart is "is out of range for ActiveModel::Type::Integer with limit 4 bytes"
    And Buyer change quantity of sku by button in before cart
      | skuID | sku                  | increase | decrease |
      | 40963 | AT SKU B Checkout 20 | [blank]  | 1        |
    # update sku to launching soon
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx807@podfoods.co | 12345678a |
    And Update regions info of SKU "30949"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 100564 | 55        | 40963              | 1000             | 1000       | sold_out     | active |
    # Buyer verify
    And BUYER refresh page
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 40963 | AT SKU B Checkout 20 | 2        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 20 | $10.00 | 2        |
    # Change SKU to inactive
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx807@podfoods.co | 12345678a |
    And Change state of SKU id: "35122" to "inactive"
     # Buyer verify
    And BUYER refresh page
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 40963 | AT SKU B Checkout 20 | 3        |
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 20 | $10.00 | 3        |
    # Change region
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx807@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 100564 | 55        | 40963              | 2000             | 2000       | in_stock     | active |
    And BUYER refresh page
    And Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity |
      | AT Brand B Checkout 14 | AT Product B Checkout 14 | AT SKU B Checkout 20 | $20.00 | 3        |
    And BUYER quit browser

  @B_CART_047
  Scenario: Check information displayed for each line-items on the Pod Express Items section
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout01ny04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout01ny04@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product "AT Product B Checkout 47b" with sku "AT SKU B Checkout 47d" then open popup cart
    And Buyer add sku to cart in popup cart
      | sku                   | quantity |
      | AT SKU B Checkout 47b | 1        |
      | AT SKU B Checkout 47d | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 1 case  |
    And Buyer add sku to cart in popup cart
      | sku                   | quantity |
      | AT SKU B Checkout 47b | 1        |
      | AT SKU B Checkout 47d | 2        |
    And Buyer add to cart in popup cart
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                   | price  | quantity | total  | moq | skuID |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 47b | $10.00 | 1        | $10.00 | 3   | 35217 |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 47d | $10.00 | 2        | $20.00 | 3   | 35218 |
    And BUYER quit browser

  @B_CART_058
  Scenario: Check display condition of pre-promotion price/case, Item Total, and post-promotion price/case, Item Total (when no usage limit is set for promotions)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx808@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 04"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61911 | 3029      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description            | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Checkout 04 | AT Promo B Checkout 04 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout34ny03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny03@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 58" and add to cart with amount = "3"
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 58 | $9.00    | $10.00   | 3        | $27.00 |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61911 | AT SKU B Checkout 58 | 2        |
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 58 | $9.00    | $10.00   | 2        | $18.00 |
    # Delete promotion after testcase
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx808@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 04"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_059
  Scenario: Check display condition of pre-promotion price/case, Item Total, and post-promotion price/case, Item Total (when promotion has case minimum < case limit)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx809@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 05"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61912 | 3029      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description            | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Checkout 05 | AT Promo B Checkout 05 | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | default    | [blank]       |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout34ny04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny04@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 59" and add to cart with amount = "6"
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 59 | $9       | $10.00   | 6        | $57.00 |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61912 | AT SKU B Checkout 59 | 3        |
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 59 | $9       | $10.00   | 3        | $27.00 |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61912 | AT SKU B Checkout 59 | 2        |
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 59 | $9       | $10.00   | 2        | $18.00 |
    # Delete promotion after testcase
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx809@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 05"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_060
  Scenario: Check display condition of pre-promotion price/case, Item Total, and post-promotion price/case, Item Total (when promotion has case minimum > case limit)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx810@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 06"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61913 | 3029      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                   | description            | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Checkout 06 | AT Promo B Checkout 06 | currentDate | currentDate | [blank]     | 4          | 3                | true           | [blank] | default    | [blank]       |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout34ny05@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny05@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 60" and add to cart with amount = "6"
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 60 | $9       | $10.00   | 6        | $56.00 |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61913 | AT SKU B Checkout 60 | 4        |
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 60 | $9       | $10.00   | 4        | $36.00 |
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 61913 | AT SKU B Checkout 60 | 2        |
    And Verify item on cart tab on right side
      | brand                  | product                   | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 60 | $10.00 | 2        | $20.00 |
    # Delete promotion after testcase
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx810@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Checkout 06"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_062 @B_CART_063
  Scenario: Check system response when tap on the Remove button on cart side bar
     # Change SKU to inactive
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx811@podfoods.co | 12345678a |
    And Change state of SKU id: "35225" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92554 | 53        | 35225              | 1000             | 1000       | in_stock     | active |
    And Change state of SKU id: "35226" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92556 | 53        | 35226              | 1000             | 1000       | in_stock     | active |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout 62 | 35225              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
       # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout 62b | 35226              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Clear cart
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout34ny06@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny06@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 62" and add to cart with amount = "6"
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 62b" and add to cart with amount = "6"
    Then Buyer click on remove button of sku "35225"
    And Buyer remove sku "35225" in before cart
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 62" and add to cart with amount = "6"

    # Change SKU to inactive
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx811@podfoods.co | 12345678a |
    And Change state of SKU id: "35225" to "inactive"
    And Change state of SKU id: "35226" to "draft"

    # Verify
    And Switch to actor BUYER
    And Buyer remove sku "35225" in before cart
#    And Buyer remove sku "35226" in before cart

    # Change SKU to active
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx811@podfoods.co | 12345678a |
    And Change state of SKU id: "35225" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 92554 | 53        | 35225              | 1000             | 1000       | in_stock     | active |
    And Change state of SKU id: "35226" to "active"

    # Add to cart
    And Switch to actor BUYER
    And BUYER refresh browser
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 62" and add to cart with amount = "6"
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 62b" and add to cart with amount = "6"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer remove sku "AT SKU B Checkout 62" in cart detail
    And Buyer remove sku "AT SKU B Checkout 62b" in cart detail
    And BUYER quit browser

  @B_CART_067
  Scenario: Verify display of an item in cart when admin changes its region from PD to PE and vice versa
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx812@podfoods.co | 12345678a |
     # Change SKU to active
    And Change state of SKU id: "45484" to "active"
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 106608 | 55        | 45484              | 2000             | 2000       | in_stock     | active   |
      | 106609 | 53        | 45484              | 1000             | 1000       | in_stock     | inactive |
     # Change SKU to active
    And Change state of SKU id: "35227" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 92559 | 55        | 35227              | 2000             | 2000       | in_stock     | active   |
      | 92558 | 53        | 35227              | 1000             | 1000       | in_stock     | inactive |
    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout34ny07@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny07@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 14", sku "AT SKU B Checkout 67a" and add to cart with amount = "10"
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 67b" and add to cart with amount = "6"
    Then Verify item on cart tab on right side
      | brand                  | product                   | sku                   | price  | quantity | total   |
      | AT Brand B Checkout 14 | AT Product B Checkout 14  | AT SKU B Checkout 67a | $20.00 | 10       | $200.00 |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 67b | $20.00 | 6        | $120.00 |
      # Change SKU to active
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx812@podfoods.co | 12345678a |
    And Change state of SKU id: "45484" to "active"
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 106609 | 53        | 45484              | 1000             | 1000       | in_stock     | active   |
      | 106608 | 55        | 45484              | 2000             | 2000       | in_stock     | inactive |

     # Change SKU to active
    And Change state of SKU id: "35227" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 92558 | 53        | 35227              | 1000             | 1000       | in_stock     | active   |
      | 92559 | 55        | 35227              | 2000             | 2000       | in_stock     | inactive |

#    # Verify
#    And BUYER refresh page
#    Then Verify item on cart tab on right side
#      | brand                  | product                   | sku                   | price  | quantity | total  |
##      | AT Brand B Checkout 14 | AT Product B Checkout 14  | AT SKU B Checkout 67a | $10.00 | 10       | $100.00 |
#      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 67b | $10.00 | 6        | $60.00 |
#    And BUYER quit browser

  @B_CART_069
  Scenario: Verify display of an item in cart when admin changes its region from PD to PE and vice versa
    # Change MOV value
    Given NGOC_ADMIN_08 open web admin
    When NGOC_ADMIN_08 login to web with role Admin
    And NGOC_ADMIN_08 navigate to "Vendors" to "Companies" by sidebar
    And Admin go to vendor company "2027" by url
    And Admin edit region MOV of vendor company
      | region          | value |
      | Pod Direct East | 100   |
     # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn10@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 12e", sku "AT SKU B Checkout 12e" and add to cart with amount = "10"
    And Buyer change quantity of sku with info
      | skuID | sku                   | quantity |
      | 54121 | AT SKU B Checkout 12e | 9        |
    And Buyer verify mov alert in catalog
      | title                           | brand                   | current | target      | description                                                                         |
      | Minimum order value is not met. | AT Brand B Checkout 12e | $90.00  | $100.00 MOV | Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |
    # Change mov value
    And Switch to actor NGOC_ADMIN_08
    And Admin edit region MOV of vendor company
      | region          | value |
      | Pod Direct East | 50    |
    # Verify
    And Switch to actor BUYER
    And BUYER refresh page
    Then Buyer verify not meet mov alert in catalog
     # Change mov value
    And Switch to actor NGOC_ADMIN_08
    And Admin edit region MOV of vendor company
      | region          | value |
      | Pod Direct East | 1000  |
     # Verify
    And Switch to actor BUYER
    And BUYER refresh page
    And Buyer verify mov alert in catalog
      | title                           | brand                   | current | target        | description                                                                         |
      | Minimum order value is not met. | AT Brand B Checkout 12e | $90.00  | $1,000.00 MOV | Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |
    And BUYER quit browser

  @B_CART_070
  Scenario: Verify display of an item in cart when admin changes its applied MOQ value
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx813@podfoods.co | 12345678a |
    And Admin change MOQ value of product "8549" by API
      | id    | moq | product_id | region_id |
      | 82052 | 5   | 8549       | 53        |

     # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout34ny08@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 70", sku "AT SKU B Checkout 70" and add to cart with amount = "5"
    And Buyer change quantity of sku with info
      | skuID | sku                  | quantity |
      | 35230 | AT SKU B Checkout 70 | 4        |
    Then Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 70 | AT SKU B Checkout 70 | $10.00 | 4        | $40.00 |
    # Change mov value
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx813@podfoods.co | 12345678a |
    And Admin change MOQ value of product "8549" by API
      | id    | moq | product_id | region_id |
      | 82052 | 3   | 8549       | 53        |
    # Verify
    And BUYER refresh page
    Then Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 70 | AT SKU B Checkout 70 | $10.00 | 4        | $40.00 |
    # Change mov value
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx813@podfoods.co | 12345678a |
    And Admin change MOQ value of product "8549" by API
      | id    | moq | product_id | region_id |
      | 82052 | 6   | 8549       | 53        |
     # Verify
    And BUYER refresh page
    Then Verify item on cart tab on right side
      | brand                  | product                  | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 70 | AT SKU B Checkout 70 | $10.00 | 4        | $40.00 |
      # Change mov value
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx813@podfoods.co | 12345678a |
    And Admin change MOQ value of product "8549" by API
      | id    | moq | product_id | region_id |
      | 82052 | 5   | 8549       | 53        |
    And BUYER quit browser

  @B_CART_071
  Scenario: Check displayed information on the Order summary section (In case showing ALL fields in Order summary section)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx813@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 71"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Pod sponsor B Cart 71"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61914 | 3034      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Cart 71 | AT Promo B Cart 71 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |
    # Create pod-sponsor promotion
    And Admin add region by API
      | region           | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | New York Express | 53        | [blank] | 3034      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                           | description                    | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Pod sponsor B Cart 71 | AT Promo Pod sponsor B Cart 71 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |
     # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout70ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
     # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout70ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 70", sku "AT SKU B Checkout 71" and add to cart with amount = "5"
    Then Verify item on cart tab on right side
      | brand                  | product                  | sku                  | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 70 | AT SKU B Checkout 71 | $9.00    | $10.00   | 5        | $45.00 |
    Then Verify price in cart "before checkout"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax   | discount | specialDiscount | total  |
      | $50.00     | $30.00             | [blank]           | $5.00 | -$5.00   | -$4.50          | $75.50 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax   | discount | specialDiscount | total  |
      | $50.00     | $30.00             | [blank]           | $5.00 | -$5.00   | -$4.50          | $75.50 |

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx813@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 71"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Pod sponsor B Cart 71"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CART_073
  Scenario: Check when buyers are applied store SOS or global SOS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx814@podfoods.co | 12345678a |
     # Active SOS
    And Admin change status using SOS of store "3589" to "true"
    And Admin change info SOS of store "3589"
      | amount_cents | flat_fee_cents |
      | 50000        | 2500           |
    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout73ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
      # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout73ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 73" and add to cart with amount = "5"
    Then Verify item on cart tab on right side
      | brand                  | product                   | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 73 | $10.00 | 5        | $50.00 |
    Then Verify price in cart "before checkout"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | $50.00     | $25.00             | [blank]           | [blank] | $75.00 |
       # DeActive SOS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx814@podfoods.co | 12345678a |
    And Admin change status using SOS of store "3589" to "false"

    And BUYER refresh page
    Then Verify price in cart "before checkout"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | $50.00     | [blank]            | [blank]           | [blank] | $50.00 |
     # Active SOS
    And Admin change status using SOS of store "3589" to "true"
    And BUYER quit browser

  @B_CART_074
  Scenario: Check when buyers are applied store LS or global LS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx815@podfoods.co | 12345678a |
     # Active LS
    And Admin change status using LS of store "3590" to "true"
    And Admin change status using SOS of store "3590" to "true"
    And Admin change info SOS of store "3590"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout74ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
     # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout74ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 73" and add to cart with amount = "5"
    Then Verify item on cart tab on right side
      | brand                  | product                   | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 73 | $10.00 | 5        | $50.00 |
    Then Verify price in cart "before checkout"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | $50.00     | $30.00             | [blank]           | [blank] | $80.00 |
       # DeActive SOS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx815@podfoods.co | 12345678a |
    And Admin change status using LS of store "3590" to "false"
    And BUYER refresh page
    Then Verify price in cart "before checkout"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | $50.00     | $30.00             | [blank]           | [blank] | $80.00 |
     # Active SOS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx815@podfoods.co | 12345678a |
    And Admin change status using LS of store "3590" to "true"
    And BUYER quit browser

  @B_CART_075
  Scenario: Check hide Small order surcharge, Logistic surcharge field when SOS, LS = 0
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx816@podfoods.co | 12345678a |
     # Active LS
    And Admin change status using LS of store "3591" to "false"
    And Admin change status using SOS of store "3591" to "false"
    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout75ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

     # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout75ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 73" and add to cart with amount = "5"
    Then Verify item on cart tab on right side
      | brand                  | product                   | sku                  | price  | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 47b | AT SKU B Checkout 73 | $10.00 | 5        | $50.00 |
    Then Verify price in cart "before checkout"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | $50.00     | [blank]            | [blank]           | [blank] | $50.00 |
     # Active SOS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx816@podfoods.co | 12345678a |
    And Admin change status using LS of store "3591" to "true"
    And Admin change status using SOS of store "3591" to "true"
    And Admin change info SOS of store "3591"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
    And BUYER quit browser

  @B_CART_081
  Scenario: Check whether a promotion is applied or not when it is set for multiple stores, 1 SKU and usage limit > 1
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx818@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 81"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61915   | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]          | [blank]   | [blank] | 3038      | [blank]                    | [blank]           | [blank]            | [blank]                  |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Cart 81 | AT Promo B Cart 81 | currentDate | currentDate | 2           | [blank]    | 1                | true           | [blank] | default    | [blank]       |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout 81 | 61915              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
     # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout81ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

     # Verify buyer 1
    Given BUYER1 open web user
    When login to beta web with email "ngoctx+stcheckout80ny02@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 81" and add to cart with amount = "5"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    # Verify buyer 3
    Given BUYER23 open web user
    When login to beta web with email "ngoctx+stcheckout81ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 81" and add to cart with amount = "5"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx818@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 81"
    And Admin delete promotion by skuName ""
    And BUYER1 quit browser
    And BUYER23 quit browser

  @B_CART_082
  Scenario: Check whether a promotion is applied or not when it is set for multiple stores, 1 SKU and usage limit > 1 2
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx819@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 82"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 35268 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]          | [blank]   | 35269 | 3592      | [blank]                    | [blank]           | [blank]            | [blank]                  |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Cart 82 | AT Promo B Cart 82 | currentDate | currentDate | 2           | [blank]    | 1                | true           | [blank] | default    | [blank]       |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout 80a | 35268              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
     # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout82ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

     # Verify buyer 1
    Given BUYER1 open web user
    When login to beta web with email "ngoctx+stcheckout80ny03@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 80a" and add to cart with amount = "5"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    # Verify buyer 3
    Given BUYER23 open web user
    When login to beta web with email "ngoctx+stcheckout82ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 80b" and add to cart with amount = "5"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx819@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 82"
    And Admin delete promotion by skuName ""
    And BUYER1 quit browser
    And BUYER23 quit browser

  @B_CART_10
  Scenario: Check display condition of the Small order surcharge warning message
    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    # Verify buyer 1
    Given BUYER1 open web user
    When login to beta web with email "ngoctx+stcheckout80ny04@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 80a" and add to cart with amount = "80"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 800.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 800.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 800.00 |
    And BUYER1 quit browser

  @B_CART_101
  Scenario: Check display condition of the Small order surcharge warning message - PD item
    # Clear cart by api
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny05@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    # Verify buyer 1
    Given BUYER1 open web user
    When login to beta web with email "ngoctx+stcheckout80ny05@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 101" and add to cart with amount = "5"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 100.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 100.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 100.00 |
    And BUYER1 quit browser

  @B_CART_102
  Scenario: Check the content of Small order surcharge awareness
    # Clear cart by api
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout102ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    # Verify buyer 1
    Given BUYER1 open web user
    When login to beta web with email "ngoctx+stcheckout102ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 80a" and add to cart with amount = "5"
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Buyer verify message remove SOS "Add another $450.00 to remove the Small Order Surcharge!"
    And BUYER1 quit browser

  @B_CART_103
  Scenario: Check displayed information on the Order summary section (In case showing ALL fields in Order summary section) - PD item - PD Head buyer
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx821@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo B Cart 103"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Pod sponsor B Cart 103"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 35582 | 3042      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                | description         | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo B Cart 103 | AT Promo B Cart 103 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |
    # Create pod-sponsor promotion
    And Admin add region by API
      | region          | region_id | idSKU   | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                  |
      | Pod Direct East | 55        | [blank] | 3042      | [blank]                    | [blank]           | [blank]            | PromotionRules::Order |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                     | name                            | description                     | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::PodSponsored | AT Promo Pod sponsor B Cart 103 | AT Promo Pod sponsor B Cart 103 | currentDate | currentDate | [blank]     | [blank]    | 1                | [blank]        | [blank] | default    | [blank]       | false   |
     # Clear cart by api
    Given Buyer login web with by api
      | email                                 | password  |
      | ngoctx+stcheckout103pdn01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
     # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout103pdn01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 70", sku "AT SKU B Checkout 103" and add to cart with amount = "5"
    Then Verify item on cart tab on right side
      | brand                  | product                  | sku                   | newPrice | oldPrice | quantity | total  |
      | AT Brand B Checkout 01 | AT Product B Checkout 70 | AT SKU B Checkout 103 | $18.00   | $20.00   | 5        | $90.00 |
    Then Verify price in cart "before checkout"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax   | discount | specialDiscount | total  |
      | $100.00    | [blank]            | [blank]           | $5.00 | -$10.00  | -$9.00          | $86.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | orderValue | smallOrderSurchage | logisticsSurchage | tax   | discount | specialDiscount | total  |
      | $100.00    | [blank]            | [blank]           | $5.00 | -$10.00  | -$9.00          | $86.00 |
    And BUYER quit browser

  @B_CHECKOUT_02 @B_CHECKOUT_06
  Scenario: Check displayed information on Shipping address section
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx822@podfoods.co | 12345678a |
#    When Search order by sku "35585" by api
#    And Admin delete order of sku "35585" by api
      # Active SOS
    And Admin change status using SOS of store "3593" to "true"
     # Change info store
    And Admin change info of store "3593" by api
      | attn    | full_name | street1             | city     | address_state_id | zip   | phone_number | id    | address_state_code | address_state_name |
      | [blank] | [blank]   | 281 Columbus Avenue | New York | 33               | 10023 | 0123456798   | 64574 | NY                 | New York           |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 01 | 35585              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout06ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 35585 | 1        |
    And Checkout cart with payment by "invoice" by API
     # Create Order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout06ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Buyer check out cart
    And BUYER quit browser

  @B_CHECKOUT_04
  Scenario: Check displayed information on Shipping address section - admin change
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx823@podfoods.co | 12345678a |
#    When Search order by sku "35585" by api
#    And Admin delete order of sku "35585" by api
    # Change info store
    And Admin change info of store "3037" by api
      | attn    | full_name | street1             | city     | address_state_id | zip   | phone_number | id    | address_state_code | address_state_name |
      | [blank] | [blank]   | 281 Columbus Avenue | New York | 33               | 10023 | 0123456798   | 64574 | NY                 | New York           |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 01 | 35585              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny08@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 35585 | 1        |
    And Checkout cart with payment by "invoice" by API
     # Create Order
    Given BUYER1 open web user
    When login to beta web with email "ngoctx+stcheckout80ny08@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    And Check information in order detail
      | buyerName                | storeName           | shippingAddress                                | orderValue | total  | payment    | status  |
      | ngoctx sstcheckout80ny08 | ngoctx stcheckout80 | 281 Columbus Avenue, New York, New York, 10023 | $10.00     | $40.00 | By invoice | Pending |
    And BUYER1 quit browser

  @B_CHECKOUT_05
  Scenario: Check displayed information on Shipping address section - buyer change
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx824@podfoods.co | 12345678a |
#    When Search order by sku "35585" by api
#    And Admin delete order of sku "35585" by api
    # Change info store
    And Admin change info of store "3037" by api
      | attn    | full_name | street1             | city     | address_state_id | zip   | phone_number | id    | address_state_code | address_state_name |
      | [blank] | [blank]   | 281 Columbus Avenue | New York | 33               | 10023 | 1234567890   | 64822 | NY                 | New York           |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 01 | 35585              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny09@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 35585 | 1        |
    And Checkout cart with payment by "invoice" by API
     # Change address by buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny09@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And BUYER Go to Dashboard
    And BUYER Navigate to "Settings" by sidebar
    And Buyer go to general
    And Buyer edit store information
      | name    | storeType | storeSize | phone   | timeZone | attn    | address | apt     | city    | state   | zip     |
      | [blank] | [blank]   | [blank]   | [blank] | [blank]  | [blank] | [blank] | [blank] | [blank] | [blank] | [blank] |
    And BUYER go to catalog "All"
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    And Check information in order detail
      | buyerName               | storeName           | shippingAddress                                | orderValue | total  | payment    | status  |
      | ngoctx stcheckout80ny09 | ngoctx stcheckout80 | 281 Columbus Avenue, New York, New York, 10023 | $10.00     | $40.00 | By invoice | Pending |
    And BUYER quit browser

  @B_CHECKOUT_18
  Scenario Outline: Check displayed option shown in the drop-down list of payment method select box
    Given Buyer login web with by api
      | email   | password  |
      | <buyer> | 12345678a |
    And Clear cart to empty in cart before by API
     # Change address by buyer
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And BUYER Go to Dashboard
    And BUYER Navigate to "Settings" by sidebar
    And Buyer go to payments
    And Buyer delete current card

    And BUYER go to catalog "All"
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Buyer check out cart
    Then Buyer verify popup New Credit Cart in Place Order page
    And Buyer verify field empty of popup New Credit Cart in Place Order page
    And Buyer create New Credit Cart
      | name | address     | card   | expiryDate | city     | cvc | state   | zip   |
      | Auto | 123 address | <card> | 1133       | New York | 123 | Alabama | 12345 |
    And Buyer create New Credit Cart success
    Then Buyer verify default of payment method in Place Order page is "Your card will be charged 3 days after fulfillment of each delivery."
    And Buyer quit browser

    Examples:
      | buyer                               | card             |
      | ngoctx+stcheckout80ny10@podfoods.co | 4000056655665556 |
      | ngoctx+stcheckout80ny11@podfoods.co | 4242424242424242 |
      | ngoctx+stcheckout80ny12@podfoods.co | 4000008260003178 |

  @B_CHECKOUT_19
  Scenario: Check displayed option shown in the drop-down list of payment method select box - payment method credit card
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout121ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
     # Change address by buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout121ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Buyer check out cart
    Then Buyer verify default of payment method in Place Order page is "Your card will be charged 3 days after fulfillment of each delivery."
    And Buyer place order cart "Visa ending in 4242"
    And Buyer view order after place order
    And Check information in order detail
      | buyerName                | storeName            | shippingAddress                                | orderValue | total  | payment                                 | status  |
      | ngoctx stcheckout121ny01 | ngoctx stcheckout121 | 281 Columbus Avenue, New York, New York, 10023 | $10.00     | $40.00 | Payment via credit card or bank account | Pending |
    And BUYER quit browser

  @B_CHECKOUT_20
  Scenario: Check displayed option shown in the drop-down list of payment method select box - payment method bank account
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout120ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
     # Change address by buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout120ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Buyer check out cart
    Then Buyer verify default of payment method in Place Order page is "Your bank account will be charged 3 days after fulfillment of each delivery."
    And Buyer place order cart "Pay by STRIPE TEST BANK ending in 6789"
    And Buyer view order after place order
    And Check information in order detail
      | buyerName                | storeName            | shippingAddress                                | orderValue | total  | payment                                 | status  |
      | ngoctx stcheckout120ny01 | ngoctx stcheckout120 | 281 Columbus Avenue, New York, New York, 10023 | $10.00     | $40.00 | Payment via credit card or bank account | Pending |
    And BUYER quit browser

  @B_CHECKOUT_38
  Scenario: Check display condition of Cutoff section and Set Delivery Weekdays section with buyers belongs to PE stores (PE buyers role -NY region) - Store within 7 business day
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout121ny02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout121ny02@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $40.00 |
    And Buyer check out cart
    Then Buyer verify delivery in Check out page
      | cutoffMessage                                          | setDeliveryDay         |
      | 11 am (pst) monday for wed, 11 am (pst) wed for friday | Within 7 business days |
    And BUYER quit browser

  @B_CHECKOUT_38a
  Scenario: Check display condition of Cutoff section and Set Delivery Weekdays section with buyers belongs to PE stores (PE buyers role - CHI region)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx825@podfoods.co | 12345678a |
     # Active store spec
    Then Admin choose store's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 2484 | 93339              | 2022-09-20 | 2022-09-24 |
    And Admin choose stores attributes to inactive
      | id    | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 93339 | 53        | 3027     | 35749              | 3000             | 3000       | in_stock     | inactive | [blank]                  |
    Then Admin inactive selected stores specific
   # Active buyer company spec
    And Admin choose company's config attributes
      | id   | variants_region_id | start_date | end_date   |
      | 9971 | 106969             | 2022-09-20 | 2022-09-25 |
    Then Admin choose company attributes to inactive
      | id     | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 106969 | 53        | 2468             | 35749              | 2000             | 2000       | in_stock     | inactive | [blank]                  |
    Then Admin inactive selected company specific

    Given Buyer login web with by api
      | email                                 | password  |
      | ngoctx+stcheckout121chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout121chi01@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 02a" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $50.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $50.00 |
    And Buyer check out cart
    Then Buyer verify delivery in Check out page
      | cutoffMessage                                                                    | setDeliveryDay                                                 |
      | 11 AM PST the day before your set delivery day(s). This may be subject to change | Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday |
    And BUYER quit browser

  @B_CHECKOUT_38b
  Scenario: Check display condition of Cutoff section and Set Delivery Weekdays section with buyers belongs to PE stores (PE buyers role - TX region)
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout121tx01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout121tx01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 02a" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $60.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $60.00 |
    And Buyer check out cart
    Then Buyer verify delivery in Check out page
      | cutoffMessage                                     | setDeliveryDay                                                 |
      | 11 am (pst) a day before your set delivery day(s) | Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday |
    And BUYER quit browser

  @B_CHECKOUT_38c
  Scenario: Check display condition of Cutoff section and Set Delivery Weekdays section with buyers belongs to PE stores (PE buyers role - SF region)
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout121sf01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout121sf01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 02a" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | 30.00              | [blank]           | [blank] | $100.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | 30.00              | [blank]           | [blank] | $100.00 |
    And Buyer check out cart
    Then Buyer verify delivery in Check out page
      | cutoffMessage                                     | setDeliveryDay                                                 |
      | 12 ps (pst) a day before your set delivery day(s) | Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday |
    And BUYER quit browser

  @B_CHECKOUT_38d
  Scenario: Check display condition of Cutoff section and Set Delivery Weekdays section with buyers belongs to PE stores (PE buyers role - LA region)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx826@podfoods.co | 12345678a |
    When Search order by sku "35749" by api
    And Admin delete order of sku "35749" by api

    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout121la01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout121la01@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout1 02a" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $90.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | $90.00 |
    And Buyer check out cart
    Then Buyer verify delivery in Check out page
      | cutoffMessage                                                               | setDeliveryDay                                                 |
      | 12 PM (PST) a day before your set delivery day(s) This is subject to change | Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday |
    And Buyer place order cart "Pay by invoice"
    And Buyer verify popup thank you for order
    And BUYER quit browser

  @B_CHECKOUT_40
  Scenario: Check display condition of Cutoff section and Set Delivery Weekdays section with buyers belongs to PE stores (PD buyers role)
    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn11@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn11@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout 44" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | $20.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | $20.00 |
    And Buyer check out cart
    Then Buyer verify delivery in Check out page
      | cutoffMessage | setDeliveryDay         |
      | [blank]       | Within 7 business days |
    And Buyer go to Claims and Inquiry Form in Checkout page
    Then Buyer verify info default of claim page
      | company             | email                                | invoice |
      | ngoctx stcheckout44 | ngoctx+stcheckout44pdn11@podfoods.co | [blank] |
    And BUYER quit browser

  @B_CHECKOUT_41
  Scenario: Check display condition of Cutoff section and Set Delivery Weekdays section with buyers belongs to PE stores (PD buyers role)
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx827@podfoods.co | 12345678a |
    When Search order by sku "35133" by api
    And Admin delete order of sku "35133" by api

    Given Buyer login web with by api
      | email                                | password  |
      | ngoctx+stcheckout44pdn12@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout44pdn12@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Checkout 01", sku "AT SKU B Checkout 44" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | $20.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | $20.00 |
    And Buyer check out cart "Pay by invoice" with receiving info
      | customStore | customerPO     | department    | specialNote |
      | AT Store    | AT Cusomter PO | AT Department | [blank]     |

    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                  | checkoutAfter | checkoutBefore |
      | AT Brand B Checkout 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName                | storeName | shippingAddress                                | orderValue | total  | payment    | status  |
      | ngoctx stcheckout44pdn12 | AT Store  | 281 Columbus Avenue, New York, New York, 10023 | $20.00     | $20.00 | By invoice | Pending |
    And BUYER quit browser

  @B_CHECKOUT_51
  Scenario: Check system responses when checkout failed - SKU Out of stock
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx828@podfoods.co | 12345678a |
    When Search order by sku "35915" by api
    And Admin delete order of sku "35915" by api
    # Active product and sku
    And Change state of SKU id: "35915" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 93614 | 53        | 35915              | 10000            | 10000      | in_stock     | active | [blank]                  |
   # Update buyer company to inactive
    And Admin change info of buyer company specific of sku "61848"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name  | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date  | end_date |
      | 128033 | 53        | active              | 2468             | ngoc cpn b checkout | 61848              | 11000            | 11000      | in_stock     | active | currentDate | Plus1    |
    # Update store specific to inactive
    And Admin change info of store specific of sku "61849"
      | id     | region_id | store_id | store_name     | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date  | end_date |
      | 128035 | 53        | 3037     | Auto Store PDM | 1664             | Tra Midwest 05     | create by api      | 12000            | 12000      | in_stock     | active | currentDate | Plus1    |

      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 51 | 35915              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 a51 | 61848              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny13@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny13@podfoods.co" pass "12345678a" role "buyer"
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 51 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 a51 | 1      |
    And Go to Cart detail
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $250.00 |
    And Buyer close recommended items modal

    # Active product and sku
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx828@podfoods.co | 12345678a |
    And Change state of SKU id: "35915" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date | out_of_stock_reason |
      | 93614 | 53        | 35915              | 10000            | 10000      | sold_out     | active | [blank]                  | vendor_short_term   |
     # Update buyer company to inactive
    And Admin change info of buyer company specific of sku "61848"
      | id     | region_id | buyer_company_state | buyer_company_id | buyer_company_name  | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date  | end_date | out_of_stock_reason   |
      | 128033 | 53        | active              | 2468             | ngoc cpn b checkout | 61848              | 11000            | 11000      | sold_out     | active | currentDate | Plus1    | pending_replenishment |
        # Update store specific to inactive
    And Admin change info of store specific of sku "61849"
      | id     | region_id | store_id | store_name     | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date  | end_date | out_of_stock_reason   |
      | 128035 | 53        | 3037     | Auto Store PDM | 1664             | Tra Midwest 05     | create by api      | 12000            | 12000      | sold_out     | active | currentDate | Plus1    | pending_replenishment |

    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    Then Buyer view order after place order of sku has not inventory
#    Then Buyer reorder by button reorder then verify popup add items
#      | header            | product                  | sku                  | unitcase    | price  | description                                                                          | addButton |
#      | Pod Express Items | AT Product B Checkout 01 | AT SKU B Checkout 01 | 1 unit/case | $10.00 | These items will be consolidated and delivered to you from our distribution centers. | [blank]   |
#    And Buyer add to card in popup reorder
#      | sku                  | quantity |
#      | AT SKU B Checkout 01 | 1        |
#    And Go to Cart detail
#    And Buyer close recommended items modal
#    And Check item in Cart detail
#      | brand                  | product                  | sku                  | price  | quantity | total  |
#      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout 01 | $10.00 | 1        | $10.00 |
#    And Buyer verify save for later item in Cart detail
#      | brand                  | product                  | sku                    | skuID | available |
#      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout1 51  | 35915 | [blank]   |
#      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout1 a51 | 61848 | [blank]   |
#    And BUYER quit browser

  @B_CHECKOUT_53
  Scenario: Check system responses when checkout failed - SKU doesnt belong region
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx830@podfoods.co | 12345678a |
    # Active product and sku
    And Change state of SKU id: "35917" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 93616 | 53        | 35917              | 10000            | 10000      | in_stock     | active | [blank]                  |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny15@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 53 | 1      |
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    # Active product and sku
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx830@podfoods.co | 12345678a |
    And Change state of SKU id: "35917" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 93616 | 53        | 35917              | 10000            | 10000      | in_stock     | inactive | [blank]                  |
    And Buyer check out cart
    And Buyer verify place order is disable
    And BUYER quit browser

  @B_CHECKOUT_55
  Scenario: Check system responses when checkout failed - SKU draft
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx831@podfoods.co | 12345678a |
    # Active product and sku
    And Change state of SKU id: "35919" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 93619 | 53        | 35919              | 10000            | 10000      | in_stock     | active |
      # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 55 | 35919              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 a55 | 61871              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |


    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny16@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny16@podfoods.co" pass "12345678a" role "buyer"
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 55 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 a55 | 1      |
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $230.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    # Active product and sku
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx831@podfoods.co | 12345678a |
     # Active product and sku
    And Change state of SKU id: "35919" to "draft"

    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Buyer reorder by button reorder then verify popup add items
      | header            | product                  | sku                    | unitcase    | price   | description                                                                          | addButton |
      | Pod Express Items | AT Product B Checkout 01 | AT SKU B Checkout1 a55 | 1 unit/case | $100.00 | These items will be consolidated and delivered to you from our distribution centers. | [blank]   |
    And Buyer add to card in popup reorder
      | sku                    | quantity |
      | AT SKU B Checkout1 a55 | 1        |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                  | product                  | sku                    | price   | quantity | total   |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout1 a55 | $100.00 | 1        | $100.00 |
    And Buyer verify save for later item in Cart detail
      | brand                  | product                  | sku                   | skuID | available |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout1 55 | 35919 | [blank]   |
    And BUYER quit browser

  @B_CHECKOUT_52
  Scenario: In case there is at least 1 line-item in cart no longer belongs to buyer's region
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx829@podfoods.co | 12345678a |
    # Active product and sku
    And Change state of SKU id: "35916" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 93615 | 53        | 35916              | 10000            | 10000      | in_stock     | active | [blank]                  |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128050 | 55        | 35916              | 11000            | 11000      | in_stock     | active | [blank]                  |

     # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 a52 | 35916              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 b52 | 61864              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny14@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny14@podfoods.co" pass "12345678a" role "buyer"
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 a52 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 b52 | 1      |

    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $230.00 |
    And Go to Cart detail
    And Buyer close recommended items modal

    # Active product and sku
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx829@podfoods.co | 12345678a |
    And Change state of SKU id: "35916" to "active"
    And Admin change info of regions attributes with sku "inactive"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 93615 | 53        | 35916              | 10000            | 10000      | in_stock     | inactive | [blank]                  |
    And Admin change info of regions attributes with sku "inactive"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 128050 | 55        | 35916              | 11000            | 11000      | in_stock     | inactive | [blank]                  |

    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Buyer reorder by button reorder then verify popup add items
      | header            | product                  | sku                    | unitcase    | price   | description                                                                          | addButton |
      | Pod Express Items | AT Product B Checkout 01 | AT SKU B Checkout1 b52 | 1 unit/case | $100.00 | These items will be consolidated and delivered to you from our distribution centers. | [blank]   |
    And Buyer add to card in popup reorder
      | sku                    | quantity |
      | AT SKU B Checkout1 b52 | 1        |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                  | product                  | sku                    | price   | quantity | total   |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout1 b52 | $100.00 | 1        | $100.00 |
    And Buyer verify save for later item in Cart detail
      | brand                  | product                  | sku                    | skuID | available |
      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout1 a52 | 35916 | [blank]   |
    And BUYER quit browser

  @B_CHECKOUT_56a
  Scenario: In case there are multiple items in cart and products of them turn to be deactivated
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx833@podfoods.co | 12345678a |
    And Admin Authorized SKU id "61876" to Buyer id "3773"

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny18@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny18@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 c56 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 d56 | 1      |

    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | $30.00             | [blank]           | [blank] | $50.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer check out cart

    # Active product and sku
    Given NGOC_ADMIN_08 open web admin
    When login to beta web with email "ngoctx08@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_08 wait 5000 mini seconds
    And Admin go to buyer "3773" by url
    And Admin remove sku whitelist
      | sku                    |
      | AT SKU B Checkout1 c56 |

    And Switch to actor BUYER
    And Buyer place order cart "Pay by invoice"
    Then Buyer verify message place order fail "Validation failed: Product variant AT SKU B Checkout1 c56 unavailable in current buyer's white list"
#    And Buyer view order after place order
#    Then Buyer reorder by button reorder then verify popup add items
#      | header            | product                  | sku                    | unitcase    | price  | description                                                                          | addButton |
#      | Pod Express Items | AT Product B Checkout 01 | AT SKU B Checkout1 d56 | 1 unit/case | $10.00 | These items will be consolidated and delivered to you from our distribution centers. | [blank]   |
#    And Buyer add to card in popup reorder
#      | sku                   | quantity |
#      | AT SKU B Checkout1 56 | 1        |
#    And Go to Cart detail
#    And Buyer close recommended items modal
#    And Check item in Cart detail
#      | brand                  | product                  | sku                    | price  | quantity | total  |
#      | AT Brand B Checkout 01 | AT Product B Checkout 01 | AT SKU B Checkout1 d56 | $10.00 | 1        | $10.00 |
#    And Buyer verify save for later item in Cart detail
#      | brand                  | product                   | sku                    | skuID | available |
#      | AT Brand B Checkout 01 | AT Product B Checkout a01 | AT SKU B Checkout1 c56 | 61876 | [blank]   |
    And BUYER quit browser

  @B_CHECKOUT_57
  Scenario: Verify the Recommended items modal when add to cart PD item
    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny19@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01b | 1      |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer verify recommended item modal is not display
    And BUYER quit browser

  @B_CHECKOUT_56
  Scenario: In case there are multiple items in cart and products of them turn to be deactivated
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx832@podfoods.co | 12345678a |
       # Active product and sku
    And Admin change state of product id "29466" to active by api
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128063 | 53        | 61874              | 1000             | 1000       | in_stock     | active | [blank]                  |

     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 56 | 61849              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 a56 | 61874              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny17@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny17@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 56 | 1      |
    And BUYER refresh browser
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch               | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout a01 | AT Brand B Checkout 01 | AT SKU B Checkout1 a56 | 1      |

    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $140.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer check out cart

    # Active product and sku
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx832@podfoods.co | 12345678a |
    # Active product and sku
    And Admin change state of product id "29466" to inactive by api

    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Buyer reorder by button reorder then verify popup add items
      | header            | product                  | sku                   | unitcase    | price   | description                                                                          | addButton |
      | Pod Express Items | AT Product B Checkout 01 | AT SKU B Checkout1 56 | 1 unit/case | $100.00 | These items will be consolidated and delivered to you from our distribution centers. | [blank]   |
    And Buyer add to card in popup reorder
      | sku                   | quantity |
      | AT SKU B Checkout1 56 | 1        |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer verify save for later item in Cart detail
      | brand                  | product                   | sku                    | skuID | available |
      | AT Brand B Checkout 01 | AT Product B Checkout a01 | AT SKU B Checkout1 a56 | 61874 | [blank]   |
    And BUYER quit browser

  @B_CHECKOUT_58
  Scenario: Verify the Recommended items modal when add to cart with store not applied SOS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx834@podfoods.co | 12345678a |
       # Active SOS
    And Admin change status using SOS of store "3594" to "false"

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout58ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01 | 1      |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer verify recommended item modal is not display
    And BUYER quit browser

  @B_CHECKOUT_59
  Scenario: Verify the Recommended items modal when add to cart with store not applied SOS
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx835@podfoods.co | 12345678a |
     # Active SOS
    And Admin change status using SOS of store "3037" to "true"
    And Admin change info SOS of store "3037"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny21@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01 | 50     |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Buyer verify recommended item modal is not display
    And BUYER quit browser

  @B_CHECKOUT_60
  Scenario: Verify the Recommended items modal, Recommended items slider, Small order surcharge awareness
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx843@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 02a | 35749              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny22@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 35749 | 1        |
    And Checkout cart with payment by "invoice" by API
    # Run job để hiện sku vừa mua trên recommended item modal
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "refresh_materialized_views"
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny22@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                 | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout 01 | 1      |
    And Go to Cart detail
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $490.00     | $500.00           |
    And Buyer verify sku in recommended item modal
      | product                  | sku                    | price  | quantity |
      | AT Product B Checkout 01 | AT SKU B Checkout1 02a | $10.00 | 0        |

    # Verify when refresh page
    And BUYER refresh browser
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $490.00     | $500.00           |
    And Buyer verify sku in recommended item modal
      | product                  | sku                    | price  | quantity |
      | AT Product B Checkout 01 | AT SKU B Checkout1 02a | $10.00 | 0        |
    And Buyer close popup recommended item modal
    And Buyer verify sku in recommended items slider
      | product                  | sku                    | price  | case   |
      | AT Product B Checkout 01 | AT SKU B Checkout1 02a | $10.00 | 1 case |

    And Update quantity item "AT SKU B Checkout 01" to "50" in Cart detail
    And BUYER refresh browser
    And Buyer verify recommended item slide is not display

    And Update quantity item "AT SKU B Checkout 01" to "49" in Cart detail
    And BUYER refresh browser
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $10.00      | $500.00           |
    And Buyer verify sku in recommended item modal
      | product                  | sku                    | price  | quantity |
      | AT Product B Checkout 01 | AT SKU B Checkout1 02a | $10.00 | 0        |
    And Buyer close popup recommended item modal
    And Buyer verify sku in recommended items slider
      | product                  | sku                    | price  | case   |
      | AT Product B Checkout 01 | AT SKU B Checkout1 02a | $10.00 | 1 case |
    And BUYER quit browser

  @B_CHECKOUT_61
  Scenario: Check MOV/SOS calculation when the MOV/SOS is NOT met
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx837@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 01"
    And Admin delete promotion by skuName ""
       # Active store spec
    Then Admin choose store's config attributes
      | id    | variants_region_id | start_date | end_date   |
      | 15384 | 128117             | 2022-09-20 | 2022-09-24 |
    And Admin choose stores attributes to inactive
      | id     | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 128117 | 53        | 3027     | 61916              | 3000             | 3000       | in_stock     | inactive | [blank]                  |
    Then Admin inactive selected stores specific
     # Active buyer company spec
    And Admin choose company's config attributes
      | id    | variants_region_id | start_date | end_date   |
      | 15385 | 128118             | 2022-09-20 | 2022-09-25 |
    Then Admin choose company attributes to inactive
      | id     | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 128118 | 53        | 2468             | 61916              | 2000             | 2000       | in_stock     | inactive | [blank]                  |
    Then Admin inactive selected company specific
       # Active product and sku
    And Change state of SKU id: "61917" to "active"
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 128119 | 53        | 61917              | 10000            | 10000      | in_stock     | active | [blank]                  |
     # Create promotion
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61917 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                          | description                   | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Recommended Modal 01 | AT Promo Recommended Modal 01 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       |
    # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 02a | 35749              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |

        # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny23@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 35749 | 1        |
    And Checkout cart with payment by "invoice" by API
    # Run job để hiện sku vừa mua trên recommended item modal
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "refresh_materialized_views"
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny23@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 a61 | 5      |
    And Go to Cart detail
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $50.00      | $500.00           |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $50.00 to remove the Small Order Surcharge!"
    And BUYER refresh page
    And Buyer choose sku in recommended item modal in Cart detail
      | sku                    | quantity |
      | AT SKU B Checkout1 02a | 10       |
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $0.00       | [blank]           |
    And Buyer close popup recommended item modal
    And Buyer verify recommended item slide is not display
    And Buyer verify message remove SOS is not display

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx837@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 01"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CHECKOUT_62
  Scenario: Check MOV/SOS calculation when the SOS threshold applied for store is changed
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx838@podfoods.co | 12345678a |
    # Active SOS
    And Admin change status using SOS of store "3606" to "true"
    And Admin change info SOS of store "3606"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 62 | 62474              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |

       # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout62ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 62474 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Run job để hiện sku vừa mua trên recommended item modal
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "refresh_materialized_views"
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout62ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 01 | 4      |
    And Go to Cart detail
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $460.00     | $500.00           |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $460.00 to remove the Small Order Surcharge!"
    And Buyer verify sku in recommended items slider
      | product                  | sku                   | price   | case   |
      | AT Product B Checkout 01 | AT SKU B Checkout1 62 | $100.00 | 1 case |

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx838@podfoods.co | 12345678a |
    # Active SOS
    And Admin change status using SOS of store "3606" to "true"
    And Admin change info SOS of store "3606"
      | amount_cents | flat_fee_cents |
      | 45000        | 3000           |

    And BUYER refresh browser
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $410.00     | $450.00           |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $410.00 to remove the Small Order Surcharge!"
    And Buyer verify sku in recommended items slider
      | product                  | sku                   | price   | case   |
      | AT Product B Checkout 01 | AT SKU B Checkout1 62 | $100.00 | 1 case |
    And BUYER quit browser

  @B_CHECKOUT_63
  Scenario: Check MOV/SOS calculation when updated modal with PE items have promotion
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx839@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 02"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 03"
    And Admin delete promotion by skuName ""
     # Active product and sku
    And Change state of SKU id: "35915" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 93614 | 53        | 35915              | 10000            | 10000      | in_stock     | active | [blank]                  |
    # Active SOS
    And Admin change status using SOS of store "3037" to "true"
    And Admin change info SOS of store "3037"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
  # Create promotion fix rate
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 35749 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | false | 1      |
    And Admin create promotion by api with info
      | type                | name                          | description                   | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Recommended Modal 02 | AT Promo Recommended Modal 02 | currentDate | currentDate | [blank]     | 2          | 1                | true           | [blank] | default    | [blank]       |
     # Create promotion %
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 35104 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                          | description                   | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Recommended Modal 03 | AT Promo Recommended Modal 03 | currentDate | currentDate | [blank]     | 2          | 1                | true           | [blank] | default    | [blank]       |
    # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 02a | 35749              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 51 | 35915              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout 33 | 35104              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny25@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 35749 | 1        |
      | 8471      | 35915 | 1        |
      | 8471      | 35104 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Run job để hiện sku vừa mua trên recommended item modal
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "refresh_materialized_views"
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny25@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 62 | 1      |
    And Go to Cart detail
    And Buyer choose sku in recommended item modal in Cart detail
      | sku                    | quantity |
      | AT SKU B Checkout1 02a | 1        |
      | AT SKU B Checkout 33   | 1        |
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | 391.00      | $500.00           |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $391.00 to remove the Small Order Surcharge!"
    And Buyer remove sku "35749" in cart detail
    And Buyer remove sku "35104" in cart detail
    And BUYER refresh page
    And Buyer choose sku in recommended item modal in Cart detail
      | sku                    | quantity |
      | AT SKU B Checkout1 02a | 3        |
      | AT SKU B Checkout 33   | 3        |
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $362.00     | $500.00           |
    And Buyer verify sku in recommended item modal
      | product                  | sku                    | price  | newPrice | quantity |
      | AT Product B Checkout 01 | AT SKU B Checkout1 02a | $10.00 | $0.00    | 3        |
      | AT Product B Checkout 01 | AT SKU B Checkout 33   | $10.00 | $9.00    | 3        |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $362.00 to remove the Small Order Surcharge!"

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx839@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 02"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 03"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CHECKOUT_64
  Scenario: Check MOV/SOS calculation when updated modal with PE items have promotion
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx840@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal a64"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal b64"
    And Admin delete promotion by skuName ""
    # Active SOS
    And Admin change status using SOS of store "3037" to "true"
    And Admin change info SOS of store "3037"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
  # Create promotion fix rate - stack deal
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61918 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | true  | 2      |
      | PromotionActions::FixRateAdjustment | 2000        | true  | 5      |
    And Admin create promotion by api with info
      | type                | name                           | description                    | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Recommended Modal a64 | AT Promo Recommended Modal a64 | currentDate | currentDate | [blank]     | 3          | 2                | true           | [blank] | stacked    | [blank]       |
     # Create promotion % - stack deal
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 61919 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | true  | 2      |
      | PromotionActions::PercentageAdjustment | 0.2         | true  | 5      |
    And Admin create promotion by api with info
      | type                | name                           | description                    | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Recommended Modal b64 | AT Promo Recommended Modal b64 | currentDate | currentDate | [blank]     | 5          | 3                | true           | [blank] | stacked    | [blank]       |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 64 | 61918              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create inventory
    And Admin create inventory api1
      | index | sku                    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 a64 | 61919              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |

         # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout80ny26@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 61918 | 1        |
      | 8471      | 61919 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Run job để hiện sku vừa mua trên recommended item modal
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "refresh_materialized_views"
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout80ny26@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                   | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 c64 | 1      |
    And Go to Cart detail
    And Buyer close recommended items modal
    # Verify slide
    And Buyer slide to first sku in recommended items slider
    And Buyer verify sku in recommended items slider
      | product                  | sku                    | price  | newPrice        | case   | promo |
      | AT Product B Checkout 01 | AT SKU B Checkout1 64  | $10.00 | -$10.00 ~ $0.00 | 1 case | TPR   |
      | AT Product B Checkout 01 | AT SKU B Checkout1 a64 | $20.00 | $16.00 ~ $18.00 | 1 case | TPR   |
    And BUYER refresh page
    And Buyer choose sku in recommended item modal in Cart detail
      | sku                    | quantity |
      | AT SKU B Checkout1 64  | 1        |
      | AT SKU B Checkout1 a64 | 1        |
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $460.00     | $500.00           |
    And Buyer verify sku in recommended item modal
      | product                  | sku                    | price  | quantity |
      | AT Product B Checkout 01 | AT SKU B Checkout1 64  | $10.00 | 1        |
      | AT Product B Checkout 01 | AT SKU B Checkout1 a64 | $20.00 | 1        |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $460.00 to remove the Small Order Surcharge!"
    And Buyer remove sku "61918" in cart detail
    And Buyer remove sku "61919" in cart detail
    And BUYER refresh page
    And Buyer choose sku in recommended item modal in Cart detail
      | sku                    | quantity |
      | AT SKU B Checkout1 64  | 3        |
      | AT SKU B Checkout1 a64 | 3        |
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $436.00     | $500.00           |
    And Buyer verify sku in recommended item modal
      | product                  | sku                    | price  | newPrice        | quantity |
      | AT Product B Checkout 01 | AT SKU B Checkout1 64  | $10.00 | -$10.00 ~ $0.00 | 3        |
      | AT Product B Checkout 01 | AT SKU B Checkout1 a64 | $20.00 | $16.00 ~ $18.00 | 3        |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $436.00 to remove the Small Order Surcharge!"
    And Buyer remove sku "61918" in cart detail
    And Buyer remove sku "61919" in cart detail

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx840@podfoods.co | 12345678a |
    # Active SOS
    And Admin change status using SOS of store "3037" to "true"
    And Admin change info SOS of store "3037"
      | amount_cents | flat_fee_cents |
      | 80000        | 3000           |

    And BUYER refresh page
    And Buyer choose sku in recommended item modal in Cart detail
      | sku                    | quantity |
      | AT SKU B Checkout1 64  | 5        |
      | AT SKU B Checkout1 a64 | 5        |
    And Buyer verify recommended item modal
      | title  | remainMoney | minimumOrderValue |
      | $30.00 | $690.00     | $800.00           |
    And Buyer verify sku in recommended item modal
      | product                  | sku                    | price  | newPrice        | quantity |
      | AT Product B Checkout 01 | AT SKU B Checkout1 64  | $10.00 | -$10.00 ~ $0.00 | 5        |
      | AT Product B Checkout 01 | AT SKU B Checkout1 a64 | $20.00 | $16.00 ~ $18.00 | 5        |
    And Buyer close popup recommended item modal
    Then Buyer verify message remove SOS "Add another $690.00 to remove the Small Order Surcharge!"

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx840@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal a64"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal b64"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

  @B_CHECKOUT_65
  Scenario: Check slide bar with SHORT-DATED PROMOTION without Case stack deals
    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx841@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal a65"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal b65"
    And Admin delete promotion by skuName ""
    # Active SOS
    And Admin change status using SOS of store "3595" to "true"
    And Admin change info SOS of store "3595"
      | amount_cents | flat_fee_cents |
      | 50000        | 3000           |
    # Create promotion % TPR
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 62466 | 3595      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | true  | 2      |
    And Admin create promotion by api with info
      | type                  | name                           | description                    | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | AT Promo Recommended Modal a65 | AT Promo Recommended Modal a65 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | stacked    | currentDate   |
     # Create promotion % Short-Date
    And Admin add region by API
      | region          | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct East | 55        | 62466 | 3595      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 2000        | true  | 1      |
    And Admin create promotion by api with info
      | type                  | name                           | description                    | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | AT Promo Recommended Modal b65 | AT Promo Recommended Modal b65 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | currentDate   |
    # Create inventory
    And Admin create inventory api1
      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Checkout1 65 | 62466              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order
    Given Buyer login web with by api
      | email                               | password  |
      | ngoctx+stcheckout65ny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8471      | 62466 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Run job để hiện sku vừa mua trên recommended item modal
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "refresh_materialized_views"
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stcheckout65ny01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 64 | 1      |
    And Go to Cart detail
    And Buyer close recommended items modal
    # Verify slide
    And Buyer slide to first sku in recommended items slider
    And Buyer verify promotion of sku in recommended items slider
      | sku                   | promoType   | newPrice | oldPrice | expiryDate  |
      | AT SKU B Checkout1 65 | SHORT-DATED | $0.00    | $10.00   | currentDate |
    And Buyer verify sku in recommended items slider
      | product                  | sku                   | price  | newPrice | case   | promo       |
      | AT Product B Checkout 01 | AT SKU B Checkout1 65 | $10.00 | $0.00    | 1 case | Short dated |

    Given NGOCTX08 login web admin by api
      | email                 | password  |
      | ngoctx841@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal a65"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Recommended Modal b65"
    And Admin delete promotion by skuName ""
    And BUYER quit browser

#  @B_CHECKOUT_66
#  Scenario: Check slide bar with SHORT-DATED PROMOTION with Case stack deals
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx842@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal a66"
#    And Admin delete promotion by skuName ""
#    # Create promotion % TPR
#    And Admin add region by API
#      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
#      | New York Express | 53        | 62467 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
#    And Admin add stack deal of promotion by API
#      | typeCharge                          | chargeValue | stack | minQty |
#      | PromotionActions::FixRateAdjustment | 1000        | true  | 1      |
#      | PromotionActions::FixRateAdjustment | 2000        | true  | 2      |
#    And Admin create promotion by api with info
#      | type                  | name                           | description                    | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
#      | Promotions::ShortDate | AT Promo Recommended Modal a66 | AT Promo Recommended Modal a66 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | stacked    | currentDate   |
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU B Checkout1 66 | 62467              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |
#
#     # Create order
#    Given Buyer login web with by api
#      | email                               | password  |
#      | ngoctx+stcheckout80ny28@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#    And Add an item to cart by API
#      | productId | skuId | quantity |
#      | 8471      | 62467 | 1        |
#    And Checkout cart with payment by "invoice" by API
#
#    # Run job để hiện sku vừa mua trên recommended item modal
#    Given ADMIN_OLD open web admin old
#    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
#    And Admin go to Sidekiq
#    And Admin run cron job "refresh_materialized_views"
#    And ADMIN_OLD quit browser
#
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stcheckout80ny28@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Buyer search and add to cart
#      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
#      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 65 | 1      |
#    And Go to Cart detail
#    And Buyer close recommended items modal
#    # Verify slide
#    And Buyer slide to first sku in recommended items slider
#    And Buyer verify promotion of sku in recommended items slider
#      | sku                   | promoType   | newPrice | oldPrice | expiryDate |
#      | AT SKU B Checkout1 66 | SHORT-DATED | $0.00    | $10.00   | [blank]    |
#    And Buyer verify sku in recommended items slider
#      | product                  | sku                   | price  | newPrice | case   | promo       |
#      | AT Product B Checkout 01 | AT SKU B Checkout1 66 | $10.00 | $0.00    | 1 case | Short dated |
#
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx842@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal a66"
#    And Admin delete promotion by skuName ""
#    And BUYER quit browser
#
#  @B_CHECKOUT_67
#  Scenario: Check slide bar with TPR PROMOTION without Case stack deals
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx843@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 67"
#    And Admin delete promotion by skuName ""
#    # Create promotion % TPR
#    And Admin add region by API
#      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
#      | New York Express | 53        | 62468 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
#    And Admin add stack deal of promotion by API
#      | typeCharge                             | chargeValue | stack | minQty |
#      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
#    And Admin create promotion by api with info
#      | type                | name                          | description                   | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
#      | Promotions::OnGoing | AT Promo Recommended Modal 67 | AT Promo Recommended Modal 67 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | currentDate   |
# # Create inventory
#    And Admin create inventory api1
#      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU B Checkout1 67 | 62468              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |
#
#     # Create order
#    Given Buyer login web with by api
#      | email                               | password  |
#      | ngoctx+stcheckout80ny29@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#    And Add an item to cart by API
#      | productId | skuId | quantity |
#      | 8471      | 62468 | 1        |
#    And Checkout cart with payment by "invoice" by API
#
#    # Run job để hiện sku vừa mua trên recommended item modal
#    Given ADMIN_OLD open web admin old
#    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
#    And Admin go to Sidekiq
#    And Admin run cron job "refresh_materialized_views"
#    And ADMIN_OLD quit browser
#
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stcheckout80ny29@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Buyer search and add to cart
#      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
#      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 66 | 1      |
#    And Go to Cart detail
#    And Buyer close popup recommended item modal
#    # Verify slide
#    And Buyer slide to first sku in recommended items slider
#    And Buyer verify promotion of sku in recommended items slider
#      | sku                   | promoType | newPrice | oldPrice | expiryDate |
#      | AT SKU B Checkout1 67 | TPR       | $9.00    | $10.00   | [blank]    |
#    And Buyer verify sku in recommended items slider
#      | product                  | sku                   | price  | newPrice | case   | promo |
#      | AT Product B Checkout 01 | AT SKU B Checkout1 67 | $10.00 | $9.00    | 1 case | TPR   |
#
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx843@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 67"
#    And Admin delete promotion by skuName ""
#    And BUYER quit browser
#
#  @B_CHECKOUT_68
#  Scenario: Check slide bar with TPR PROMOTION with Case stack deals
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx844@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 68"
#    And Admin delete promotion by skuName ""
#    # Create promotion % TPR
#    And Admin add region by API
#      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
#      | New York Express | 53        | 62469 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
#    And Admin add stack deal of promotion by API
#      | typeCharge                          | chargeValue | stack | minQty |
#      | PromotionActions::FixRateAdjustment | 1000        | true  | 1      |
#      | PromotionActions::FixRateAdjustment | 2000        | true  | 2      |
#    And Admin create promotion by api with info
#      | type                | name                          | description                   | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
#      | Promotions::OnGoing | AT Promo Recommended Modal 68 | AT Promo Recommended Modal 68 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | stacked    | currentDate   |
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU B Checkout1 68 | 62469              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
#
#     # Create order
#    Given Buyer login web with by api
#      | email                               | password  |
#      | ngoctx+stcheckout80ny30@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#    And Add an item to cart by API
#      | productId | skuId | quantity |
#      | 8471      | 62469 | 1        |
#    And Checkout cart with payment by "invoice" by API
#
#    # Run job để hiện sku vừa mua trên recommended item modal
#    Given ADMIN_OLD open web admin old
#    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
#    And Admin go to Sidekiq
#    And Admin run cron job "refresh_materialized_views"
#    And ADMIN_OLD quit browser
#
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stcheckout80ny30@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Buyer search and add to cart
#      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
#      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 66 | 1      |
#    And Go to Cart detail
#    And Buyer close popup recommended item modal
#    # Verify slide
#    And Buyer slide to first sku in recommended items slider
#    And Buyer verify promotion of sku in recommended items slider
#      | sku                   | promoType | newPrice        | oldPrice | expiryDate |
#      | AT SKU B Checkout1 68 | TPR       | -$10.00 ~ $0.00 | $10.00   | [blank]    |
#    And Buyer verify sku in recommended items slider
#      | product                  | sku                   | price  | newPrice        | case   | promo |
#      | AT Product B Checkout 01 | AT SKU B Checkout1 68 | $10.00 | -$10.00 ~ $0.00 | 1 case | TPR   |
#
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx844@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 68"
#    And Admin delete promotion by skuName ""
#    And BUYER quit browser
#
#  @B_CHECKOUT_69
#  Scenario: Check slide bar with BUY IN PROMOTION without Case stack deals
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx845@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 69"
#    And Admin delete promotion by skuName ""
#    # Create promotion % BUY IN
#    And Admin add region by API
#      | region   | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
#      | New York | 53        | 45710 | 3229      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
#    And Admin add stack deal of promotion by API
#      | typeCharge                             | chargeValue | stack | minQty |
#      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
#    And Admin create promotion by api with info
#      | type              | name                          | description                   | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
#      | Promotions::BuyIn | AT Promo Recommended Modal 69 | AT Promo Recommended Modal 69 | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | currentDate   |
#
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stcheckoutbuyin01@podfoods.co" pass "12345678a" role "buyer"
#    And Search item "AT Product B Checkout Buyin 01"
#    And Verify Promotional Discount of "AT Product B Checkout Buyin 01" and sku "AT SKU B Checkout Buyin 01" in product detail
#      | unitPrice | casePrice | typePromo        | discount | newPrice | caseLimit | discountThumbnails |
#      | $90.00    | $90.00    | BUY-IN PROMOTION | 10% off  | $90.00   | [blank]   | 10%                |
#
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx845@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo Recommended Modal 69"
#    And Admin delete promotion by skuName ""
#    And BUYER quit browser
#
#  @B_CART_080
#  Scenario: Check whether a promotion is applied or not when it is set for only 1 store, multiple SKUs and usage limit = 2
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx817@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo B Cart 80"
#    And Admin delete promotion by skuName ""
#     # Create promotion
#    And Admin add region by API
#      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
#      | New York Express | 53        | 35268 | 3037      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
#      | [blank]          | [blank]   | 35269 | [blank]   | [blank]                    | [blank]           | [blank]            | [blank]                  |
#    And Admin add stack deal of promotion by API
#      | typeCharge                             | chargeValue | stack | minQty |
#      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
#    And Admin create promotion by api with info
#      | type                | name               | description        | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
#      | Promotions::OnGoing | AT Promo B Cart 80 | AT Promo B Cart 80 | currentDate | currentDate | 2           | [blank]    | 1                | true           | [blank] | default    | [blank]       |
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU B Checkout 80a | 35268              | 100      | random   | 91           | currentDate  | [blank]     | [blank] |
#
#    # Clear cart by api
#    Given Buyer login web with by api
#      | email                               | password  |
#      | ngoctx+stcheckout80ny01@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#     # Clear cart by api
#    Given Buyer login web with by api
#      | email                                | password  |
#      | ngoctx+stcheckout80bny01@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#     # Clear cart by api
#    Given Buyer login web with by api
#      | email                                | password  |
#      | ngoctx+stcheckout80cny01@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#
#     # Verify buyer 1
#    Given BUYER1 open web user
#    When login to beta web with email "ngoctx+stcheckout80ny01@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 80a" and add to cart with amount = "5"
#    Then Verify price in cart "before checkout"
#      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
#      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
#    And Go to Cart detail
#    And Buyer close recommended items modal
#    Then Verify price in cart "details"
#      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
#      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
#    And Check out cart "Pay by invoice" and "don't see" Invoice
#      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
#      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
#    # Verify buyer 2
#    Given BUYER2 open web user
#    When login to beta web with email "ngoctx+stcheckout80bny01@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 80a" and add to cart with amount = "5"
#    Then Verify price in cart "before checkout"
#      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
#      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
#    And Go to Cart detail
#    And Buyer close recommended items modal
#    Then Verify price in cart "details"
#      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
#      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
#    And Check out cart "Pay by invoice" and "don't see" Invoice
#      | smallOrderSurchage | logisticsSurchage | discount | tax     | total |
#      | 30.00              | [blank]           | -$5.00   | [blank] | 75.00 |
#    # Verify buyer 3
#    Given BUYER23 open web user
#    When login to beta web with email "ngoctx+stcheckout80cny01@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Search product by name "AT Product B Checkout 47b", sku "AT SKU B Checkout 80a" and add to cart with amount = "5"
#    Then Verify price in cart "before checkout"
#      | smallOrderSurchage | logisticsSurchage | tax     | total |
#      | 30.00              | [blank]           | [blank] | 80.00 |
#    And Go to Cart detail
#    And Buyer close recommended items modal
#    Then Verify price in cart "details"
#      | smallOrderSurchage | logisticsSurchage | tax     | total |
#      | 30.00              | [blank]           | [blank] | 80.00 |
#    And Check out cart "Pay by invoice" and "don't see" Invoice
#      | smallOrderSurchage | logisticsSurchage | tax     | total |
#      | 30.00              | [blank]           | [blank] | 80.00 |
#
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx817@podfoods.co | 12345678a |
#    And Admin search promotion by Promotion Name "AT Promo B Cart 80"
#    And Admin delete promotion by skuName ""
#    And BUYER1 quit browser
#    And BUYER2 quit browser
#    And BUYER23 quit browser
#
#  @B_CHECKOUT_71
#  Scenario: Check display of price/case shown for each SKU
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx846@podfoods.co | 12345678a |
#     # Active store spec
#    Then Admin choose store's config attributes
#      | id    | variants_region_id | start_date | end_date   |
#      | 15940 | 129227             | 2022-09-20 | 2025-09-24 |
#    And Admin choose stores attributes to active
#      | id     | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
#      | 129227 | 53        | 3035     | 62472              | 3000             | 3000       | in_stock     | active | [blank]                  |
#    Then Admin active selected stores specific
#     # Active buyer company spec
#    And Admin choose company's config attributes
#      | id    | variants_region_id | start_date | end_date   |
#      | 15941 | 129228             | 2022-09-20 | 2024-09-25 |
#    Then Admin choose company attributes to active
#      | id     | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
#      | 129228 | 53        | 2468             | 62472              | 2000             | 2000       | in_stock     | active | [blank]                  |
#    Then Admin active selected company specific
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU B Checkout1 67 | 62468              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
#    # Create inventory
#    And Admin create inventory api1
#      | index | sku                   | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU B Checkout1 67 | 62472              | 2        | random   | 91           | currentDate  | [blank]     | [blank] |
#
#  # Create order
#    Given Buyer login web with by api
#      | email                               | password  |
#      | ngoctx+stcheckout71ny01@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#    And Add an item to cart by API
#      | productId | skuId | quantity |
#      | 8471      | 62472 | 1        |
#    And Checkout cart with payment by "invoice" by API
#    # Run job để hiện sku vừa mua trên recommended item modal
#    Given ADMIN_OLD open web admin old
#    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
#    And Admin go to Sidekiq
#    And Admin run cron job "refresh_materialized_views"
#    And ADMIN_OLD quit browser
#
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stcheckout71ny01@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Buyer search and add to cart
#      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
#      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 67 | 1      |
#    And Go to Cart detail
#    And Buyer close popup recommended item modal
#    # Verify slide
#    And Buyer slide to first sku in recommended items slider
#    And Buyer verify sku in recommended items slider
#      | product                  | sku                   | price  | case   |
#      | AT Product B Checkout 01 | AT SKU B Checkout1 71 | $30.00 | 1 case |
#
#    Given NGOCTX08 login web admin by api
#      | email                | password  |
#      | ngoctx08@podfoods.co | 12345678a |
#     # Active store spec
#    Then Admin choose store's config attributes
#      | id    | variants_region_id | start_date | end_date   |
#      | 15940 | 129227             | 2022-09-20 | 2022-09-24 |
#    And Admin choose stores attributes to active
#      | id     | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
#      | 129227 | 53        | 3035     | 62472              | 3000             | 3000       | in_stock     | inactive | [blank]                  |
#    Then Admin inactive selected stores specific
#
#    And BUYER refresh page
#    And Buyer close popup recommended item modal
#    # Verify slide
#    And Buyer slide to first sku in recommended items slider
#    And Buyer verify sku in recommended items slider
#      | product                  | sku                   | price  | case   |
#      | AT Product B Checkout 01 | AT SKU B Checkout1 71 | $20.00 | 1 case |
#
#    Given NGOCTX08 login web admin by api
#      | email                | password  |
#      | ngoctx08@podfoods.co | 12345678a |
#      # Active buyer company spec
#    And Admin choose company's config attributes
#      | id    | variants_region_id | start_date | end_date   |
#      | 15941 | 129228             | 2022-09-20 | 2022-09-25 |
#    Then Admin choose company attributes to inactive
#      | id     | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
#      | 129228 | 53        | 2468             | 62472              | 2000             | 2000       | in_stock     | inactive | [blank]                  |
#    Then Admin inactive selected company specific
#
#    And BUYER refresh page
#    And Buyer close popup recommended item modal
#    # Verify slide
#    And Buyer slide to first sku in recommended items slider
#    And Buyer verify sku in recommended items slider
#      | product                  | sku                   | price  | case   |
#      | AT Product B Checkout 01 | AT SKU B Checkout1 71 | $10.00 | 1 case |
#    And BUYER quit browser

#  @B_CHECKOUT_72
#  Scenario: Check the quantity box on the modal of sub buyer
#    Given NGOCTX08 login web admin by api
#      | email                 | password  |
#      | ngoctx847@podfoods.co | 12345678a |
#      # Active store spec
#    Then Admin choose store's config attributes
#      | id   | variants_region_id | start_date | end_date   |
#      | 2484 | 93339              | 2022-09-20 | 2022-09-24 |
#    And Admin choose stores attributes to inactive
#      | id    | region_id | store_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
#      | 93339 | 53        | 3027     | 35749              | 3000             | 3000       | in_stock     | inactive | [blank]                  |
#    Then Admin inactive selected stores specific
#     # Active buyer company spec
#    And Admin choose company's config attributes
#      | id   | variants_region_id | start_date | end_date   |
#      | 9971 | 106969             | 2022-09-20 | 2022-09-25 |
#    Then Admin choose company attributes to inactive
#      | id     | region_id | buyer_company_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
#      | 106969 | 53        | 2468             | 35749              | 2000             | 2000       | in_stock     | inactive | [blank]                  |
#    Then Admin inactive selected company specific

#    # Create order
#    Given Buyer login web with by api
#      | email                                | password  |
#      | ngoctx+stcheckout01sny01@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#    And Add an item to cart by API
#      | productId | skuId | quantity |
#      | 8471      | 35749 | 1        |
#    And Checkout cart with payment by "invoice" by API
#    # Run job để hiện sku vừa mua trên recommended item modal
#    Given ADMIN_OLD open web admin old
#    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
#    And Admin go to Sidekiq
#    And Admin run cron job "refresh_materialized_views"
#
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stcheckout01sny01@podfoods.co" pass "12345678a" role "buyer"
#    And Clear cart to empty in cart before
#    And Buyer search and add to cart
#      | typeSearchSKU | typeSort                    | typeSearch | valueSearch              | brand                  | name                  | amount |
#      | absolute      | Order by Brand name — A > Z | product    | AT Product B Checkout 01 | AT Brand B Checkout 01 | AT SKU B Checkout1 53 | 1      |
#    And Go to Cart detail
#    And Buyer verify recommended item modal
#      | title  | remainMoney | minimumOrderValue |
#      | $30.00 | $400.00     | $500.00           |
#    And Buyer close popup recommended item modal
#    Then Buyer verify message remove SOS "Add another $400.00 to remove the Small Order Surcharge!"
#    And Buyer verify sku in recommended items slider
#      | product                  | sku                    | price  | case   |
#      | AT Product B Checkout 01 | AT SKU B Checkout1 02a | $10.00 | 1 case |
#
#


  @B_CART_CHECKOUT_152
  Scenario: Save for later function
#    Given AUTO_BAO@21 login web admin by api
#      | email             | password  |
#      | bao21@podfoods.co | 12345678a |

    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer70@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Buyer delete all save later cart by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer70@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto product add to cart mov", sku "Auto SKU 2 add to cart mov" and add to cart with amount = "1"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total  |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        | $20.00 |
    And Buyer save for later sku "Auto SKU 2 add to cart mov" in cart detail
    And Buyer verify save for later item in Cart detail
      | brand                      | product                      | sku                        | skuID |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | 30950 |
    And Check item in Cart detail
      | brand   | product | sku     | price   | quantity | total   |
      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank] |
    And Search product by name "Auto product add to cart mov", sku "Auto SKU add to cart mov" and add to cart with amount = "50"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                      | sku                      | price  | quantity | total   |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU add to cart mov | $10.00 | 50       | $500.00 |
    And Buyer verify save for later item in Cart detail
      | brand                      | product                      | sku                        | skuID |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | 30950 |
    And Buyer move to cart sku "Auto SKU 2 add to cart mov" in saved for later
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total   |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU add to cart mov   | $10.00 | 50       | $500.00 |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        | $20.00  |
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $550.00 |
    And Buyer remove sku "Auto SKU add to cart mov" in cart detail
    And Buyer remove sku "Auto SKU 2 add to cart mov" in cart detail

  @B_CART_CHECKOUT_153
  Scenario: Save for later function 2
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer70@podfoods.co | 12345678a |
    Then Clear cart to empty in cart before by API
    And Buyer delete all save later cart by API

    Given AUTO_BAO@21 login web admin by api
      | email             | password  |
      | bao21@podfoods.co | 12345678a |
    And Admin search product name "Auto product sfl 1 api" by api
    And Admin delete product name "Auto product sfl 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                   | brand_id |
      | Auto product sfl 1 api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Florida Express     | 63 | active | in_stock     | 1000      | 1000 |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku sfl 1 api" of product ""
    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku sfl 2 api" of product ""
    And Admin create a "active" SKU from admin with name "random sku sfl 3 api" of product ""
    And Clear Info of Region api
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku sfl 4 api" of product ""
    And Clear Info of store api
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku sfl 5 api" of product ""
    And Clear Info of buyer company api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku sfl 6 api" of product ""
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer70@podfoods.co | 12345678a |
    Then Clear cart to empty in cart before by API
    And Add an item to cart by API 2
      | productId | skuId   | skuName              | quantity |
      | [blank]   | [blank] | random sku sfl 1 api | 1        |
      | [blank]   | [blank] | random sku sfl 2 api | 1        |
      | [blank]   | [blank] | random sku sfl 3 api | 1        |
      | [blank]   | [blank] | random sku sfl 4 api | 1        |
      | [blank]   | [blank] | random sku sfl 5 api | 1        |
      | [blank]   | [blank] | random sku sfl 6 api | 1        |
#    open web user
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer70@podfoods.co" pass "12345678a" role "buyer"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                     | product                | sku                  | price  | quantity | total  |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 6 api | $10.00 | 1        | $10.00 |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 1 api | $10.00 | 1        | $10.00 |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 2 api | $10.00 | 1        | $10.00 |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 3 api | $10.00 | 1        | $10.00 |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 4 api | $10.00 | 1        | $10.00 |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 5 api | $10.00 | 1        | $10.00 |
    And Buyer save for later sku "random sku sfl 1 api" in cart detail
    And Buyer save for later sku "random sku sfl 2 api" in cart detail
    And Buyer save for later sku "random sku sfl 3 api" in cart detail
    And Buyer save for later sku "random sku sfl 6 api" in cart detail
    And Buyer save for later sku "random sku sfl 4 api" in cart detail
    And Buyer save for later sku "random sku sfl 5 api" in cart detail
#    Change to inactive
    Given AUTO_BAO@21 login web admin by api
      | email             | password  |
      | bao21@podfoods.co | 12345678a |
    And Admin change info of regions attributes of sku "random sku sfl 1 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And Admin change info of regions attributes of sku "random sku sfl 2 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | sold_out     | active |
    And Admin change info of regions attributes of sku "random sku sfl 3 api" state "inactive"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
    And Admin change info of buyer company specific of sku "random sku sfl 5 api"
      | id      | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | [blank] | 26        | active              | 2216             | Auto_BuyerCompany  | create by api      | 1000             | 1000       | in_stock     | active | Minus2     | Minus1   |
    And Admin change info of store specific of sku "random sku sfl 4 api"
      | id      | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | [blank] | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | create by api      | 1000             | 1000       | in_stock     | active | Minus2     | Minus1   |
    And Admin change info of regions attributes of sku "random sku sfl 6 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 58        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And Switch to actor BUYER
    And BUYER refresh page
    And Buyer verify save for later item not available
      | sku                  |
      | random sku sfl 5 api |
      | random sku sfl 4 api |
      | random sku sfl 6 api |
      | random sku sfl 3 api |
      | random sku sfl 2 api |
      | random sku sfl 1 api |
#    Change to active
    And Admin change info of regions attributes of sku "random sku sfl 1 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
    And Admin change info of regions attributes of sku "random sku sfl 2 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
    And Admin change info of regions attributes of sku "random sku sfl 3 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
    And Admin change info of buyer company specific of sku "random sku sfl 5 api"
      | id      | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date  | end_date    |
      | [blank] | 26        | active              | 2216             | Auto_BuyerCompany  | create by api      | 1000             | 1000       | in_stock     | active | currentDate | currentDate |
    And Admin change info of store specific of sku "random sku sfl 4 api"
      | id      | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date  | end_date    |
      | [blank] | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | create by api      | 1000             | 1000       | in_stock     | active | currentDate | currentDate |
    And Admin change info of regions attributes of sku "random sku sfl 6 api" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 58        | [blank]            | 1000             | 1000       | in_stock     | active |
    And BUYER refresh page
    And Buyer verify save for later item in Cart detail
      | brand                     | product                | sku                  | skuID   |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 6 api | [blank] |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 1 api | [blank] |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 2 api | [blank] |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 3 api | [blank] |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 4 api | [blank] |
      | Auto brand create product | Auto product sfl 1 api | random sku sfl 5 api | [blank] |
#mvn verify -Dtestsuite="AddToCartTestSuite" -Dcucumber.options="src/test/resources/features/addtocart"
@feature=addToCart
Feature: Add To Cart

  @addToCart01
  Scenario: Check showing a MOV alert to help buyers meet the MOV if they don't meet when putting a SKU in cart with PE head buyer role
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Short-dated"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored"
    And Admin delete promotion by skuName ""
    And Admin search promotion by skuName "Auto SKU add to cart mov"
    And Admin delete promotion by skuName "Auto SKU add to cart mov"
    And Admin search promotion by skuName "Auto SKU 2 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 2 add to cart mov"

    And Update regions info of SKU "30949"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82920 | 58        | 30949              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "30950"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82921 | 26        | 30950              | 2000             | 2400       | in_stock     | active |
#Create sample request
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | 30949              | 82920              |
      | 30950              | 82921              |
    And Admin add buyer for sample request by API
      | buyer_id |
      | 2902     |
    And Admin create sample request by API2
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | [blank]   | [blank]  | 6336        | 2709     | 1850              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |

      # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Auto SKU add to cart mov | 30949              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku                        | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Auto SKU 2 add to cart mov | 30950              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 82920              | 30949              | 50       | false     | [blank]          |
      | 82921              | 30950              | 2        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2902     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    # Update sku to pre order
    And Update regions info of SKU "30949"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82920 | 58        | 30949              | 1000             | 1200       | coming_soon  | active |
        # Create Pre order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer38@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 6336      | 30949 | 1        |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Update regions info of SKU "30949"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82920 | 58        | 30949              | 1000             | 1200       | in_stock     | active |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer38@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check mov when add cart product from popup
      | product                      | sku                      | amount | message                                                                                                                                                              | counter |
      | Auto product add to cart mov | Auto SKU add to cart mov | 1      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add cart from product detail
      | product                      | sku                      | amount |
      | Auto product add to cart mov | Auto SKU add to cart mov | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Search and check mov when add cart product from popup
      | product                      | sku                      | amount | message | counter |
      | Auto product add to cart mov | Auto SKU add to cart mov | 50     | [blank] | [blank] |
    And Clear cart to empty in cart before

    And Search Brand and go to detail
      | brand                      | productName                  | unitPrice | numberSku |
      | Auto brand add to cart mov | Auto product add to cart mov | $10.00    | [blank]   |
    And Add to cart product "Auto product add to cart mov" sku "Auto SKU add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
  #Check is met
    And Add to cart product "Auto product add to cart mov" sku "Auto SKU add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before

    And Go to product detail "Auto product add to cart mov" from product list of Brand
    And Buyer choose SKU "Auto SKU add to cart mov" in product detail
    And Add product "Auto product add to cart mov" to favorite
    And Go to product detail "Auto product add to cart mov" from product list of Brand
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $12.00 | $500.00      | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |
    And Clear cart to empty in cart before
    And Add to cart the sku "Auto SKU 2 add to cart mov" with quantity = "1"

    And Verify item on cart tab on right side
      | brand                      | product                      | sku                        | price  | quantity |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        |
    And Add product "Auto product add to cart mov" to favorite
#    Favorite screen
    And Go to favorite page of "Auto product add to cart mov"
    And Click add to cart product "Auto product add to cart mov" sku "Auto SKU add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
  #   check is met
    And Click add to cart product "Auto product add to cart mov" sku "Auto SKU add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Click add to cart product "Auto product add to cart mov" sku "Auto SKU 2 add to cart mov" and quantity "1" from favorite page
    And Verify item on cart tab on right side
      | brand                      | product                      | sku                        | price  | quantity |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        |

##Order guide
    And Go to tab "Order guide"
    And Clear cart to empty in cart before
    And Add cart sku "Auto SKU add to cart mov" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add cart sku "Auto SKU 2 add to cart mov" from order guide
    And Verify item on cart tab on right side
      | brand                      | product                      | sku                        | price  | quantity |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        |
    And Clear cart to empty in cart before
#Check order
    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number "create by api"
    And Buyer reorder sku "Auto SKU add to cart mov" and quantity "1"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOV not met in cart detail
      | message                                   | counter |
      | Please order more cases to reach SKU MOV. | $490.00 |
    And Buyer close SOS popup
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total  |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU add to cart mov   | $10.00 | 1        | $10.00 |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        | $20.00 |
    And Update quantity item "Auto SKU add to cart mov" to "50" in Cart detail
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    And BUYER go to catalog "All"
    And Clear cart to empty in cart before
    And Buyer go to "Samples" from dashboard
    And Go to sample request detail with number "create by api"
    And Add to cart sku "Auto SKU add to cart mov" from sample request
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add to cart sku "Auto SKU 2 add to cart mov" from sample request
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total  |
      | Auto brand add to cart mov | Auto product add to cart mov | Auto SKU 2 add to cart mov | $20.00 | 1        | $20.00 |
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 30949 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | [blank]   | 30950 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name             | description      | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | actionType | buy_in  | skuExpireDate |
      | Promotions::OnGoing | Test add to cart | Test add to cart | 2022-06-14 | [blank]    | 1           | [blank]    | 1                | true           | default    | [blank] | [blank]       |
#    Promotion screen
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                  | orderBrand | time    |
      | Auto brand add to cart mov | [blank]    | [blank] |
    And Buyer add to card sku "Auto SKU add to cart mov" from promo detail
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $491.00 |
    And Close popup add cart
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU add to cart mov"
    And Admin delete promotion by skuName "Auto SKU add to cart mov"
    And Admin search promotion by skuName "Auto SKU 2 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 2 add to cart mov"
    And Admin search product recommendation Buyer id "2902" by api
    And Admin delete product recommendation by api
    And Update regions info of SKU "30949"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82920 | 58        | 30949              | 1000             | 1200       | in_stock     | active |
    #Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id | comment |
      | 2902     | 2902   | 6336       | comment |

    And Buyer go to "Orders" from dashboard
    And Buyer go to Pre-order detail number "create by api"
    And Add to cart sku "Auto SKU add to cart mov" from Pre-order detail
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Search item "Auto SKU add to cart mov"
    And Go to Recommended products
    And Add to cart product "Auto product add to cart mov" sku "Auto SKU add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add to cart product "Auto product add to cart mov" sku "Auto SKU add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before

  @addToCart12
  Scenario: Check showing a MOV alert to help buyers meet the MOV if they don't meet when putting a SKU in cart with PD head buyer role
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 3 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 3 add to cart mov"
    And Admin search promotion by skuName "Auto SKU 4 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 4 add to cart mov"
    And Admin search product recommendation Buyer id "2969" by api
    And Admin delete product recommendation by api
       #    //Update sku to pre order
    And Update regions info of SKU "31005"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83007 | 58        | 31005              | 1000             | 1200       | coming_soon  | active |
        # Create Pre order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer39@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 6357      | 31005 | 1        |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Update regions info of SKU "31005"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83007 | 58        | 31005              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31006"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83010 | 26        | 31006              | 2000             | 2400       | in_stock     | active |
    And Update regions info of SKU "31006"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83009 | 58        | 31006              | 2000             | 2400       | in_stock     | active |
#Create sample
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | 31005              | 83007              |
      | 31006              | 83009              |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 2969      | 2969     | 6357        | 2708     | 1850              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |

#    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 83007              | 31005              | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id | comment |
      | 2969     | 2969   | 6357       | comment |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
#    And Search product by name "Auto product add to cart mov", sku "Auto SKU add to cart mov" and add to cart with amount = "1"
    And Search and check mov when add cart product from popup
      | product                        | sku                        | amount | message                                                                                                                                                              | counter |
      | Auto product 2 add to cart mov | Auto SKU 3 add to cart mov | 1      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |

    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add cart from product detail
      | product                        | sku                        | amount |
      | Auto product 2 add to cart mov | Auto SKU 3 add to cart mov | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart

#    And Search and check mov when add cart product from popup
#      | product                        | sku                        | amount | message | counter |
#      | Auto product 2 add to cart mov | Auto SKU 3 add to cart mov | 50     | [blank]  | [blank]  |
#    And Clear cart to empty in cart before

    And Search Brand and go to detail
      | brand                      | productName                    | unitPrice | numberSku |
      | Auto brand add to cart mov | Auto product 2 add to cart mov | $10.00    | [blank]   |
    And Add to cart product "Auto product 2 add to cart mov" sku "Auto SKU 3 add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
  #Check is met
    And Add to cart product "Auto product 2 add to cart mov" sku "Auto SKU 3 add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before

    And Go to product detail "Auto product 2 add to cart mov" from product list of Brand
    And Buyer choose SKU "Auto SKU 3 add to cart mov" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $12.00 | $500.00      | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |
    And Add product "Auto product 2 add to cart mov" to favorite
#    Favorite screen
    And Go to favorite page of "Auto product 2 add to cart mov"
    And Click add to cart product "Auto product 2 add to cart mov" sku "Auto SKU 3 add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
  #   check is met
    And Click add to cart product "Auto product 2 add to cart mov" sku "Auto SKU 3 add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
##Order guide
    And Go to tab "Order guide"
    And Clear cart to empty in cart before
    And Add cart sku "Auto SKU 3 add to cart mov" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number "create by api"
    And Buyer reorder sku "Auto SKU 3 add to cart mov" and quantity "1"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOV not met in cart detail
      | message                                   | counter |
#      | Please add more case(s) to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
      | Please order more cases to reach SKU MOV. | $490.00 |
    And Check item in Cart detail
      | brand                      | product                        | sku                        | price  | quantity | total  |
      | Auto brand add to cart mov | Auto product 2 add to cart mov | Auto SKU 3 add to cart mov | $10.00 | 1        | $10.00 |
    And Update quantity item "Auto SKU 3 add to cart mov" to "50" in Cart detail
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |

    And BUYER go to catalog "All"
    And Clear cart to empty in cart before
    And Buyer go to "Samples" from dashboard
    And Go to sample request detail with number "create by api"
    And Add to cart sku "Auto SKU 3 add to cart mov" from sample request
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
  #  //Create promotion
    And Admin add region by API
      | region             | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | 31005 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]            | [blank]   | 31006 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name             | description      | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Test add to cart | Test add to cart | 2022-06-14 | [blank]    | 1           | [blank]    | 1                | true           | [blank] | default    | [blank]       |

#    Promotion screen
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                  | orderBrand | time    |
      | Auto brand add to cart mov | [blank]    | [blank] |
    And Buyer add to card sku "Auto SKU 3 add to cart mov" from promo detail
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $491.00 |
    And Close popup add cart
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 3 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 3 add to cart mov"
    And Admin search promotion by skuName "Auto SKU 4 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 4 add to cart mov"

    And Update regions info of SKU "31005"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83007 | 58        | 31005              | 1000             | 1200       | in_stock     | active |
    And Buyer go to "Orders" from dashboard
    And Buyer go to Pre-order detail number "create by api"
    And Add to cart sku "Auto SKU 3 add to cart mov" from Pre-order detail
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart

    And Go to Recommended products
    And Add to cart product "Auto product 2 add to cart mov" sku "Auto SKU 3 add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add to cart product "Auto product 2 add to cart mov" sku "Auto SKU 3 add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Clear cart to empty in cart before

  @addToCart13
  Scenario: Check showing a MOV alert to help buyers meet the MOV if they don't meet when putting a SKU in cart with PE sub buyer role
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 5 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 5 add to cart mov"
    And Admin search promotion by skuName "Auto SKU 6 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 6 add to cart mov"

       #    //Update sku to pre order
    And Update regions info of SKU "31020"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83025 | 58        | 31020              | 1000             | 1200       | coming_soon  | active |
        # Create Pre order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer41@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 6364      | 31020 | 1        |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Update regions info of SKU "31020"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83025 | 58        | 31020              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31021"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83026 | 26        | 31021              | 2000             | 2400       | in_stock     | active |

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | 31020              | 83025              |
      | 31021              | 83026              |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 2972      | 2972     | 6364        | 2709     | 1850              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |

    #    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 83025              | 31020              | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2972     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer41@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check mov when add cart product from popup
      | product                        | sku                        | amount | message                                                                                                                                                              | counter |
      | Auto product 3 add to cart mov | Auto SKU 5 add to cart mov | 1      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add cart from product detail
      | product                        | sku                        | amount |
      | Auto product 3 add to cart mov | Auto SKU 5 add to cart mov | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart

    And Search and check mov when add cart product from popup
      | product                        | sku                        | amount | message | counter |
      | Auto product 3 add to cart mov | Auto SKU 5 add to cart mov | 50     | [blank] | [blank] |
    And Clear cart to empty in cart before
    And Search Brand and go to detail
      | brand                      | productName                    | unitPrice | numberSku |
      | Auto brand add to cart mov | Auto product 3 add to cart mov | $10.00    | [blank]   |
    And Add to cart product "Auto product 3 add to cart mov" sku "Auto SKU 5 add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
  #Check is met
    And Add to cart product "Auto product 3 add to cart mov" sku "Auto SKU 5 add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Go to product detail "Auto product 3 add to cart mov" from product list of Brand
    And Buyer choose SKU "Auto SKU 5 add to cart mov" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $12.00 | $500.00      | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |
    And Clear cart to empty in cart before
    And Add to cart the sku "Auto SKU 6 add to cart mov" with quantity = "1"
    And Verify item on cart tab on right side
      | brand                      | product                        | sku                        | price  | quantity |
      | Auto brand add to cart mov | Auto product 3 add to cart mov | Auto SKU 6 add to cart mov | $20.00 | 1        |
    And Buyer choose SKU "Auto SKU 5 add to cart mov" in product detail
    And Add product "Auto product 3 add to cart mov" to favorite
#    Favorite screen
    And Go to favorite page of "Auto product 3 add to cart mov"
    And Click add to cart product "Auto product 3 add to cart mov" sku "Auto SKU 5 add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
  #   check is met
    And Click add to cart product "Auto product 3 add to cart mov" sku "Auto SKU 5 add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Click add to cart product "Auto product 3 add to cart mov" sku "Auto SKU 6 add to cart mov" and quantity "1" from favorite page
    And Verify item on cart tab on right side
      | brand                      | product                        | sku                        | price  | quantity |
      | Auto brand add to cart mov | Auto product 3 add to cart mov | Auto SKU 6 add to cart mov | $20.00 | 1        |

##Order guide
    And Go to tab "Order guide"
    And Clear cart to empty in cart before
    And Add cart sku "Auto SKU 5 add to cart mov" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number "create by api"
    And Buyer reorder sku "Auto SKU 5 add to cart mov" and quantity "1"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOV not met in cart detail
      | message                                   | counter |
      | Please order more cases to reach SKU MOV. | $490.00 |

    And Check item in Cart detail
      | brand                      | product                        | sku                        | price  | quantity | total  |
      | Auto brand add to cart mov | Auto product 3 add to cart mov | Auto SKU 5 add to cart mov | $10.00 | 1        | $10.00 |
    And Update quantity item "Auto SKU 5 add to cart mov" to "50" in Cart detail
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |

    And BUYER go to catalog "All"
    And Clear cart to empty in cart before

    And Buyer go to "Samples" from dashboard
    And Go to sample request detail with number "create by api"
    And Add to cart sku "Auto SKU 5 add to cart mov" from sample request
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add to cart sku "Auto SKU 6 add to cart mov" from sample request
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                        | sku                        | price  | quantity | total  |
      | Auto brand add to cart mov | Auto product 3 add to cart mov | Auto SKU 6 add to cart mov | $20.00 | 1        | $20.00 |

#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 31021 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | [blank]   | 31020 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name             | description      | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Test add to cart | Test add to cart | 2022-06-14 | [blank]    | 1           | [blank]    | 1                | true           | [blank] | default    | [blank]       |

#    Promotion screen
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                  | orderBrand | time    |
      | Auto brand add to cart mov | [blank]    | [blank] |
    And Buyer add to card sku "Auto SKU 5 add to cart mov" from promo detail
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $491.00 |
    And Close popup add cart
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 5 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 5 add to cart mov"
    And Admin search promotion by skuName "Auto SKU 6 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 6 add to cart mov"

    And Update regions info of SKU "31020"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83025 | 58        | 31020              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31021"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83026 | 26        | 31021              | 2000             | 2400       | in_stock     | active |
    And Admin search product recommendation Buyer id "2972" by api
    And Admin delete product recommendation by api
    #Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id | comment |
      | 2972     | 2972   | 6364       | comment |

    And Buyer go to "Orders" from dashboard
    And Buyer go to Pre-order detail number "create by api"
    And Add to cart sku "Auto SKU 5 add to cart mov" from Pre-order detail
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Search item "Auto SKU 5 add to cart mov"
    And Go to Recommended products
    And Add to cart product "Auto product 3 add to cart mov" sku "Auto SKU 5 add to cart mov" and quantity "1" from product list
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add to cart product "Auto product 3 add to cart mov" sku "Auto SKU 5 add to cart mov" and quantity "50" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Clear cart to empty in cart before

  @addToCart33
  Scenario: Check showing a MOQ alert to help buyers meet the MOQ if they don't meet when putting a SKU in cart with PE head buyer role
    Given NGOCTX login web admin by api
      | email              | password  |
      | bao32@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU add to cart moq"
    And Admin delete promotion by skuName "Auto SKU add to cart moq"
    And Admin search promotion by skuName "Auto SKU 2 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 2 add to cart moq"

       #    //Update sku to pre order
    And Update regions info of SKU "31026"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83045 | 26        | 31026              | 1000             | 1200       | coming_soon  | active |
        # Create Pre order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer43@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 6366      | 31026 | 1        |

    Given NGOCTX login web admin by api
      | email              | password  |
      | bao32@podfoods.co | 12345678a |
    And Update regions info of SKU "31025"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83034 | 58        | 31025              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31026"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83045 | 26        | 31026              | 2000             | 2400       | in_stock     | active |

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | 31025              | 83034              |
      | 31026              | 83045              |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 2976      | 2976     | 6366        | 2724     | 1854              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |

    #    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 83034              | 31025              | 7        | false     | [blank]          |
      | 83045              | 31026              | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2976     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |


    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add cart from product detail
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 7      |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before

    And Search Brand and go to detail
      | brand                      | productName                  | unitPrice | numberSku |
      | Auto brand add to cart moq | Auto product add to cart moq | $10.00    | [blank]   |
    And Add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
  #Check is met
    And Add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "7" from product list
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before

    And Go to product detail "Auto product add to cart moq" from product list of Brand
    And Buyer choose SKU "Auto SKU add to cart moq" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $12.00 | 7            | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |

    And Buyer choose SKU "Auto SKU 2 add to cart moq" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $24.00 | 5            | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |
    And Clear cart to empty in cart before
    And Add to cart the sku "Auto SKU 2 add to cart moq" with quantity = "1"
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
#    And Close popup add cart
#    And Verify item on cart tab on right side
#      | brand                      | product                      | sku                        | price  | quantity |
#      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU 2 add to cart moq | $20.00 | 1        |
#    Favorite screen
    And Go to favorite page of "Auto product add to cart moq"
    And Click add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
     #   check is met
    And Click add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "7" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Click add to cart product "Auto product add to cart moq" sku "Auto SKU 2 add to cart moq" and quantity "1" from favorite page
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Verify item on cart tab on right side
      | brand                      | product                      | sku                        | price  | quantity |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU 2 add to cart moq | $20.00 | 1        |

##Order guide
    And Go to tab "Order guide"
    And Clear cart to empty in cart before
    And Add cart sku "Auto SKU add to cart moq" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add cart sku "Auto SKU 2 add to cart moq" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Verify item on cart tab on right side
      | brand                      | product                      | sku                        | price  | quantity |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU 2 add to cart moq | $20.00 | 1        |
    And Clear cart to empty in cart before

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number "create by api"
    And Buyer reorder sku "Auto SKU add to cart moq" and quantity "1"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU add to cart moq   | Please order more cases to reach SKU MOQ. | MOQ: 7  |
      | Auto SKU 2 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU add to cart moq   | $10.00 | 1        | $10.00 |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU 2 add to cart moq | $20.00 | 1        | $20.00 |
    And Update quantity item "Auto SKU add to cart moq" to "7" in Cart detail
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU add to cart moq   | [blank]                                   | [blank] |
      | Auto SKU 2 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |

    And BUYER go to catalog "All"
    And Clear cart to empty in cart before

    And Buyer go to "Samples" from dashboard
    And Go to sample request detail with number "create by api"
    And Add to cart sku "Auto SKU add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add to cart sku "Auto SKU 2 add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                      | sku                        | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU 2 add to cart moq | $20.00 | 1        | $20.00 |
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU 2 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |
#
#  //Create promotion

    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 31026 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | [blank]   | 31025 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name             | description      | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Test add to cart | Test add to cart | 2022-06-14 | [blank]    | 1           | [blank]    | 1                | true           | [blank] | default    | [blank]       |

#    Promotion screen
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                  | orderBrand | time    |
      | Auto brand add to cart moq | [blank]    | [blank] |
    And Buyer add to card sku "Auto SKU add to cart moq" from promo detail
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Buyer add to card sku "Auto SKU 2 add to cart moq" from promo detail
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 3 cases |
    And Close popup add cart

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU add to cart moq"
    And Admin delete promotion by skuName "Auto SKU add to cart moq"
    And Admin search promotion by skuName "Auto SKU 2 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 2 add to cart moq"
    And Admin search product recommendation Buyer id "2976" by api
    And Admin delete product recommendation by api
    And Update regions info of SKU "31025"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83034 | 58        | 31025              | 1000             | 1200       | in_stock     | active |
        #Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id | comment |
      | 2976     | 2976   | 6366       | comment |

    And Buyer go to "Orders" from dashboard
    And Buyer go to Pre-order detail number "create by api"
    And Add to cart sku "Auto SKU 2 add to cart moq" from Pre-order detail
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 2 cases |
    And Close popup add cart
    And Search item "Auto SKU add to cart moq"
#    recommended
    And Go to Recommended products
    And Add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Clear cart to empty in cart before

  @addToCart45
  Scenario: Check showing a MOQ alert to help buyers meet the MOQ if they don't meet when putting a SKU in cart with PD head buyer role
    Given NGOCTX login web admin by api
      | email              | password  |
      | bao31@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU add to cart moq"
    And Admin delete promotion by skuName "Auto SKU add to cart moq"
    And Admin search promotion by skuName "Auto SKU 2 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 2 add to cart moq"

#      # Update sku to pre order
#    And Update regions info of SKU "31025"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83034 | 58        | 31025              | 1000             | 1200       | coming_soon  | active |
#        # Create Pre order
#    Given Buyer login web with by api
#      | email                          | password  |
#      | ngoctx+autobuyer40@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#    And Add item to pre-order by API
#      | productId | skuId | quantity |
#      | 6366      | 31029 | 1        |

#    Given NGOCTX login web admin by api
#      | email              | password  |
#      | ngoctx@podfoods.co | 12345678a |
    And Update regions info of SKU "31025"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83034 | 58        | 31025              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31026"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83045 | 26        | 31026              | 2000             | 2400       | in_stock     | active |

    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | 31025              | 83034              |
      | 31036              | 83045              |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 2985      | 2985     | 6366        | 2727     | 1854              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |

     #    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 83034              | 31025              | 7        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2985     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer45@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add cart from product detail
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 7      |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Search Brand and go to detail
      | brand                      | productName                  | unitPrice | numberSku |
      | Auto brand add to cart moq | Auto product add to cart moq | $10.00    | [blank]   |
    And Add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
  #Check is met
    And Add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "7" from product list
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Go to product detail "Auto product add to cart moq" from product list of Brand
    And Buyer choose SKU "Auto SKU add to cart moq" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $12.00 | 7            | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |
    And Add product "Auto product add to cart moq" to favorite
#    Favorite screen
    And Go to favorite page of "Auto product add to cart moq"
    And Click add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
     #   check is met
    And Click add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "7" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before

##Order guide
    And Go to tab "Order guide"
    And Clear cart to empty in cart before
    And Add cart sku "Auto SKU add to cart moq" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Clear cart to empty in cart before

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number "create by api"
    And Buyer reorder sku "Auto SKU add to cart moq" and quantity "1"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ not met in cart detail
      | sku                      | message                                   | counter |
      | Auto SKU add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 7  |
    And Check item in Cart detail
      | brand                      | product                      | sku                      | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU add to cart moq | $10.00 | 1        | $10.00 |
    And Update quantity item "Auto SKU add to cart moq" to "7" in Cart detail
    And Check MOQ not met in cart detail
      | sku                      | message | counter |
      | Auto SKU add to cart moq | [blank] | [blank] |

    And BUYER go to catalog "All"
    And Clear cart to empty in cart before
    And Buyer go to "Samples" from dashboard
    And Go to sample request detail with number "create by api"
    And Add to cart sku "Auto SKU add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Admin add region by API
      | region             | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | 31025 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name             | description      | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Test add to cart | Test add to cart | 2022-06-14 | [blank]    | 1           | [blank]    | 1                | true           | [blank] | default    | [blank]       |

##    Promotion screen
#    And Go to tab "Promotions"
#    And Search promotions by info
#      | brandName                  | orderBrand | time    |
#      | Auto brand add to cart moq | [blank]    | [blank] |
#    And Buyer add to card sku "Auto SKU add to cart moq" from promo detail
#    And Check MOQ not met
#      | message                                              | counter |
#      | Please order more cases to reach SKU MOQ. Thank you! | 6 cases |
#    And Close popup add cart
#  #    And Buyer add to card sku "Auto SKU 2 add to cart moq" from promo detail
##    And Check MOQ not met
##      | message                                                                                                                                              | counter |
##      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 3 cases |
#
#    Given NGOCTX login web admin by api
#      | email              | password  |
#      | ngoctx@podfoods.co | 12345678a |
#    And Admin search promotion by skuName "Auto SKU add to cart moq"
#    And Admin delete promotion by skuName "Auto SKU add to cart moq"
#    And Admin search promotion by skuName "Auto SKU 2 add to cart moq"
#    And Admin delete promotion by skuName "Auto SKU 2 add to cart moq"
##
###    //Update sku to pre order
##    And Update regions info of SKU "31029"
##      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
##      | 83041 | 58        | 31029              | 1000             | 1200       | coming_soon  | active |
##
##    And Verify pre-order in tag All of order just create
##      | date     | tag | store | creator      | total  |
##      | 06/23/22 | Pre | [blank]  | Auto Buyer40 | $10.00 |
#
#    And Update regions info of SKU "31029"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83041 | 58        | 31029              | 1000             | 1200       | in_stock     | active |
#    #Create recommendation
#    And Admin create recommendation by api
#      | buyer_id | _buyer | product_id | comment |
#      | 2985     | 2985   | 6366       | comment |
#    And Buyer go to "Orders" from dashboard
#
#    And Buyer go to Pre-order detail number "create by api"
#    And Add to cart sku "Auto SKU add to cart moq" from Pre-order detail
#    And Check MOQ not met
#      | message                                              | counter |
#      | Please order more cases to reach SKU MOQ. Thank you! | 6 cases |
#    And Close popup add cart
#  #    recomment
#    And Go to Recommended products
#    And Add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "1" from product list
#    And Check MOQ not met
#      | message                                              | counter |
#      | Please order more cases to reach SKU MOQ. Thank you! | 6 cases |
#    And Close popup add cart
#    And Clear cart to empty in cart before

  @addToCart57
  Scenario: Check showing a MOQ alert to help buyers meet the MOQ if they don't meet when putting a SKU in cart with Sub PD head buyer role
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 5 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 5 add to cart moq"
    And Admin search promotion by skuName "Auto SKU 6 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 6 add to cart moq"
    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83070 | 58        | 31044              | 1000             | 1200       | in_stock     | active |
    And Update regions info of SKU "31045"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83071 | 26        | 31045              | 2000             | 2400       | in_stock     | active |
    And Admin add SKUs sample request by API
      | product_variant_id | variants_region_id |
      | 31044              | 83070              |
      | 31045              | 83071              |
    And Admin create sample request by API
      | buyer_ids | buyer_id | product_ids | store_id | vendor_company_id | payment_type | attn    | street1            | city     | address_state_id | address_state_code | address_state_name | zip   | fulfillment_date | fulfillment_state |
      | 2977      | 2977     | 6371        | 2724     | 1854              | invoice      | [blank] | 455 Madison Avenue | New York | 33               | NY                 | New York           | 10022 | [blank]          | pending           |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer44@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                        | sku                        | amount |
      | Auto product 3 add to cart moq | Auto SKU 5 add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add cart from product detail
      | product                        | sku                        | amount |
      | Auto product 3 add to cart moq | Auto SKU 5 add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Search and check moq when add cart product from popup
      | product                        | sku                        | amount |
      | Auto product 3 add to cart moq | Auto SKU 5 add to cart moq | 7      |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Search Brand and go to detail
      | brand                      | productName                    | unitPrice | numberSku |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | $10.00    | [blank]   |
    And Add to cart product "Auto product 3 add to cart moq" sku "Auto SKU 5 add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
  #Check is met
    And Add to cart product "Auto product 3 add to cart moq" sku "Auto SKU 5 add to cart moq" and quantity "7" from product list
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
#    And Clear cart to empty in cart before
    And Go to product detail "Auto product 3 add to cart moq" from product list of Brand
    And Buyer choose SKU "Auto SKU 5 add to cart moq" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $12.00 | 7            | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |
    And Clear cart to empty in cart before

    And Buyer choose SKU "Auto SKU 6 add to cart moq" in product detail
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack        |
      | 121212121212 | 17%         | $24.00 | 5            | 12" x 12" x 12" | 12" x 12" x 12" | 12.0 g   | 1 unit per case |
    And Clear cart to empty in cart before
    And Add to cart the sku "Auto SKU 6 add to cart moq" with quantity = "1"
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Verify item on cart tab on right side
      | brand                      | product                        | sku                        | price  | quantity |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | Auto SKU 6 add to cart moq | $20.00 | 1        |
    And Add product "Auto product 3 add to cart moq" to favorite
#    Favorite screen
    And Go to favorite page of "Auto product 3 add to cart moq"
    And Click add to cart product "Auto product 3 add to cart moq" sku "Auto SKU 5 add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
     #   check is met
    And Click add to cart product "Auto product 3 add to cart moq" sku "Auto SKU 5 add to cart moq" and quantity "7" from product list
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Click add to cart product "Auto product 3 add to cart moq" sku "Auto SKU 6 add to cart moq" and quantity "1" from favorite page
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Verify item on cart tab on right side
      | brand                      | product                        | sku                        | price  | quantity |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | Auto SKU 6 add to cart moq | $20.00 | 1        |
##Order guide
    And Go to tab "Order guide"
    And Clear cart to empty in cart before
    And Add cart sku "Auto SKU 5 add to cart moq" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add cart sku "Auto SKU 6 add to cart moq" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Verify item on cart tab on right side
      | brand                      | product                        | sku                        | price  | quantity |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | Auto SKU 6 add to cart moq | $20.00 | 1        |
    And Clear cart to empty in cart before

    And Buyer go to "Orders" from dashboard
    And Go to order detail with order number "220624576"
    And Buyer reorder sku "Auto SKU 5 add to cart moq" and quantity "1"
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU 5 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 7  |
      | Auto SKU 6 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |
    And Check item in Cart detail
      | brand                      | product                        | sku                        | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | Auto SKU 5 add to cart moq | $10.00 | 1        | $10.00 |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | Auto SKU 6 add to cart moq | $20.00 | 1        | $20.00 |
    And Update quantity item "Auto SKU 5 add to cart moq" to "7" in Cart detail
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU 5 add to cart moq | [blank]                                   | [blank] |
      | Auto SKU 6 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |

    And BUYER go to catalog "All"
    And Clear cart to empty in cart before
    And Buyer go to "Samples" from dashboard
    And Go to sample request detail with number "create by api"
    And Add to cart sku "Auto SKU 5 add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add to cart sku "Auto SKU 6 add to cart moq" from sample request
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check item in Cart detail
      | brand                      | product                        | sku                        | price  | quantity | total  |
      | Auto brand add to cart moq | Auto product 3 add to cart moq | Auto SKU 6 add to cart moq | $20.00 | 1        | $20.00 |
    And Check MOQ not met in cart detail
      | sku                        | message                                   | counter |
      | Auto SKU 6 add to cart moq | Please order more cases to reach SKU MOQ. | MOQ: 5  |
#
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 31045 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
      | [blank]             | [blank]   | 31044 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name             | description      | starts_at  | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Test add to cart | Test add to cart | 2022-06-14 | [blank]    | 1           | [blank]    | 1                | true           | [blank] | default    | [blank]       |

#    Promotion screen
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                  | orderBrand | time    |
      | Auto brand add to cart moq | [blank]    | [blank] |
    And Buyer add to card sku "Auto SKU 5 add to cart moq" from promo detail
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Buyer add to card sku "Auto SKU 6 add to cart moq" from promo detail
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 3 cases |
    And Close popup add cart
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU 5 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 5 add to cart moq"
    And Admin search promotion by skuName "Auto SKU 6 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 6 add to cart moq"
    And Admin search product recommendation Buyer id "2977" by api
    And Admin delete product recommendation by api
#    //Update sku to pre order
    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83070 | 58        | 31044              | 1000             | 1200       | coming_soon  | active |

    And Verify pre-order in tab All of order "#220624187P"
      | date     | tag | store                              | creator      | total  |
      | 06/24/22 | Pre | Auto store 2 check add to cart moq | Auto Buyer44 | $10.00 |

    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83070 | 58        | 31044              | 1000             | 1200       | in_stock     | active |
        #Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id | comment |
      | 2977     | 2977   | 6371       | comment |

    And Buyer go to Pre-order detail number "220624187P"
    And Add to cart sku "Auto SKU 5 add to cart moq" from Pre-order detail
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Search item "Auto SKU 5 add to cart moq"
#    recomment
    And Go to Recommended products
    And Add to cart product "Auto product 3 add to cart moq" sku "Auto SKU 5 add to cart moq" and quantity "1" from product list
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Clear cart to empty in cart before

  @addToCart73
  Scenario: Check applying correctly Regional limits when switching between MOV and MOQ PD Head Buyer
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                               | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company switch mov moq"
    And Admin update Regional limit of vendor company to "MOQ"

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer45@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                     | sku                     | amount |
      | Auto product switch mov moq | Auto SKU switch mov moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    Given Switch to actor ADMIN
    And Admin update Regional limit of vendor company to "MOV"

    Given Switch to actor BUYER
    And Add cart from product detail
      | product                     | sku                     | amount |
      | Auto product switch mov moq | Auto SKU switch mov moq | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    Given Switch to actor ADMIN
    And Admin update Regional limit of vendor company to "MOQ"

    Given Switch to actor BUYER
    And Search and check moq when add cart product from popup
      | product                     | sku                     | amount |
      | Auto product switch mov moq | Auto SKU switch mov moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart

  @addToCart77
  Scenario: Change availability of an item on the MOV alert
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | inactive |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active   |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83091 | 26        | 31061              | 1000             | 1000       | in_stock     | active   |
      | 83092 | 58        | 31061              | 1000             | 1000       | in_stock     | inactive |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
    And Admin update Regional limit of vendor company to "MOV"

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |

    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
    And Clear cart to empty in cart before
    And Add to cart the sku "Auto SKU 3 switch mov moq" with quantity = "2"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $480.00 |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Add to cart the sku "Auto SKU 4 switch mov moq" with quantity = "2"
    And Verify item on cart tab on right side
      | brand                       | product                       | sku                       | price  | quantity |
      | Auto brand 2 switch mov moq | Auto product 3 switch mov moq | Auto SKU 4 switch mov moq | $10.00 | 2        |
#
#    And Admin change info of regions attributes with sku "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83091 | 26        | 31061              | 1000             | 1000       | coming_soon  | active |
#    And Add to cart the sku "Auto SKU 4 switch mov moq" with quantity = "2"
#    And Verify alert validation field
#      | Validation failed: "Auto brand 2 switch mov moq Auto SKU 4 switch mov moq" will be available soon. |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason   |
      | 83091 | 26        | 31061              | 1000             | 1000       | sold_out     | active | pending_replenishment |
    And Add to cart the sku "Auto SKU 4 switch mov moq" with quantity = "2"
    And Verify alert validation field
      | Validation failed: "Auto brand 2 switch mov moq Auto SKU 4 switch mov moq" is sold out. |

  @TC_75_84
  Scenario: Change PD item to PE item on the MOV alert
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | inactive |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active   |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83091 | 26        | 31061              | 1000             | 1000       | in_stock     | active   |
      | 83092 | 58        | 31061              | 1000             | 1000       | in_stock     | inactive |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
    And Admin update Regional limit of vendor company to "MOV"
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |

    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |

    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |

    And Add to cart the sku "Auto SKU 3 switch mov moq" with quantity = "2"
#    And Check MOV not met
#      | message                                                                                                                                                              | counter |
#      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $480.00 |
    And Verify item on cart tab on right side
      | brand                       | product                       | sku                       | price   | quantity |
      | Auto brand 2 switch mov moq | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | $500.00 | 3        |

  @TC_79_80
  Scenario: Change state of an item from active to draft or inactive on the MOV alert
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | inactive |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active   |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83091 | 26        | 31061              | 1000             | 1000       | in_stock     | active   |
      | 83092 | 58        | 31061              | 1000             | 1000       | in_stock     | inactive |
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
    And Admin update Regional limit of vendor company to "MOV"
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |

#    Change state to draft
    And Admin change info of regions attributes of sku "Auto SKU 3 switch mov moq" state "draft"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
    And Buyer update cart of MOV alert with info
      | sku                       | quantity |
      | Auto SKU 3 switch mov moq | 50       |
    And Buyer update cart of MOV alert success
    And Vendor check alert message
      | Item has been updated or deleted |

#  Change state to draft
    And Admin change info of regions attributes of sku "Auto SKU 3 switch mov moq" state "inactive"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
    And Buyer update cart of MOV alert with info
      | sku                       | quantity |
      | Auto SKU 3 switch mov moq | 50       |
    And Buyer update cart of MOV alert success
    And Vendor check alert message
      | Item has been updated or deleted |

    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | inactive |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active   |

  @TC_85
  Scenario: Change PD item to PE item on the MOQ alert
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | inactive |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active   |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
    And Admin update Regional limit of vendor company to "MOQ"
    And Admin change MOQ value of product "6375" by API
      | id    | moq | product_id | region_id |
      | 56401 | 5   | 6375       | 58        |
    And Admin change MOQ value of product "6375" by API
      | id    | moq | product_id | region_id |
      | 56394 | 5   | 6375       | 26        |

#    PD buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer45@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
#
  #    PD buyer
    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
#
    #    Change PD to PE item
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active   |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | inactive |
    And Switch to actor BUYER2
    And Change quantity of skus in MOQ alert
      | skuName                   | quantity |
      | Auto SKU 3 switch mov moq | 5        |
#    And Update cart MOQ Alert
    And Click on button "Add to Cart"
    And Vendor check alert message
      | Item has been updated or deleted |

    And Switch to actor BUYER
    And Change quantity of skus in MOQ alert
      | skuName                   | quantity |
      | Auto SKU 3 switch mov moq | 5        |
#    And Update cart MOQ Alert
    And Click on button "Add to Cart"
    And Vendor check alert message
      | Item has been updated or deleted |

  @TC_87
  Scenario: Change PE item to PD item on the MOQ alert
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active   |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | inactive |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83091 | 26        | 31061              | 1000             | 1000       | in_stock     | active   |
      | 83092 | 58        | 31061              | 1000             | 1000       | in_stock     | inactive |
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
    And Admin update Regional limit of vendor company to "MOQ"

  #    PE buyer
    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    #    Change PE to PD item
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | inactive |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active   |

    And Change quantity of skus in MOQ alert
      | skuName                   | quantity |
      | Auto SKU 3 switch mov moq | 5        |
#    And Update cart MOQ Alert
    And Click on button "Add to Cart"
    And Vendor check alert message
      | Item has been updated or deleted |

  @TC_83
  Scenario: Change MOV value of vendor company
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | inactive |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active   |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83091 | 26        | 31061              | 1000             | 1000       | in_stock     | active   |
      | 83092 | 58        | 31061              | 1000             | 1000       | in_stock     | inactive |

    And Admin update limit type of vendor company "1856" to "mov" by api
    And Admin update limit region id "58" of vendor company "1856" to "50000" by api

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |

    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
    And Admin edit region MOV of vendor company
      | region             | value |
      | Pod Direct Central | 20    |
    And Admin check region MOV of vendor company
      | region             | value |
      | Pod Direct Central | 20    |

    And Switch to actor BUYER
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $10.00  |
    And Close popup add cart
    And Switch to actor ADMIN
    And Admin edit region MOV of vendor company
      | region             | value |
      | Pod Direct Central | 500   |
    And Switch to actor BUYER
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |

    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart

  @TC_91 @TC_103
  Scenario: Change state of an item from active to draft or inactive on the MOQ alert
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active |
    And Admin change MOQ value of product "6375" by API
      | id    | moq | product_id | region_id |
      | 56401 | 5   | 6375       | 58        |
    And Admin change MOQ value of product "6375" by API
      | id    | moq | product_id | region_id |
      | 56394 | 5   | 6375       | 26        |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
    And Admin update Regional limit of vendor company to "MOQ"
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product                       | sku                       | amount |
      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
#
##    Change state to draft
#    And Admin change info of regions attributes of sku "Auto SKU 3 switch mov moq" state "draft"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
#    And Change quantity of skus in MOQ alert
#      | skuName                   | quantity |
#      | Auto SKU 3 switch mov moq | 5        |
#    And Update cart MOQ Alert
#    And Vendor check alert message
#      | Item has been updated or deleted |
#
##  Change state to inactive
#    And Admin change info of regions attributes of sku "Auto SKU 3 switch mov moq" state "inactive"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
#    And Change quantity of skus in MOQ alert
#      | skuName                   | quantity |
#      | Auto SKU 3 switch mov moq | 5        |
#    And Update cart MOQ Alert
#    And Vendor check alert message
#      | Item has been updated or deleted |
#
#    And Admin change info of regions attributes with sku "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
#      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active |

#  @TC_101 # Page missing when change out of stock
#  Scenario: Change availability of an item
#    Given NGOCTX login web admin by api
#      | email              | password  |
#      | ngoctx@podfoods.co | 12345678a |
#    And Admin change info of regions attributes with sku "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | out_of_stock_reason | inventory_receiving_date |
#      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active | [blank]             | [blank]                  |
#      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active | [blank]             | [blank]                  |
#
#    Given ADMIN open web admin
#    When ADMIN login to web with role Admin
#    And ADMIN navigate to "Vendors" to "Companies" by sidebar
#    And Admin search vendor company
#      | name                                 | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
#      | Auto Vendor company 2 switch mov moq | [blank]    | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
#    And Admin go to detail vendor company "Auto Vendor company 2 switch mov moq"
#    And Admin update Regional limit of vendor company to "MOQ"
#
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
#    And Clear cart to empty in cart before
#    And Add cart from product detail
#      | product                       | sku                       | amount |
#      | Auto product 3 switch mov moq | Auto SKU 3 switch mov moq | 1      |
#    And Check MOQ not met
#      | message                                                                                                                                              | counter |
#      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
##
###    Change state to draft
##    And Admin change info of regions attributes of sku "Auto SKU 3 switch mov moq" state "active"
##      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
##      | 83090 | 26        | 31060              | 50000            | 50000      | coming_soon  | active |
##    And Change quantity of skus in MOQ alert
##      | skuName                   | quantity |
##      | Auto SKU 3 switch mov moq | 5        |
##    And Update cart MOQ Alert
##    And Vendor check alert message
##      | Validation failed: "Auto brand 2 switch mov moq Auto SKU 3 switch mov moq" will be available soon. |
#
##  Change availability of an item
#    And Admin change info of regions attributes of sku "Auto SKU 3 switch mov moq" state "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83090 | 26        | 31060              | 50000            | 50000      | sold_out     | active |
#    And Change quantity of skus in MOQ alert
#      | skuName                   | quantity |
#      | Auto SKU 3 switch mov moq | 5        |
#    And Update cart MOQ Alert
#    And BUYER check alert message
#      | Validation failed: "Auto brand 2 switch mov moq Auto SKU 3 switch mov moq" is sold out. |
#
#    And Admin change info of regions attributes with sku "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
#      | 83090 | 26        | 31060              | 50000            | 50000      | in_stock     | active |
#      | 83089 | 58        | 31060              | 1000             | 1000       | in_stock     | active |

  @TC_97
  Scenario: Check showing a MOQ alert to help buyers meet the MOQ if they don't meet when putting a SKU in cart with Sub PE head buyer role
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |

    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83070 | 58        | 31044              | 1000             | 1200       | in_stock     | active   |
      | 91960 | 26        | 31044              | 1000             | 1200       | in_stock     | inactive |
    And Update regions info of SKU "31045"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 83071 | 26        | 31045              | 2000             | 2400       | in_stock     | active |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer44@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                        | sku                        | amount |
      | Auto product 3 add to cart moq | Auto SKU 5 add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |

    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 83070 | 58        | 31044              | 1000             | 1200       | in_stock     | inactive |
      | 91960 | 26        | 31044              | 1000             | 1200       | in_stock     | active   |
    And Change quantity of skus in MOQ alert
      | skuName                    | quantity |
      | Auto SKU 5 add to cart moq | 7        |
    And Click on dialog button "Add to cart"
    And Buyer check alert message
      | Item has been updated or deleted |

    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer46@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                        | sku                        | amount |
      | Auto product 3 add to cart moq | Auto SKU 5 add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |

    And Update regions info of SKU "31044"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 91960 | 26        | 31044              | 1000             | 1200       | in_stock     | inactive |
      | 83070 | 58        | 31044              | 1000             | 1200       | in_stock     | active   |
    And Change quantity of skus in MOQ alert
      | skuName                    | quantity |
      | Auto SKU 5 add to cart moq | 5        |
    And Click on dialog button "Add to cart"
    And Buyer check alert message
      | Item has been updated or deleted |

  @TC_999
  Scenario: Reset data
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin search promotion by skuName "Auto SKU add to cart mov"
    And Admin delete promotion by skuName "Auto SKU add to cart mov"
    And Admin search promotion by skuName "Auto SKU 2 add to cart mov"
    And Admin delete promotion by skuName "Auto SKU 2 add to cart mov"
    And Admin search promotion by skuName "Auto SKU 5 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 5 add to cart moq"
    And Admin search promotion by skuName "Auto SKU 6 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 6 add to cart moq"
    And Admin search promotion by skuName "Auto SKU 3 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU add to cart moq"
    And Admin search promotion by skuName "Auto SKU 4 add to cart moq"
    And Admin delete promotion by skuName "Auto SKU 4 add to cart moq"
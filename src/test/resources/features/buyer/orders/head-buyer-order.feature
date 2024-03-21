@feature=buyerOrder
Feature: Head Buyer Order

  @B_ORDERS_215
  Scenario: HEAD BUYER - CREATE ORDER
    Given AUTO_BAO@21 login web admin by api
      | email             | password  |
      | bao21@podfoods.co | 12345678a |
    And Admin search product name "Auto hb prd create order 1 api" by api
    And Admin delete product name "Auto hb prd create order 1 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | Auto hb prd create order 1 api | 3018     |
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp |
      | New York Express | 53 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                           | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | Auto hb sku create order 1 api | active | 1          | 0          | 123123123215 | 123123123215 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |

    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                           | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | Auto hb sku create order 2 api | active | 1          | 0          | 123123123216 | 123123123216 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
#
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+autobuyer66@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Head buyer go to create multi order
    And Head buyer add store to create multi order
      | value                     |
      | Auto store switch mov moq |
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                            |
      | Auto hb sku create order 1 api |
    And Head buyer verify info sku in add sku popup of create multi order
      | sku     | product | brand   | upc     | skuID   |
      | [blank] | [blank] | [blank] | [blank] | [blank] |
    And Buyer close popup
    And Head buyer add store to create multi order
      | value                              |
      | Auto store 2 check add to cart moq |
      | Auto Store check Orrder NY         |
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                            |
      | Auto hb prd create order 1 api |
    And Head buyer verify info sku in add sku popup of create multi order
      | sku                            | product                        | brand                     | upc                       | skuID |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123215 | #     |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123216 | #     |
    And Buyer close popup
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                            |
      | Auto hb sku create order 2 api |
    And Head buyer verify info sku in add sku popup of create multi order
      | sku                            | product                        | brand                     | upc                       | skuID |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123216 | #     |
    And Buyer close popup
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku          |
      | 123123123216 |
    And Head buyer verify info sku in add sku popup of create multi order
      | sku                            | product                        | brand                     | upc                       | skuID |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123216 | #     |
    And Buyer close popup
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                       |
      | Auto brand create product |
    And Head buyer verify info sku in add sku popup of create multi order
      | sku                            | product                        | brand                     | upc                       | skuID |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123215 | #     |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123216 | #     |
    And Head buyer add sku to create multi order
      | sku                            |
      | Auto hb sku create order 1 api |
      | Auto hb sku create order 2 api |
    And Head buyer add sku success to create multi order
    And Head buyer verify sku added to create multi order
      | sku                            | product                        | brand                     | image           | id            |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                            |
      | Auto hb prd create order 1 api |
    And Head buyer verify info sku in add sku popup of create multi order
      | sku                            | product                        | brand                     | upc                       | skuID |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123215 | #     |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | Unit UPC/EAN 123123123216 | #     |
    And Head buyer verify sku added in popup create multi order
      | sku                            |
      | Auto hb sku create order 1 api |
      | Auto hb sku create order 2 api |
    And Buyer close popup
    And Head buyer remove added store create multi order
      | store                              |
      | Auto store switch mov moq          |
      | Auto store 2 check add to cart moq |
      | Auto Store check Orrder NY         |
    And Buyer check error message is showing of fields
      | field      | message                    |
      | Add stores | This field cannot be blank |
    And Check button "Next" is disable
    And Head buyer add store to create multi order
      | value                     |
      | Auto store switch mov moq |
    And Head buyer next to create multi order
    And Buyer check alert message
      | Selected sku(s) are not available for selected store(s) |
    And Head buyer add store to create multi order
      | value                              |
      | Auto store 2 check add to cart moq |
      | Auto Store check Orrder NY         |
    And Head buyer next to create multi order
    # Verify buyer 1
    And Head buyer verify item in order of store "Auto Store check Orrder NY"
      | sku                            | product                        | brand                     | skuID | upc                          | unit        | price   | oldPrice | amount  | error                                    |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | api   | Unit UPC / EAN: 123123123215 | 1 unit/case | $10.00  | [blank]  | 1       | [blank]                                  |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | api   | Unit UPC / EAN: 123123123216 | [blank]     | [blank] | [blank]  | [blank] | This item is not available to the store. |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total   |
      | $10.00     | [blank]   | $10.00   | [blank] | [blank]         | [blank] | [blank] |
#     # Verify buyer 2
  # Verify buyer 1
    And Head buyer verify item in order of store "Auto store 2 check add to cart moq"
      | sku                            | product                        | brand                     | skuID | upc                          | unit        | price   | oldPrice | amount  | error                                    |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | api   | Unit UPC / EAN: 123123123216 | 1 unit/case | $10.00  | [blank]  | 1       | [blank]                                  |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | api   | Unit UPC / EAN: 123123123215 | [blank]     | [blank] | [blank]  | [blank] | This item is not available to the store. |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total   |
      | $10.00     | [blank]   | $10.00   | [blank] | [blank]         | [blank] | [blank] |

    And Head buyer add favorite on create multiple orders page
      | sku                            | store                              |
      | Auto hb sku create order 1 api | Auto store 2 check add to cart moq |
      | Auto hb sku create order 2 api | Auto Store check Orrder NY         |
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Head buyer go to create multi order
    And Head buyer check favorite sku info on create multiple orders page
      | sku                            | product                        | brand                     | image           | id            |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
    And Head buyer check default favorite sku on create multiple orders page
      | sku                            |
      | Auto hb sku create order 1 api |
      | Auto hb sku create order 2 api |
    And Head buyer add store to create multi order
      | value                      |
      | Auto Store check Orrder NY |
    And Head buyer add from favorite sku on create multiple orders page
      | sku                            |
      | Auto hb sku create order 1 api |
      | Auto hb sku create order 2 api |
    And Head buyer verify sku added to create multi order
      | sku                            | product                        | brand                     | image           | id            |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
    And Head buyer next to create multi order
    # Verify buyer 1
    And Head buyer verify item in order of store "Auto Store check Orrder NY"
      | sku                            | product                        | brand                     | skuID | upc                          | unit        | price   | oldPrice | amount  | error                                    |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | api   | Unit UPC / EAN: 123123123215 | 1 unit/case | $10.00  | [blank]  | 1       | [blank]                                  |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | api   | Unit UPC / EAN: 123123123216 | [blank]     | [blank] | [blank]  | [blank] | This item is not available to the store. |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total   |
      | $10.00     | [blank]   | $10.00   | [blank] | [blank]         | [blank] | [blank] |
    And Click on any text "< Back"
    And Head buyer verify sku added to create multi order
      | sku                            | product                        | brand                     | image           | id            |
      | Auto hb sku create order 1 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
      | Auto hb sku create order 2 api | Auto hb prd create order 1 api | Auto brand create product | masterImage.jpg | create by api |
    Given AUTO_BAO@21 login web admin by api
      | email             | password  |
      | bao21@podfoods.co | 12345678a |
    And Admin search product name "Auto hb prd create order 1 api" by api
    And Admin delete product name "Auto hb prd create order 1 api" by api

  @B_ORDERS_232
  Scenario: HEAD BUYER - CREATE ORDER 2
    Given AUTO_BAO@21 login web admin by api
      | email             | password  |
      | bao21@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto hb prd create order 232 api" by api
    And Admin search product name "Auto hb prd create order 232 api" by api
    And Admin delete product name "Auto hb prd create order 232 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | Auto hb prd create order 232 api | 3018     |
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp |
      | New York Express | 53 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                             | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | Auto hb sku create order 232 api | active | 1          | 0          | 123123123232 | 123123123232 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |

    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                             | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | Auto hb sku create order 233 api | active | 1          | 0          | 123123123233 | 123123123233 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
#
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+autobuyer66@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Head buyer go to create multi order
    And Head buyer add store to create multi order
      | value                              |
      | Auto store 2 check add to cart moq |
      | Auto Store check Orrder NY         |
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                              |
      | Auto hb prd create order 232 api |
    And Head buyer add sku to create multi order
      | sku                              |
      | Auto hb sku create order 232 api |
      | Auto hb sku create order 233 api |
    And Head buyer add sku success to create multi order
    And Head buyer next to create multi order
    # Verify buyer 1
    And Head buyer verify item in order of store "Auto Store check Orrder NY"
      | sku                              | product                          | brand                     | skuID | upc                          | unit        | price   | oldPrice | amount  | error                                    |
      | Auto hb sku create order 232 api | Auto hb prd create order 232 api | Auto brand create product | api   | Unit UPC / EAN: 123123123232 | 1 unit/case | $10.00  | [blank]  | 1       | [blank]                                  |
      | Auto hb sku create order 233 api | Auto hb prd create order 232 api | Auto brand create product | api   | Unit UPC / EAN: 123123123233 | [blank]     | [blank] | [blank]  | [blank] | This item is not available to the store. |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total   |
      | $10.00     | [blank]   | $10.00   | [blank] | [blank]         | [blank] | [blank] |
#     # Verify buyer 2
  # Verify buyer 1
    And Head buyer verify item in order of store "Auto store 2 check add to cart moq"
      | sku                              | product                          | brand                     | skuID | upc                          | unit        | price   | oldPrice | amount  | error                                    |
      | Auto hb sku create order 233 api | Auto hb prd create order 232 api | Auto brand create product | api   | Unit UPC / EAN: 123123123233 | 1 unit/case | $10.00  | [blank]  | 1       | [blank]                                  |
      | Auto hb sku create order 232 api | Auto hb prd create order 232 api | Auto brand create product | api   | Unit UPC / EAN: 123123123232 | [blank]     | [blank] | [blank]  | [blank] | This item is not available to the store. |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total   |
      | $10.00     | [blank]   | $10.00   | [blank] | [blank]         | [blank] | [blank] |
    And Head buyer create order with info
      | store                      | buyer        | customerPO       |
      | Auto Store check Orrder NY | Auto Buyer22 | Auto customer PO |
#    And Head buyer change buyer of store "Auto Buyer22" to buyer "Auto Buyer22" order of create multi order
    And Head buyer change buyer of store "Auto store 2 check add to cart moq" to buyer "Auto Buyer44" order of create multi order
   # Verify buyer 1
    And Head buyer verify item in order of store "Auto store 2 check add to cart moq"
      | sku                              | product                          | brand                     | skuID | upc                          | unit        | price   | oldPrice | amount  | error                                         |
      | Auto hb sku create order 233 api | Auto hb prd create order 232 api | Auto brand create product | api   | Unit UPC / EAN: 123123123233 | 1 unit/case | $10.00  | [blank]  | 1       | This item is not available to this sub-buyer. |
      | Auto hb sku create order 232 api | Auto hb prd create order 232 api | Auto brand create product | api   | Unit UPC / EAN: 123123123232 | [blank]     | [blank] | [blank]  | [blank] | This item is not available to the store.      |


  @B_ORDERS_239
  Scenario: HEAD BUYER - CREATE ORDER Check display condition of pre-promotion price/case (when no usage limit is set for promotions)
    Given AUTO_BAO@21 login web admin by api
      | email             | password  |
      | bao21@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto hb order Promotion"
    And Admin delete promotion by skuName "Auto hb order Promotion"
    And Admin delete order by sku of product "Auto hb prd create order 239 api" by api
    And Admin search product name "Auto hb prd create order 239 api" by api
    And Admin delete product name "Auto hb prd create order 239 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | Auto hb prd create order 239 api | 3018     |
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp |
      | New York Express | 53 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                             | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | Auto hb sku create order 239 api | active | 1          | 0          | 123123123939 | 123123123939 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
#  //Create promotion
    And Admin add region by API
      | region           | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | true  | 1      |
      | PromotionActions::PercentageAdjustment | 0.15        | true  | 15     |
    And Admin create promotion by api with info
      | type                  | name                    | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto hb order Promotion | Test        | currentDate | currentDate | [blank]     | 100        | 1                | true           | [blank] | stacked    | currentDate   |

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+autobuyer66@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Head buyer go to create multi order
    And Head buyer add store to create multi order
      | value                      |
      | Auto Store check Orrder NY |
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                              |
      | Auto hb prd create order 239 api |
    And Head buyer add sku to create multi order
      | sku                              |
      | Auto hb sku create order 239 api |
    And Head buyer add sku success to create multi order
    And Head buyer next to create multi order
    And Head buyer verify item in order of store "Auto Store check Orrder NY"
      | sku                              | product                          | brand                     | skuID | upc                          | unit        | price | oldPrice | amount | error   |
      | Auto hb sku create order 239 api | Auto hb prd create order 239 api | Auto brand create product | api   | Unit UPC / EAN: 123123123939 | 1 unit/case | $9.00 | $10.00   | 1      | [blank] |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total |
      | $10.00     | -$1.00    | $9.00    | [blank] | [blank]         | [blank] | $9.00 |
    And Head buyer edit amount of item create multiple order
      | sku                              | store                      | amount |
      | Auto hb sku create order 239 api | Auto Store check Orrder NY | 15     |
    And Head buyer verify item in order of store "Auto Store check Orrder NY"
      | sku                              | product                          | brand                     | skuID | upc                          | unit        | price | oldPrice | amount | error   |
      | Auto hb sku create order 239 api | Auto hb prd create order 239 api | Auto brand create product | api   | Unit UPC / EAN: 123123123939 | 1 unit/case | $8.50 | $10.00   | 15     | [blank] |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total   |
      | $150.00    | -$22.50   | $127.50  | [blank] | [blank]         | [blank] | $127.50 |

  @B_ORDERS_243
  Scenario: HEAD BUYER - CREATE ORDER Check display condition of pre-promotion price/case (when usage limit is set for promotions)
    Given AUTO_BAO@21 login web admin by api
      | email             | password  |
      | bao21@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto hb order Promotion"
    And Admin delete promotion by skuName "Auto hb order Promotion"
    And Admin delete order by sku of product "Auto hb prd create order 243 api" by api
    And Admin search product name "Auto hb prd create order 243 api" by api
    And Admin delete product name "Auto hb prd create order 243 api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | Auto hb prd create order 243 api | 3018     |
    And Info of Region
      | region           | id | state  | availability | casePrice | msrp |
      | New York Express | 53 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU of product "" by api
      | name                             | state  | case_units | msrp_cents | code         | case_code    | barcode_type  | masterImage     | barcodeImage | caseImage   | nutritionLabelImage | masterCartonImage  | master_carton_code | storage_shelf_life | shelf_life_condition_id | pull_threshold_use_default_value | pull_threshold | retail_shelf_life | retail_shelf_life_id | max_temperature | min_temperature | city  | address_state_id | nutrition_description | low_quantity_threshold | expiry_day_threshold | lead_time      | position | ingredients        | description        |
      | Auto hb sku create order 243 api | active | 1          | 0          | 123123124339 | 123123124339 | Barcodes::Upc | masterImage.jpg | UPCImage.png | anhJPEG.jpg | nutritionImage.jpg  | nutritionImage.jpg | 123                | 1                  | 1                       | true                             | [blank]        | 1                 | 1                    | 1               | 1               | Bronx | 1                | nutrition description | 10                     | 100                  | Auto lead time | 1        | Auto ingredients 1 | Auto description 1 |
#  //Create promotion
    And Admin add region by API
      | region           | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | true  | 1      |
      | PromotionActions::PercentageAdjustment | 0.15        | true  | 15     |
    And Admin create promotion by api with info
      | type                  | name                    | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto hb order Promotion | Test        | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | stacked    | currentDate   |

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+autobuyer66@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Head buyer go to create multi order
    And Head buyer add store to create multi order
      | value                      |
      | Auto Store check Orrder NY |
    And Head buyer go to add sku to create multi order
    And Head buyer search sku in add sku popup of create multi order
      | sku                              |
      | Auto hb prd create order 243 api |
    And Head buyer add sku to create multi order
      | sku                              |
      | Auto hb sku create order 243 api |
    And Head buyer add sku success to create multi order
    And Head buyer next to create multi order
    And Head buyer verify item in order of store "Auto Store check Orrder NY"
      | sku                              | product                          | brand                     | skuID | upc                          | unit        | price | oldPrice | amount | error   |
      | Auto hb sku create order 243 api | Auto hb prd create order 243 api | Auto brand create product | api   | Unit UPC / EAN: 123123124339 | 1 unit/case | $9.00 | $10.00   | 1      | [blank] |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total |
      | $10.00     | -$1.00    | $9.00    | [blank] | [blank]         | [blank] | $9.00 |
    And Head buyer edit amount of item create multiple order
      | sku                              | store                      | amount |
      | Auto hb sku create order 243 api | Auto Store check Orrder NY | 15     |
    And Head buyer verify item in order of store "Auto Store check Orrder NY"
      | sku                              | product                          | brand                     | skuID | upc                          | unit        | price | oldPrice | amount | error   |
      | Auto hb sku create order 243 api | Auto hb prd create order 243 api | Auto brand create product | api   | Unit UPC / EAN: 123123124339 | 1 unit/case | $9.90 | $10.00   | 15     | [blank] |
    And Head buyer verify cart summary of buyer "Auto Store check Orrder NY" in create multi order
      | orderValue | promotion | subTotal | sos     | specialDiscount | taxes   | total   |
      | $150.00    | -$1.50    | $148.50  | [blank] | [blank]         | [blank] | $148.50 |
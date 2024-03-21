#mvn verify -Dtestsuite="PromotionTestSuite4" -Dcucumber.options="src/test/resources/features/promotion"
@feature=Promotion4
Feature: Promotion4

  @PROMOTION_230
  Scenario: Verify that Vendor created a TPR promotion successfully
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 230 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
#    And Vendor select an Inventory Lot for create new Promotion
#      | lotCode | expiryDate |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |

    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany   |
      | Auto Vendor TPR Promotion 230 | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     | Auto Buyer Company Bao |
    Then Verify promotion show in All promotion page
      | name                          | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 230 | TPR  | CHI    | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 230"
    And Admin verify promotion detail
      | name                          | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor TPR Promotion 230 | TPR  | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check item on Promotion detail
      | product                        | sku                        | brand                     |
      | auto product vendor promotion1 | auto sku vendor promotion1 | Auto brand create product |
    And Admin Close the Create promotion form
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany   |
      | Auto Vendor TPR Promotion 230 | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     | Auto Buyer Company Bao |
    And Admin check no data found
    And BAO_ADMIN9 navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany   |
      | Auto Vendor TPR Promotion 230 | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     | Auto Buyer Company Bao |
    And Admin check no data found
    And BAO_ADMIN9 navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany   |
      | Auto Vendor TPR Promotion 230 | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     | Auto Buyer Company Bao |
#    And Admin check no data found

  @PROMOTION_231
  Scenario: Vendor create promotion - validate
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
#    And Admin search promotion by skuName "Auto_Check Promotions"
#    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Check any text "is" showing on screen
      | The promotion will be active from this date                                                              |
      | The promotion will be deactivated on this date. You can leave it blank if this is a permanent promotion. |
      | Leave your note here                                                                                     |
      | Select a type of promotion                                                                               |
      | You can select regions where you run this promotion                                                      |
      | You can select retailers you run this promotion for                                                      |
      | Please select SKUs you run this promotion for                                                            |
      | Enter case limit & case minimum                                                                          |
      | Enter usage limit                                                                                        |
      | Select the discount type of your product                                                                 |
    And  Vendor clear field "Case minimum"
    And Click on button "Create"
    And VENDOR check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field          | message                     |
      | Name           | This field cannot be blank. |
      | Start Date     | This field cannot be blank. |
      | Promotion type | This field cannot be blank. |
      | Case minimum   | This field cannot be blank  |
      | Discount Type  | This field cannot be blank. |
    And Check any text "is" showing on screen
      | Please select at least one.     |
      | Please select at least one sku. |
    And Vendor create Promotion with info
      | name                      | startDate | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | Plus1     | currentDate | Auto note | TPR (Temporary Price Reduction) | 0         | 0           | 0          | Percentage   | 10     |
    And Vendor check error message is showing of fields
      | field        | message                      |
      | Case limit   | Value must be greater than 0 |
      | Case minimum | Value must be greater than 0 |
      | Usage limit  | Value must be greater than 0 |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Vendor choose region for create new Promotion
      | Atlanta Express          |
      | Chicagoland Express      |
      | Florida Express          |
      | Denver Express           |
      | Mid Atlantic Express     |
      | New York Express         |
      | North California Express |
      | Phoenix Express          |
      | Sacramento Express       |
      | South California Express |
      | Dallas Express           |
      | Pod Direct Central       |
      | Pod Direct East          |
#      | Pod Direct Southeast           |
#      | Pod Direct Southwest & Rockies |
      | Pod Direct West          |
    And Vendor check error message not showing of fields
      | field          | message                     |
      | Name           | This field cannot be blank. |
      | Start Date     | This field cannot be blank. |
      | Promotion type | This field cannot be blank. |
      | Discount Type  | This field cannot be blank. |
    And Vendor create Promotion with info
      | name                      | startDate | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | Plus1     | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Percentage   | 10     |
    And Vendor check error message not showing of fields
      | field        | message                      |
      | Case limit   | Value must be greater than 0 |
      | Case minimum | Value must be greater than 0 |
      | Usage limit  | Value must be greater than 0 |
    And Click on button "Create"
    And VENDOR check alert message
      | Expires at must be after or equal to |
    And Vendor search specific buyer companies "Auto Buyer Company Bao2" and add to Promotion
      | [blank] |
    And Admin close dialog form

  @PROMOTION_247
  Scenario: Vendor create promotion - validate SKU popup
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
#    And Admin search promotion by skuName "Auto_Check Promotions"
#    And Admin delete promotion by skuName "Auto_Check Promotions"
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion247" by api
    And Admin delete product name "auto product vendor promotion247" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | auto product vendor promotion2472 | 3103     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion2472" of product ""

    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | auto product vendor promotion2471 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion2471" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | Plus1     | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Percentage   | 10     |
    And Vendor search specific SKU "auto sku vendor promotion2472" and add to Promotion
      | [blank] |
    And Vendor close popup
    And Vendor search specific SKU "auto sku vendor promotion2471" and add to Promotion
      | auto sku vendor promotion2471 |
    And Vendor remove specific SKU create Promotion
      | sku                           |
      | auto sku vendor promotion2471 |
    And Vendor search specific SKU "auto product vendor promotion2471" and add to Promotion
      | auto sku vendor promotion2471 |
    And Vendor remove specific SKU create Promotion
      | sku                           |
      | auto sku vendor promotion2471 |
    And Vendor search specific SKU "Auto brand create product" and add to Promotion
      | auto sku vendor promotion2471 |
    And Vendor search specific SKU "auto sku vendor promotion2471" and check SKU is selected
      | auto sku vendor promotion2471 |
    And Vendor close popup
    And Admin change state of product id "random" to inactive by api
    And Vendor remove specific SKU create Promotion
      | sku                           |
      | auto sku vendor promotion2471 |
    And Vendor search specific SKU "auto sku vendor promotion2471" and add to Promotion
      | [blank] |

  @PROMOTION_240
  Scenario: Check validation of the "Find lots by brand, product, SKU, or lot code..." search box
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion250 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion250" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion250" by api
    And Admin delete product name "auto product vendor promotion250" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion250 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion250" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion250 | random             | 5        | auto lot sku vendor promotion250 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                          | expiryDate |
      | auto product vendor promotion250 | auto lot sku vendor promotion250 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion250 | Auto brand create product | auto product vendor promotion250 | anhJPG2.jpg |
    And Vendor remove value on Input "Find lots by brand, product, SKU, or lot code..."
    And Vendor select an Inventory Lot for create new Promotion
      | search                       | lotCode                          | expiryDate |
      | auto sku vendor promotion250 | auto lot sku vendor promotion250 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion250 | Auto brand create product | auto product vendor promotion250 | anhJPG2.jpg |
    And Admin remove value on Input "Find lots by brand, product, SKU, or lot code..."
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                          | expiryDate |
      | auto lot sku vendor promotion250 | auto lot sku vendor promotion250 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion250 | Auto brand create product | auto product vendor promotion250 | anhJPG2.jpg |
    And Admin change state of product id "random" to inactive by api

    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                          | expiryDate |
      | auto lot sku vendor promotion250 | auto lot sku vendor promotion250 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion250 | Auto brand create product | auto product vendor promotion250 | anhJPG2.jpg |

      #  end quantity = 0
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 5        | Autotest |
    And VENDOR refresh browser
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor input invalid "Find lots by brand, product, SKU, or lot code..."
      | value                        |
      | auto sku vendor promotion250 |
    And Vendor input invalid "Find lots by brand, product, SKU, or lot code..."
      | value                            |
      | auto product vendor promotion250 |
    And Vendor input invalid "Find lots by brand, product, SKU, or lot code..."
      | value                            |
      | auto lot sku vendor promotion250 |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion250 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion250" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion250" by api
    And Admin delete product name "auto product vendor promotion250" by api

  @PROMOTION_255 @PROMOTION_261
  Scenario: Check validation of the Is this a case stack deal
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 3           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
    And Vendor create Promotion with info
      | name    | startDate | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | [blank] | [blank]   | [blank] | [blank] | [blank]       | [blank]   | 3           | [blank]    | [blank]      | [blank] |
    And Click on button "Create"
    And Vendor check error message is showing of fields
      | field        | message                                                                   |
      | Min quantity | Min quantity must be a valid number and cannot be lower than case minimum |
    And VENDOR refresh browser
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 3           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 2      |
      | 4           | 1      |
    And Click on button "Create"
    And VENDOR check alert message
      | Promotion actions Discount value should be increase proportionally as the min_qty |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_256 @PROMOTION_266
  Scenario: Vendor creates a promotion TPR
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 3           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
#    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
#      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
      | 3           | 3      |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores | start-date  | end-date    | discount                                                     |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | stores | currentDate | currentDate | 1 - 1 cases: $1.00 OI2 - 2 cases: $2.00 OI3+ cases: $3.00 OI |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                        | sku                        | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | Chicagoland Express | $10.00        | $7.00 ~ $9.00 |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                      | type | regions             | stores    | start       | end         | discount      |
      | [blank] | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | All store | currentDate | currentDate | $1.00 ~ $3.00 |

  @PROMOTION_263
  Scenario: Vendor creates a promotion Buy-in
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                         | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy in Promotion | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                        | type   | regions             | stores | start-date  | end-date    | discount | appliedBuyerCompany    | caseLimit |
      | Auto Vendor Buy in Promotion | Buy-in | Chicagoland Express | stores | currentDate | currentDate | 1%       | Auto Buyer Company Bao | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                        | sku                        | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | Chicagoland Express | $10.00        | $9.90         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                         | type   | regions             | stores   | start       | end         | discount |
      | [blank] | Auto Vendor Buy in Promotion | Buy-in | Chicagoland Express | 6 stores | currentDate | currentDate | 1%       |

  @PROMOTION_264
  Scenario: Vendor creates a promotion Short-dated
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores | start-date  | end-date    | discount | appliedBuyerCompany    | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | stores | currentDate | currentDate | 1%       | Auto Buyer Company Bao | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                        | sku                        | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | Chicagoland Express | $10.00        | $9.90         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions             | stores   | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | 6 stores | currentDate | currentDate | 1%       |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_271
  Scenario: Vendor creates a promotion Short-dated Retail Specific promotion = ON
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions     | stores | start-date  | end-date    | discount | appliedBuyerCompany    | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | stores | currentDate | currentDate | 1%       | Auto Buyer Company Bao | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                        | sku                        | region  | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | [blank] | [blank]       | [blank]       |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions | stores  | startDate   |
      | Short-dated | Auto brand create product | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions     | stores   | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | All regions | 6 stores | currentDate | currentDate | 1%       |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_273
  Scenario: Vendor creates a promotion Short-dated Retail Specific promotion = ON and for multiple company
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific buyer companies "Auto_BuyerCompany" and add to Promotion
      | Auto_BuyerCompany |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions     | stores | start-date  | end-date    | discount | appliedBuyerCompany    | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | stores | currentDate | currentDate | 1%       | Auto Buyer Company Bao | 1         |
    And Vendor check promotion detail
      | title                             | type        | regions     | stores | start-date  | end-date    | discount | appliedBuyerCompany | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | stores | currentDate | currentDate | 1%       | Auto_BuyerCompany   | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                        | sku                        | region  | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | [blank] | [blank]       | [blank]       |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions | stores  | startDate   |
      | Short-dated | Auto brand create product | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions     | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | All regions | stores | currentDate | currentDate | 1%       |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_275 @PROMOTION_277 @PROMOTION_279
  Scenario: Check display of a Vendor promotion when Admin deactivates all its active stores
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
      # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany               | managedBy | onboardingState | tag     |
      | AT Buyer company promotion | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
     # Create buyer company by api
    And Admin create buyer company by API
      | name                       | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer company promotion | 01-123 | 90          | [blank]    | https://auto.podfoods.co/login | 2             |
     # Create store by api
    And Admin create store by API
      | name                | email                              | region_id | time_zone                  | store_size | buyer_company_id | phone_number | city     | street1        | address_state_id | zip   | number | street           |
      | AT store promotion1 | ngoctx+autostorepromo1@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | create by api    | 1234567890   | New York | 281 9th Avenue | 33               | 10001 | 1554   | West 18th Street |

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor search specific buyer companies "AT Buyer company promotion" and add to Promotion
      | AT Buyer company promotion |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions     | stores  | start-date  | end-date    | discount | appliedBuyerCompany        | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | 1 store | currentDate | currentDate | 1%       | AT Buyer company promotion | 1         |
    And Vendor check store of Applied Buyer Companies "AT Buyer company promotion" Promotion
      | storeId       | region |
      | create by api | 26     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions | stores  | startDate   |
      | Short-dated | Auto brand create product | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions     | stores  | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | All regions | 1 store | currentDate | currentDate | 1%       |

    And Admin change state of store "create by api" to "inactive"
    And VENDOR refresh browser
    And Vendor check records promotions
      | number  | name                              | type        | regions     | stores  | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | All regions | 0 store | currentDate | currentDate | 1%       |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion"

    And Vendor check promotion detail
      | title                             | type        | regions     | stores  | start-date  | end-date    | discount | appliedBuyerCompany        | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | 0 store | currentDate | currentDate | 1%       | AT Buyer company promotion | 1         |
    And Vendor check store of Applied Buyer Companies "AT Buyer company promotion" Promotion
      | storeId | region  |
      | [blank] | [blank] |
#    Change buyer company to "inactive"
    And Admin change state of buyer company "create by api" to "inactive" by API
    And VENDOR refresh browser
    And Check any text "not" showing on screen
      | AT Buyer company promotion |
       # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany               | managedBy | onboardingState | tag     |
      | AT Buyer company promotion | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

  @PROMOTION_281
  Scenario: Check display of a Vendor promotion when Admin deletes all its buyer companies
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
      # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany               | managedBy | onboardingState | tag     |
      | AT Buyer company promotion | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
     # Create buyer company by api
    And Admin create buyer company by API
      | name                       | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer company promotion | 01-123 | 90          | [blank]    | https://auto.podfoods.co/login | 2             |
     # Create store by api
    And Admin create store by API
      | name                | email                              | region_id | time_zone                  | store_size | buyer_company_id | phone_number | city     | street1        | address_state_id | zip   | number | street           |
      | AT store promotion1 | ngoctx+autostorepromo1@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | create by api    | 1234567890   | New York | 281 9th Avenue | 33               | 10001 | 1554   | West 18th Street |

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor search specific buyer companies "AT Buyer company promotion" and add to Promotion
      | AT Buyer company promotion |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions     | stores  | start-date  | end-date    | discount | appliedBuyerCompany        | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | 1 store | currentDate | currentDate | 1%       | AT Buyer company promotion | 1         |
    And Vendor check store of Applied Buyer Companies "AT Buyer company promotion" Promotion
      | storeId       | region |
      | create by api | 26     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions | stores  | startDate   |
      | Short-dated | Auto brand create product | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions     | stores  | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | All regions | 1 store | currentDate | currentDate | 1%       |
        # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany               | managedBy | onboardingState | tag     |
      | AT Buyer company promotion | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    And VENDOR refresh browser
    And Vendor check records promotions
      | number  | name                              | type        | regions     | stores  | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | All regions | 0 store | currentDate | currentDate | 1%       |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion"
    And Vendor check promotion detail
      | title                             | type        | regions     | stores     | start-date  | end-date    | discount | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | All stores | currentDate | currentDate | 1%       | 1         |
    And Vendor check store of Applied Buyer Companies "" Promotion
      | storeId | region  |
      | [blank] | [blank] |

  @PROMOTION_283
  Scenario: Vendor creates a promotion Short-dated - Applied for multiple regions - Applied for multiple buyer companies
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
      | Florida Express     |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific buyer companies "Auto_BuyerCompany" and add to Promotion
      | Auto_BuyerCompany |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions   | stores | start-date  | end-date    | discount | appliedBuyerCompany    | caseLimit | useLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | 2 regions | stores | currentDate | currentDate | 1%       | Auto Buyer Company Bao | 1         | 1        |
    And Vendor check promotion detail
      | title                             | type        | regions   | stores | start-date  | end-date    | discount | appliedBuyerCompany | caseLimit | useLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | 2 regions | stores | currentDate | currentDate | 1%       | Auto_BuyerCompany   | 1         | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                        | sku                        | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | Chicagoland Express | $10.00        | $9.90         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions   | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | 2 regions | store  | currentDate | currentDate | 1%       |

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                              | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany   |
      | Auto Vendor Short-dated Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     | Auto Buyer Company Bao |
    Then Verify promotion show in All promotion page
      | name                              | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 1         |
    Then Verify promotion show in All promotion page
      | name                              | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | FL     | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion"
    And Admin verify promotion detail
      | name                              | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor Short-dated Promotion | Short-dated | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
      | Florida Express     |
    And Check applied buyer company of Promotion detail
      | buyerCompany           |
      | Auto Buyer Company Bao |
      | Auto_BuyerCompany      |
    And Check item on Promotion detail
      | product                        | sku                        | brand                     |
      | auto product vendor promotion1 | auto sku vendor promotion1 | Auto brand create product |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_287
  Scenario: Vendor creates a promotion Short-dated with Inventory Lot and SKU Expiry Date = null:
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion287 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion287" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion287" by api
    And Admin delete product name "auto product vendor promotion287" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion287 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion287" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion287 | random             | 5        | auto lot sku vendor promotion287 | 99           | Plus1        | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                          | expiryDate |
      | auto product vendor promotion287 | auto lot sku vendor promotion287 | [blank]    |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion287 | Auto brand create product | auto product vendor promotion287 | anhJPG2.jpg |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores     | start-date  | end-date    | discount | caseLimit | useLimit | expiryDate |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | $1.00    | 1         | 1        | -          |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion287 | auto sku vendor promotion287 | Chicagoland Express | $10.00        | $9.00         |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion287 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion287" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion287" by api
    And Admin delete product name "auto product vendor promotion287" by api

  @PROMOTION_289
  Scenario: Vendor creates a promotion Short-dated with Inventory Lot and SKU Expiry Date:
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion289 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion289" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion289" by api
    And Admin delete product name "auto product vendor promotion289" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion289 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion289" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion289 | random             | 5        | auto lot sku vendor promotion289 | 99           | Plus1        | Plus1       | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                          | expiryDate |
      | auto product vendor promotion289 | auto lot sku vendor promotion289 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion289 | Auto brand create product | auto product vendor promotion289 | anhJPG2.jpg |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores     | start-date  | end-date    | discount | caseLimit | useLimit | expiryDate |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | $1.00    | 1         | 1        | Plus1      |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion289 | auto sku vendor promotion289 | Chicagoland Express | $10.00        | $9.00         |
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion289 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion289" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion289" by api
    And Admin delete product name "auto product vendor promotion289" by api

  @PROMOTION_291 @PROMOTION_293 @PROMOTION_298
  Scenario: Vendor creates a promotion (Buy-in/ TPR/ Short-dated) has only one Specific SKU then admin DRAFTS or DEACTIVATES that SKU
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion291 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion292" of product ""
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion291" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku random vendor promotion291" and add to Promotion
      | auto sku random vendor promotion291 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores | start-date  | end-date    | discount | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | stores | currentDate | currentDate | 1%       | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                                 | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion291 | auto sku random vendor promotion291 | Chicagoland Express | $10.00        | $9.90         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | store  | currentDate | currentDate | 1%       |

    And Change state of SKU id: "auto sku random vendor promotion291" to "draft"
    And VENDOR refresh browser
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion"

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                              | type        | store   | brand   | productName | skuName | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany |
      | Auto Vendor Short-dated Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | currentDate | [blank]     | [blank]              |
    Then Verify promotion show in All promotion page
      | name                              | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion"
    And Admin verify promotion detail
      | name                              | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor Short-dated Promotion | Short-dated | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
    And Check item on Promotion detail
      | product                          | sku                                 | brand                     |
      | auto product vendor promotion291 | auto sku random vendor promotion291 | Auto brand create product |

    And Change state of SKU id: "auto sku random vendor promotion291" to "active"
    And VENDOR refresh browser
    And Vendor check records promotions
      | number  | name                              | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | store  | currentDate | currentDate | 1%       |
#inactive sku
    And Change state of SKU id: "auto sku random vendor promotion291" to "inactive"
    And VENDOR refresh browser
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion"

    And BAO_ADMIN9 refresh browser
    Then Verify promotion show in All promotion page
      | name                              | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion"
    And Admin verify promotion detail
      | name                              | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor Short-dated Promotion | Short-dated | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
    And Check item on Promotion detail
      | product                          | sku                                 | brand                     |
      | auto product vendor promotion291 | auto sku random vendor promotion291 | Auto brand create product |
#Delete sku
    And Admin delete sku "" in product "" by api
    And BAO_ADMIN9 refresh browser
    Then Verify promotion show in All promotion page
      | name                              | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion"
    And Admin verify promotion detail
      | name                              | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor Short-dated Promotion | Short-dated | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
    And Check any text "not" showing on screen
      | auto sku random vendor promotion291 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_294
  Scenario: Vendor creates a promotion (Buy-in/ TPR/ Short-dated) has multiple Specific SKUs
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion294 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion2941" of product ""
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion2942" of product ""
    And Clear Info of Region api
    And Info of Region
      | region           | id | state    | availability | casePrice | msrp |
      | New York Express | 53 | inactive | in_stock     | 3000      | 3000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion2943" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
      | Florida Express     |
    And Vendor search specific SKU "auto sku random vendor promotion294" and add to Promotion
      | auto sku random vendor promotion2941 |
      | auto sku random vendor promotion2942 |
      | auto sku random vendor promotion2943 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions   | stores     | start-date  | end-date    | discount | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | 2 regions | All stores | currentDate | currentDate | 1%       | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                                  | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion294 | auto sku random vendor promotion2941 | Chicagoland Express | $10.00        | $9.90         |
      | Auto brand create product | auto product vendor promotion294 | auto sku random vendor promotion2942 | Florida Express     | $20.00        | $19.80        |
      | Auto brand create product | auto product vendor promotion294 | auto sku random vendor promotion2943 | [blank]             | [blank]       | [blank]       |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions   | stores     | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | 2 regions | All stores | currentDate | currentDate | 1%       |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                              | type        | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal | includedBuyerCompany |
      | Auto Vendor Short-dated Promotion | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     | [blank]              |
    Then Verify promotion show in All promotion page
      | name                              | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | CHI    | currentDate | currentDate | 1          | 1         |
    Then Verify promotion show in All promotion page
      | name                              | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | FL     | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion"
    And Admin verify promotion detail
      | name                              | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor Short-dated Promotion | Short-dated | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
      | Florida Express     |
    And Check item on Promotion detail
      | product                          | sku                                  | brand                     |
      | auto product vendor promotion294 | auto sku random vendor promotion2941 | Auto brand create product |
      | auto product vendor promotion294 | auto sku random vendor promotion2942 | Auto brand create product |
      | auto product vendor promotion294 | auto sku random vendor promotion2943 | Auto brand create product |

    #Delete sku
    And Admin delete sku "" in product "" by api
    And BAO_ADMIN9 refresh browser
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion"
    And Admin verify promotion detail
      | name                              | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor Short-dated Promotion | Short-dated | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
      | Florida Express     |
    And Check item on Promotion detail
      | product                          | sku                                  | brand                     |
      | auto product vendor promotion294 | auto sku random vendor promotion2941 | Auto brand create product |
      | auto product vendor promotion294 | auto sku random vendor promotion2942 | Auto brand create product |
    And Check any text "not" showing on screen
      | auto sku random vendor promotion2943 |

    And VENDOR refresh browser
    And Vendor check records promotions
      | number  | name                              | type        | regions   | stores     | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | 2 regions | All stores | currentDate | currentDate | 1%       |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion"
    And Vendor check promotion detail
      | title                             | type        | regions   | stores     | start-date  | end-date    | discount | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | 2 regions | All stores | currentDate | currentDate | 1%       | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                                  | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion294 | auto sku random vendor promotion2941 | Chicagoland Express | $10.00        | $9.90         |
      | Auto brand create product | auto product vendor promotion294 | auto sku random vendor promotion2942 | Florida Express     | $20.00        | $19.80        |
    And Check any text "not" showing on screen
      | auto sku random vendor promotion2943 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_299
  Scenario: Vendor creates a promotion (Buy-in/ TPR/ Short-dated) has a Specific SKUs: SKUs have both Region specific price, Store specific price and Buyer company specific price
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion299 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1500             | 1500       | in_stock     |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 2000             | 2000       | in_stock     |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion299" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
      | Florida Express     |
    And Vendor search specific SKU "auto sku random vendor promotion299" and add to Promotion
      | auto sku random vendor promotion299 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions | stores | start-date  | end-date    | discount | caseLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | region  | store  | currentDate | currentDate | $1.00    | 1         |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                                 | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion299 | auto sku random vendor promotion299 | Chicagoland Express | $10.00        | $9.00         |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_300
  Scenario: Vendor creates a promotion (Buy-in/ TPR/ Short-dated) with Is this a case stack deal? = ON
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion300 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion300" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion300" and add to Promotion
      | auto sku vendor promotion300 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
      | 3           | 3      |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores     | start-date  | end-date    | discount                                                     | caseLimit | useLimit | status    |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 1 - 1 cases: $1.00 OI2 - 2 cases: $2.00 OI3+ cases: $3.00 OI | 1         | 1        | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion300 | auto sku vendor promotion300 | Chicagoland Express | $10.00        | $7.00 ~ $9.00 |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     | [blank]              |
    Then Verify promotion show in All promotion page
      | name                      | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | currentDate | currentDate | 1          | 1         |

    And Admin go to promotion detail "Auto Vendor TPR Promotion"
    And Admin verify promotion detail
      | name                      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor TPR Promotion | TPR  | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
      | 3           | 3      |
    And Verify help stack deal description
      | help                     |
      | Lower the price by $1.00 |
      | Lower the price by $2.00 |
      | Lower the price by $3.00 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_303
  Scenario: Vendor creates a promotion (Buy-in/ TPR/ Short-dated) with Is this a case stack deal? = ON, Discount type = Percentage
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion300 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion300" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion300" and add to Promotion
      | auto sku vendor promotion300 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 2           | 20     |
      | 3           | 30     |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores     | start-date  | end-date    | discount                                               | caseLimit | useLimit | status    |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 1 - 1 cases: 10% OI2 - 2 cases: 20% OI3+ cases: 30% OI | 1         | 1        | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion300 | auto sku vendor promotion300 | Chicagoland Express | $10.00        | $7.00 ~ $9.00 |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region  | startAt     | expireAt    | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | currentDate | currentDate | [blank]     | [blank]              |
    Then Verify promotion show in All promotion page
      | name                      | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | currentDate | currentDate | 1          | 1         |

    And Admin go to promotion detail "Auto Vendor TPR Promotion"
    And Admin verify promotion detail
      | name                      | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor TPR Promotion | TPR  | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 10     |
      | 2           | 20     |
      | 3           | 30     |
    And Verify help stack deal description
      | help                      |
      | Lower the price by 10.00% |
      | Lower the price by 20.00% |
      | Lower the price by 30.00% |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_306
  Scenario: Vendors duplicate a normal promotion (Buy-in, TPR, Short-dated)
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion306 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion306" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion306" and add to Promotion
      | auto sku vendor promotion306 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And Vendor check promotion duplicate
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion306 | Auto brand create product | auto product vendor promotion306 | anhJPG2.jpg |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores | start-date  | end-date    | discount | caseLimit | useLimit | status    |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | stores | currentDate | currentDate | $1.00    | 1         | 1        | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $9.00         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                      | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
      | [blank] | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_308 @PROMOTION_320
  Scenario: Vendors duplicate a normal promotion - validate SKU
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion306 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion3061" of product ""
    And Clear Info of Region api
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion3062" of product ""
    And Clear Info of Region api
    And Info of Region
      | region          | id | state    | availability | casePrice | msrp |
      | Florida Express | 63 | inactive | in_stock     | 3000      | 3000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion3063" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku random vendor promotion3061" and add to Promotion
      | auto sku random vendor promotion3061 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And Vendor check promotion duplicate
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor clear field "Name"
    And Vendor remove value on Input "Start Date"
    And Vendor clear field "Note"
    And Vendor clear field "Case limit"
    And Vendor clear field "Case minimum"
    And Vendor clear field "Usage limit"
    And Vendor clear field "Amount"
    And Click on button "Duplicate"
    And VENDOR check alert message
      | Please correct the errors on this form before continuing. |
    And Vendor check error message is showing of fields
      | field        | message                      |
      | Name         | This field cannot be blank.  |
      | Start Date   | This field cannot be blank.  |
      | Case limit   | Value must be greater than 0 |
      | Usage limit  | Value must be greater than 0 |
      | Case minimum | This field cannot be blank   |
    And Vendor create Promotion with info
      | name                      | startDate   | endDate | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | Minus1  | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Click on button "Duplicate"
    And VENDOR check alert message
      | Expires at must be after or equal to |
    And Vendor create Promotion with info
      | name                                  | startDate   | endDate     | note                  | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion duplication | currentDate | currentDate | Auto note duplication | TPR (Temporary Price Reduction) | 2         | 2           | 2          | Percentage   | 10     |
    And Vendor search specific SKU "auto sku random vendor promotion3061" and check SKU is selected
      | auto sku random vendor promotion3061 |
    And Vendor close popup
    And Vendor search specific SKU "auto sku random vendor promotion306" and add to Promotion
      | auto sku random vendor promotion3062 |
      | auto sku random vendor promotion3063 |
    And Vendor check specific SKU create Promotion
      | skuName                              | brand                     | product                          | image       |
      | auto sku random vendor promotion3061 | Auto brand create product | auto product vendor promotion306 | anhJPG2.jpg |
      | auto sku random vendor promotion3063 | Auto brand create product | auto product vendor promotion306 | anhJPG2.jpg |
      | auto sku random vendor promotion3062 | Auto brand create product | auto product vendor promotion306 | anhJPG2.jpg |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                                 | type | regions             | stores | start-date  | end-date    | discount | caseLimit | status    |
      | Auto Vendor TPR Promotion duplication | TPR  | Chicagoland Express | stores | currentDate | currentDate | 10%      | 2         | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                                  | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku random vendor promotion3061 | Chicagoland Express | $10.00        | $9.00         |
      | Auto brand create product | auto product vendor promotion306 | auto sku random vendor promotion3062 | [blank]             | [blank]       | [blank]       |
      | Auto brand create product | auto product vendor promotion306 | auto sku random vendor promotion3063 | [blank]             | [blank]       | [blank]       |
    And Vendor check store of Applied Buyer Companies "Auto Buyer Company Bao" Promotion
      | storeId | region |
      | 2729    | 26     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                                  | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion duplication | TPR  | Chicagoland Express | stores | currentDate | currentDate | 10%      |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_313
  Scenario: Vendors duplicate a normal promotion - Check validation of the "Find lots by brand, product, SKU, or lot code..."
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion313 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion313" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion313" by api
    And Admin delete product name "auto product vendor promotion313" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion313 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion3131" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion3131 | random             | 5        | auto lot sku vendor promotion3131 | 99           | Plus1        | Plus1       | [blank] |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion3132" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion3132 | random             | 5        | auto lot sku vendor promotion3132 | 99           | Plus1        | Plus1       | [blank] |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion3133" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                           | expiryDate |
      | auto product vendor promotion313 | auto lot sku vendor promotion3131 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion313 | Auto brand create product | auto product vendor promotion313 | anhJPG2.jpg |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions             | stores     | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | $1.00    |
    And Vendor duplicate promotion "Auto Vendor Short-dated Promotion"
    And Vendor check promotion duplicate
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor check value of field
      | field                                            | value                             |
      | Find lots by brand, product, SKU, or lot code... | auto lot sku vendor promotion3131 |
      | SKU Expiry Date                                  | Plus1                             |
    And Vendor check specific SKU create Promotion
      | skuName                       | brand                     | product                          | image       |
      | auto sku vendor promotion3131 | Auto brand create product | auto product vendor promotion313 | anhJPG2.jpg |

    And Vendor remove value on Input "Find lots by brand, product, SKU, or lot code..."
    And Vendor select an Inventory Lot for create new Promotion
      | search                       | lotCode                           | expiryDate |
      | auto sku vendor promotion313 | auto lot sku vendor promotion3131 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                       | brand                     | product                          | image       |
      | auto sku vendor promotion3131 | Auto brand create product | auto product vendor promotion313 | anhJPG2.jpg |

    And Vendor remove value on Input "Find lots by brand, product, SKU, or lot code..."
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                           | expiryDate |
      | auto product vendor promotion313 | auto lot sku vendor promotion3132 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                       | brand                     | product                          | image       |
      | auto sku vendor promotion3132 | Auto brand create product | auto product vendor promotion313 | anhJPG2.jpg |
    And Vendor remove value on Input "Find lots by brand, product, SKU, or lot code..."
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                           | expiryDate |
      | auto lot sku vendor promotion313 | auto lot sku vendor promotion3132 | Plus1      |
    And Vendor check specific SKU create Promotion
      | skuName                       | brand                     | product                          | image       |
      | auto sku vendor promotion3132 | Auto brand create product | auto product vendor promotion313 | anhJPG2.jpg |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores     | start-date  | end-date    | discount | caseLimit | useLimit | status    |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | $1.00    | 1         | 1        | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                           | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion313 | auto sku vendor promotion3132 | Chicagoland Express | $10.00        | $9.00         |
     #  end quantity = 0
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 5        | Autotest |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor Short-dated Promotion"
    And Vendor remove value on Input "Find lots by brand, product, SKU, or lot code..."
    And Vendor input invalid "Find lots by brand, product, SKU, or lot code..."
      | value                         |
      | auto sku vendor promotion3132 |
    And Vendor input invalid "Find lots by brand, product, SKU, or lot code..."
      | value                         |
      | auto sku vendor promotion3133 |

     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion313 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion313" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion313" by api
    And Admin delete product name "auto product vendor promotion313" by api

  @PROMOTION_316
  Scenario: Vendors duplicate a normal promotion - validate 2
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion306 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku random vendor promotion3061" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku random vendor promotion3061" and add to Promotion
      | auto sku random vendor promotion3061 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And Vendor check promotion duplicate
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |

    And Vendor choose region for create new Promotion
      | [blank] |
    And Vendor remove all specific buyer companies of Promotion
    And Vendor remove specific SKU create Promotion
      | sku                                  |
      | auto sku random vendor promotion3061 |
    And Click on button "Duplicate"
    And VENDOR check alert message
      | Please correct the errors on this form before continuing. |
    And Check any text "is" showing on screen
#      | Please select at least one buyer company. |
      | Please select at least one sku. |
    And Vendor search specific SKU "auto sku random vendor promotion3061" and add to Promotion
      | auto sku random vendor promotion3061 |
#    And Check any text "is" showing on screen
#      | Please select at least one buyer company. |
    And Vendor choose region for create new Promotion
      | Atlanta Express          |
#      | Chicagoland Express            |
      | Denver Express           |
      | Florida Express          |
      | Mid Atlantic Express     |
      | New York Express         |
      | North California Express |
      | Phoenix Express          |
      | Sacramento Express       |
      | South California Express |
      | Dallas Express           |
      | Pod Direct Central       |
      | Pod Direct East          |
#      | Pod Direct Southeast           |
#      | Pod Direct Southwest & Rockies |
      | Pod Direct West          |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                     | type | regions    | stores     | start-date  | end-date    | discount | caseLimit | status    |
      | Auto Vendor TPR Promotion | TPR  | 14 regions | All stores | currentDate | currentDate | $1.00    | 1         | Submitted |

  @PROMOTION_317
  Scenario: Check validation of the Select Buyer Companies popup
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
      # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany               | managedBy | onboardingState | tag     |
      | AT Buyer company promotion | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
     # Create buyer company by api
    And Admin create buyer company by API
      | name                       | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer company promotion | 01-123 | 90          | [blank]    | https://auto.podfoods.co/login | 2             |
     # Create store by api
    And Admin create store by API
      | name                | email                              | region_id | time_zone                  | store_size | buyer_company_id | phone_number | city     | street1        | address_state_id | zip   | number | street           |
      | AT store promotion1 | ngoctx+autostorepromo1@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | create by api    | 1234567890   | New York | 281 9th Avenue | 33               | 10001 | 1554   | West 18th Street |

    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor search specific buyer companies "AT Buyer company promotion" and add to Promotion
      | AT Buyer company promotion |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And VENDOR wait 2000 mini seconds
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions | stores  | startDate   |
      | Short-dated | Auto brand create product | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions     | stores  | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | All regions | 1 store | currentDate | currentDate | 1%       |
    And Vendor duplicate promotion "Auto Vendor Short-dated Promotion"
    And Vendor check promotion duplicate
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor check buyer company "in" duplicate promotion
      | AT Buyer company promotion |
        # Delete buyer company
    When Admin search buyer company by API
      | buyerCompany               | managedBy | onboardingState | tag     |
      | AT Buyer company promotion | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    And VENDOR refresh browser
    And VENDOR wait 5000 mini seconds
    And Vendor check promotion duplicate
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor check buyer company "not in" duplicate promotion
      | AT Buyer company promotion |
    And Vendor search specific buyer companies "AT Buyer company promotion" and add to Promotion
      | [blank] |
    And Vendor close popup
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions     | stores | start-date  | end-date    | discount | caseLimit | status    |
      | Auto Vendor Short-dated Promotion | Short-dated | All regions | stores | currentDate | currentDate | 1%       | 1         | Submitted |
    And Vendor check store of Applied Buyer Companies "Auto Buyer Company Bao" Promotion
      | storeId | region |
      | 2729    | 26     |

  @PROMOTION_328
  Scenario: Vendors duplicate Promotion - Check validation of the Is this a case stack deal
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion328" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion328" and add to Promotion
      | auto sku vendor promotion328 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And VENDOR wait 2000 mini seconds
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And VENDOR wait 2000 mini seconds
    And Vendor check promotion duplicate
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
    And Verify help stack deal description
      | help                     |
      | Lower the price by $1.00 |
      | Lower the price by $2.00 |
    And Vendor create Promotion with info
      | name    | startDate | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | [blank] | [blank]   | [blank] | [blank] | [blank]       | [blank]   | 3           | [blank]    | [blank]      | [blank] |
    And Click on button "Duplicate"
    And Vendor check error message is showing of fields
      | field        | message                                                                   |
      | Min quantity | Min quantity must be a valid number and cannot be lower than case minimum |
    And Vendor remove cases stack deal number 1 create Promotion
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 2      |
      | 4           | 1      |
    And Verify help stack deal description
      | help                     |
      | Lower the price by $2.00 |
      | Lower the price by $1.00 |
    And Click on button "Duplicate"
    And VENDOR check alert message
      | Promotion actions Discount value should be increase proportionally as the min_qty |
    And Vendor remove cases stack deal number 1 create Promotion
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 1      |
      | 4           | 3      |
    And Verify help stack deal description
      | help                     |
      | Lower the price by $1.00 |
      | Lower the price by $3.00 |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores     | start-date  | end-date    | discount                                | caseLimit | useLimit | status    |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 3 - 3 cases: $1.00 OI4+ cases: $3.00 OI | 1         | 1        | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $7.00 ~ $9.00 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_329
  Scenario: Vendors duplicate Promotion - Check validation of the Is this a case stack deal 2
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion328" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion328" and add to Promotion
      | auto sku vendor promotion328 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And VENDOR wait 2000 mini seconds
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And VENDOR wait 3000 mini seconds
    And Vendor check promotion duplicate
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
    And Verify help stack deal description
      | help                  |
      | Lower the price by 1% |
      | Lower the price by 2% |
    And Vendor create Promotion with info
      | name    | startDate | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | [blank] | [blank]   | [blank] | [blank] | [blank]       | [blank]   | 3           | [blank]    | [blank]      | [blank] |
    And Click on button "Duplicate"
    And Vendor check error message is showing of fields
      | field        | message                                                                   |
      | Min quantity | Min quantity must be a valid number and cannot be lower than case minimum |
    And Vendor remove cases stack deal number 1 create Promotion
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 2      |
      | 4           | 1      |
    And Verify help stack deal description
      | help                  |
      | Lower the price by 2% |
      | Lower the price by 1% |
    And Click on button "Duplicate"
    And VENDOR check alert message
      | Promotion actions Discount value should be increase proportionally as the min_qty |
    And Vendor remove cases stack deal number 1 create Promotion
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 1      |
      | 4           | 3      |
    And Verify help stack deal description
      | help                  |
      | Lower the price by 1% |
      | Lower the price by 3% |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores     | start-date  | end-date    | discount                          | caseLimit | useLimit | status    |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 3 - 3 cases: 1% OI4+ cases: 3% OI | 1         | 1        | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $9.70 ~ $9.90 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_336
  Scenario: Verify vendor duplicates a Buy-in promotion:
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion306 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion306" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                         | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion306" and add to Promotion
      | auto sku vendor promotion306 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor Buy-in Promotion"
    And Vendor check promotion duplicate
      | name                         | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Fix Rate     | 1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion306 | Auto brand create product | auto product vendor promotion306 | anhJPG2.jpg |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                        | type   | regions             | stores | start-date  | end-date    | discount | caseLimit | status    |
      | Auto Vendor Buy-in Promotion | Buy-in | Chicagoland Express | stores | currentDate | currentDate | $1.00    | 1         | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $9.00         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                         | type   | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Buy-in Promotion | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
      | [blank] | Auto Vendor Buy-in Promotion | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor duplicate promotion "Auto Vendor Buy-in Promotion"
    And Vendor create Promotion with info
      | name                              | startDate | endDate | note        | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion edit | Minus1    | Plus1   | Auto note 2 | Buy-in        | 2         | 2           | [blank]    | Fix Rate     | 2      |
    And Vendor choose region for create new Promotion
      | Florida Express |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                             | type   | regions   | stores | start-date | end-date | discount | caseLimit | caseMinimum | status    |
      | Auto Vendor Buy-in Promotion edit | Buy-in | 2 regions | stores | Minus1     | Plus1    | $2.00    | 2         | 2           | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $8.00         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | Minus1    |
    And Vendor check records promotions
      | number  | name                              | type   | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Buy-in Promotion edit | Buy-in | 2 regions           | store  | Minus1      | Plus1       | $2.00    |
      | [blank] | Auto Vendor Buy-in Promotion      | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
      | [blank] | Auto Vendor Buy-in Promotion      | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_339
  Scenario: Verify vendor duplicates a Buy-in promotion: - With Case Stack Deals
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion328" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                         | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion328" and add to Promotion
      | auto sku vendor promotion328 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And VENDOR wait 2000 mini seconds
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor Buy-in Promotion"
    And VENDOR wait 2000 mini seconds
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                        | type   | regions             | stores     | start-date  | end-date    | discount                                | caseLimit | status    |
      | Auto Vendor Buy-in Promotion | Buy-in | Chicagoland Express | All stores | currentDate | currentDate | 1 - 1 cases: $1.00 OI2+ cases: $2.00 OI | 1         | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $8.00 ~ $9.00 |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor Buy-in Promotion"
    And VENDOR wait 2000 mini seconds
    And Vendor remove cases stack deal number 1 create Promotion
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 1      |
      | 4           | 3      |
    And Verify help stack deal description
      | help                     |
      | Lower the price by $1.00 |
      | Lower the price by $3.00 |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                        | type   | regions             | stores     | start-date  | end-date    | discount                                | caseLimit | status    |
      | Auto Vendor Buy-in Promotion | Buy-in | Chicagoland Express | All stores | currentDate | currentDate | 3 - 3 cases: $1.00 OI4+ cases: $3.00 OI | 1         | Submitted |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $7.00 ~ $9.00 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_342
  Scenario: Verify vendor duplicates a TPR promotion:
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion306 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion306" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion306" and add to Promotion
      | auto sku vendor promotion306 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And Vendor check promotion duplicate
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion306 | Auto brand create product | auto product vendor promotion306 | anhJPG2.jpg |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores | start-date  | end-date    | discount | caseLimit | status    | useLimit |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | stores | currentDate | currentDate | $1.00    | 1         | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $9.00         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                      | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
      | [blank] | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And Vendor create Promotion with info
      | name                           | startDate | endDate | note        | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion edit | Minus1    | Plus1   | Auto note 2 | TPR (Temporary Price Reduction) | 2         | 2           | [blank]    | Fix Rate     | 2      |
    And Vendor choose region for create new Promotion
      | Florida Express |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                          | type | regions   | stores | start-date | end-date | discount | caseLimit | caseMinimum | status    | useLimit |
      | Auto Vendor TPR Promotion edit | TPR  | 2 regions | stores | Minus1     | Plus1    | $2.00    | 2         | 2           | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $8.00         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | Minus1    |
    And Vendor check records promotions
      | number  | name                           | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion edit | TPR  | 2 regions           | store  | Minus1      | Plus1       | $2.00    |
      | [blank] | Auto Vendor TPR Promotion      | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
      | [blank] | Auto Vendor TPR Promotion      | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_345
  Scenario: Verify vendor duplicates a TPR promotion: - With Case Stack Deals
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion328" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion328" and add to Promotion
      | auto sku vendor promotion328 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And VENDOR wait 2000 mini seconds
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And VENDOR wait 2000 mini seconds
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores     | start-date  | end-date    | discount                                | caseLimit | status    | useLimit |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 1 - 1 cases: $1.00 OI2+ cases: $2.00 OI | 1         | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $8.00 ~ $9.00 |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor TPR Promotion"
    And VENDOR wait 2000 mini seconds
    And Vendor remove cases stack deal number 1 create Promotion
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 1      |
      | 4           | 3      |
    And Verify help stack deal description
      | help                     |
      | Lower the price by $1.00 |
      | Lower the price by $3.00 |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                     | type | regions             | stores     | start-date  | end-date    | discount                                | caseLimit | status    | useLimit |
      | Auto Vendor TPR Promotion | TPR  | Chicagoland Express | All stores | currentDate | currentDate | 3 - 3 cases: $1.00 OI4+ cases: $3.00 OI | 1         | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $7.00 ~ $9.00 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_348
  Scenario: Verify vendor duplicates a Short-dated promotion:
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion306 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion306" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor37@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion306" and add to Promotion
      | auto sku vendor promotion306 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor Short-dated Promotion"
    And Vendor check promotion duplicate
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                     | product                          | image       |
      | auto sku vendor promotion306 | Auto brand create product | auto product vendor promotion306 | anhJPG2.jpg |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores | start-date  | end-date    | discount | caseLimit | status    | useLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | stores | currentDate | currentDate | $1.00    | 1         | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $9.00         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                              | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
      | [blank] | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor duplicate promotion "Auto Vendor Short-dated Promotion"
    And Vendor create Promotion with info
      | name                                   | startDate | endDate | note        | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion edit | Minus1    | Plus1   | Auto note 2 | Short-dated   | 2         | 2           | [blank]    | Fix Rate     | 2      |
    And Vendor choose region for create new Promotion
      | Florida Express |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                                  | type        | regions   | stores | start-date | end-date | discount | caseLimit | caseMinimum | status    | useLimit |
      | Auto Vendor Short-dated Promotion edit | Short-dated | 2 regions | stores | Minus1     | Plus1    | $2.00    | 2         | 2           | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $8.00         |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | Minus1    |
    And Vendor check records promotions
      | number  | name                                   | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion edit | Short-dated | 2 regions           | store  | Minus1      | Plus1       | $2.00    |
      | [blank] | Auto Vendor Short-dated Promotion      | Short-dated | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
      | [blank] | Auto Vendor Short-dated Promotion      | Short-dated | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api

  @PROMOTION_351  @PROMOTION_348
  Scenario: Verify vendor duplicates a Short-dated promotion: - With Case Stack Deals
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion328" of product ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                              | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific SKU "auto sku vendor promotion328" and add to Promotion
      | auto sku vendor promotion328 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And VENDOR wait 2000 mini seconds
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor Short-dated Promotion"
    And VENDOR wait 2000 mini seconds
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores     | start-date  | end-date    | discount                                | caseLimit | status    | useLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | 1 - 1 cases: $1.00 OI2+ cases: $2.00 OI | 1         | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $8.00 ~ $9.00 |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor duplicate promotion "Auto Vendor Short-dated Promotion"
    And VENDOR wait 2000 mini seconds
    And Vendor remove cases stack deal number 1 create Promotion
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 3           | 1      |
      | 4           | 3      |
    And Verify help stack deal description
      | help                     |
      | Lower the price by $1.00 |
      | Lower the price by $3.00 |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on button "OK"
    And Vendor check promotion detail
      | title                             | type        | regions             | stores     | start-date  | end-date    | discount                                | caseLimit | status    | useLimit |
      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | 3 - 3 cases: $1.00 OI4+ cases: $3.00 OI | 1         | Submitted | 1        |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                       | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion | auto sku vendor promotion328 | Chicagoland Express | $10.00        | $7.00 ~ $9.00 |

    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_354
  Scenario: Admin dashboard > Vendor Submissions list
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand                     | productName                    | skuName                    | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany   |
      | Auto Vendor TPR Promotion | TPR  | [blank] | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | Chicagoland Express | currentDate | currentDate | [blank]     | Auto Buyer Company Bao |
    And Admin reset filter
    And Search promotion by info
      | name    | type   | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany | status    |
      | [blank] | Buy-in | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | [blank] | [blank]  | Yes         | [blank]              | Submitted |
    And Search promotion by info
      | name    | type        | store   | brand   | productName | skuName | region          | startAt | expireAt | isStackDeal | includedBuyerCompany | status   |
      | [blank] | Short-dated | [blank] | [blank] | [blank]     | [blank] | Florida Express | [blank] | [blank]  | No          | [blank]              | Approved |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region               | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | Mid Atlantic Express | [blank] | [blank]  | -           | [blank]              |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region           | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | New York Express | [blank] | [blank]  | [blank]     | [blank]              |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region                   | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | North California Express | [blank] | [blank]  | [blank]     | [blank]              |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region                   | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | South California Express | [blank] | [blank]  | [blank]     | [blank]              |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region         | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | Dallas Express | [blank] | [blank]  | [blank]     | [blank]              |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region             | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | Pod Direct Central | [blank] | [blank]  | [blank]     | [blank]              |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region          | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | Pod Direct East | [blank] | [blank]  | [blank]     | [blank]              |
#    And Search promotion by info
#      | name    | type    | store   | brand   | productName | skuName | region               | startAt | expireAt | isStackDeal | includedBuyerCompany |
#      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | Pod Direct Southeast | [blank] | [blank]  | [blank]     | [blank]              |
#    And Search promotion by info
#      | name    | type    | store   | brand   | productName | skuName | region                         | startAt | expireAt | isStackDeal | includedBuyerCompany |
#      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | Pod Direct Southwest & Rockies | [blank] | [blank]  | [blank]     | [blank]              |
    And Search promotion by info
      | name    | type    | store   | brand   | productName | skuName | region          | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | [blank] | [blank] | [blank] | [blank] | [blank]     | [blank] | Pod Direct West | [blank] | [blank]  | [blank]     | [blank]              |

  @PROMOTION_358
  Scenario: Check admin deletes a Vendor submission
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand                     | productName                    | skuName                    | region              | startAt     | expireAt    | isStackDeal | includedBuyerCompany   |
      | Auto Vendor TPR Promotion | TPR  | [blank] | Auto brand create product | auto product vendor promotion1 | auto sku vendor promotion1 | Chicagoland Express | currentDate | currentDate | [blank]     | Auto Buyer Company Bao |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | currentDate | currentDate | 1          | 1         |
    And Admin delete submission promotion name "Auto Vendor TPR Promotion"
    And Click on dialog button "Understand & Continue"
    And Admin check no data found

  @PROMOTION_359
  Scenario: Check admin deletes a Approved Vendor submission
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 359 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 359 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                          | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 359 | TPR  | CHI    | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 359"
    And Admin verify promotion detail
      | name                          | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor TPR Promotion 359 | TPR  | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check item on Promotion detail
      | product                        | sku                        | brand                     |
      | auto product vendor promotion1 | auto sku vendor promotion1 | Auto brand create product |
    And Click on dialog button "Approve"
    And BAO_ADMIN9 check alert message
      | Promotion has been approved successfully ! |
    And Admin check delete submission promotion name "Auto Vendor TPR Promotion 359" is disabled
    And Admin go to promotion detail "Auto Vendor TPR Promotion 359"
    And Admin check approved submission promotion detail
      | approvedBy       | approvedOn  | name                          | type | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | note      |
      | bao9@podfoods.co | currentDate | Auto Vendor TPR Promotion 359 | TPR  | 1          | 1         | 1           | currentDate | currentDate | Auto note |
    And Admin check "is" applied region of approved submission promotion
      | region                   | apply   |
      | Chicagoland Express      | checked |
      | Florida Express          | [blank] |
      | Mid Atlantic Express     | [blank] |
      | New York Express         | [blank] |
      | North California Express | [blank] |
      | South California Express | [blank] |
      | Dallas Express           | [blank] |
      | Pod Direct Central       | [blank] |
      | Pod Direct East          | [blank] |
#      | Pod Direct Southeast           | [blank] |
#      | Pod Direct Southwest & Rockies | [blank] |
      | Pod Direct West          | [blank] |
    And Check item on Promotion detail
      | product                        | sku                        | brand                     |
      | auto product vendor promotion1 | auto sku vendor promotion1 | Auto brand create product |
    And Check any text "is" showing on screen
      | Auto Buyer Company Bao |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | USD  | 1      |

  @PROMOTION_360
  Scenario: Admin check Vendor submission promotion
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion369 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion369" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion369" by api
    And Admin delete product name "auto product vendor promotion369" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion369 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion369" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion369 | random             | 5        | auto lot sku vendor promotion369 | 99           | Plus1        | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                  | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion 359 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                          | expiryDate |
      | auto product vendor promotion369 | auto lot sku vendor promotion369 | [blank]    |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 5           | 2      |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |

    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                                  | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor Short-dated Promotion 359 | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                                  | type        | region | startAt     | expireAt    | usageLimit | CaseLimit | managedBy        |
      | Auto Vendor Short-dated Promotion 359 | Short-dated | CHI    | currentDate | currentDate | 1          | 1         | bao9@podfoods.co |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion 359"
    And Admin verify promotion detail
      | name                                  | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      |
      | Auto Vendor Short-dated Promotion 359 | Short-dated | 1          | 1         | 1           | currentDate | currentDate | is-checked | Auto note |
    And Check item on Promotion detail
      | product                          | sku                          | brand                     |
      | auto product vendor promotion369 | auto sku vendor promotion369 | Auto brand create product |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 1      |
      | 5           | 2      |
    And Click on dialog button "Approve"
    And BAO_ADMIN9 check alert message
      | Promotion has been approved successfully ! |
    And Admin check delete submission promotion name "Auto Vendor Short-dated Promotion 359" is disabled
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion 359"
    And Admin check approved submission promotion detail
      | approvedBy       | approvedOn  | name                                  | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | note      |
      | bao9@podfoods.co | currentDate | Auto Vendor Short-dated Promotion 359 | Short-dated | 1          | 1         | 1           | currentDate | currentDate | Auto note |
    And Admin check "is" applied region of approved submission promotion
      | region                   | apply   |
      | Atlanta Express          | [blank] |
      | Chicagoland Express      | checked |
      | Denver Express           | [blank] |
      | Florida Express          | [blank] |
      | Mid Atlantic Express     | [blank] |
      | New York Express         | [blank] |
      | North California Express | [blank] |
      | Phoenix Express          | [blank] |
      | Sacramento Express       | [blank] |
      | South California Express | [blank] |
      | Dallas Express           | [blank] |
      | Pod Direct Central       | [blank] |
      | Pod Direct East          | [blank] |
#      | Pod Direct Southeast           | [blank] |
#      | Pod Direct Southwest & Rockies | [blank] |
      | Pod Direct West          | [blank] |
    And Check item on Promotion detail
      | product                          | sku                          | brand                     |
      | auto product vendor promotion369 | auto sku vendor promotion369 | Auto brand create product |
    And Verify amount of promotion with "have" stack deal
      | minQuantity | amount |
      | 1           | 1      |
      | 5           | 2      |

  @PROMOTION_361
  Scenario: Check validation of Submitted vendor submission form
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 359 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 359 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 359"
    And Admin Clear field "Name"
    And Admin Clear field "From"
    And Admin Clear field "Note"
    And Admin Clear field "Case limit"
    And Admin Clear field "Case minimum"
    And Admin Clear field "Usage limit"
    And Admin Clear field "Amount"
    And Click on dialog button "Update"
    And BAO_ADMIN9 check error message is showing of fields on dialog
      | field        | message                                                    |
      | Name         | Please select a specific name for this promotion           |
      | From         | Please select a specific start date for this promotion     |
      | Case minimum | Please enter a valid minimum case value for this promotion |
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api

  @PROMOTION_387
  Scenario: Verify that admin edits information of a vendor submission successfully
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion387 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion387" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 387 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion387" and add to Promotion
      | auto sku vendor promotion387 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Create promotion
      | name                                 | description | note             | fromDate | toDate | type | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Vendor TPR Promotion 387 edited | [blank]     | Auto note edited | Minus1   | Plus1  | TPR  | [blank]   | 2          | 2         | 2           | Yes        | [blank] | [blank]   | 20     | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And BAO_ADMIN9 wait 2000 mini seconds
    And Search promotion by info
      | name                                 | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 edited | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                                 | type | region      | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 387 edited | TPR  | All regions | Minus1  | Plus1    | 2          | 2         |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387 edited"
    And Admin verify promotion detail
      | name                                 | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | note             |
      | Auto Vendor TPR Promotion 387 edited | TPR  | 2          | 2         | 2           | Minus1   | Plus1  | [blank]    | Auto note edited |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 20     |
    And Check item on Promotion detail
      | product                          | sku                          | brand                     |
      | auto product vendor promotion387 | auto sku vendor promotion387 | Auto brand create product |
    And Create promotion
      | name    | description | note    | fromDate | toDate  | type   | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | [blank] | [blank]     | [blank] | [blank]  | [blank] | Buy-in | [blank]   | [blank]    | [blank]   | [blank]     | [blank]    | [blank] | [blank]   | [blank] | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And BAO_ADMIN9 check alert message
      | Usage limit can't have value when the promotion has buy_in option |
    And Create promotion
      | name    | description | note    | fromDate | toDate  | type | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | [blank] | [blank]     | [blank] | [blank]  | [blank] | TPR  | [blank]   | [blank]    | [blank]   | [blank]     | [blank]    | [blank] | [blank]   | [blank] | [blank]      | [blank]              | [blank]              |
    And Admin Clear field "Usage limit"
    And Create promotion
      | name    | description | note    | fromDate | toDate  | type   | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | [blank] | [blank]     | [blank] | [blank]  | [blank] | Buy-in | [blank]   | [blank]    | [blank]   | [blank]     | [blank]    | [blank] | [blank]   | [blank] | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And BAO_ADMIN9 wait 2000 mini seconds
    And Search promotion by info
      | name                                 | type   | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 edited | Buy-in | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                                 | type   | region      | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 387 edited | Buy-in | All regions | Minus1  | Plus1    | [blank]    | 2         |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387 edited"
    And Admin verify promotion detail
      | name                                 | type   | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | note             |
      | Auto Vendor TPR Promotion 387 edited | Buy-in | [blank]    | 2         | 2           | Minus1   | Plus1  | [blank]    | Auto note edited |
    And Create promotion
      | name    | description | note    | fromDate | toDate  | type        | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | [blank] | [blank]     | [blank] | [blank]  | [blank] | Short-dated | [blank]   | 2          | [blank]   | [blank]     | [blank]    | [blank] | [blank]   | [blank] | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And BAO_ADMIN9 wait 2000 mini seconds
    And Search promotion by info
      | name                                 | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 edited | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                                 | type        | region      | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 387 edited | Short-dated | All regions | Minus1  | Plus1    | [blank]    | 2         |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387 edited"
    And Admin verify promotion detail
      | name                                 | type        | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | note             |
      | Auto Vendor TPR Promotion 387 edited | Short-dated | 2          | 2         | 2           | Minus1   | Plus1  | [blank]    | Auto note edited |
    And Create promotion
      | name    | description | note    | fromDate | toDate  | type   | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | [blank] | [blank]     | [blank] | [blank]  | [blank] | Buy-in | [blank]   | [blank]    | [blank]   | [blank]     | [blank]    | [blank] | [blank]   | [blank] | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And BAO_ADMIN9 check alert message
      | Usage limit can't have value when the promotion has buy_in option |

  @PROMOTION_383
  Scenario: Verify that admin edits information of a vendor submission 2
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion387 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion387" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 387 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Percentage   | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion387" and add to Promotion
      | auto sku vendor promotion387 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Create promotion
      | name                                 | description | note             | fromDate | toDate | type | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Vendor TPR Promotion 387 edited | [blank]     | Auto note edited | Minus1   | Plus1  | TPR  | [blank]   | 2          | 2         | 2           | Yes        | [blank] | [blank]   | 1      | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And Admin wait 2000 mini seconds
    And Verify promotion show in All promotion page
      | name                                 | type | region      | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 387 edited | TPR  | All regions | Minus1  | Plus1    | 2          | 2         |
#    And BAO_ADMIN9 check alert message
#      | Promotion actions The default action can contain only 1 action |

  @PROMOTION_383
  Scenario: Verify that admin edits information of a vendor submission 3
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion387 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion387" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 387 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion387" and add to Promotion
      | auto sku vendor promotion387 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Create promotion
      | name                                 | description | note             | fromDate | toDate | type | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Vendor TPR Promotion 387 edited | [blank]     | Auto note edited | Minus1   | Plus1  | TPR  | [blank]   | 2          | 2         | 2           | Yes        | [blank] | [blank]   | 1      | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And Admin wait 2000 mini seconds
    And Verify promotion show in All promotion page
      | name                                 | type | region      | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 387 edited | TPR  | All regions | Minus1  | Plus1    | 2          | 2         |
#    And BAO_ADMIN9 check alert message
#      | Promotion actions The default action can contain only 1 action |

  @PROMOTION_384
  Scenario: Verify that admin edits information of a vendor submission 4 Check validation of Min quantity field
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion387 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion387" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 387 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion387" and add to Promotion
      | auto sku vendor promotion387 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
#    And Create promotion
#      | name                                 | description | note             | fromDate | toDate | type | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
#      | Auto Vendor TPR Promotion 387 edited | [blank]     | Auto note edited | Minus1   | Plus1  | TPR  | [blank]   | 2          | 2         | 2           | Yes        | [blank] | [blank]   | 1      | [blank]      | [blank]              | [blank]              |
#    And Admin add case stack deal to promotion
#      | minQuantity | amount  |
#      | [blank]     | [blank] |
#      | [blank]     | [blank] |
#    And Verify amount of promotion with "have" stack deal
#      | minQuantity | amount |
#      | 0           | 0      |
#      | 0           | 0      |
#    And Admin edit case stack deal on promotion
#      | minQuantity | amount |
#      | 5           | 10     |
#      | 4           | 15     |
#    And Check any text "is" showing on screen
#      | Min quantity must be a valid number and cannot be lower than case minimum |

  @PROMOTION_366
  Scenario: Check validation of Inventory lot field on a Submitted vendor submission form
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion366 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion366" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion366" by api
    And Admin delete product name "auto product vendor promotion366" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion366 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion3661" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion366 | random             | 5        | auto lot sku vendor promotion366 | 99           | Plus1        | Plus1       | [blank] |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion3662" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 366 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion3661" and add to Promotion
      | auto sku vendor promotion3661 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 366 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 366"
    And Create promotion
      | name                                 | description | note    | fromDate | toDate  | type        | expirySKU | usageLimit | caseLimit | caseMinimum | showVendor | store   | typePromo | amount  | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Vendor TPR Promotion 366 edited | [blank]     | [blank] | [blank]  | [blank] | Short-dated | [blank]   | [blank]    | [blank]   | [blank]     | [blank]    | [blank] | [blank]   | [blank] | [blank]      | [blank]              | [blank]              |
    And Admin select an Inventory Lot for Promotion
      | search                           | lotCode                          | expiryDate |
      | auto lot sku vendor promotion366 | auto lot sku vendor promotion366 | Plus1      |
    And Check item on Promotion detail
      | product                          | sku                           | brand                     |
      | auto product vendor promotion366 | auto sku vendor promotion3661 | Auto brand create product |
    And Click on dialog button "Update"
    And BAO_ADMIN9 wait 2000 mini seconds
    And Search promotion by info
      | name                                 | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 366 edited | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                                 | type        | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 366 edited | Short-dated | CHI    | currentDate | currentDate | 1          | 1         |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 366 edited"
    And Admin verify promotion detail
      | name                                 | type        | usageLimit | caseLimit | caseMinimum | fromDate    | toDate      | showVendor | note      | skuExpiryDate |
      | Auto Vendor TPR Promotion 366 edited | Short-dated | 1          | 1         | 1           | currentDate | currentDate | [blank]    | Auto note | Plus1         |
    And Check item on Promotion detail
      | product                          | sku                           | brand                     |
      | auto product vendor promotion366 | auto sku vendor promotion3661 | Auto brand create product |

  @PROMOTION_378 @PROMOTION_404
  Scenario: Verify that admin edits information of a vendor submission 4
    Given BAO_ADMIN9 login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion" by api
    And Admin delete product name "auto product vendor promotion" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion387 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion3871" of product ""
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion3872" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                          | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion 387 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion3871" and add to Promotion
      | auto sku vendor promotion3871 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Add SKU to promo
      | specSKU                       |
      | auto sku vendor promotion3872 |
    And Check item on Promotion detail
      | product                          | sku                           | brand                     |
      | auto product vendor promotion387 | auto sku vendor promotion3871 | Auto brand create product |
      | auto product vendor promotion387 | auto sku vendor promotion3872 | Auto brand create product |
    And Admin Close the Create promotion form
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Choose regions to promo
      | region          |
      | Florida Express |
    And Check item on Promotion detail
      | product                          | sku                           | brand                     |
      | auto product vendor promotion387 | auto sku vendor promotion3871 | Auto brand create product |
    And Add SKU to promo
      | specSKU                       |
      | auto sku vendor promotion3872 |
    And Click on dialog button "Update"
    And BAO_ADMIN9 wait 2000 mini seconds
    And Search promotion by info
      | name                          | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion 387 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                          | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 387 | TPR  | CHI    | currentDate | currentDate | 1          | 1         |
    And Verify promotion show in All promotion page
      | name                          | type | region | startAt     | expireAt    | u hvnfhgfhgfhgfgfhgfhgfghfkhlkadsasdsdafsgdsageLimit | CaseLimit |
      | Auto Vendor TPR Promotion 387 | TPR  | FL     | currentDate | currentDate | 1                                                    | 1         |
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Check applied regions of Promotion detail
      | region              |
      | Chicagoland Express |
      | Florida Express     |
    And Check item on Promotion detail
      | product                          | sku                           | brand                     |
      | auto product vendor promotion387 | auto sku vendor promotion3871 | Auto brand create product |
      | auto product vendor promotion387 | auto sku vendor promotion3872 | Auto brand create product |
    And Choose stores and buyer company to promotion
      | includeStore        | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto store Florida  | [blank]      | [blank]              | [blank]              |
      | Auto Store Chicago1 | [blank]      | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And BAO_ADMIN9 wait 2000 mini seconds
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Check included stores of promotion
      | store               |
      | Auto store Florida  |
      | Auto Store Chicago1 |
    And Choose stores and buyer company to promotion
      | includeStore | excludeStore       | includedBuyerCompany | excludedBuyerCompany |
      | [blank]      | Auto store Florida | [blank]              | [blank]              |
    And Click on dialog button "Update"
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin delete "Excluded stores" name "Auto store Florida" in create promotion form
    And Choose stores and buyer company to promotion
      | includeStore | excludeStore | includedBuyerCompany | excludedBuyerCompany   |
      | [blank]      | [blank]      | [blank]              | Auto Buyer Company Bao |
    And Click on dialog button "Update"
    And Admin verify content of alert
      | You input conflicted promotion values. Please check the included stores (or buyer companies) and excluded stores (or buyer companies). |
    And Admin delete "Excluded buyer companies" name "Auto Buyer Company Bao" in create promotion form
    And Choose stores and buyer company to promotion
      | includeStore | excludeStore            | includedBuyerCompany | excludedBuyerCompany  |
      | [blank]      | Auto Bao Store Express1 | [blank]              | Auto Buyer company 38 |
    And Click on dialog button "Update"
    And BAO_ADMIN9 wait 2000 mini seconds
    And Admin go to promotion detail "Auto Vendor TPR Promotion 387"
    And Check included stores of promotion
      | store               |
      | Auto store Florida  |
      | Auto Store Chicago1 |
    And Check excluded stores of promotion
      | store                   |
      | Auto Bao Store Express1 |
    And Check excluded buyer companies of promotion
      | buyerCompany          |
      | Auto Buyer company 38 |

  @PROMOTION_414
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate | endDate | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | Minus1    | Plus1   | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
#    And Vendor select an Inventory Lot for create new Promotion
#      | lotCode | expiryDate |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | Plus1    | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | Minus1  | Plus1    | 1          | 1         |
    And Verify promotion info in Promotion detail
      | name                      | description | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor | store   |
      | Auto Vendor TPR Promotion | Auto note   | TPR  | 1          | 1         | 1           | Minus1   | Plus1  | is-checked | [blank] |
    And Click on any text "Link to original vendor submitted promotion"
    And Admin check approved submission promotion detail
      | approvedBy       | approvedOn  | name                      | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | note      |
      | bao9@podfoods.co | currentDate | Auto Vendor TPR Promotion | TPR  | 1          | 1         | 1           | Minus1   | Plus1  | Auto note |
    And Click on any text "Link to approved promotion"
    And Admin verify promotion detail
      | name                      | description | type | usageLimit | caseLimit | caseMinimum | fromDate | toDate | showVendor |
      | Auto Vendor TPR Promotion | Auto note   | TPR  | 1          | 1         | 1           | Minus1   | Plus1  | [blank]    |
    And Admin Close the Create promotion form
    And BAO_ADMIN9 navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | Minus1  | Plus1    | 1          | 1         |
    And BAO_ADMIN9 navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | [blank]  | [blank]     | [blank]              |
    And Admin check no data found
    And BAO_ADMIN9 navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus1  | [blank]  | [blank]     | [blank]              |
    And Admin check no data found

  @PROMOTION_415
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully 2
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt     | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | currentDate | currentDate | 1          | 1         |
    And BAO_ADMIN9 navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt     | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt     | expireAt    | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | currentDate | currentDate | 1          | 1         |
    And BAO_ADMIN9 navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt     | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | [blank]  | [blank]     | [blank]              |
    And Admin check no data found
    And BAO_ADMIN9 navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt     | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | currentDate | [blank]  | [blank]     | [blank]              |
    And Admin check no data found

  @PROMOTION_416
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully 3
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate | endDate | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | Plus1     | Plus2   | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | Plus1   | Plus2    | 1          | 1         |
    And BAO_ADMIN9 navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | [blank]  | [blank]     | [blank]              |
    And Admin check no data found
    And BAO_ADMIN9 navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | [blank]  | [blank]     | [blank]              |
    And Admin check no data found
    And BAO_ADMIN9 navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Plus1   | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | Plus1   | Plus2    | 1          | 1         |

  @PROMOTION_417
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully 4
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                      | startDate | endDate | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion | Minus2    | Minus1  | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |
    And BAO_ADMIN9 navigate to "Promotions" to "All promotions" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | Minus2  | Minus1   | 1          | 1         |
    And BAO_ADMIN9 navigate to "Promotions" to "Active" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | [blank]  | [blank]     | [blank]              |
    And Admin check no data found
    And BAO_ADMIN9 navigate to "Promotions" to "Expired" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | [blank]  | [blank]     | [blank]              |
    And Verify promotion show in All promotion page
      | name                      | type | region | startAt | expireAt | usageLimit | CaseLimit |
      | Auto Vendor TPR Promotion | TPR  | CHI    | Minus2  | Minus1   | 1          | 1         |
    And BAO_ADMIN9 navigate to "Promotions" to "Upcoming" by sidebar
    And Search promotion by info
      | name                      | type | store   | brand   | productName | skuName | region              | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion | TPR  | [blank] | [blank] | [blank]     | [blank] | Chicagoland Express | Minus2  | [blank]  | [blank]     | [blank]              |
    And Admin check no data found

  @PROMOTION_419
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - Buy-in promotion
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                            | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion419 | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                            | type   | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor Buy-in Promotion419 | Buy-in | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor Buy-in Promotion419"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Buy-in Promotion419 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor search promotion on tab "Active"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Buy-in Promotion419 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor search promotion on tab "Expired"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "Buy in" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type   | price | caseLimit |
      | auto sku vendor promotion1 | BUY-IN | $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice | currentPrice | typePromo        | discount    | newPrice | caseLimit | discountThumbnails |
      | $9.00     | $9.00        | Buy-in Promotion | -$1.00/case | $9.00    | 1         | -$1                |

  @PROMOTION_420
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - Buy-in promotion - With Case Stack Deals
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                            | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion420 | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 1      |
      | 2           | 2      |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                            | type   | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor Buy-in Promotion420 | Buy-in | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor Buy-in Promotion420"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount      |
      | [blank] | Auto Vendor Buy-in Promotion420 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00 ~ $2.00 |
    And Vendor search promotion on tab "Active"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount      |
      | [blank] | Auto Vendor Buy-in Promotion420 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | $1.00 ~ $2.00 |
    And Vendor search promotion on tab "Expired"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "Buy in" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type   | price         | caseLimit |
      | auto sku vendor promotion1 | BUY-IN | $8.00 ~ $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice     | currentPrice  | typePromo        | caseLimit | discountThumbnails |
      | $8.00 ~ $9.00 | $8.00 ~ $9.00 | Buy-in Promotion | 1         | -$1 ~ -$2          |
    And Verify Stack case promotion on product detail
      | stackCase             |
      | 1 - 1 cases: $1.00 OI |
      | 2+ cases: $2.00 OI    |

  @PROMOTION_421
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - Buy-in promotion - Percentage
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                            | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion421 | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Percentage   | 10     |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                            | type   | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor Buy-in Promotion421 | Buy-in | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor Buy-in Promotion421"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Buy-in Promotion421 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "Active"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Buy-in Promotion421 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "Expired"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "Buy in" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type   | price | caseLimit |
      | auto sku vendor promotion1 | BUY-IN | $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice | currentPrice | typePromo        | discount | newPrice | caseLimit | discountThumbnails |
      | $9.00     | $9.00        | Buy-in Promotion | 10% off  | $9.00    | 1         | 10%                |

  @PROMOTION_421
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - Buy-in promotion - Percentage-  With Case Stack Deals
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor Buy-in Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                            | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Buy-in Promotion421 | currentDate | currentDate | Auto note | Buy-in        | 1         | 1           | [blank]    | Percentage   | 10     |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 2           | 20     |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                            | type   | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor Buy-in Promotion421 | Buy-in | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor Buy-in Promotion421"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount  |
      | [blank] | Auto Vendor Buy-in Promotion421 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | 10% ~ 20% |
    And Vendor search promotion on tab "Active"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                            | type   | regions             | stores | start       | end         | discount  |
      | [blank] | Auto Vendor Buy-in Promotion421 | Buy-in | Chicagoland Express | store  | currentDate | currentDate | 10% ~ 20% |
    And Vendor search promotion on tab "Expired"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type   | brand                     | regions             | stores  | startDate   |
      | Buy-in | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "Buy in" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type   | price         | caseLimit |
      | auto sku vendor promotion1 | BUY-IN | $8.00 ~ $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice     | currentPrice  | typePromo        | caseLimit | discountThumbnails |
      | $8.00 ~ $9.00 | $8.00 ~ $9.00 | Buy-in Promotion | 1         | 10% ~ 20%          |
    And Verify Stack case promotion on product detail
      | stackCase           |
      | 1 - 1 cases: 10% OI |
      | 2+ cases: 20% OI    |

  @PROMOTION_422
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - TPR promotion
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                         | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion422 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | [blank]    | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                         | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion422 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion422"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                         | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion422 | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor search promotion on tab "Active"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                         | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion422 | TPR  | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor search promotion on tab "Expired"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "TPR" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type | price | caseLimit |
      | auto sku vendor promotion1 | TPR  | $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice | currentPrice | typePromo     | discount    | newPrice | caseLimit | discountThumbnails |
      | $9.00     | $9.00        | TPR Promotion | -$1.00/case | $9.00    | 1         | -$1                |

  @PROMOTION_423
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - TPR promotion - Percentage
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                         | startDate   | endDate     | note      | promotionType                   | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor TPR Promotion423 | currentDate | currentDate | Auto note | TPR (Temporary Price Reduction) | 1         | 1           | [blank]    | Percentage   | 10     |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                         | type | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor TPR Promotion423 | TPR  | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor TPR Promotion423"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                         | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion423 | TPR  | Chicagoland Express | store  | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "Active"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                         | type | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor TPR Promotion423 | TPR  | Chicagoland Express | store  | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "Expired"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type | brand                     | regions             | stores  | startDate   |
      | TPR  | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "TPR" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type | price | caseLimit |
      | auto sku vendor promotion1 | TPR  | $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice | currentPrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $9.00     | $9.00        | TPR Promotion | 10% off  | $9.00    | 1         | 10%                |

  @PROMOTION_424
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - Short-dated promotion
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion424 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | [blank]    | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                                 | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor Short-dated Promotion424 | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion424"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                                 | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion424 | Short-dated | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor search promotion on tab "Active"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                                 | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion424 | Short-dated | Chicagoland Express | store  | currentDate | currentDate | $1.00    |
    And Vendor search promotion on tab "Expired"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "Short dated" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type        | price | caseLimit |
      | auto sku vendor promotion1 | SHORT-DATED | $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice | currentPrice | typePromo             | discount    | newPrice | caseLimit | discountThumbnails |
      | $9.00     | $9.00        | Short-dated Promotion | -$1.00/case | $9.00    | 1         | -$1                |

  @PROMOTION_425
  Scenario:Verify display of a promotion on Active child tabs when admin approved it successfully - Short-dated promotion - Percentage
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion1" by api
    And Admin delete product name "auto product vendor promotion1" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                           | brand_id |
      | auto product vendor promotion1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion1" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion425 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | [blank]    | Percentage   | 10     |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion1" and add to Promotion
      | auto sku vendor promotion1 |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    Given BAO_ADMIN9 open web admin
    When BAO_ADMIN9 login to web with role Admin
    And BAO_ADMIN9 navigate to "Promotions" to "Vendor submissions" by sidebar
    And Search promotion by info
      | name                                 | type        | store   | brand   | productName | skuName | region  | startAt | expireAt | isStackDeal | includedBuyerCompany |
      | Auto Vendor Short-dated Promotion425 | Short-dated | [blank] | [blank] | [blank]     | [blank] | [blank] | [blank] | [blank]  | [blank]     | [blank]              |
    And Admin go to promotion detail "Auto Vendor Short-dated Promotion425"
    And Click on dialog button "Approve"
    And Admin verify content of alert
      | Promotion has been approved successfully ! |

    And Switch to actor VENDOR
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor search promotion on tab "Submitted"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "All"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                                 | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion425 | Short-dated | Chicagoland Express | store  | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "Active"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                                 | type        | regions             | stores | start       | end         | discount |
      | [blank] | Auto Vendor Short-dated Promotion425 | Short-dated | Chicagoland Express | store  | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "Expired"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    And Vendor search promotion on tab "Upcoming"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check not found promotion number ""
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "buyer"
    And Buyer Search product by name "auto product vendor promotion1"
    Then Verify promo preview "Short dated" of product "auto product vendor promotion1" in "Catalog page"
      | name                       | type        | price | caseLimit |
      | auto sku vendor promotion1 | SHORT-DATED | $9.00 | 1         |
    And Verify Promotional Discount of "auto product vendor promotion1" and sku "auto sku vendor promotion1" in product detail
      | unitPrice | currentPrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $9.00     | $9.00        | Short-dated Promotion | 10% off  | $9.00    | 1         | 10%                |

  @PROMOTION_429
  Scenario:Check Save Draft a promotion with only required fields
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search promotion by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion429" by api
    And Admin delete product name "auto product vendor promotion429" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion429 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion429" of product ""

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion429 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | [blank]    | Percentage   | 10     |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
#    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
#      | Auto Buyer Company Bao |
    And Vendor search specific SKU "auto sku vendor promotion429" and add to Promotion
      | auto sku vendor promotion429 |
    And Click on button "Save Draft"
    And VENDOR check alert message
      | Promotion saved successfully. |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand                     | regions             | stores  | startDate   |
      | Short-dated | Auto brand create product | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number  | name                                      | type        | regions             | stores     | start       | end         | discount |
      | [blank] | DraftAuto Vendor Short-dated Promotion429 | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | 10%      |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion429"
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion429 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | [blank]    | Percentage   | 10     |
    And Click on button "Create"
    And VENDOR check dialog message
      | Promotion created successfully |
    And Click on dialog button "OK"
    And Vendor check promotion detail
      | title                                | type        | regions             | stores     | start-date  | end-date    | discount | caseLimit | expiryDate |
      | Auto Vendor Short-dated Promotion429 | Short-dated | Chicagoland Express | All stores | currentDate | currentDate | 10%      | 1         | -          |
    And Vendor Check applied SKUs on promotion detail
      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
      | Auto brand create product | auto product vendor promotion429 | auto sku vendor promotion429 | Chicagoland Express | $10.00        | $9.00         |
    And Admin search promotion by Promotion Name "Auto Vendor Short-dated Promotion429"
    And Admin delete promotion by skuName ""
    And Admin search product name "auto product vendor promotion429" by api
    And Admin delete product name "auto product vendor promotion429" by api

  @PROMOTION_430
  Scenario:Check Save Draft a promotion with validate required fields
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion430 | Plus1     | [blank] | [blank] | [blank]       | [blank]   | [blank]     | [blank]    | [blank]      | [blank] |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion430 | Plus1     | [blank] | [blank] | [blank]       | [blank]   | 1           | [blank]    | [blank]      | [blank] |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | Plus1     |
    And Vendor check records promotions
      | number           | name                                      | type    | regions     | stores     | start | end | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion430 | [blank] | All regions | All stores | Plus1 | -   | [blank]  |
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate |
      | Short-dated | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion430"
    And Vendor search promotion on tab "All"
      | type   | brand   | regions | stores  | startDate |
      | Buy-in | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion430"
    And Vendor search promotion on tab "All"
      | type | brand   | regions | stores  | startDate |
      | TPR  | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion430"
    And Vendor search promotion on tab "Active"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion430"
    And Vendor search promotion on tab "Upcoming"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion430"
    And Vendor search promotion on tab "Expired"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion430"
    And Vendor search promotion on tab "Submitted"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | [blank]   |
    And Vendor check not found promotion name "Auto Vendor Short-dated Promotion430"
    And Vendor search promotion on tab "Draft"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | Plus1     |
    And Vendor check records promotions
      | number           | name                                      | type    | regions     | stores     | start | end | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion430 | [blank] | All regions | All stores | Plus1 | -   | [blank]  |

  @PROMOTION_431
  Scenario:Check Save Draft a promotion with validate required fields 2
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion431 | Plus1     | currentDate | Auto note | [blank]       | 0         | 0           | 0          | [blank]      | [blank] |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion431 | Plus1     | currentDate | Auto note | [blank]       | 0         | 0           | 0          | [blank]      | [blank] |
    And Vendor check error message is showing of fields
      | field          | message                      |
      | Promotion type | This field cannot be blank.  |
      | Case limit     | Value must be greater than 0 |
      | Case minimum   | Value must be greater than 0 |
      | Usage limit    | Value must be greater than 0 |
    And Vendor create Promotion with info
      | name    | startDate | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | [blank] | Plus1     | [blank] | [blank] | [blank]       | 1         | 2           | [blank]    | Fix Rate     | -1     |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion431 | Plus1     | currentDate | Auto note | [blank]       | 1         | 2           | 0          | Fix Rate     | -1     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | Plus1     |
    And Vendor check records promotions
      | number           | name                                      | type    | regions     | stores     | start | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion431 | [blank] | All regions | All stores | Plus1 | currentDate | $-1.00   |

  @PROMOTION_432
  Scenario:Check Save Draft a promotion with validate required fields 3
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion431 | Plus1     | currentDate | Auto note | [blank]       | 0         | 0           | 0          | [blank]      | [blank] |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion431 | Plus1     | currentDate | Auto note | [blank]       | 0         | 0           | 0          | [blank]      | [blank] |
    And Vendor check error message is showing of fields
      | field          | message                      |
      | Promotion type | This field cannot be blank.  |
      | Case limit     | Value must be greater than 0 |
      | Case minimum   | Value must be greater than 0 |
      | Usage limit    | Value must be greater than 0 |
    And Vendor create Promotion with info
      | name    | startDate | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | [blank] | [blank]   | [blank] | [blank] | [blank]       | 1         | 2           | [blank]    | Percentage   | -1     |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion431 | Plus1     | currentDate | Auto note | [blank]       | 1         | 2           | 0          | Percentage   | 1      |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type    | brand   | regions | stores  | startDate |
      | [blank] | [blank] | [blank] | [blank] | Plus1     |
    And Vendor check records promotions
      | number           | name                                      | type    | regions     | stores     | start | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion431 | [blank] | All regions | All stores | Plus1 | currentDate | 1%       |

  @PROMOTION_447
  Scenario: Check validation of the Is this a case stack deal? switch button when save draft
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion447 | currentDate | [blank] | [blank] | [blank]       | 1         | 2           | [blank]    | Fix Rate     | [blank] |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 1           | 10     |
    And Vendor check error message is showing of fields
      | field        | message                                                                   |
      | Min quantity | Min quantity must be a valid number and cannot be lower than case minimum |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion447 | currentDate | [blank] | [blank] | [blank]       | 1         | 1           | [blank]    | Fix Rate     | 10     |
    And Vendor check stack deal draft promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 1           | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type    | brand   | regions | stores  | startDate   |
      | [blank] | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type    | regions     | stores     | start       | end | discount        |
      | create by vendor | DraftAuto Vendor Short-dated Promotion447 | [blank] | All regions | All stores | currentDate | -   | $10.00 ~ $10.00 |

  @PROMOTION_448
  Scenario: Check validation of the Is this a case stack deal? switch button when save draft 2
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount  |
      | Auto Vendor Short-dated Promotion447 | currentDate | [blank] | [blank] | [blank]       | 1         | 2           | [blank]    | Percentage   | [blank] |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 1           | 10     |
    And Vendor check error message is showing of fields
      | field        | message                                                                   |
      | Min quantity | Min quantity must be a valid number and cannot be lower than case minimum |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion447 | currentDate | [blank] | [blank] | [blank]       | 1         | 1           | [blank]    | Percentage   | 10     |
    And Vendor check stack deal draft promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 1           | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type    | brand   | regions | stores  | startDate   |
      | [blank] | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type    | regions     | stores     | start       | end | discount  |
      | create by vendor | DraftAuto Vendor Short-dated Promotion447 | [blank] | All regions | All stores | currentDate | -   | 10% ~ 10% |

  @PROMOTION_449
  Scenario: Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) with Regional promotion = ON, End Date is not empty, Is this a case stack deal? = OFF
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion449 | currentDate | Plus1   | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor choose region for create new Promotion
      | Dallas Express |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion449 | currentDate | Plus1   | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions        | stores  | startDate   |
      | Short-dated | [blank] | Dallas Express | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions        | stores     | start       | end   | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion449 | Short-dated | Dallas Express | All stores | currentDate | Plus1 | 10%      |

  @PROMOTION_450
  Scenario: Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) with Regional promotion = ON, End Date is empty, Is this a case stack deal? = OFF
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion450 | currentDate | [blank] | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
      | Dallas Express      |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion450 | currentDate | [blank] | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions        | stores  | startDate   |
      | Short-dated | [blank] | Dallas Express | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions   | stores     | start       | end     | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion450 | Short-dated | 2 regions | All stores | currentDate | [blank] | 10%      |
    And Vendor search promotion on tab "All"
      | type        | brand   | regions             | stores  | startDate   |
      | Short-dated | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions   | stores     | start       | end     | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion450 | Short-dated | 2 regions | All stores | currentDate | [blank] | 10%      |

  @PROMOTION_451
  Scenario: Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) with Retail Specific promotion = ON:- Applied for 1 buyer company has not any stores
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion451 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor search specific buyer companies "At thang no store company" and add to Promotion
      | At thang no store company |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion451 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion451 | Short-dated | All regions | 0 store | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "All"
      | type        | brand   | regions             | stores  | startDate   |
      | Short-dated | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion451 | Short-dated | All regions | 0 store | currentDate | currentDate | 10%      |

    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion451"
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion451 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Check any text "is" showing on screen
      | At thang no store company |

  @PROMOTION_453
  Scenario: Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) with Retail Specific promotion = ON:- Applied for multiple buyer companies
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion453 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor search specific buyer companies "Auto Buyer Company Bao" and add to Promotion
      | Auto Buyer Company Bao |
    And Vendor search specific buyer companies "Auto_BuyerCompany" and add to Promotion
      | Auto_BuyerCompany |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion453 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores    | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion453 | Short-dated | All regions | 25 stores | currentDate | currentDate | 10%      |
    And Vendor search promotion on tab "All"
      | type        | brand   | regions             | stores  | startDate   |
      | Short-dated | [blank] | Chicagoland Express | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores    | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion453 | Short-dated | All regions | 25 stores | currentDate | currentDate | 10%      |

    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion453"
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion453 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Check any text "is" showing on screen
      | Auto Buyer Company Bao |
      | Auto_BuyerCompany      |

  @PROMOTION_454
  Scenario: Check display of a Vendor promotion when Admin deactivates all its active stores
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
    When Admin search buyer company by API
      | buyerCompany                  | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion454 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    # Create buyer company by api
    And Admin create buyer company by API
      | name                          | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer Company Promotion454 | 01-123 | 83          | 83         | https://beta.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                  | email                        | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | at Store Promotion454 | at+storepromo454@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
#    And Admin change state of store "create by api" to "inactive"
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion454 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor search specific buyer companies "AT Buyer Company Promotion454" and add to Promotion
      | AT Buyer Company Promotion454 |

    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion454 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion454 | Short-dated | All regions | 1 store | currentDate | currentDate | 10%      |

    And Admin change state of store "create by api" to "inactive"
    And Vendor refresh browser
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion454 | Short-dated | All regions | 0 store | currentDate | currentDate | 10%      |
    When Admin search buyer company by API
      | buyerCompany                  | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion454 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    And Vendor refresh browser
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion454 | Short-dated | All regions | 0 store | currentDate | currentDate | 10%      |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion454"
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion454 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Check any text "not" showing on screen
      | AT Buyer Company Promotion454 |

  @PROMOTION_456
  Scenario: Check display of a Vendor promotion when Admin deactivates all its buyer companies
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
    When Admin search buyer company by API
      | buyerCompany                  | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion455 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    # Create buyer company by api
    And Admin create buyer company by API
      | name                          | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer Company Promotion455 | 01-123 | 83          | 83         | https://beta.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                  | email                        | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | at Store Promotion455 | at+storepromo455@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
#    And Admin change state of store "create by api" to "inactive"
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion455 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor search specific buyer companies "AT Buyer Company Promotion455" and add to Promotion
      | AT Buyer Company Promotion455 |

    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion455 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion455 | Short-dated | All regions | 1 store | currentDate | currentDate | 10%      |

#    Change buyer company to "inactive"
    And Admin change state of buyer company "create by api" to "inactive" by API
    And Vendor refresh browser
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion455 | Short-dated | All regions | 0 store | currentDate | currentDate | 10%      |
    When Admin search buyer company by API
      | buyerCompany                  | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion455 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    And Vendor refresh browser
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion455 | Short-dated | All regions | 0 store | currentDate | currentDate | 10%      |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion455"
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion455 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Check any text "not" showing on screen
      | AT Buyer Company Promotion455 |

  @PROMOTION_458
  Scenario: Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) with - Applied for multiple regions - Applied for multiple buyer companies
    Given BAO_ADMIN11 login web admin by api
      | email             | password  |
      | bao11@podfoods.co | 12345678a |
    When Admin search buyer company by API
      | buyerCompany                   | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion4581 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    When Admin search buyer company by API
      | buyerCompany                   | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion4582 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    # Create buyer company by api
    And Admin create buyer company by API
      | name                           | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer Company Promotion4581 | 01-123 | 83          | 83         | https://beta.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                   | email                         | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | at Store Promotion4581 | at+storepromo4581@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create buyer company by api
    And Admin create buyer company by API
      | name                           | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer Company Promotion4582 | 01-123 | 83          | 83         | https://beta.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name                   | email                         | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | at Store Promotion4582 | at+storepromo4582@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion458 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor search specific buyer companies "AT Buyer Company Promotion4581" and add to Promotion
      | AT Buyer Company Promotion4581 |
    And Vendor search specific buyer companies "AT Buyer Company Promotion4582" and add to Promotion
      | AT Buyer Company Promotion4582 |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
      | Dallas Express      |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion458 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions   | stores  | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion458 | Short-dated | 2 regions | 2 store | currentDate | currentDate | 10%      |
    When Admin search buyer company by API
      | buyerCompany                   | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion4581 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    When Admin search buyer company by API
      | buyerCompany                   | managedBy | onboardingState | tag     |
      | AT Buyer Company Promotion4582 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API

  @PROMOTION_459
  Scenario: Vendor creates a Draft promotion Short-dated with Inventory Lot and SKU Expiry Date:- Vendor do not select any Inventory lot"
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion459 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion459" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion459" by api
    And Admin delete product name "auto product vendor promotion459" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion459 | 2580     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion4591" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion4591 | random             | 5        | auto lot sku vendor promotion4591 | 99           | Plus1        | [blank]     | [blank] |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion4592" of product ""
    And Admin create inventory api1
      | index | sku                           | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion4592 | random             | 5        | auto lot sku vendor promotion4592 | 99           | Plus1        | Plus1       | [blank] |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion459 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                            | lotCode                           | expiryDate |
      | auto lot sku vendor promotion4591 | auto lot sku vendor promotion4591 | [blank]    |
    And Vendor check specific SKU create Promotion
      | skuName                       | brand                | product                          | image       |
      | auto sku vendor promotion4591 | Auto_Brand_Inventory | auto product vendor promotion459 | anhJPG2.jpg |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion459 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor select an Inventory Lot for create new Promotion
      | search                            | lotCode                           | expiryDate |
      | auto lot sku vendor promotion4592 | auto lot sku vendor promotion4592 | Plus1      |
    And Vendor save draft promotion success

  @PROMOTION_462
  Scenario: Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) has only one Specific SKU then admin DRAFTS or DEACTIVATES that SKU
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion462" by api
    And Admin delete product name "auto product vendor promotion462" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion462 | 2580     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random auto sku vendor promotion4621" of product ""
    And Clear Info of Region api
    And Info of Region
      | region         | id | state  | availability | casePrice | msrp |
      | Dallas Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random auto sku vendor promotion4622" of product ""
    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random auto sku vendor promotion4623" of product ""
       #  change State của sku
    And Admin change info of regions attributes of sku "random auto sku vendor promotion4623" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion462 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
      | Dallas Express      |
    And Vendor search specific SKU "random auto sku vendor promotion462" and add to Promotion
      | random auto sku vendor promotion4621 |
      | random auto sku vendor promotion4622 |
      | random auto sku vendor promotion4623 |
    And Vendor check specific SKU create Promotion
      | skuName                              | brand                | product                          | image       |
      | random auto sku vendor promotion4623 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
      | random auto sku vendor promotion4622 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
      | random auto sku vendor promotion4621 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion462 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions   | stores     | start       | end         | discount |
      | create by vendor | DraftAuto Vendor Short-dated Promotion462 | Short-dated | 2 regions | All stores | currentDate | currentDate | $1.00    |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion462"
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion462 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor check specific SKU create Promotion
      | skuName                              | brand                | product                          | image       |
      | random auto sku vendor promotion4621 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
      | random auto sku vendor promotion4622 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
      | random auto sku vendor promotion4623 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
#Change state of skus
    And Change state of SKU id: "random auto sku vendor promotion4621" to "draft"
    And Change state of SKU id: "random auto sku vendor promotion4623" to "inactive"
    And Vendor refresh browser
    And Vendor check specific SKU create Promotion
      | skuName                              | brand                | product                          | image       |
      | random auto sku vendor promotion4621 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
      | random auto sku vendor promotion4622 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
      | random auto sku vendor promotion4623 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
    And Vendor search specific SKU "random auto sku vendor promotion462" and check SKU is not show
      | random auto sku vendor promotion4621 |
      | random auto sku vendor promotion4623 |
#    Delete sku
    And Admin delete sku "random auto sku vendor promotion4622" in product "" by api
    And Vendor refresh browser
    And Vendor check specific SKU create Promotion
      | skuName                              | brand                | product                          | image       |
      | random auto sku vendor promotion4621 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
      | random auto sku vendor promotion4623 | Auto_Brand_Inventory | auto product vendor promotion462 | anhJPG2.jpg |
    And Check any text "not" showing on screen
      | random auto sku vendor promotion4622 |
    And Vendor search specific SKU "random auto sku vendor promotion462" and check SKU is not show
      | random auto sku vendor promotion4621 |
      | random auto sku vendor promotion4622 |
      | random auto sku vendor promotion4623 |

  @PROMOTION_470
  Scenario: "Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) with Is this a case stack deal? = ON - Discount type = Percentage"
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion470 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 10     |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 2           | 20     |
      | 1           | 10     |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion470 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Percentage   | 20     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores     | start       | end         | discount  |
      | create by vendor | DraftAuto Vendor Short-dated Promotion470 | Short-dated | All regions | All stores | currentDate | currentDate | 10% ~ 20% |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion470"
    And Vendor check stack deal draft promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 2           | 20     |

  @PROMOTION_470
  Scenario: "Vendor creates a Draft promotion (Buy-in/ TPR/ Short-dated) with Is this a case stack deal? = ON - Discount type = Fix rate"
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion470 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Fix Rate     | 10     |
    And Vendor add cases stack deal create Promotion
      | minQuantity | amount |
      | 2           | 20     |
      | 1           | 10     |
    And Vendor save draft promotion success
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note    | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated Promotion470 | currentDate | currentDate | [blank] | Short-dated   | 1         | 2           | [blank]    | Fix Rate     | 20     |
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "All"
      | type        | brand   | regions | stores  | startDate   |
      | Short-dated | [blank] | [blank] | [blank] | currentDate |
    And Vendor check records promotions
      | number           | name                                      | type        | regions     | stores    | start       | end         | discount        |
      | create by vendor | DraftAuto Vendor Short-dated Promotion470 | Short-dated | All regions | All store | currentDate | currentDate | $10.00 ~ $20.00 |
    And Vendor go to promotion detail with number or name: "Auto Vendor Short-dated Promotion470"
    And Vendor check stack deal draft promotion
      | minQuantity | amount |
      | 1           | 10     |
      | 2           | 20     |

  @PROMOTION_472
  Scenario: Vendor duplicates a Draft promotion
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao9@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | auto product vendor promotion472 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "auto product vendor promotion472" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin search promotion vendor submission by Promotion Name "Auto Vendor Short-dated Promotion"
    And Admin delete promotion submission by api name ""
    And Admin search product name "auto product vendor promotion472" by api
    And Admin delete product name "auto product vendor promotion472" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | auto product vendor promotion472 | 2580     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "auto sku vendor promotion472" of product ""
    And Admin create inventory api1
      | index | sku                          | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment |
      | 1     | auto sku vendor promotion472 | random             | 5        | auto lot sku vendor promotion472 | 99           | Plus1        | [blank]     | [blank] |
#    And Admin create a "active" SKU from admin with name "auto sku vendor promotion4592" of product ""
#    And Admin create inventory api1
#      | index | sku                           | product_variant_id | quantity | lot_code                          | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | auto sku vendor promotion4592 | random             | 5        | auto lot sku vendor promotion4592 | 99           | Plus1        | Plus1       | [blank] |
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Promotions" by sidebar
    And Vendor go to create Promotion
    And Vendor create Promotion with info
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated promotion472 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor choose region for create new Promotion
      | Chicagoland Express |
    And Vendor select an Inventory Lot for create new Promotion
      | search                           | lotCode                          | expiryDate |
      | auto lot sku vendor promotion472 | auto lot sku vendor promotion472 | [blank]    |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                | product                          | image       |
      | auto sku vendor promotion472 | Auto_Brand_Inventory | auto product vendor promotion472 | anhJPG2.jpg |
    And Vendor save draft promotion success
    And Click on any text "< Back to Promotions"
    And Vendor search promotion on tab "Draft"
      | type        | brand                | regions | stores  | startDate   |
      | Short-dated | Auto_Brand_Inventory | [blank] | [blank] | currentDate |
#    And Vendor check promotion draft
#      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
#      | Auto Vendor Short-dated Promotion459 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
#    And Vendor select an Inventory Lot for create new Promotion
#      | search                            | lotCode                           | expiryDate |
#      | auto lot sku vendor promotion4592 | auto lot sku vendor promotion4592 | Plus1      |
#    And Vendor save draft promotion success
    And Vendor duplicate promotion "Auto Vendor Short-dated promotion472"
    And Vendor check promotion draft
      | name                                 | startDate   | endDate     | note      | promotionType | caseLimit | caseMinimum | usageLimit | discountType | amount |
      | Auto Vendor Short-dated promotion472 | currentDate | currentDate | Auto note | Short-dated   | 1         | 1           | 1          | Fix Rate     | 1      |
    And Vendor check specific SKU create Promotion
      | skuName                      | brand                | product                          | image       |
      | auto sku vendor promotion472 | Auto_Brand_Inventory | auto product vendor promotion472 | anhJPG2.jpg |
    And Click on button "Duplicate"
    And VENDOR check dialog message
      | Promotion created successfully |
    And VENDOR check dialog message
      | Thank you for filling out the new promotion form. Your request is under review and Pod Foods will reach out to you shortly. |
    And Click on button "OK"
#    And Vendor check promotion detail
#      | title                             | type        | regions             | stores | start-date  | end-date    | discount | caseLimit | status    | useLimit |
#      | Auto Vendor Short-dated Promotion | Short-dated | Chicagoland Express | stores | currentDate | currentDate | $1.00    | 1         | Submitted | 1        |
#    And Vendor Check applied SKUs on promotion detail
#      | brand                     | product                          | sku                          | region              | originalPrice | discountPrice |
#      | Auto brand create product | auto product vendor promotion306 | auto sku vendor promotion306 | Chicagoland Express | $10.00        | $9.00         |


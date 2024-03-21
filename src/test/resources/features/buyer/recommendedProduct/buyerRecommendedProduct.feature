# language: en
#Tính năng: Buyer Recommended Product
@feature=buyerRecommendedProduct
@feature=Buyer
Feature: Buyer Recommended Product

  @RECOMMENDED_PRODUCTS_1
  Scenario Outline: Check displayed information on the page of the normal buyers
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer check redirect link on catalog page
      | title                | newTitle                                                                             | redirectLink                      |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
      | Brands               | All brands - Pod Foods \| Online Distribution Platform for Emerging Brands           | .podfoods.co/brands               |
      | Order guide          | Order Guide - Pod Foods \| Online Distribution Platform for Emerging Brands          | .podfoods.co/order-guide          |
      | Recommended products | Recommended Products - Pod Foods \| Online Distribution Platform for Emerging Brands | .podfoods.co/recommended-products |
      | Favorites            | Favorites - Pod Foods \| Online Distribution Platform for Emerging Brands            | .podfoods.co/favorites            |
      | Refer a Brand        | Brand Referral - Pod Foods \| Online Distribution Platform for Emerging Brands       | .podfoods.co/brands/invite        |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
      | Recommended products | Recommended Products - Pod Foods \| Online Distribution Platform for Emerging Brands | .podfoods.co/recommended-products |
    And Check any text "is" showing on screen
      | Your recommended products |
    Examples:
      | role_            | buyer                          | pass      | role       |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer35@podfoods.co | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer66@podfoods.co | 12345678a | head buyer |

  @RECOMMENDED_PRODUCTS_2
  Scenario Outline: Check the Recommended products list when buyer has no recommended items "<id>"
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    #Create recommendation
#    And Admin create recommendation by api
#      | buyer_id | _buyer | product_id | comment |
#      | 2902     | 2902   | 6336       | comment |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Check any text "is" showing on screen
      | Your recommended products     |
      | No results found              |
      | We couldn't find any matches. |
    Examples:
      | role_            | buyer                          | pass      | role       | id   |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer      | 3186 |
      | Store sub buyer  | ngoctx+autobuyer35@podfoods.co | 12345678a | buyer      | 2891 |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co | 12345678a | buyer      | 3332 |
#      | Head buyer       | ngoctx+autobuyer66@podfoods.co | 12345678a | head buyer | 158  |

  @RECOMMENDED_PRODUCTS_4
  Scenario Outline: Check the Recommended products list when buyer has multiple recommended items"<id>"
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id | comment |
      | <id>     | <id>   | 6366       | comment |
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id | comment   |
      | <id>     | <id>   | 6336       | comment 2 |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer check Recommended products
      | brand                      | product                      | image     | comment   | expressTag   |
      | Auto brand add to cart moq | Auto product add to cart moq | logo.jpg  | comment   | <expressTag> |
      | Auto brand add to cart mov | Auto product add to cart mov | 17597.png | comment 2 | <expressTag> |
    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |
      | Store sub buyer  | ngoctx+autobuyer35@podfoods.co | 12345678a | buyer | 2891 | show       |
      | Store manager PD | ngoctx+autobuyer45@podfoods.co | 12345678a | buyer | 2985 | not show   |

  @RECOMMENDED_PRODUCTS_4_2
  Scenario Outline: Check the Recommended products list when head buyer has multiple recommended items
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Head Buyer id "<id>" by api
    And Admin delete product recommendation by api
#    Create recommendation
    And Admin create recommendation by api
      | head_buyer_id | _buyer | product_id | comment |
      | <id>          | <id>   | 6366       | comment |
    And Admin create recommendation by api
      | head_buyer_id | _buyer | product_id | comment   |
      | <id>          | <id>   | 6336       | comment 2 |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer check Recommended products
      | brand                      | product                      | image     | comment   | expressTag   |
      | Auto brand add to cart moq | Auto product add to cart moq | logo.jpg  | comment   | <expressTag> |
      | Auto brand add to cart mov | Auto product add to cart mov | 17597.png | comment 2 | <expressTag> |
    Examples:
      | role_      | buyer                          | pass      | role       | id  | expressTag |
      | Head buyer | ngoctx+autobuyer66@podfoods.co | 12345678a | head buyer | 158 | show       |

  @BUYER_RECOMMENDED_5
  Scenario Outline: Check display of master image on the product card when deactivates main SKU
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api

    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
    And Admin create SKU from admin with name "random sku buyer recommended api2" of product ""

#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
#     changes main SKU to another region
    And Admin change info of regions attributes of sku "random sku buyer recommended api1" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer check Recommended products
      | brand                     | product                              | image       | comment | expressTag   |
      | Auto brand create product | random product buyer recommended api | anhJPEG.jpg | comment | <expressTag> |
    #     changes main SKU to another region
    And Admin change info of regions attributes of sku "random sku buyer recommended api2" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And BUYER refresh browser
    And Buyer check not show Recommended product "random product buyer recommended api"

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_6
  Scenario Outline: Check the display of promotion tag of a product card (Check with normal buyers only)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
    #  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description                              | starts_at   | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Auto promotion buyer recommended product | currentDate | [blank]    | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — Z-A"
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                              | image       | comment | expressTag   |
      | Auto brand create product | random product buyer recommended api | anhJPG2.jpg | comment | <expressTag> |
    Then Verify promo preview "TPR" of product "random product buyer recommended api" in "Recommended products"
      | name                              | type | price | caseLimit |
      | random sku buyer recommended api1 | TPR  | $5.00 | 1         |
    And Verify Promotional Discount of "random product buyer recommended api" and sku "random sku buyer recommended api1" in product detail
      | unitPrice | casePrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails | expireDate |
      | $5.00     | $5.00     | TPR Promotion | 50% off  | $5.00    | 1         | 50%                | [blank]    |

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_7
  Scenario Outline: Check the display of promotion tag of a product card (Check with normal buyers only)- A Product under consideration has multiple SKUs with same promotion type
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
    #  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description                              | starts_at   | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Auto promotion buyer recommended product | currentDate | [blank]    | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

#    SKU 2
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api2" of product ""
#  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                      | description                              | starts_at   | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product2 | Auto promotion buyer recommended product | currentDate | [blank]    | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — Z-A"
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                              | image       | comment | expressTag   |
      | Auto brand create product | random product buyer recommended api | anhJPG2.jpg | comment | <expressTag> |
    Then Verify promo preview "TPR" of product "random product buyer recommended api" in "Recommended products"
      | name                              | type | price | caseLimit |
      | random sku buyer recommended api1 | TPR  | $5.00 | 1         |
      | random sku buyer recommended api2 | TPR  | $8.00 | 1         |
    And Verify Promotional Discount of "random product buyer recommended api" and sku "random sku buyer recommended api1" in product detail
      | unitPrice | casePrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails | expireDate |
      | $5.00     | $5.00     | TPR Promotion | 50% off  | $5.00    | 1         | 50%                | [blank]    |

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_8 @BUYER_RECOMMENDED_47
  Scenario Outline: Check the display of promotion tag of a product card (Check with normal buyers only)- A Product under consideration has 1 SKU with different promotion types
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
    #  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description                              | starts_at   | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Auto promotion buyer recommended product | currentDate | [blank]    | 1           | 1          | 1                | true           | [blank] | default    | [blank]       |

#     promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                      | description                              | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product2 | Auto promotion buyer recommended product | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — Z-A"
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                              | image       | comment | expressTag   |
      | Auto brand create product | random product buyer recommended api | anhJPG2.jpg | comment | <expressTag> |
    Then Verify promo preview "Promotions" of product "random product buyer recommended api" in "Recommended products"
      | name                              | type        | price | caseLimit | expiryDate  |
      | random sku buyer recommended api1 | Short-dated | $5.00 | 1         | currentDate |
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                               | product                              | caseUnit    | price | image       | quantity |
      | Pod Express Items | random sku buyer recommended api1 | random product buyer recommended api | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    Then Verify promo preview "Short dated" of sku "random sku buyer recommended api1" is "show" on add cart popup
      | name                              | type        | price | caseLimit | expiryDate  |
      | random sku buyer recommended api1 | Short-dated | $5.00 | 1         | currentDate |
    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_9 @BUYER_RECOMMENDED_45
  Scenario Outline: Check the display of promotion tag of a product card (Check with normal buyers only)- A Product under consideration has multiple SKUs with different promotion types
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
    #  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description                              | starts_at   | expires_at | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Auto promotion buyer recommended product | currentDate | [blank]    | 1           | 1          | 1                | true           | [blank] | default    | [blank]       |

#     promotion 2
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api2" of product ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                      | description                              | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product2 | Auto promotion buyer recommended product | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                              | image       | comment | expressTag   |
      | Auto brand create product | random product buyer recommended api | anhJPG2.jpg | comment | <expressTag> |
    Then Verify promo preview "Promotions" of product "random product buyer recommended api" in "Recommended products"
      | name                              | type        | price | caseLimit | expiryDate  |
      | random sku buyer recommended api1 | TPR         | $5.00 | 1         | [blank]     |
      | random sku buyer recommended api2 | Short-dated | $8.00 | 1         | currentDate |
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                               | product                              | caseUnit    | price | image       | quantity |
      | Pod Express Items | random sku buyer recommended api1 | random product buyer recommended api | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api1" is "show" on add cart popup
      | name                              | type | price | caseLimit |
      | random sku buyer recommended api1 | TPR  | $5.00 | 1         |
#  changes main SKU to another region
    And Admin change info of regions attributes of sku "random sku buyer recommended api1" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And BUYER refresh browser
    Then Verify promo preview "Short dated" of product "random product buyer recommended api" in "Recommended products"
      | name                              | type        | price | caseLimit | expiryDate  |
      | random sku buyer recommended api2 | Short-dated | $8.00 | 1         | currentDate |
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                               | product                              | caseUnit    | price | image       | quantity |
      | Pod Express Items | random sku buyer recommended api2 | random product buyer recommended api | 1 unit/case | $8.00 | anhJPG2.jpg | 0        |
    Then Verify promo preview "Short dated" of sku "random sku buyer recommended api2" is "show" on add cart popup
      | name                              | type        | price | caseLimit | expiryDate  |
      | random sku buyer recommended api2 | Short-dated | $8.00 | 1         | currentDate |
    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_12 @BUYER_RECOMMENDED_43
  Scenario Outline: Check showing the Promotion toast when tap on any promotion tag (Check with normal buyers only)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
    #  //Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                                     | description                              | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto promotion buyer recommended product | Auto promotion buyer recommended product | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                              | image       | comment | expressTag   |
      | Auto brand create product | random product buyer recommended api | anhJPG2.jpg | comment | <expressTag> |
    Then Verify promo preview "Buy in" of product "random product buyer recommended api" in "Recommended products"
      | name                              | type   | price | caseLimit |
      | random sku buyer recommended api1 | Buy-in | $5.00 | 1         |
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                               | product                              | caseUnit    | price | image       | quantity |
      | Pod Express Items | random sku buyer recommended api1 | random product buyer recommended api | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    Then Verify promo preview "Buy in" of sku "random sku buyer recommended api1" is "show" on add cart popup
      | name                              | type   | price | caseLimit | expiryDate  |
      | random sku buyer recommended api1 | Buy-in | $5.00 | 1         | currentDate |
    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_16
  Scenario Outline: Check NOT display the Express badge of a product card for PD buyers
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
    And Clear Info of Region api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | <id>     | <id>   | create by api | comment1 |

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api2 | 3018     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2360             | Auto Buyer Company Bao | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api2" of product ""
    And Clear Info of buyer company api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | <id>     | <id>   | create by api | comment2 |

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api3 | 3018     |
    And Info of Store specific
      | store_id | store_name                | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2727     | Auto store switch mov moq | 2360             | Auto Buyer Company Bao | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api3" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | <id>     | <id>   | create by api | comment3 |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                               | image       | comment  | expressTag   |
      | Auto brand create product | random product buyer recommended api1 | anhJPG2.jpg | comment1 | <expressTag> |
      | Auto brand create product | random product buyer recommended api2 | anhJPG2.jpg | comment2 | <expressTag> |
      | Auto brand create product | random product buyer recommended api3 | anhJPG2.jpg | comment3 | <expressTag> |

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PD | ngoctx+autobuyer45@podfoods.co | 12345678a | buyer | 2985 | not show   |

  @BUYER_RECOMMENDED_20 @BUYER_RECOMMENDED_31
  Scenario: Check display the Express badge of a product card for PE buyers
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
    And Clear Info of Region api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment1 |

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api2 | 3018     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api2" of product ""
    And Clear Info of buyer company api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment2 |

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api3 | 3018     |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api3" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment3 |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                               | image       | comment  | expressTag |
      | Auto brand create product | random product buyer recommended api1 | anhJPG2.jpg | comment1 | show       |
      | Auto brand create product | random product buyer recommended api2 | anhJPG2.jpg | comment2 | not show   |
      | Auto brand create product | random product buyer recommended api3 | anhJPG2.jpg | comment3 | not show   |
#Edit recommendation
    And Admin edit recommendation by api
      | id            | buyer_id | _buyer | product_id    | comment  |
      | create by api | 3365     | 3365   | create by api | comment3 |

    And BUYER refresh browser
    And Buyer check not show Recommended product "random product buyer recommended api3"

  @BUYER_RECOMMENDED_32
  Scenario: Check display of product card when admin delete product recommended of buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
    And Clear Info of Region api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment1 |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                               | image       | comment  | expressTag |
      | Auto brand create product | random product buyer recommended api1 | anhJPG2.jpg | comment1 | show       |
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api

    And BUYER refresh browser
    And Buyer check not show Recommended product "random product buyer recommended api1"

  @BUYER_RECOMMENDED_33
  Scenario:Check sort by and export function
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
    And Clear Info of Region api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment1 |

    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api2" of product ""
    And Clear Info of Region api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment1 |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                               | image       | comment  | expressTag |
      | Auto brand create product | random product buyer recommended api1 | anhJPG2.jpg | comment1 | show       |
      | Auto brand create product | random product buyer recommended api2 | anhJPG2.jpg | comment1 | show       |

    And Buyer delete file export Recommended product
    And Buyer export Recommended product
    And Buyer check file export Recommended product
      | brand                     | productName                           | productType | categories | packageSize | unitSize | dimensions   | moq | sku                               | unitUPC      | location          | leadTime | unitCase | margin | msrp   | storeShelfLife | retailShelfLife | temperature   | qualities    |
      | Auto brand create product | random product buyer recommended api1 | Bao Bakery  | Bakery     | Bulk        | 1.0 g    | 1" x 1" x 1" | 1   | random sku buyer recommended api1 | 123123123123 | Chicago, Illinois | [blank]  | 1        | 0%     | $10.00 | 1 days (Dry)   | 1 days (Dry)    | 1.0 F - 1.0 F | 100% Natural |

  @BUYER_RECOMMENDED_36
  Scenario: Check showing Add to cart modal when click on the Add to cart button
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin search product recommendation Buyer id "2977" by api
    And Admin search product recommendation Buyer id "2985" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api36 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
    And Admin Authorized SKU id "" to Buyer id "2977"
    And Clear Info of Region api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api2" of product ""
    And Admin Authorized SKU id "" to Buyer id "2977"

    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | sold_out     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api3" of product ""
    And Admin Authorized SKU id "" to Buyer id "2977"

    And Clear Info of Region api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | sold_out     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api4" of product ""
    And Admin Authorized SKU id "" to Buyer id "2977"

    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp | startDate | endDate |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 | Minus2    | Minus1  |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api5" of product ""
    And Admin Authorized SKU id "" to Buyer id "2977"

    And Clear Info of Region api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp | startDate | endDate |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 | Minus2    | Minus1  |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api6" of product ""
    And Admin Authorized SKU id "" to Buyer id "2977"

    And Clear Info of Region api
    #    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment1 |
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 2977     | 2977   | create by api | comment1 |
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 2985     | 2985   | create by api | comment1 |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                                | image       | comment  |
      | Auto brand create product | random product buyer recommended api36 | anhJPG2.jpg | comment1 |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api36" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                               | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items  | random sku buyer recommended api2 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Direct Items  | random sku buyer recommended api4 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Express Items | random sku buyer recommended api1 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Express Items | random sku buyer recommended api3 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And  Buyer check items not available on popup add cart
      | sku                               |
      | random sku buyer recommended api4 |
      | random sku buyer recommended api3 |
#
    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer44@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                                | image       | comment  |
      | Auto brand create product | random product buyer recommended api36 | anhJPG2.jpg | comment1 |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api36" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                               | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items  | random sku buyer recommended api2 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Direct Items  | random sku buyer recommended api4 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Express Items | random sku buyer recommended api1 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Express Items | random sku buyer recommended api3 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And  Buyer check items not available on popup add cart
      | sku                               |
      | random sku buyer recommended api4 |
      | random sku buyer recommended api3 |

    Given BUYER3 open web user
    When login to beta web with email "ngoctx+autobuyer45@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                     | product                                | image       | comment  |
      | Auto brand create product | random product buyer recommended api36 | anhJPG2.jpg | comment1 |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api36" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                               | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api2 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Direct Items | random sku buyer recommended api4 | random product buyer recommended api36 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And  Buyer check items not available on popup add cart
      | sku                               |
      | random sku buyer recommended api4 |

  @BUYER_RECOMMENDED_39
  Scenario:Check display of price/case shown for each SKU
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api39 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1500      | 1500 |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 2000             | 2000       | in_stock     |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 3000             | 3000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api39" of product ""

#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 3186     | 3186   | create by api | comment1 |

#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 2969     | 2969   | create by api | comment1 |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer click add to cart product "random product buyer recommended api39" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api39 | random product buyer recommended api39 | 1 unit/case | $30.00 | anhJPG2.jpg | 0        |
  #    Update store specific to inactive
    And Admin change info of store specific of sku "create by api"
      | id            | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | create by api      | 3000             | 3000       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer click add to cart product "random product buyer recommended api39" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api39 | random product buyer recommended api39 | 1 unit/case | $20.00 | anhJPG2.jpg | 0        |
     #    Update buyer company  to inactive
    And Admin change info of buyer company specific of sku "create by api"
      | id            | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | active              | 2216             | Auto_BuyerCompany  | create by api      | 2000             | 2000       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer click add to cart product "random product buyer recommended api39" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api39 | random product buyer recommended api39 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |

    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer click add to cart product "random product buyer recommended api39" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api39 | random product buyer recommended api39 | 1 unit/case | $15.00 | anhJPG2.jpg | 0        |

  @BUYER_RECOMMENDED_39_2
  Scenario:Check display of price/case shown for each SKU PD Buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "2969" by api
    And Admin delete product recommendation by api
    And Admin search product name "random sku buyer recommended api" by api
    And Admin delete product name "random sku buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api39 | 3018     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name    | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2384             | Auto Buyer company 38 | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 2384             | Auto Buyer company 38 | 58        | currentDate | currentDate | 2000             | 2000       | in_stock     |
    And Info of Store specific
      | store_id | store_name                       | buyer_company_id | buyer_company_name    | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2708     | Auto store check add to cart mov | 2384             | Auto Buyer company 38 | 58        | currentDate | currentDate | 3000             | 3000       | in_stock     |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api39" of product ""

#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment  |
      | 2969     | 2969   | create by api | comment1 |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer click add to cart product "random product buyer recommended api39" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api39 | random product buyer recommended api39 | 1 unit/case | $30.00 | anhJPG2.jpg | 0        |
      #    Update store specific to inactive
    And Admin change info of store specific of sku "create by api"
      | id            | region_id | store_id | store_name                       | buyer_company_id | buyer_company_name    | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 58        | 2708     | Auto store check add to cart mov | 2384             | Auto Buyer company 38 | create by api      | 3000             | 3000       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer click add to cart product "random product buyer recommended api39" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api39 | random product buyer recommended api39 | 1 unit/case | $20.00 | anhJPG2.jpg | 0        |

  @BUYER_RECOMMENDED_48
  Scenario:Check the display of promotion tag when usage limit of promotion is used up
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name " Auto Promotion Recommended"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 2969     | 2969   | create by api | comment |
  #Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                       | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Recommended | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

     #    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    Then Verify tag "TPR" promotion is "not show" on product "random product buyer recommended api"
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                               | product                              | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api1 | random product buyer recommended api | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api1" is "not show" on add cart popup
      | name                              | type | price | caseLimit |
      | random sku buyer recommended api1 | TPR  | $5.00 | 1         |

  @BUYER_RECOMMENDED_51
  Scenario Outline: Check when Buyer enter quantity and Add to cart with a product is applied MOV system
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer recommended api | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                      | product                              | image       | comment | expressTag   |
      | Auto brand add to cart mov | random product buyer recommended api | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                               | product                              | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api1 | random product buyer recommended api | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer choose items an add cart product from popup
      | product                           | sku                               | amount |
      | random sku buyer recommended api1 | random sku buyer recommended api1 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer choose items an add cart product from popup
      | product                           | sku                               | amount |
      | random sku buyer recommended api1 | random sku buyer recommended api1 | 50     |
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                      | description                              | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product2 | Auto promotion buyer recommended product | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    And BUYER refresh browser
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                               | product                              | caseUnit    | price | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api1 | random product buyer recommended api | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    And Verify promo preview "Short dated" of sku "random sku buyer recommended api1" is "show" on add cart popup
      | name                              | type        | price | caseLimit | expiryDate  |
      | random sku buyer recommended api1 | Short-dated | $5.00 | 1         | currentDate |
    And Buyer choose items an add cart product from popup
      | product                           | sku                               | amount |
      | random sku buyer recommended api1 | random sku buyer recommended api1 | 1      |
    And BUYER check dialog message
      | SKUs with short-dated promotions are not guaranteed sales and there are no refunds for expiration of these items |
    And Click on dialog button "I understand"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Close popup add cart

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | not show   |

  @BUYER_RECOMMENDED_54
  Scenario Outline: Check when Buyer enter quantity and Add to cart with a product is applied MOV system
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                  | brand_id |
      | random product buyer recommended api1 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api1" of product ""
    And Clear Info of Region api
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api2" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                      | product                              | image       | comment | expressTag   |
      | Auto brand add to cart mov | random product buyer recommended api | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                               | product                              | caseUnit    | price  | image       | quantity |
      | Pod Direct Items  | random sku buyer recommended api1 | random product buyer recommended api | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Express Items | random sku buyer recommended api2 | random product buyer recommended api | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer choose items an add cart product from popup
      | product                               | sku                               | amount |
      | random product buyer recommended api1 | random sku buyer recommended api1 | 1      |
      | random product buyer recommended api1 | random sku buyer recommended api2 | 1      |
    And BUYER check alert message
      | Item added to cart! |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Verify item on cart tab on right side
      | brand                      | product                               | sku                               | price  | quantity |
      | Auto brand add to cart mov | random product buyer recommended api1 | random sku buyer recommended api2 | $10.00 | 1        |
    And Buyer click add to cart product "random product buyer recommended api" on popup cart
    And Buyer choose items an add cart product from popup
      | product                           | sku                               | amount |
      | random sku buyer recommended api1 | random sku buyer recommended api1 | 50     |
    And Check MOV not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Verify item on cart tab on right side
      | brand                      | product                               | sku                               | price  | quantity |
      | Auto brand add to cart mov | random product buyer recommended api1 | random sku buyer recommended api2 | $10.00 | 1        |
      | Auto brand add to cart mov | random product buyer recommended api1 | random sku buyer recommended api1 | $10.00 | 50       |

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_56
  Scenario Outline: Check when Buyer enter quantity and Add to cart with a product is applied MOQ system
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api56 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api56" of product ""
    #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |

#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                  | product                                | image       | comment | expressTag   |
      | Auto Brand product moq | random product buyer recommended api56 | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api56" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api56 | random product buyer recommended api56 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api56 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Click on dialog button "Add to cart"
    And Verify item on cart tab on right side
      | brand                  | product                                | sku                                | price  | quantity |
      | Auto Brand product moq | random product buyer recommended api56 | random sku buyer recommended api56 | $10.00 | 1        |
    And Buyer click add to cart product "random product buyer recommended api56" on popup cart
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api56 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Click on dialog button "Add to cart"
    And Verify item on cart tab on right side
      | brand                  | product                                | sku                                | price  | quantity |
      | Auto Brand product moq | random product buyer recommended api56 | random sku buyer recommended api56 | $10.00 | 5        |
    And Clear cart to empty in cart before

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_57
  Scenario Outline: Check when Buyer enter quantity and Add to cart with a product is applied MOQ system - If Buyer add Short-dated Pod Express Items with MOQ is not met
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api57 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api57" of product ""
    #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                       | description                              | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product57 | Auto promotion buyer recommended product | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                  | product                                | image       | comment | expressTag   |
      | Auto Brand product moq | random product buyer recommended api57 | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api57" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api57 | random product buyer recommended api57 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api57 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Verify promo preview "Short dated" of sku "random sku buyer recommended api57" is "show" on add cart popup
      | name                               | type        | price | caseLimit | expiryDate  |
      | random sku buyer recommended api57 | Short-dated | $5.00 | 1         | currentDate |
    And Click on dialog button "Add to cart"
    And BUYER check dialog message
      | SKUs with short-dated promotions are not guaranteed sales and there are no refunds for expiration of these items |
    And Click on dialog button "I understand"
    And Verify item on cart tab on right side
      | brand                  | product                                | sku                                | price | quantity |
      | Auto Brand product moq | random product buyer recommended api57 | random sku buyer recommended api57 | $5.00 | 1        |
    And Buyer click add to cart product "random product buyer recommended api57" on popup cart
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api57 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Click on dialog button "Add to cart"
    And BUYER check dialog message
      | SKUs with short-dated promotions are not guaranteed sales and there are no refunds for expiration of these items |
    And Click on dialog button "I understand"
    And Verify item on cart tab on right side
      | brand                  | product                                | sku                                | price | quantity |
      | Auto Brand product moq | random product buyer recommended api57 | random sku buyer recommended api57 | $9.00 | 5        |

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_62
  Scenario Outline:  If Buyer add both Pod Express items and Pod Direct items but MOQ for Pod Direct item is not met
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api62 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api621" of product ""
    #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |
#    SKU 2
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api622" of product ""
    #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 58        | 10  | currentDate | currentDate |
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                  | product                                | image       | comment | expressTag   |
      | Auto Brand product moq | random product buyer recommended api62 | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api62" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                 | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api621 | random product buyer recommended api62 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Direct Items  | random sku buyer recommended api622 | random product buyer recommended api62 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                 | quantity |
      | random sku buyer recommended api621 | 1        |
    And Check MOQ not met of "Pod Express Items"
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Buyer add sku to cart in popup cart
      | sku                                 | quantity |
      | random sku buyer recommended api622 | 1        |
    And Check MOQ not met of "Pod Direct Items"
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 9 cases |
    And Check dialog button "Add to cart" is "disable"
    And Buyer add sku to cart in popup cart
      | sku                                 | quantity |
      | random sku buyer recommended api622 | 10       |
    And Check MOQ not met of "Pod Direct Items"
      | message | counter |
      | [blank] | [blank] |
    And Check MOQ not met of "Pod Express Items"
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Click on dialog button "Add to cart"
    And Verify item on cart tab on right side
      | brand                  | product                                | sku                                 | price  | quantity |
      | Auto Brand product moq | random product buyer recommended api62 | random sku buyer recommended api621 | $10.00 | 1        |
      | Auto Brand product moq | random product buyer recommended api62 | random sku buyer recommended api622 | $10.00 | 10       |
    And Buyer click add to cart product "random product buyer recommended api62" on popup cart
    And Check MOQ not met of "Pod Express Items"
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Buyer add sku to cart in popup cart
      | sku                                 | quantity |
      | random sku buyer recommended api621 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Click on dialog button "Add to cart"
    And Verify item on cart tab on right side
      | brand                  | product                                | sku                                 | price  | quantity |
      | Auto Brand product moq | random product buyer recommended api62 | random sku buyer recommended api621 | $10.00 | 5        |
      | Auto Brand product moq | random product buyer recommended api62 | random sku buyer recommended api622 | $10.00 | 10       |
    And Clear cart to empty in cart before

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer53@podfoods.co | 12345678a | buyer | 3186 | show       |

  @BUYER_RECOMMENDED_68
  Scenario Outline: Check displayed information on the MOV alert - In case A has a promotion
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "<id>" by api
    And Admin delete product recommendation by api
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api68 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api68" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | <id>     | <id>   | create by api | comment |
#Create promotion * In case A has a promotion which has case minimum = 1 and no case limit:
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       | false   |
#
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                      | product                                | image       | comment | expressTag   |
      | Auto brand add to cart mov | random product buyer recommended api68 | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api68" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                                | product                                | caseUnit    | price | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api68 | random product buyer recommended api68 | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    And Buyer choose items an add cart product from popup
      | product                            | sku                                | amount |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer check items on popup add cart not met MOV
      | type             | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api68 | random product buyer recommended api68 | 1 unit/case | $5.00  | anhJPG2.jpg | 1        |
      | Pod Direct Items | Auto SKU add to cart mov           | Auto product add to cart mov           | 1 unit/case | $10.00 | 17597.png   | 0        |
      | Pod Direct Items | Auto SKU 3 add to cart mov         | Auto product 2 add to cart mov         | 1 unit/case | $10.00 | 17597.png   | 0        |
      | Pod Direct Items | Auto SKU 5 add to cart mov         | Auto product 3 add to cart mov         | 1 unit/case | $10.00 | 17597.png   | 0        |
    And Buyer update cart of MOV alert with info
      | product                            | sku                                | quantity |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 50       |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $250.00 |
    And Buyer update cart of MOV alert with info
      | product                            | sku                                | quantity |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 100      |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart

     #Create promotion * In case A has a promotion which has case minimum and case limit; case minimum < case limit:
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | 2          | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api68" on popup cart
    And Buyer choose items an add cart product from popup
      | product                            | sku                                | amount |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer update cart of MOV alert with info
      | sku                                | quantity |
      | random sku buyer recommended api68 | 3        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $480.00 |
    And Buyer update cart of MOV alert with info
      | sku                                | quantity |
      | random sku buyer recommended api68 | 52       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api68" is "show" on add cart popup have met MOV
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api68 | TPR  | $5.00 | 2         |
    And Close popup add cart

     #Create promotion * In case A has a promotion which has case minimum and case limit; case minimum >= case limit:
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | 1          | 2                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api68" on popup cart
    And Buyer choose items an add cart product from popup
      | product                            | sku                                | amount |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Buyer update cart of MOV alert with info
      | sku                                | quantity |
      | random sku buyer recommended api68 | 3        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $475.00 |
    And Buyer update cart of MOV alert with info
      | sku                                | quantity |
      | random sku buyer recommended api68 | 51       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |

    Examples:
      | role_            | buyer                          | pass      | role  | id   | expressTag |
      | Store manager PE | ngoctx+autobuyer39@podfoods.co | 12345678a | buyer | 2969 | not show   |

  @BUYER_RECOMMENDED_79
  Scenario: Check prioritizing store-specific promotions over region-specific promotions MOV
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "2969" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api68 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api68" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 2969     | 2969   | create by api | comment |

  #Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | [blank]   | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

#Create promotion 2
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                      | product                                | image       | comment | expressTag   |
      | Auto brand add to cart mov | random product buyer recommended api68 | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    Then Verify promo preview "Promotions" of product "random product buyer recommended api68" in "Recommended products"
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api68 | TPR  | $5.00 | 1         |
    And Buyer click add to cart product "random product buyer recommended api68" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                                | product                                | caseUnit    | price | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api68 | random product buyer recommended api68 | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    And Buyer choose items an add cart product from popup
      | product                            | sku                                | amount |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer update cart of MOV alert with info
      | product                            | sku                                | quantity |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 50       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api68" is "show" on add cart popup have met MOV
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api68 | TPR  | $5.00 | 1         |
    And Close popup add cart

  @BUYER_RECOMMENDED_80
  Scenario: Check the priority when many created store-specific promotions for the same store and same SKUs MOV
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "2969" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api68 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api68" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 2969     | 2969   | create by api | comment |

  #Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

#Create promotion 2
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                      | product                                | image       | comment | expressTag   |
      | Auto brand add to cart mov | random product buyer recommended api68 | anhJPG2.jpg | comment | <expressTag> |
    And Clear cart to empty in cart before
    Then Verify promo preview "Promotions" of product "random product buyer recommended api68" in "Recommended products"
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api68 | TPR  | $5.00 | 1         |
    And Buyer click add to cart product "random product buyer recommended api68" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                                | product                                | caseUnit    | price | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api68 | random product buyer recommended api68 | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    And Buyer choose items an add cart product from popup
      | product                            | sku                                | amount |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer update cart of MOV alert with info
      | product                            | sku                                | quantity |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 50       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api68" is "show" on add cart popup have met MOV
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api68 | TPR  | $5.00 | 1         |
    And Close popup add cart

  @BUYER_RECOMMENDED_81
  Scenario: Check the display of promotion tag when usage limit of promotion is used up MOV
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "2969" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api68 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api68" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 2969     | 2969   | create by api | comment |

#Create promotion 2
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

     #    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                      | product                                | image       | comment | expressTag |
      | Auto brand add to cart mov | random product buyer recommended api68 | anhJPG2.jpg | comment | not show   |
    And Clear cart to empty in cart before
    And Verify tag "TPR" promotion is "not show" on product "random product buyer recommended api68"
    And Buyer click add to cart product "random product buyer recommended api68" on popup cart
    And Buyer check items on popup add cart
      | type             | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | random sku buyer recommended api68 | random product buyer recommended api68 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer choose items an add cart product from popup
      | product                            | sku                                | amount |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Buyer update cart of MOV alert with info
      | product                            | sku                                | quantity |
      | random sku buyer recommended api68 | random sku buyer recommended api68 | 50       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api68" is "not show" on add cart popup have met MOV
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api68 | TPR  | $5.00 | 1         |
    And Close popup add cart

  @BUYER_RECOMMENDED_88
  Scenario: Check displayed information on the MOQ alert
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api88 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api88" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 3186     | 3186   | create by api | comment |
        #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |
    #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                  | product                                | image       | comment | expressTag |
      | Auto Brand product moq | random product buyer recommended api88 | anhJPG2.jpg | comment | show       |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api88" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api88 | random product buyer recommended api88 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api88 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api88" is "show" on add cart popup
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api88 | TPR  | $5.00 | 1         |

    #Create promotion * In case A has a promotion which has case minimum = 1 and no case limit:
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api88" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api88 | random product buyer recommended api88 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api88 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api88" is "show" on add cart popup
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api88 | TPR  | $5.00 | [blank]   |

#
     #Create promotion * In case A has a promotion which has case minimum and case limit; case minimum < case limit:
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | 2          | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api88" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api88 | random product buyer recommended api88 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api88 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api88" is "show" on add cart popup
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api88 | TPR  | $5.00 | 2         |

    And Close popup add cart
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""

  @BUYER_RECOMMENDED_101
  Scenario: Check prioritizing store-specific promotions over region-specific promotions MOQ
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api88 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api88" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 3186     | 3186   | create by api | comment |
        #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |

  #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

#Create promotion 2
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                  | product                                | image       | comment | expressTag |
      | Auto Brand product moq | random product buyer recommended api88 | anhJPG2.jpg | comment | show       |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api88" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api88 | random product buyer recommended api88 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api88 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api88" is "show" on add cart popup
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api88 | TPR  | $5.00 | 1         |

  @BUYER_RECOMMENDED_102
  Scenario: Check the priority when many created store-specific promotions for the same store and same SKUs MOQ
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api88 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api88" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 3186     | 3186   | create by api | comment |
        #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |

#Create promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |
  #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                  | product                                | image       | comment | expressTag |
      | Auto Brand product moq | random product buyer recommended api88 | anhJPG2.jpg | comment | show       |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api88" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api88 | random product buyer recommended api88 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api88 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api88" is "show" on add cart popup
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api88 | TPR  | $5.00 | 1         |

  @BUYER_RECOMMENDED_103
  Scenario: Check the display of promotion tag when usage limit of promotion is used up MOQ
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao5@podfoods.co | 12345678a |
    And Admin search product recommendation Buyer id "3186" by api
    And Admin delete product recommendation by api
    And Admin search promotion by Promotion Name "Auto promotion buyer recommended product"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer recommended api" by api
    And Admin search product name "random product buyer recommended api" by api
    And Admin delete product name "random product buyer recommended api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                                   | brand_id |
      | random product buyer recommended api88 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "random sku buyer recommended api88" of product ""
#    Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 3186     | 3186   | create by api | comment |
        #    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |
  #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                                     | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto promotion buyer recommended product | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

     #    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3186     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer53@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Recommended products" from menu bar
    And Buyer search Recommended product with "By Brand — A-Z"
    And Buyer check Recommended products
      | brand                  | product                                | image       | comment | expressTag |
      | Auto Brand product moq | random product buyer recommended api88 | anhJPG2.jpg | comment | show       |
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product buyer recommended api88" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                                | product                                | caseUnit    | price  | image       | quantity |
      | Pod Express Items | random sku buyer recommended api88 | random product buyer recommended api88 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Buyer add sku to cart in popup cart
      | sku                                | quantity |
      | random sku buyer recommended api88 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "TPR" of sku "random sku buyer recommended api88" is "not show" on add cart popup
      | name                               | type | price | caseLimit |
      | random sku buyer recommended api88 | TPR  | $5.00 | 1         |

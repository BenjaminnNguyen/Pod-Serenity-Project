@feature=buyerFavorite
@feature=Buyer
Feature: Buyer Favorite

  @B_FAVORITES_1
  Scenario Outline: Check displayed information on the page of the normal buyers
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
#    And Buyer go to "Favorites" from menu bar
    And Buyer check redirect link on catalog page
      | title                | newTitle                                                                             | redirectLink                      |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
      | Favorites            | Favorites - Pod Foods \| Online Distribution Platform for Emerging Brands            | .podfoods.co/favorites            |
      | Brands               | All brands - Pod Foods \| Online Distribution Platform for Emerging Brands           | .podfoods.co/brands               |
      | Order guide          | Order Guide - Pod Foods \| Online Distribution Platform for Emerging Brands          | .podfoods.co/order-guide          |
      | Recommended products | Recommended Products - Pod Foods \| Online Distribution Platform for Emerging Brands | .podfoods.co/recommended-products |
      | Refer a Brand        | Brand Referral - Pod Foods \| Online Distribution Platform for Emerging Brands       | .podfoods.co/brands/invite        |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
      | Favorites            | Favorites - Pod Foods \| Online Distribution Platform for Emerging Brands            | .podfoods.co/favorites            |
    And Check any text "is" showing on screen
      | Your favorites variants |
    Examples:
      | role_            | buyer                          | pass      | role       | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer      | 2882 |
      | Store sub buyer  | ngoctx+autobuyer7@podfoods.co  | 12345678a | buyer      | 2745 |
      | Store manager PD | ngoctx+autobuyer31@podfoods.co | 12345678a | buyer      | 2883 |
      | Head buyer       | ngoctx+autobuyer66@podfoods.co | 12345678a | head buyer | 158  |

  @B_FAVORITES_3
  Scenario Outline: Check displayed information on the page of the normal buyers
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product favorite api | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api" of product ""

    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer get favorite product list by API
    And Buyer clear favorite product list by API

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Check any text "is" showing on screen
      | No results found              |
      | We couldn't find any matches. |
    And Buyer set favorite product "create by api" by API
    And BUYER refresh browser
    And Buyer check list favorite variants
      | sku                     | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |

    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_4
  Scenario Outline: Check displayed information on the page of the normal buyers - head buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product favorite api | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api" of product ""

    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Head Buyer get favorite product list by API
    And Head Buyer clear favorite product list by API

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Check any text "is" showing on screen
      | No results found              |
      | We couldn't find any matches. |
    And Head Buyer set favorite product "create by api" by API
    And BUYER refresh browser
    And Buyer check list favorite variants
      | sku                     | product                     | brand                      | image       | upc          | skuId | price   | unitCase | expressTag |
      | sku random favorite api | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | [blank] | [blank]  | show       |

    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer66@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_5
  Scenario Outline: Check the Favorites variants list when buyer has any Favorite items
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer30@podfoods.co | 12345678a |
    And Buyer get favorite product list by API
    And Buyer clear favorite product list by API

    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product favorite api | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api51" of product ""
    And Clear Info of Region api
    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer set favorite product "create by api" by API
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api52" of product ""
    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer set favorite product "create by api" by API

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Buyer check list favorite variants
      | sku                       | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api51 | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $20.00/unit | (1 unit/case) | show       |
      | sku random favorite api52 | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | not show   |

    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_7
  Scenario Outline: Check display of promotion tag on the variant card (Check with normal buyers only)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Favorite"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | random product favorite api7 | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api7" of product ""
    #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | [blank]   | random | 2681      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                          | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Favorite | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer get favorite product list by API
    And Buyer clear favorite product list by API
    And Buyer set favorite product "create by api" by API

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Buyer check list favorite variants
      | sku                      | product                      | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api7 | random product favorite api7 | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
    Then Verify promo preview "TPR" of product "random product favorite api7" in "Favorite page"
      | name                     | type | price | caseLimit |
      | sku random favorite api7 | TPR  | $5.00 | 1         |
    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_8
  Scenario Outline: Check display of promotion tag on the variant card (Check with normal buyers only)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Favorite"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | random product favorite api7 | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api7" of product ""
    #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | [blank]   | random | 2681      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                          | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Favorite | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |
#Create promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | [blank]   | random | 2681      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 200         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                          | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Favorite | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer get favorite product list by API
    And Buyer clear favorite product list by API
    And Buyer set favorite product "create by api" by API

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Buyer check list favorite variants
      | sku                      | product                      | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api7 | random product favorite api7 | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
    Then Verify promo preview "Short dated" of product "random product favorite api7" in "Favorite page"
      | name                     | type        | price | caseLimit | expiryDate  |
      | sku random favorite api7 | Short-dated | $8.00 | 1         | currentDate |
    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_9
  Scenario Outline: Check display of promotion tag on the variant card (Check with normal buyers only)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Favorite"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                         | brand_id |
      | random product favorite api7 | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api7" of product ""
    #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | [blank]   | random | 2681      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                          | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Favorite | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |
  #    Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2882     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer get favorite product list by API
    And Buyer clear favorite product list by API
    And Buyer set favorite product "create by api" by API

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Buyer check list favorite variants
      | sku                      | product                      | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api7 | random product favorite api7 | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
    And Verify tag "TPR" promotion is "not show" on product "random product favorite api7"
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Favorite"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_13
  Scenario Outline: Check when remove SKU from Favorites list successfully
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product favorite api | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random favorite api" of product ""
    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer get favorite product list by API
    And Buyer clear favorite product list by API
    And Buyer set favorite product "create by api" by API
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Buyer check list favorite variants
      | sku                     | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
    And Buyer remove favorite SKU "sku random favorite api"
    And BUYER check dialog message
      | Are you sure you want to remove this item from your favorites? |
    And Buyer check list favorite variants
      | sku                     | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
    And BUYER refresh browser
    And Buyer check list favorite variants
      | sku                     | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
    And Buyer remove favorite SKU "sku random favorite api"
    And Click on dialog button "OK"
    And BUYER check alert message
      | Item removed from favorites |
    And Check any text "is" showing on screen
      | No results found              |
      | We couldn't find any matches. |
    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_14
  Scenario Outline: Check display of variant card when admins draft or deactivate somethings
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product favorite api" by api
    And Admin search product name "random product favorite api" by api
    And Admin delete product name "random product favorite api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                        | brand_id |
      | random product favorite api | 2971     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 2000             | 2000       | in_stock     |
    And Info of Store specific
      | store_id | store_name                         | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2681     | Auto Store check inventory Chicago | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 3000             | 3000       | in_stock     |

    And Admin create a "active" SKU from admin with name "sku random favorite api14" of product ""
    Given Buyer login web with by api
      | email   | password |
      | <buyer> | <pass>   |
    And Buyer get favorite product list by API
    And Buyer clear favorite product list by API
    And Buyer set favorite product "create by api" by API
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Favorites" from menu bar
    And Buyer check list favorite variants
      | sku                       | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api14 | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $30.00/unit | (1 unit/case) | show       |
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
       #    Update store specific to inactive
    And Admin change info of store specific of sku "create by api"
      | id            | region_id | store_id | store_name                         | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | 2681     | Auto Store check inventory Chicago | 2216             | Auto_BuyerCompany  | create by api      | 3000             | 3000       | in_stock     | active | Minus2     | Minus1   |

    And BUYER refresh browser
    And Buyer check list favorite variants
      | sku                       | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api14 | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $20.00/unit | (1 unit/case) | show       |

       #    Update buyer company  to inactive
    And Admin change info of buyer company specific of sku "create by api"
      | id            | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | active              | 2216             | Auto_BuyerCompany  | create by api      | 2000             | 2000       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer check list favorite variants
      | sku                       | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api14 | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
#    Inactive region của sku
    And Admin change info of regions attributes of sku "sku random favorite api14" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And BUYER refresh browser
    And Buyer check list favorite variants
      | sku                       | product                     | brand                      | image       | upc          | skuId | price   | unitCase | expressTag |
      | sku random favorite api14 | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | [blank] | [blank]  | not show   |
    And Buyer check SKU "sku random favorite api14" not available on favorite page
    And Go to detail of product "random product favorite api" from catalog
    And BUYER check page missing
    And Buyer go to "Catalog" from menu bar
    And Buyer go to "Favorites" from menu bar

    #  active region của sku
    And Admin change info of regions attributes of sku "sku random favorite api14" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
    And BUYER refresh browser
    And Clear cart to empty in cart before
    And Buyer check list favorite variants
      | sku                       | product                     | brand                      | image       | upc          | skuId | price       | unitCase      | expressTag |
      | sku random favorite api14 | random product favorite api | Auto brand add to cart mov | anhJPG2.jpg | 123123123123 | api   | $10.00/unit | (1 unit/case) | show       |
    And Click add to cart product "random product favorite api" sku "sku random favorite api14" and quantity "1" from favorite page
    And Verify item on cart tab on right side
      | brand                      | product                     | sku                       | price  | quantity |
      | Auto brand add to cart mov | random product favorite api | sku random favorite api14 | $10.00 | 1        |
    And Clear cart to empty in cart before

    Examples:
      | role_            | buyer                          | pass      | role  | id   |
      | Store manager PE | ngoctx+autobuyer30@podfoods.co | 12345678a | buyer | 2882 |

  @B_FAVORITES_24
  Scenario: Check showing a MOQ alert to help buyers meet the MOQ if they don't meet when putting a SKU in cart
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
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
    And Clear cart to empty in cart before

  @B_FAVORITES_21
  Scenario: Check showing a MOQ alert to help buyers meet the MOV if they don't meet when putting a SKU in cart
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer38@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
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
    And Clear cart to empty in cart before

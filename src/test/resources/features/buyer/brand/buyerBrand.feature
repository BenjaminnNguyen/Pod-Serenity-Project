# language: en
#Tính năng: Buyer Brand
@feature=buyerBrand
@feature=Buyer
Feature: Buyer Brand

  @B_BRANDS_1
  Scenario Outline: Check displayed information on the Brands list page of the normal buyers
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Normal buyer check catalog page
    And Buyer check redirect link on catalog page
      | title                | newTitle                                                                             | redirectLink                      |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
      | Brands               | All brands - Pod Foods \| Online Distribution Platform for Emerging Brands           | .podfoods.co/brands               |
      | Order guide          | Order Guide - Pod Foods \| Online Distribution Platform for Emerging Brands          | .podfoods.co/order-guide          |
      | Recommended products | Recommended Products - Pod Foods \| Online Distribution Platform for Emerging Brands | .podfoods.co/recommended-products |
      | Favorites            | Favorites - Pod Foods \| Online Distribution Platform for Emerging Brands            | .podfoods.co/favorites            |
      | Refer a Brand        | Brand Referral - Pod Foods \| Online Distribution Platform for Emerging Brands       | .podfoods.co/brands/invite        |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
    And Buyer go to "Brands" from menu bar
    And Buyer search brand on brands page
      | state    | sortBy              |
      | Alabama  | Order by Popularity |
      | Florida  | Order by name — A-Z |
      | New York | Order by name — Z-A |
      | Yukon    | [blank]             |
    Examples:
      | role_            | buyer                          | pass      | role       |
      | Store manager PE | ngoctx+autobuyer59@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer61@podfoods.co | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co | 12345678a | head buyer |

  @B_BRAND_3
  Scenario: Check the Search function 2
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand 3 product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                        | description          | micro_description | city     | address_state_id | vendor_company_id |
      | Auto random Brand 4 product | Auto Brand 3 product | [blank]           | New York | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                     | brand_id      |
      | random product api402231 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api402231" of product ""
    And Clear Info of Region api
    And Admin create brand by API
      | name                        | description          | micro_description | city     | address_state_id | vendor_company_id |
      | Auto random Brand 3 product | Auto Brand 3 product | [blank]           | New York | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                     | brand_id      |
      | random product api302231 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api302231" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Brands" from menu bar
    And Search Brand item "Auto random Brand 3 product"
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — A-Z |
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |
      | Auto random Brand 4 product | New York, New York | no_img_thumbnail.png |
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — Z-A |
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 4 product | New York, New York | no_img_thumbnail.png |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |

    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Brands" from menu bar
    And Search Brand item "Auto random Brand 3 product"
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — A-Z |
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |
      | Auto random Brand 4 product | New York, New York | no_img_thumbnail.png |
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — Z-A |
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 4 product | New York, New York | no_img_thumbnail.png |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |

    Given BUYER3 open web user
    When login to beta web with email "ngoctx+autobuyer63@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Brands" from menu bar
    And Search Brand item "Auto random Brand 3 product"
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — A-Z |
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |
      | Auto random Brand 4 product | New York, New York | no_img_thumbnail.png |
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — Z-A |
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 4 product | New York, New York | no_img_thumbnail.png |
      | Auto random Brand 3 product | New York, New York | no_img_thumbnail.png |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name                        | vendorCompany | managedBy | state  | tags    |
      | Auto random Brand 3 product | [blank]       | [blank]   | Active | [blank] |
    And Go to brand detail
    And Upload image of brands
      | logo        | cover      |
      | anhJPEG.jpg | anhPNG.png |
    And Wait for upload image brand success

    And Switch to actor BUYER
    And BUYER refresh browser
    And Buyer check list brand on all brands page
      | brand                       | address            | image       |
      | Auto random Brand 3 product | New York, New York | anhJPEG.jpg |

    And Switch to actor BUYER2
    And BUYER refresh browser
    And Buyer check list brand on all brands page
      | brand                       | address            | image       |
      | Auto random Brand 3 product | New York, New York | anhJPEG.jpg |

    And Switch to actor BUYER3
    And BUYER refresh browser
    And Buyer check list brand on all brands page
      | brand                       | address            | image       |
      | Auto random Brand 3 product | New York, New York | anhJPEG.jpg |

  @B_BRAND_5 @B_BRANDS_7
  Scenario: Check the State (Province/Territory) filter and Sort by filter
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand " by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                        | description          | micro_description | city     | address_state_id | vendor_company_id |
      | Auto random Brand 5 product | Auto Brand 3 product | [blank]           | New York | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                     | brand_id      |
      | random product api502231 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api502231" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Brands" from menu bar
    And Search Brand item "Auto random Brand 5 product"
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 5 product | New York, New York | no_img_thumbnail.png |
    And Buyer search brand on brands page
      | state   | sortBy  |
      | Alabama | [blank] |
    And Check brands "Auto random Brand 5 product" "not" showing
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by Popularity |
    And Check brands "Auto random Brand 5 product" "not" showing
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — A-Z |
    And Check brands "Auto random Brand 5 product" "not" showing
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — Z-A |
    And Check brands "Auto random Brand 5 product" "not" showing
    And Buyer search brand on brands page
      | state    | sortBy  |
      | New York | [blank] |
    And Check brands "Auto random Brand 5 product" "is" showing
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by Popularity |
    And Check brands "Auto random Brand 5 product" "is" showing
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — A-Z |
    And Check brands "Auto random Brand 5 product" "is" showing
    And Buyer search brand on brands page
      | state   | sortBy              |
      | [blank] | Order by name — Z-A |
    And Check brands "Auto random Brand 5 product" "is" showing
    And BUYER input invalid "State (Province/Territory)"
      | value |
      | aaa   |
#    Change state sku
    And Change state of SKU id: "sku random api502231" to "draft"
    And BUYER refresh browser
    And Check brands "Auto random Brand 5 product" "not" showing
    And Change state of SKU id: "sku random api502231" to "active"
    And BUYER refresh browser
    And Check brands "Auto random Brand 5 product" "is" showing
#    Change state brand
    And Admin change state of brand "" to "inactive" by API
    And BUYER refresh browser
    And Check brands "Auto random Brand 5 product" "not" showing
#    Delete brand
    And Admin search brand name "Auto random Brand 5 product" by api
    And Admin delete brand by API
    And BUYER refresh browser
    And Check brands "Auto random Brand 5 product" "not" showing

  @B_BRANDS_16
  Scenario: Check information displayed on the brand details page
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand " by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                        | description | micro_description | city     | address_state_id | vendor_company_id |
      | Auto random Brand 6 product | description | micro description | New York | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                     | brand_id      |
      | random product api602231 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api602231" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Brands" from menu bar
    And Search Brand item "Auto random Brand 6 product"
    And Buyer check list brand on all brands page
      | brand                       | address            | image                |
      | Auto random Brand 6 product | New York, New York | no_img_thumbnail.png |
    And BUYER go to brand "Auto random Brand 6 product" detail on catalog
    And BUYER check brand detail on catalog
      | brandName                   | city     | state    | description | logo                 | coverImage         |
      | Auto random Brand 6 product | New York | New York | description | no_img_thumbnail.png | no_img_product.png |

    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name                        | vendorCompany | managedBy | state  | tags    |
      | Auto random Brand 6 product | [blank]       | [blank]   | Active | [blank] |
    And Go to brand detail
    And Upload image of brands
      | logo        | cover      |
      | anhJPEG.jpg | anhPNG.png |
    And Wait for upload image brand success

    And Admin add sub image of brands
      | subImage    |
      | anhJPEG.jpg |
      | anhPNG.png  |
    And Wait for upload image brand success

    And Switch to actor BUYER
    And BUYER refresh browser
    And BUYER check brand detail on catalog
      | brandName                   | city     | state    | description | logo        | coverImage |
      | Auto random Brand 6 product | New York | New York | description | anhJPEG.jpg | anhPNG.png |
    And BUYER check photo of brand on catalog
      | photo       |
      | anhPNG.png  |
      | anhJPEG.jpg |

  @B_BRANDS_19 @B_BRANDS_46
  Scenario: Check a Product card by default - Normal buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand " by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                        | description | micro_description | city     | address_state_id | vendor_company_id |
      | Auto random Brand 7 product | description | micro description | New York | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                     | brand_id      |
      | random product api702231 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api702231" of product ""
#    Product 2
    And Create product by api with file "CreateProduct.json" and info
      | name                       | brand_id      |
      | random product 2 api702231 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random 2 api702231" of product ""
#Create promotion
    And Admin search promotion by Promotion Name "Auto Promotion buyer brand"
    And Admin delete promotion by skuName ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                       | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto Promotion buyer brand | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Brands" from menu bar
    And Search Brand item "Auto random Brand 7 product"
    And BUYER go to brand "Auto random Brand 7 product" detail on catalog
    And BUYER check brand detail on catalog
      | brandName                   | city     | state    | description | logo                 | coverImage         |
      | Auto random Brand 7 product | New York | New York | description | no_img_thumbnail.png | no_img_product.png |
    And Buyer check list product on brand detail page
      | status  | brand                       | product                    | sku  | image       | expressTag | price  |
      | showing | Auto random Brand 7 product | random product api702231   | 1SKU | anhJPG2.jpg | not show   | $10.00 |
      | showing | Auto random Brand 7 product | random product 2 api702231 | 1SKU | anhJPG2.jpg | show       | $10.00 |
    Then Verify promo preview "TPR" of product "random product 2 api702231" in "Brand page"
      | name                   | type | price | caseLimit |
      | sku random 2 api702231 | TPR  | $5.00 | 1         |
    And Admin change state of product id "random" to inactive by api
    And Go to product detail "random product 2 api702231" from product list of Brand
    And BUYER check page missing

  @B_BRANDS_19 @B_BRANDS_46
  Scenario: Check a Product card by default - Head buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand " by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                        | description | micro_description | city     | address_state_id | vendor_company_id |
      | Auto random Brand 7 product | description | micro description | New York | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                     | brand_id      |
      | random product api702231 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api702231" of product ""
#    Product 2
    And Create product by api with file "CreateProduct.json" and info
      | name                       | brand_id      |
      | random product 2 api702231 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random 2 api702231" of product ""
#Create promotion
    And Admin search promotion by Promotion Name "Auto Promotion buyer brand"
    And Admin delete promotion by skuName ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                       | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto Promotion buyer brand | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer49@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Brands" from menu bar
    And Search Brand item "Auto random Brand 7 product"
    And BUYER go to brand "Auto random Brand 7 product" detail on catalog
    And BUYER check brand detail on catalog
      | brandName                   | city     | state    | description | logo                 | coverImage         |
      | Auto random Brand 7 product | New York | New York | description | no_img_thumbnail.png | no_img_product.png |
    And Buyer check list product on brand detail page
      | status  | brand                       | product                    | sku  | image       | expressTag | price   |
      | showing | Auto random Brand 7 product | random product api702231   | 1SKU | anhJPG2.jpg | not show   | [blank] |
      | showing | Auto random Brand 7 product | random product 2 api702231 | 1SKU | anhJPG2.jpg | show       | [blank] |
    And Verify tag "TPR" promotion is "not show" on product "random product 2 api702231"
#
#    Then Verify promo preview "TPR" of product "random product 2 api702231" in "Brand page"
#      | name                   | type | price | caseLimit |
#      | sku random 2 api702231 | TPR  | $5.00 | 1         |
    And Admin change state of product id "random" to inactive by api
    And Go to product detail "random product 2 api702231" from product list of Brand
    And BUYER check page missing


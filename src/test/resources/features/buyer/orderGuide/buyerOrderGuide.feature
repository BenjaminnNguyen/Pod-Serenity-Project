# language: en
#Tính năng: Buyer Order Guide
@feature=buyerOrderGuide
@feature=Buyer
Feature: Buyer Order Guide

  @B_ORDER_GUIDE_1
  Scenario Outline: Check displayed information on the page of the normal buyers
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Order guide" from menu bar
    And Buyer check redirect link on catalog page
      | title                | newTitle                                                                             | redirectLink                      |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
      | Brands               | All brands - Pod Foods \| Online Distribution Platform for Emerging Brands           | .podfoods.co/brands               |
      | Order guide          | Order Guide - Pod Foods \| Online Distribution Platform for Emerging Brands          | .podfoods.co/order-guide          |
      | Recommended products | Recommended Products - Pod Foods \| Online Distribution Platform for Emerging Brands | .podfoods.co/recommended-products |
      | Favorites            | Favorites - Pod Foods \| Online Distribution Platform for Emerging Brands            | .podfoods.co/favorites            |
      | Refer a Brand        | Brand Referral - Pod Foods \| Online Distribution Platform for Emerging Brands       | .podfoods.co/brands/invite        |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
    And Buyer go to "Order guide" from menu bar
    And Check any text "is" showing on screen
      | Your order guide products |
    And Buyer search Order guide on tab "Your order guide"
      | item    | timeInterval              | orderBy                              | activeOnly |
      | item    | Recent (Prior Six Months) | Brand — A-Z                          | yes        |
      | [blank] | All                       | Brand — Z-A                          | [blank]    |
      | [blank] | [blank]                   | Next Reorder Date — Earliest first   | [blank]    |
      | [blank] | [blank]                   | Next Reorder Date — Latest first     | [blank]    |
      | [blank] | [blank]                   | Average Reorder Days — Lowest first  | [blank]    |
      | [blank] | [blank]                   | Average Reorder Days — Highest first | [blank]    |

    And Buyer search Order guide on tab "Store order guide"
      | item    | timeInterval              | orderBy                              | activeOnly |
      | item    | Recent (Prior Six Months) | Brand — A-Z                          | yes        |
      | [blank] | All                       | Brand — Z-A                          | [blank]    |
      | [blank] | [blank]                   | Next Reorder Date — Earliest first   | [blank]    |
      | [blank] | [blank]                   | Next Reorder Date — Latest first     | [blank]    |
      | [blank] | [blank]                   | Average Reorder Days — Lowest first  | [blank]    |
      | [blank] | [blank]                   | Average Reorder Days — Highest first | [blank]    |
    And Buyer search Order guide on tab "Your order guide"
      | item    | timeInterval | orderBy | activeOnly |
      | [blank] | [blank]      | [blank] | [blank]    |
    And Buyer export Order guide

    Examples:
      | role_            | buyer                          | pass      | role  |
      | Store manager PE | ngoctx+autobuyer59@podfoods.co | 12345678a | buyer |
      | Store sub buyer  | ngoctx+autobuyer61@podfoods.co | 12345678a | buyer |
      | Store manager PD | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer |

  @B_ORDER_GUIDE_2
  Scenario Outline: Check displayed information on the page of the head buyers
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Order guide" from menu bar
    And Buyer check redirect link on catalog page
      | title                | newTitle                                                                             | redirectLink                      |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
      | Brands               | All brands - Pod Foods \| Online Distribution Platform for Emerging Brands           | .podfoods.co/brands               |
      | Order guide          | Order Guide - Pod Foods \| Online Distribution Platform for Emerging Brands          | .podfoods.co/order-guide          |
      | Recommended products | Recommended Products - Pod Foods \| Online Distribution Platform for Emerging Brands | .podfoods.co/recommended-products |
      | Favorites            | Favorites - Pod Foods \| Online Distribution Platform for Emerging Brands            | .podfoods.co/favorites            |
      | Refer a Brand        | Brand Referral - Pod Foods \| Online Distribution Platform for Emerging Brands       | .podfoods.co/brands/invite        |
      | Catalog              | Catalog - Pod Foods \| Online Distribution Platform for Emerging Brands              | .podfoods.co/products             |
    And Buyer go to "Order guide" from menu bar
    And Check any text "is" showing on screen
      | Your order guide products |
    And Buyer search Order guide on tab "Store order guide"
      | item    | timeInterval              | store                     | orderBy                              | activeOnly |
      | item    | Recent (Prior Six Months) | [blank]                   | Brand — A-Z                          | yes        |
      | [blank] | All                       | [blank]                   | Brand — Z-A                          | [blank]    |
      | [blank] | [blank]                   | [blank]                   | Next Reorder Date — Earliest first   | [blank]    |
      | [blank] | [blank]                   | [blank]                   | Next Reorder Date — Latest first     | [blank]    |
      | [blank] | [blank]                   | [blank]                   | Average Reorder Days — Lowest first  | [blank]    |
      | [blank] | [blank]                   | Auto store switch mov moq | Average Reorder Days — Highest first | [blank]    |
    And Buyer export Order guide

    Examples:
      | role_      | buyer                          | pass      | role       |
      | Head buyer | ngoctx+autobuyer49@podfoods.co | 12345678a | head buyer |

  @B_ORDER_GUIDE_4
  Scenario:Check the Recommended products section when buyer has an recommended items
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
#
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product order guide api1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api1" of product ""
      #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | [blank]    |
    And Buyer check previous order items on Order guide
      | sku                         | brand                     | product                         | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay |
      | sku random order guide api1 | Auto brand create product | random product order guide api1 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api1" in Order guide
      | orderDate   | quantity |
      | currentDate | 5        |
#    Change product to inactive
    And Admin change state of product id "random" to inactive by api
    And BUYER refresh browser
    And Buyer check previous order items on Order guide
      | sku                         | brand                     | product                         | image       | skuId   | upc                          | pack    | expressTag | price   | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api1 | Auto brand create product | random product order guide api1 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | [blank] | -               | -           | disable |

    And Buyer search Order guide on tab "Your order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check item "sku random order guide api1" not show in Order guide

  @B_ORDER_GUIDE_3
  Scenario:Check the Recommended products section when buyer has multiple recommended items
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
#
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product order guide api1 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api1" of product ""
      #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And Clear Info of Region api
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product order guide api2 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api2" of product ""
     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | [blank]    |
    And Buyer check previous order items on Order guide
      | sku                         | brand                     | product                         | image       | skuId         | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay |
      | sku random order guide api2 | Auto brand create product | random product order guide api2 | anhJPG2.jpg | create by api | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case)  | -               | -           |
      | sku random order guide api1 | Auto brand create product | random product order guide api1 | anhJPG2.jpg | [blank]       | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | currentDate     | -           |
    And Buyer check previous order date of SKU "sku random order guide api2" in Order guide
      | orderDate   | quantity |
      | currentDate | 50       |
    And Buyer check previous order date of SKU "sku random order guide api1" in Order guide
      | orderDate   | quantity |
      | currentDate | 5        |

  @B_ORDER_GUIDE_5
  Scenario: Check the Recommended products section when buyer has an recommended items - Sub buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
#
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product order guide api5 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api5" of product ""
    And Admin Authorized SKU id "" to Buyer id "3365"
      #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3365     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | [blank]    |
    And Buyer check item "sku random order guide api5" not show in Order guide
    And Buyer search Order guide on tab "Store order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | [blank]    |
    And Buyer check previous order items on Order guide
      | sku                         | brand                     | product                         | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api5 | Auto brand create product | random product order guide api5 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | -               | -           | disable |
    And Buyer check previous order date of SKU "sku random order guide api5" in Order guide
      | orderDate   | quantity |
      | currentDate | 5        |

  @B_ORDER_GUIDE_6
  Scenario: Check the Recommended products section when buyer has an recommended items - Normal buyer check MOV MOQ
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Admin search product recommendation Buyer id "3314" by api
    And Admin delete product recommendation by api
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product order guide api5 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api5" of product ""
         #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Clear Info of Region api

#    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |
     #Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 3314     | 3314   | create by api | comment |
    And Admin clear line items attributes by API
  #    Create product MOV
    And Create product by api with file "CreateProduct.json" and info
      | name                            | brand_id |
      | random product order guide api6 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api6" of product ""
#     Create recommendation
    And Admin create recommendation by api
      | buyer_id | _buyer | product_id    | comment |
      | 3314     | 3314   | create by api | comment |
     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer check Recommended products section Order guide
      | brand                  | product                         | image       | expressTag |
      | Auto Brand product moq | random product order guide api5 | anhJPG2.jpg | show       |
      | Auto Brand product mov | random product order guide api6 | anhJPG2.jpg | not show   |
    And Click on any text "Explore more"
    And Buyer go to "Order guide" from menu bar
    And Clear cart to empty in cart before
    And Buyer click add to cart product "random product order guide api5" on popup cart
    And Buyer add sku to cart in popup cart
      | sku                         | quantity |
      | sku random order guide api5 | 1        |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Buyer click add to cart product "random product order guide api6" on popup cart
    And Buyer add sku to cart in popup cart
      | sku                         | quantity |
      | sku random order guide api6 | 1        |
    And Click on dialog button "Add to cart"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | [blank]    |
    And Add cart sku "random product order guide api5" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Close popup add cart
    And Clear cart to empty in cart before
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product mov | Recent (Prior Six Months) | Brand — A-Z | [blank]    |
    And Add cart sku "random product order guide api6" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
#inactive product
    And Admin change state of product id "random" to inactive by api
    And Buyer click add to cart product "random product order guide api6" on popup cart
    And Check any text "is" showing on screen
      | There is no items available for add to cart. |
    And Check dialog button "Add to cart" is "disable"

  @B_ORDER_GUIDE_28
  Scenario: Check displayed information of an authorized SKU not ordered yet directly
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
#
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product order guide api 281 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api281" of product ""
    And Admin Authorized SKU id "" to Buyer id "3365"

#  Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3365     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#    Product 2 authorized and not order
    And Create product by api with file "CreateProduct.json" and info
      | name                               | brand_id |
      | random product order guide api 282 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api282" of product ""
    And Admin Authorized SKU id "" to Buyer id "3365"

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                           | brand                     | product                            | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api282 | Auto brand create product | random product order guide api 282 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | [blank]         | [blank]     | show    |
    And Buyer check previous order date of SKU "sku random order guide api282" in Order guide
      | orderDate | quantity |
      | [blank]   | [blank]  |
    And Buyer check previous order items on Order guide
      | sku                           | brand                     | product                            | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api281 | Auto brand create product | random product order guide api 281 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | -               | -           | show    |
    And Buyer check previous order date of SKU "sku random order guide api281" in Order guide
      | orderDate   | quantity |
      | currentDate | 5        |
    And Buyer search Order guide on tab "Store order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                           | brand                     | product                            | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api282 | Auto brand create product | random product order guide api 282 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | [blank]         | [blank]     | show    |
    And Buyer check previous order date of SKU "sku random order guide api282" in Order guide
      | orderDate | quantity |
      | [blank]   | [blank]  |
    And Buyer check previous order items on Order guide
      | sku                           | brand                     | product                            | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api281 | Auto brand create product | random product order guide api 281 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | -               | -           | show    |
    And Buyer check previous order date of SKU "sku random order guide api281" in Order guide
      | orderDate   | quantity |
      | currentDate | 5        |

    Given BUYER2 open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Store order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                           | brand                     | product                            | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api281 | Auto brand create product | random product order guide api 281 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | -               | -           | show    |
    And Buyer check previous order date of SKU "sku random order guide api281" in Order guide
      | orderDate   | quantity |
      | currentDate | 5        |

  @B_ORDER_GUIDE_63
  Scenario: Check showing the Promotion toast when tap on any Buy-in promotion tag
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
#
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product order guide api281 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api281" of product ""
    And Admin Authorized SKU id "" to Buyer id "3365"
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::BuyIn | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                           | brand                     | product                           | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay | addCart |
      | sku random order guide api281 | Auto brand create product | random product order guide api281 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | [blank]         | [blank]     | show    |
    And Buyer check price applied promotions of SKU in Order guide
      | sku                           | oldPrice | currentPrice | typePromotion |
      | sku random order guide api281 | $100.00  | $50.00       | Buy in        |
    And Buyer check previous order date of SKU "sku random order guide api281" in Order guide
      | orderDate | quantity |
      | [blank]   | [blank]  |
    And Buyer check promotions tag of SKU in Order guide
      | sku                           | oldPrice | currentPrice | typePromotion |
      | sku random order guide api281 | $100.00  | $50.00       | BUY-IN        |

  @B_ORDER_GUIDE_31
  Scenario: Check the recommended items - Admin orders with a SKU more than 3 times
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product order guide api 31 | 3018     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api31" of product ""
      #    Admin create order
#    And Admin create line items attributes by API
#      | skuName                      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | sku random order guide api31 | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
  #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 10       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
       #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 15       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And Admin clear line items attributes by API1
    And Admin create a "active" SKU from admin with name "sku random order guide api32" of product ""
       #    Admin create order
    # Authorized SKUs to Sub buyer able to buy this sku
    And Admin Authorized SKU id "" to Buyer id "3365"
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 20       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3365     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

#
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                     | product                           | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay |
      | sku random order guide api31 | Auto brand create product | random product order guide api 31 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | currentDate     | -           |
    And Buyer check previous order date of SKU "sku random order guide api31" in Order guide
      | orderDate   | quantity |
      | currentDate | 5        |
      | currentDate | 10       |
      | currentDate | 15       |
    And Buyer search Order guide on tab "Store order guide"
      | item                      | timeInterval              | orderBy     | activeOnly |
      | Auto brand create product | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                     | product                           | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay |
      | sku random order guide api31 | Auto brand create product | random product order guide api 31 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | currentDate     | -           |
#    And Buyer check previous order date of SKU "sku random order guide api31" in Order guide
#      | orderDate   | quantity |
#      | currentDate | 5        |
#      | currentDate | 10       |
#      | currentDate | 15       |
    And Buyer check previous order items on Order guide
      | sku                          | brand                     | product                           | image       | skuId   | upc                          | pack    | expressTag | price                       | nextReorderDate | avgOrderDay |
      | sku random order guide api32 | Auto brand create product | random product order guide api 31 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $100.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api32" in Order guide
      | orderDate   | quantity |
      | currentDate | 20       |

  @B_ORDER_GUIDE_33
  Scenario: Check display value of SKU price
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api33 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1500             | 1500       | in_stock     |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 2000             | 2000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random order guide api33" of product ""
         #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api33 | Auto Brand product moq | random product order guide api33 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $20.00 / unit(1 unit/case) | -               | -           |

    #    Update region to inactive
#    And Admin change info of regions attributes of sku "sku random order guide api33" state "active"
#      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
#      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
  #    Update store specific to inactive
    And Admin change info of store specific of sku "create by api"
      | id            | region_id | store_id | store_name          | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | create by api      | 2000             | 2000       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api33 | Auto Brand product moq | random product order guide api33 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $15.00 / unit(1 unit/case) | -               | -           |

#      Update buyer company  to inactive
    And Admin change info of buyer company specific of sku "create by api"
      | id            | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | active              | 2216             | Auto_BuyerCompany  | create by api      | 1500             | 1500       | in_stock     | active | Minus2     | Minus1   |
    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api33 | Auto Brand product moq | random product order guide api33 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |

  @B_ORDER_GUIDE_37
  Scenario: Check display of promotion tag on the variant card
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api37 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api37" of product ""
         #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api37 | Auto Brand product moq | random product order guide api37 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check price applied promotions of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion |
      | sku random order guide api37 | $10.00   | $5.00        | TPR           |
    And Buyer check promotions tag of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion | caseLimit         |
      | sku random order guide api37 | $10.00   | $5.00        | TPR           | First 1 case only |
#Short dated promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api37 | Auto Brand product moq | random product order guide api37 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check price applied promotions of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion |
      | sku random order guide api37 | $10.00   | $0.00        | Short dated   |
    And Buyer check promotions tag of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion | caseLimit         | expiryDate  |
      | sku random order guide api37 | $10.00   | $0.00        | Short-dated   | First 1 case only | currentDate |
    And Add cart sku "random product order guide api37" from order guide
    And BUYER check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |

  @B_ORDER_GUIDE_38
  Scenario: Check display of promotion tag on the variant card - sub buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api38 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api38" of product ""

#    When Admin search buyer company by API
#      | buyerCompany                 | managedBy | onboardingState | tag     |
#      | AT Buyer Company order guide | [blank]   | [blank]         | [blank] |
#    And Admin delete buyer company "" by API
#    # Create buyer company by api
#    And Admin create buyer company by API
#      | name                         | ein    | launcher_id | manager_id | website                        | store_type_id |
#      | AT Buyer Company order guide | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
#    # Create store by api
#    And Admin create store by API
#      | name                 | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
#      | AT Store order guide | at+storechi01@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
#     # Create sub buyer account
#    And Admin create "sub" buyer account by API
#      | first_name | last_name | email                            | role      | business_name | contact_number | tag     | store_id      | manager_id | password  |
#      | atbuyeracc | s01       | atbuyeraccorderguide@podfoods.co | sub_buyer | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

    And Admin Authorized SKU id "" to Buyer id "3365"
         #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3365     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |
#
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer61@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api38 | Auto Brand product moq | random product order guide api38 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check price applied promotions of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion |
      | sku random order guide api38 | $10.00   | $5.00        | TPR           |
    And Buyer check promotions tag of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion | caseLimit         |
      | sku random order guide api38 | $10.00   | $5.00        | TPR           | First 1 case only |
    #Short dated promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                          | chargeValue | stack | minQty |
      | PromotionActions::FixRateAdjustment | 1000        | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api38 | Auto Brand product moq | random product order guide api38 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check price applied promotions of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion |
      | sku random order guide api38 | $10.00   | $0.00        | Short dated   |
    And Buyer check promotions tag of SKU in Order guide
      | sku                          | oldPrice | currentPrice | typePromotion | caseLimit         | expiryDate  |
      | sku random order guide api38 | $10.00   | $0.00        | Short-dated   | First 1 case only | currentDate |

  @B_ORDER_GUIDE_44
  Scenario: Check state of Add to cart button by default
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api44 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api44" of product ""
         #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 5        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api44 | Auto Brand product moq | random product order guide api44 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer click sku "random product order guide api44" on Order guide
    And Buyer check detail of product
      | productName                      | productBrand           | pricePerUnit | pricePerCase | availability |
      | random product order guide api44 | Auto Brand product moq | $10.00       | $10.00       | In Stock     |
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |

    #  change State của sku
    And Admin change info of regions attributes of sku "sku random order guide api44" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | sold_out     | active |
    And BUYER refresh browser
#    And Click on any text "random product order guide api44"
    And Buyer click sku "random product order guide api44" on Order guide
    And Buyer check detail of product
      | productName                      | productBrand           | pricePerUnit | pricePerCase | availability |
      | random product order guide api44 | Auto Brand product moq | $10.00       | $10.00       | Out of Stock |
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
       #  change State của sku
    And Admin change info of regions attributes of sku "sku random order guide api44" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | sold_out     | inactive |
    And Buyer click sku "random product order guide api44" on Order guide
    And BUYER check page missing

  @B_ORDER_GUIDE_51
  Scenario: Check displayed information on the MOV alert
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api51 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api51" of product ""
     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api51 | Auto brand add to cart mov | random product order guide api51 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api51" in Order guide
      | orderDate   | quantity |
      | currentDate | 50       |
    And Add cart sku "random product order guide api51" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api51 | 50       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
#Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api51 | Auto brand add to cart mov | random product order guide api51 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api51" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer check items on popup add cart not met MOV
      | type             | sku                          | product                          | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | sku random order guide api51 | random product order guide api51 | 1 unit/case | $10.00 | anhJPG2.jpg | 1        |
      | Pod Direct Items | Auto SKU add to cart mov     | Auto product add to cart mov     | 1 unit/case | $10.00 | 17597.png   | 0        |
      | Pod Direct Items | Auto SKU 3 add to cart mov   | Auto product 2 add to cart mov   | 1 unit/case | $10.00 | 17597.png   | 0        |
      | Pod Direct Items | Auto SKU 5 add to cart mov   | Auto product 3 add to cart mov   | 1 unit/case | $10.00 | 17597.png   | 0        |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api51 | 51       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart

    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    #Create promotion * In case A has a promotion which has case minimum = 1 and no case limit:
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api51 | Auto brand add to cart mov | random product order guide api51 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api51" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api51 | 50       |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $250.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api51 | 100      |
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
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 2          | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api51 | Auto brand add to cart mov | random product order guide api51 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api51" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api51 | 3        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $480.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api51 | 52       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "sku random order guide api51" is "show" on add cart popup have met MOV
      | name                         | type | price | caseLimit |
      | sku random order guide api51 | TPR  | $5.00 | 2         |
    And Close popup add cart

  @B_ORDER_GUIDE_66
  Scenario: Check prioritizing store-specific promotions over region-specific promotions MOV
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api66 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api66" of product ""
     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

  #Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | [blank]   | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

#Create promotion 2
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api66 | Auto brand add to cart mov | random product order guide api66 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api66" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api66 | 3        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $475.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api66 | 52       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "sku random order guide api66" is "show" on add cart popup have met MOV
      | name                         | type | price | caseLimit |
      | sku random order guide api66 | TPR  | $5.00 | 1         |
    And Close popup add cart

  @B_ORDER_GUIDE_67
  Scenario:Check the priority when many created store-specific promotions for the same store and same SKUs
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api67 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api67" of product ""
     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

  #Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

#Create promotion 2
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api67 | Auto brand add to cart mov | random product order guide api67 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api67" from order guide
    And BUYER check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
    And Click on dialog button "I understand"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $492.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api67 | 3        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $472.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api67 | 52       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "Short dated" of sku "sku random order guide api67" is "show" on add cart popup have met MOV
      | name                         | type        | price | caseLimit |
      | sku random order guide api67 | Short-dated | $8.00 | 1         |
    And Close popup add cart

  @B_ORDER_GUIDE_68
  Scenario:Check the display of promotion tag when usage limit of promotion is used up
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api68 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api68" of product ""

  #Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api68 | Auto brand add to cart mov | random product order guide api68 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api68" from order guide
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api68 | 2        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $480.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api68 | 50       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "sku random order guide api68" is "not show" on add cart popup have met MOV
      | name                         | type | price | caseLimit |
      | sku random order guide api68 | TPR  | $5.00 | 1         |
    And Close popup add cart

  @B_ORDER_GUIDE_74
  Scenario:Check displayed content on the Short-dated popup
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api67 | 2971     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api67" of product ""
     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 2969     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

#Create promotion 2
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 2708      | [blank]                    | 2384              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer39@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                       | timeInterval              | orderBy     | activeOnly |
      | Auto brand add to cart mov | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                      | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api67 | Auto brand add to cart mov | random product order guide api67 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | not show   | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api67" from order guide
    And Buyer check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
    And Click on dialog button "I understand"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api67 | 3        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $475.00 |
    And Buyer update cart of MOV alert with info
      | sku                          | quantity |
      | sku random order guide api67 | 52       |
    And Check MOV not met in cart detail
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "Short dated" of sku "sku random order guide api67" is "show" on add cart popup have met MOV
      | name                         | type        | price | caseLimit |
      | sku random order guide api67 | Short-dated | $5.00 | 1         |
    And Buyer update cart of MOV alert success
    And BUYER check dialog message
      | SKUs with short-dated promotions are not guaranteed sales and there are no refunds for expiration of these items |
    And Close popup add cart

  @B_ORDER_GUIDE_75
  Scenario: Check displayed information on the MOQ alert
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api75 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api75" of product ""
     #    Admin create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api75 | Auto Brand product moq | random product order guide api75 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api75" in Order guide
      | orderDate   | quantity |
      | currentDate | 50       |
    And Clear cart to empty in cart before
    And Add cart sku "random product order guide api75" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Buyer add sku to cart in popup cart
      | sku                          | quantity |
      | sku random order guide api75 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
#Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api75 | Auto Brand product moq | random product order guide api75 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Add cart sku "random product order guide api75" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 3 cases |

    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    #Create promotion * In case A has a promotion which has case minimum = 1 and no case limit:
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | [blank]    | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api75 | Auto Brand product moq | random product order guide api75 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Clear cart to empty in cart before
    And Add cart sku "random product order guide api75" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Buyer add sku to cart in popup cart
      | sku                          | quantity |
      | sku random order guide api75 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
#
     #Create promotion * In case A has a promotion which has case minimum and case limit; case minimum < case limit:
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 2          | 1                | true           | [blank] | default    | [blank]       | false   |

    And BUYER refresh browser
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api75 | Auto Brand product moq | random product order guide api75 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Clear cart to empty in cart before
    And Add cart sku "random product order guide api75" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    And Buyer add sku to cart in popup cart
      | sku                          | quantity |
      | sku random order guide api75 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    Then Verify promo preview "TPR" of sku "sku random order guide api75" is "show" on add cart popup
      | name                         | type | price | caseLimit |
      | sku random order guide api75 | TPR  | $5.00 | 2         |
    And Close popup add cart
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""

  @B_ORDER_GUIDE_87
  Scenario: Check prioritizing store-specific promotions over region-specific promotions MOQ
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api87 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api87" of product ""

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |
    #Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | [blank]   | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |
    
#Create promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api87 | Auto Brand product moq | random product order guide api87 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api87" in Order guide
      | orderDate   | quantity |
      | currentDate | 50       |
    And Clear cart to empty in cart before
    And Add cart sku "random product order guide api87" from order guide
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "TPR" of sku "sku random order guide api87" is "show" on add cart popup
      | name                         | type | price | caseLimit |
      | sku random order guide api87 | TPR  | $5.00 | 1         |
    And Buyer add sku to cart in popup cart
      | sku                          | quantity |
      | sku random order guide api87 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""

  @B_ORDER_GUIDE_88
  Scenario: Check the priority when many created store-specific promotions for the same store and same SKUs - MOQ
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api87 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api87" of product ""

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
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
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

#Create promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api87 | Auto Brand product moq | random product order guide api87 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api87" in Order guide
      | orderDate   | quantity |
      | currentDate | 50       |
    And Clear cart to empty in cart before
    And Add cart sku "random product order guide api87" from order guide
    And BUYER check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
    And Click on dialog button "I understand"
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "Short dated" of sku "sku random order guide api87" is "show" on add cart popup
      | name                         | type        | price | caseLimit |
      | sku random order guide api87 | Short-dated | $8.00 | 1         |
    And Buyer add sku to cart in popup cart
      | sku                          | quantity |
      | sku random order guide api87 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""

  @B_ORDER_GUIDE_89
  Scenario: Check the display of promotion tag when usage limit of promotion is used up- MOQ
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api87 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api87" of product ""
#Create promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2582      | [blank]                    | 2216              | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion Buyer Order guide | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   | false   |

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#    set MOQ
    And Admin set regional moq of product "create by api"
      | id            | product_id    | region_id | moq | created_at  | updated_at  |
      | create by api | create by api | 26        | 5   | currentDate | currentDate |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api87 | Auto Brand product moq | random product order guide api87 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api87" in Order guide
      | orderDate   | quantity |
      | currentDate | 50       |
    And Clear cart to empty in cart before
    And Add cart sku "random product order guide api87" from order guide
#    And BUYER check dialog message
#      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
#    And Click on dialog button "I understand"
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 4 cases |
    Then Verify promo preview "Short dated" of sku "sku random order guide api87" is "not show" on add cart popup
      | name                         | type        | price | caseLimit |
      | sku random order guide api87 | Short-dated | $8.00 | 1         |
    And Buyer add sku to cart in popup cart
      | sku                          | quantity |
      | sku random order guide api87 | 4        |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""

  @B_ORDER_GUIDE_94
  Scenario: Verify the exported file
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Order guide"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product order guide api" by api
    And Admin search product name "random product order guide api" by api
    And Admin delete product name "random product order guide api" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                             | brand_id |
      | random product order guide api94 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api94" of product ""

    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 50       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
    And Admin clear line items attributes by API
    And Create product by api with file "CreateProduct.json" and info
      | name                              | brand_id |
      | random product order guide api294 | 3086     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random order guide api294" of product ""
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api26    | create by api      | 10       | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3314     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Order guide" from menu bar
    And Buyer search Order guide on tab "Your order guide"
      | item                   | timeInterval              | orderBy     | activeOnly |
      | Auto Brand product moq | Recent (Prior Six Months) | Brand — A-Z | yes        |
    And Buyer check previous order items on Order guide
      | sku                          | brand                  | product                          | image       | skuId   | upc                          | pack    | expressTag | price                      | nextReorderDate | avgOrderDay |
      | sku random order guide api94 | Auto Brand product moq | random product order guide api94 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
#      | sku random order guide api294 | Auto Brand product moq | random product order guide api294 | anhJPG2.jpg | [blank] | Unit UPC / EAN: 123123123123 | [blank] | show       | $10.00 / unit(1 unit/case) | -               | -           |
    And Buyer check previous order date of SKU "sku random order guide api94" in Order guide
      | orderDate   | quantity |
      | currentDate | 50       |
    And Buyer check previous order date of SKU "sku random order guide api294" in Order guide
      | orderDate   | quantity |
      | currentDate | 10       |
    And Buyer delete file export order guide
    And Buyer export order guide
    And Buyer check file export order guide
      | itemId        | brand                  | product                           | sku                           | priceCase | priceUnit | pack | unitSize | unitUPC      |
      | create by api | Auto Brand product moq | random product order guide api94  | sku random order guide api94  | $10.00    | $10.00    | 1    | 1.0 g    | 123123123123 |
      | create by api | Auto Brand product moq | random product order guide api294 | sku random order guide api294 | $10.00    | $10.00    | 1    | 1.0 g    | 123123123123 |
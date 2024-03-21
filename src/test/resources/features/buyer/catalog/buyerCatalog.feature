# language: en
@feature=buyerCatalog
#Tính năng: Buyer catalog
Feature: Buyer Catalog

  @B_CATALOG_1 @B_CATALOG_2
  Scenario Outline: Check displayed information on the Catalog of the normal buyers
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
    Examples:
      | role_            | buyer                            | pass      | role       |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer |

  @B_CATALOG_17
  Scenario: Prepare data - Check the Search function
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |

    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api11 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api11" of product ""
    And Clear Info of Region api
##Product 2
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api2 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api2" of product ""
    And Clear Info of Region api
##Product 3
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api3 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api3" of product ""
    And Clear Info of Region api
##Product 4
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api4 | create by api |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api4" of product ""
    And Clear Info of buyer company api
##Product 5
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api5 | create by api |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api5" of product ""
    And Clear Info of buyer company api
##Product 6
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api6 | create by api |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 62        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api6" of product ""
    And Clear Info of buyer company api
##Product7
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api7 | create by api |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2216             | Auto_BuyerCompany  | 61        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api7" of product ""
    And Clear Info of buyer company api
##Product8 active on Store A
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api8 | create by api |
    And Info of Store specific
      | store_id | store_name          | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2582     | Auto Store Chicago1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api8" of product ""
    And Clear Info of store api
##Product9  active on Store B
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api9 | create by api |
    And Info of Store specific
      | store_id | store_name                         | buyer_company_id | buyer_company_name     | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2724     | Auto store 2 check add to cart moq | 2360             | Auto Buyer Company Bao | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api9" of product ""
    And Clear Info of store api
  ##Product10 active on Store C
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api10 | create by api |
    And Info of Store specific
      | store_id | store_name     | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api10" of product ""
    And Clear Info of store api

  @B_CATALOG_17
  Scenario Outline: Check the Search function 2
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api"
#    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                     | product              | sku  |
      | <prd1>  | Auto random Brand product | random product api11 | 1SKU |
      | <prd2>  | Auto random Brand product | random product api2  | 1SKU |
      | <prd3>  | Auto random Brand product | random product api3  | 1SKU |
      | <prd4>  | Auto random Brand product | random product api4  | 1SKU |
      | <prd5>  | Auto random Brand product | random product api5  | 1SKU |
      | <prd6>  | Auto random Brand product | random product api6  | 1SKU |
      | <prd7>  | Auto random Brand product | random product api7  | 1SKU |
      | <prd8>  | Auto random Brand product | random product api8  | 1SKU |
      | <prd9>  | Auto random Brand product | random product api9  | 1SKU |
      | <prd10> | Auto random Brand product | random product api10 | 1SKU |
    And BUYER log out
    Examples:
      | role_              | buyer                          | pass      | role  | prd1     | prd2    | prd3    | prd4     | prd5     | prd6     | prd7     | prd8     | prd9     | prd10    |
      | Store manager PE   | ngoctx+autobuyer59@podfoods.co | 12345678a | buyer | showing  | showing | showing | showing  | showing  | not show | not show | showing  | not show | not show |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer | not show | showing | showing | not show | not show | not show | not show | not show | not show | showing  |
      | Store sub buyer PE | ngoctx+autobuyer44@podfoods.co | 12345678a | buyer | showing  | showing | showing | not show | not show | not show | not show | not show | showing  | not show |
#      | Head buyer         | ngoctx+autobuyer49@podfoods.co | 12345678a | head buyer |         |         |         |         |         |          |          |         |          |         |

  @B_CATALOG_17
  Scenario: Check the Search function 2
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product"
    And Buyer Search product by name "Auto sku"
    And Buyer Search product by name "Auto brand"
    And Buyer Search product by name "121212121212"
    And Buyer Search product by name "121212121212"
    And Buyer Search product by name "Auto Vendor company"
    And Buyer Search product by name "3018"
    And Click on any text "Clear all filters"
    And Search Brands by name "AutoTest Brand Ngoc01"

  @B_CATALOG_20
  Scenario: Check display of a product on the Catalog for a head buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+autoheadbuyer2@podfoods.co" pass "12345678a" role "head buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product"
    And Buyer Search product by name "Auto sku"
    And Buyer Search product by name "Auto brand"
    And Buyer Search product by name "121212121212"
    And Buyer Search product by name "121212121212"
    And Buyer Search product by name "Auto Vendor company"
    And Buyer Search product by name "3018"
    And Click on any text "Clear all filters"
    And Search Brands by name "AutoTest Brand Ngoc01"
    And Search Brands by name "AutoTest Brand Ngoc0123"

  @B_CATALOG_23
  Scenario Outline: Check UI of default Categories bar
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin edit product category id "21" api
      | name | pull_threshold |
      | Test | 0              |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter by category "New" on catalog page
    And Buyer filter by category "Cheese" on catalog page
    And Buyer filter by category "Test" on catalog page

    And Admin edit product category id "21" api
      | name  | pull_threshold |
      | Test1 | 0              |
    And Refesh browser
    And Buyer filter by category "Test1" on catalog page
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin edit product category id "21" api
      | name | pull_threshold |
      | Test | 0              |
    And BUYER log out
    Examples:
      | role_            | buyer                            | pass      | role       |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer |

  @B_CATALOG_28
  Scenario Outline: Check search no result
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter by category "Hemp" on catalog page
    And Buyer check number product show on catalog
      | count | total |
      | 0     | 0     |
    And Check any text "is" showing on screen
      | No results found              |
      | We couldn't find any matches. |
    And Click on any text "Invite Brands >"
    And Switch to tab by title "Brand Referral - Pod Foods | Online Distribution Platform for Emerging Brands"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "No results found 123"
    And "BUYER" choose filter by "Order by Newest"
    And Check any text "is" showing on screen
      | No results found              |
      | We couldn't find any matches. |
    And Buyer check number product show on catalog
      | count | total |
      | 0     | 0     |
    Examples:
      | role_            | buyer                            | pass      | role       |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer |

  @B_CATALOG_28
  Scenario Outline: Check search no result head buyer
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter by category "Hemp" on catalog page
    And Buyer check number product show on catalog
      | count | total |
      | 0     | 0     |
    And Check any text "is" showing on screen
      | No results found              |
      | We couldn't find any matches. |
    And Click on any text "Clear all filters"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "No results found 123"
    And "BUYER" choose filter by "Order by Newest"
    And Check any text "is" showing on screen
      | No results found              |
      | We couldn't find any matches. |
    And Buyer check number product show on catalog
      | count | total |
      | 0     | 0     |
    Examples:
      | role_      | buyer                          | pass      | role       |
      | Head buyer | ngoctx+autobuyer49@podfoods.co | 12345678a | head buyer |

  @B_CATALOG_28
  Scenario Outline: Check the order of all product cards when select any options of the Order by select box:
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Click on any text "Explore more"
    And "BUYER" choose filter by "Order by Newest"
    And "BUYER" choose filter by "Order by Brand name — A > Z"
    And "BUYER" choose filter by "Order by Brand name — Z > A"
    And "BUYER" choose filter by "Order by Product name — A > Z"
    And "BUYER" choose filter by "Order by Product name — Z > A"
    And "BUYER" choose filter by "Order by Price — Lower first"
    And "BUYER" choose filter by "Order by Price — Higher first"
    And "BUYER" choose filter by "Order by Popularity"
    Examples:
      | role_            | buyer                            | pass      | role  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer |

  @B_CATALOG_28
  Scenario Outline: Check the order of all product cards when select any options of the Order by select box head buyer:
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Click on any text "Explore more"
    And "BUYER" choose filter by "Order by Newest"
    And "BUYER" choose filter by "Order by Brand name — A > Z"
    And "BUYER" choose filter by "Order by Brand name — Z > A"
    And "BUYER" choose filter by "Order by Product name — A > Z"
    And "BUYER" choose filter by "Order by Product name — Z > A"
    And "BUYER" choose filter by "Order by Price — Lower first"
    And "BUYER" choose filter by "Order by Price — Higher first"
    And "BUYER" choose filter by "Order by Popularity"
    Examples:
      | role_      | buyer                          | pass      | role       |
      | Head buyer | ngoctx+autobuyer49@podfoods.co | 12345678a | head buyer |

  @B_CATALOG_3
  Scenario: Verify the Policy Privacy confirmation popup
    # Delete buyer company
    Given BAO6 login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    When Admin search buyer company by API
      | buyerCompany        | managedBy | onboardingState | tag     |
      | AT Buyer Company 04 | [blank]   | [blank]         | [blank] |
    And Admin delete buyer company "" by API
    # Create buyer company by api
    And Admin create buyer company by API
      | name                | ein    | launcher_id | manager_id | website                        | store_type_id |
      | AT Buyer Company 04 | 01-123 | [blank]     | [blank]    | https://auto.podfoods.co/login | 2             |
    # Create store by api
    And Admin create store by API
      | name          | email                     | region_id | time_zone                  | store_size | store_type_id | buyer_company_id | phone_number | city    | street1               | address_state_id | zip   | number | street           |
      | at storechi03 | at+storechi01@podfoods.co | 26        | Pacific Time (US & Canada) | <50k       | 2             | create by api    | 1234567890   | Chicago | 1544 West 18th Street | 14               | 60608 | 1554   | West 18th Street |
    # Create head buyer account
    And Admin create "head" buyer account by API
      | first_name | last_name | email                       | role       | buyer_company_id | region | business_name | contact_number | tag     | store_id | manager_id | password  |
      | atbuyeracc | hb01      | atbuyeracc+hb04@podfoods.co | head_buyer | create by api    | 53     | Department    | 1234567890     | [blank] | [blank]  | [blank]    | 12345678a |
     # Create buyer account
    And Admin create "store" buyer account by API
      | first_name | last_name | email                      | role    | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyeracc | b01       | atbuyeracc+b04@podfoods.co | manager | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |
    # Create sub buyer account
    And Admin create "sub" buyer account by API
      | first_name | last_name | email                      | role      | business_name | contact_number | tag     | store_id      | manager_id | password  |
      | atbuyeracc | s01       | atbuyeracc+s04@podfoods.co | sub_buyer | Department    | 1234567890     | [blank] | create by api | [blank]    | 12345678a |

    Given HEAD_BUYER open web user
    When Buyer login with email "atbuyeracc+hb04@podfoods.co" and password "12345678a"
    And Buyer check Privacy Policy and accept
    And Buyer go to "Catalog" from menu bar
    Given BUYER open web user
    When Buyer login with email "atbuyeracc+b04@podfoods.co" and password "12345678a"
    And Buyer check Privacy Policy and accept
    And Buyer go to "Catalog" from menu bar
    Given SUB_BUYER open web user
    When Buyer login with email "atbuyeracc+s04@podfoods.co" and password "12345678a"
    And Buyer check Privacy Policy and accept
    And Buyer go to "Catalog" from menu bar

  @B_CATALOG_6
  Scenario Outline: Verify the announcement bar
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
      | 58 |
      | 54 |
    And Admin create announcements by api
      | name      | title     | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test | Auto test announcement | buyer          | currentDate           | currentDate          | podfoods.co | podfoods.co |
    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer check announcement is "<status>"
      | title     | description            | link        |
      | Auto test | Auto test announcement | podfoods.co |
    Examples:
      | role_            | buyer                            | pass      | role       | status   |
      | Vendor           | ngoctx+autovendor36@podfoods.co  | 12345678a | vendor     | not show |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing  |
      | Store sub buyer  | ngoctx+autobuyer61@podfoods.co   | 12345678a | buyer      | showing  |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | showing  |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head_buyer | showing  |
      | Store manager    | ngoctx+autobuyer62@podfoods.co   | 12345678a | buyer      | not show |

  @B_CATALOG_7 @B_CATALOG_20
  Scenario Outline: Verify the announcement bar -Check display of the announcement with Start delivering date > Current date
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
      | 58 |
      | 54 |
    And Admin create announcements by api
      | name      | title     | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test | Auto test announcement | buyer          | Plus1                 | Plus1                | podfoods.co | podfoods.co |
    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer check announcement is "<status>"
      | title     | description            | link        |
      | Auto test | Auto test announcement | podfoods.co |

    Examples:
      | role_            | buyer                            | pass      | role       | status   |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | not show |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | not show |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | not show |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head_buyer | not show |

  @B_CATALOG_9
  Scenario: Verify the announcement bar -Check display of the announcement with Start delivering date < Current date < Stop delivering date
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
      | 58 |
      | 54 |
    And Admin create announcements by api
      | name      | title     | body                   | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test | Auto test announcement | buyer          | Minus1                | Plus1                | podfoods.co | podfoods.co |

  @B_CATALOG_9
  Scenario Outline: Verify the announcement bar -Check display of the announcement with Start delivering date < Current date < Stop delivering date
    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer check announcement is "<status>"
      | title     | description            | link        |
      | Auto test | Auto test announcement | podfoods.co |
    Examples:
      | role_            | buyer                            | pass      | role       | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | showing |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | showing |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head_buyer | showing |

  @B_CATALOG_11
  Scenario Outline: Check apprearance order of annoucements if there are multiple unread announcements in effect time in a row
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
    And Admin create announcements by api
      | name      | title     | body                     | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test | Auto test announcement 1 | buyer          | Minus1                | Plus1                | podfoods.co | podfoods.co |
    And Admin create announcements by api
      | name        | title       | body                     | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test 2 | Auto test 2 | Auto test announcement 2 | buyer          | Minus1                | Plus1                | podfoods.co | podfoods.co |
    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer check announcement is "<status>"
      | title     | description              | link        |
      | Auto test | Auto test announcement 1 | podfoods.co |
    And Admin search announcements api
      | q[title]  | q[body]                  | q[recipient_type] | q[start_delivering_date] |
      | Auto test | Auto test announcement 1 | buyer             | [blank]                  |
    And Admin delete announcements by api
    And <role> refresh browser
    And Buyer check announcement is "<status>"
      | title       | description              | link        |
      | Auto test 2 | Auto test announcement 2 | podfoods.co |
    Examples:
      | role_            | buyer                            | pass      | role  | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing |

  @B_CATALOG_12
  Scenario Outline: Check display of the announcement bar without attached link
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
    And Admin create announcements by api
      | name      | title     | body                     | recipient_type | start_delivering_date | stop_delivering_date | link    | link_title |
      | auto test | Auto test | Auto test announcement 1 | buyer          | Minus1                | Plus1                | [blank] | [blank]    |

    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer check announcement is "<status>"
      | title     | description              | link    |
      | Auto test | Auto test announcement 1 | [blank] |
    Examples:
      | role_            | buyer                            | pass      | role  | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing |

  @B_CATALOG_13
  Scenario Outline: Check display of the announcement bar with attached link
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
    And Admin create announcements by api
      | name      | title     | body                     | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title |
      | auto test | Auto test | Auto test announcement 1 | buyer          | Minus1                | Plus1                | podfoods.co | [blank]    |

    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer check announcement is "<status>"
      | title     | description              | link       |
      | Auto test | Auto test announcement 1 | Learn more |
    Examples:
      | role_            | buyer                            | pass      | role  | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing |

  @B_CATALOG_13_2
  Scenario Outline: Check display of the announcement bar with attached link 2
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api
    Then Admin set region of announcements api
      | 26 |
    And Admin create announcements by api
      | name      | title     | body                     | recipient_type | start_delivering_date | stop_delivering_date | link        | link_title  |
      | auto test | Auto test | Auto test announcement 1 | buyer          | Minus1                | Plus1                | podfoods.co | podfoods.co |

    Given <role> open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer check announcement is "<status>"
      | title     | description              | link        |
      | Auto test | Auto test announcement 1 | podfoods.co |
    Examples:
      | role_            | buyer                            | pass      | role  | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing |

  @B_CATALOG_12
  Scenario: Admin delete announcements
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search announcements api
      | q[title] | q[body] | q[recipient_type] | q[start_delivering_date] |
      | [blank]  | [blank] | buyer             | [blank]                  |
    And Admin delete announcements by api

  @B_CATALOG_31
  Scenario Outline: Check the order of all product cards when select any options of the Order by select box
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin set Kailua api
      | use_kailua_api |
#      | false           |
      | true           |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "Auto product"
    And "BUYER" choose filter by "Order by Relevance"
    Examples:
      | role_            | buyer                            | pass      | role       |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer |

  @B_CATALOG_36 @B_CATALOG_70
  Scenario Outline: Check displayed information on the Filters side-bar
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter on left side with:
      | express_only   | state   |
      | <express_only> | Alabama |
    And Buyer filter with tags
      | tag           |
      | Auto Bao Tags |
    And Buyer filter with product qualities
      | qualities    |
      | 100% Natural |
    And Buyer filter with package size
      | packageSize |
      | Bulk        |
    And Check display of filter criteria
      | criteria      |
      | Auto Bao Tags |
      | 100% Natural  |
      | Bulk          |
      | Alabama       |
    And Click on any text "Clear all filters"
    Examples:
      | role_            | buyer                            | pass      | role       | express_only |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | No           |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | [blank]      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | [blank]      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | No           |

  @B_CATALOG_42
  Scenario Outline: Verify the State (Province/Territory) criteria, Verify the Express only criteria
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api1 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api1" of product ""

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter on left side with:
      | express_only   | state   |
      | <express_only> | <state> |
    And Buyer filter with tags
      | tag               |
      | Private SKU tag_1 |
    And Buyer filter with product qualities
      | qualities    |
      | 100% Natural |
    And Buyer filter with package size
      | packageSize |
      | Bulk        |
    And Check display of filter criteria
      | criteria          |
      | Express-Only      |
      | Private SKU tag_1 |
      | 100% Natural      |
      | Bulk              |
      | <state>           |
    And Buyer check product on catalog
      | status   | brand                     | product             | sku  |
      | <status> | Auto random Brand product | random product api1 | 1SKU |
    And Click on any text "Clear all filters"
    Examples:
      | role_            | buyer                            | pass      | role       | express_only | state    | status   |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | Yes          | Illinois | showing  |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | Yes          | Alabama  | not show |

  @B_CATALOG_46 @B_CATALOG_49
  Scenario Outline: Verify the Tags criteria by details
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api1 | create by api |
    And Admin add tag to product "create by api" by api
      | tag_id | tag_name      | expiry_date |
      | 49     | 11111         | Plus1       |
      | 81     | Auto Bao Tags | Plus1       |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api1" of product ""
#    Product2
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api2 | create by api |
    And Admin add tag to product "create by api" by api
      | tag_id | tag_name | expiry_date |
      | 49     | 11111    | Plus1       |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api2" of product ""
      #    Product3
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api3 | create by api |
    And Admin add tag to product "create by api" by api
      | tag_id | tag_name | expiry_date |
      | 49     | 11111    | Plus1       |
    And Info of Region
      | region              | id | state    | availability | casePrice | msrp |
      | Chicagoland Express | 26 | inactive | in_stock     | 1000      | 1000 |
      | Florida Express     | 63 | active   | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api3" of product ""

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with tags
      | tag           |
      | Auto Bao Tags |
    And Check display of filter criteria
      | criteria      |
      | Auto Bao Tags |
    And Buyer check product on catalog
      | status    | brand                     | product             | sku  |
      | <status>  | Auto random Brand product | random product api1 | 1SKU |
      | <status2> | Auto random Brand product | random product api2 | 1SKU |
      | <status2> | Auto random Brand product | random product api3 | 1SKU |
    And Check tags of product on catalog
      | product             | tag           |
      | random product api1 | 11111         |
      | random product api1 | Auto Bao Tags |
    And Buyer filter with tags
      | tag   |
      | 11111 |
    And Check display of filter criteria
      | criteria      |
      | Auto Bao Tags |
      | 11111         |
    And Buyer check product on catalog
      | status    | brand                     | product             | sku  |
      | <status>  | Auto random Brand product | random product api1 | 1SKU |
      | <status2> | Auto random Brand product | random product api2 | 1SKU |
      | <status2> | Auto random Brand product | random product api3 | 1SKU |
    And Check tags of product on catalog
      | product             | tag           |
      | random product api1 | 11111         |
      | random product api1 | Auto Bao Tags |
    And Click on any text "Clear all filters"
    And Buyer filter with tags
      | tag   |
      | 11111 |
    And Check display of filter criteria
      | criteria |
      | 11111    |
    And Buyer check product on catalog
      | status    | brand                     | product             | sku  |
      | <status>  | Auto random Brand product | random product api1 | 1SKU |
      | <status>  | Auto random Brand product | random product api2 | 1SKU |
      | <status2> | Auto random Brand product | random product api3 | 1SKU |
    And Check tags of product on catalog
      | product             | tag           |
      | random product api1 | 11111         |
      | random product api1 | Auto Bao Tags |
      | random product api2 | 11111         |
    Examples:
      | role_            | buyer                            | pass      | role  | express_only | state    | status  | status2  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | Yes          | Illinois | showing | not show |
#      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | Yes          | Alabama  | not show |not show |

  @B_CATALOG_52
  Scenario Outline: Check filter by with SKU tags successfully
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                | brand_id      |
      | random product api5 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api5" of product ""
#    And Admin add tag to SKU "create by api" by api
#      | tag_id | tag_name      | expiry_date |
#      | 81     | Auto Bao Tags | Plus1       |

#    BUG
    Given BAO_ADMIN5 open web admin
    When BAO_ADMIN5 login to web with role Admin
    And BAO_ADMIN5 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | random product api5 | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to detail of product "random product api5"
    And Admin go to SKU detail "sku random api5"
    And with Tags
      | tagName          | expiryDate |
      | Auto Bao Tags    | Plus1      |
      | Public SKU tag_1 | Plus1      |
    And Click Create

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with tags
      | tag              |
      | Auto Bao Tags    |
      | Public SKU tag_1 |
    And Check display of filter criteria
      | criteria         |
      | Auto Bao Tags    |
      | Public SKU tag_1 |
    And Buyer check product on catalog
      | status   | brand                     | product             | sku  |
      | <status> | Auto random Brand product | random product api5 | 1SKU |

    Examples:
      | role_            | buyer                            | pass      | role  | express_only | state    | status  | status2  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | Yes          | Illinois | showing | not show |
#      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | Yes          | Alabama  | not show |not show |

  @B_CATALOG_57
  Scenario: Check display of a new created public Tag when admin creates its successfully
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search tags by api
      | q[any_text]            |
      | Auto tag Buyer catalog |
    And Admin delete tag by api
    And Admin create tag by api
      | name                   | description | permission | tag_target_ids |
      | Auto tag Buyer catalog | description | catalog    | 7              |
    And Admin create tag by api
      | name                    | description | permission | tag_target_ids |
      | Auto tag Buyer catalog2 | description | catalog    | 8              |
    And Admin create tag by api
      | name                    | description | permission | tag_target_ids |
      | Auto tag Buyer catalog3 | description | catalog    | 7              |
      | Auto tag Buyer catalog3 | description | catalog    | 8              |

  @B_CATALOG_57
  Scenario Outline: Check display of a new created public Tag when admin creates its successfully
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with tags
      | tag                     |
      | Auto tag Buyer catalog  |
      | Auto tag Buyer catalog2 |
      | Auto tag Buyer catalog3 |
    And Check display of filter criteria
      | criteria                |
      | Auto tag Buyer catalog  |
      | Auto tag Buyer catalog2 |
      | Auto tag Buyer catalog3 |
    Examples:
      | role_            | buyer                            | pass      | role       |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer |

  @B_CATALOG_58
  Scenario Outline: Check display Product Quality criteria
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin delete product qualities name "Auto qualities Buyer catalog" by api
    And Admin create product qualities by api
      | name                         |
      | Auto qualities Buyer catalog |
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with product qualities
      | qualities                    |
      | Auto qualities Buyer catalog |
    And Check display of filter criteria
      | criteria                     |
      | Auto qualities Buyer catalog |

    And Admin delete product qualities by api
    Examples:
      | role_            | buyer                            | pass      | role       |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer |

  @B_CATALOG_59
  Scenario: Check filter by Product Quality criteria successfully
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin delete product qualities name "Auto qualities Buyer catalog" by api
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api58 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api58" of product ""
    And Admin create product qualities by api
      | name                         |
      | Auto qualities Buyer catalog |
    And Admin update qualities of SKU "create by api" by api
      | id            |
      | create by api |

  @B_CATALOG_59
  Scenario Outline: Check filter by Product Quality criteria successfully
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with product qualities
      | qualities                    |
      | Auto qualities Buyer catalog |
    And Check display of filter criteria
      | criteria                     |
      | Auto qualities Buyer catalog |
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api58 | 1SKU |

    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin delete product qualities name "Auto qualities Buyer catalog" by api
    And BUYER refresh browser
    And Check any text "not" showing on screen
      | Auto qualities Buyer catalog |
    Examples:
      | role_            | buyer                            | pass      | role       | status   |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing  |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | not show |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | not show |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | showing  |

  @B_CATALOG_60
  Scenario: Check filter by multiple Product Quality criteria successfully
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin delete product qualities name "Auto qualities Buyer catalog" by api
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api60 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api60" of product ""
#    Create product qualities
    And Admin create product qualities by api
      | name                         |
      | Auto qualities Buyer catalog |
    #    Update product qualities
    And Admin update qualities of SKU "create by api" by api
      | id            |
      | create by api |

  @B_CATALOG_60
  Scenario Outline: Check filter by multiple Product Quality criteria successfully
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with product qualities
      | qualities                    |
      | 100% Natural                 |
      | Auto qualities Buyer catalog |
    And Check display of filter criteria
      | criteria                     |
      | 100% Natural                 |
      | Auto qualities Buyer catalog |
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api60 | 1SKU |
    And Click on any text "Clear all filters"

#Edit product qualities
    And Admin edit product qualities name "Auto qualities Buyer catalog" by api
      | name                                |
      | Auto qualities Buyer catalog edited |
    And BUYER refresh browser
    And Buyer filter with product qualities
      | qualities                           |
      | Auto qualities Buyer catalog edited |
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api60 | 1SKU |

    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    #    Delete product qualities
    And Admin delete product qualities name "Auto qualities Buyer catalog" by api
    And Admin delete product qualities name "Auto qualities Buyer catalog edited" by api
    And BUYER refresh browser
    And Check any text "not" showing on screen
      | Auto qualities Buyer catalog |
    Examples:
      | role_            | buyer                            | pass      | role       | status   |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing  |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | not show |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | not show |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | showing  |

  @B_CATALOG_64
  Scenario: Check display Packing Size criteria
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin delete product package size name "Auto package size Buyer catalog" by api
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api64 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api64" of product ""
    And Admin create product package size by api
      | name                            |
      | Auto package size Buyer catalog |
    And Admin update package size of product "create by api" by api
      | product[package_size_id] |
      | create by api            |

  @B_CATALOG_64
  Scenario Outline: Check display Packing Size criteria
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with package size
      | packageSize                     |
      | Auto package size Buyer catalog |
    And Check display of filter criteria
      | criteria                        |
      | Auto package size Buyer catalog |
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api64 | 1SKU |

    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin delete product package size name "Auto package size Buyer catalog" by api
    And BUYER refresh browser
    And Check any text "not" showing on screen
      | Auto package size Buyer catalog |
    Examples:
      | role_            | buyer                            | pass      | role       | status   |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing  |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | not show |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | not show |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | showing  |

  @B_CATALOG_65 @B_CATALOG_71
  Scenario: Check filter by multiple Product package size criteria successfully
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin delete product package size name "Auto package size Buyer catalog" by api
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api65 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api65" of product ""
#    Create product package size
    And Admin create product package size by api
      | name                            |
      | Auto package size Buyer catalog |
    #    Update product package size
    And Admin update package size of product "create by api" by api
      | product[package_size_id] |
      | create by api            |
#    package size 2
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api66 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api66" of product ""
#
  @B_CATALOG_65 @B_CATALOG_71
  Scenario Outline: Check filter by multiple Product package size criteria successfully
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer filter with package size
      | packageSize                     |
      | Auto package size Buyer catalog |
    And Check display of filter criteria
      | criteria                        |
      | Auto package size Buyer catalog |
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api65 | 1SKU |
    And Click on any text "Clear all filters"
    And Buyer filter with package size
      | packageSize                     |
      | Auto package size Buyer catalog |
      | Bulk                            |
    And "BUYER" choose filter by "Order by Newest"
    And Check display of filter criteria
      | criteria                        |
      | Auto package size Buyer catalog |
      | Bulk                            |
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api65 | 1SKU |
      | <status> | Auto random Brand product | random product api66 | 1SKU |
    And Click on any text "Clear all filters"

#Edit product package size
    And Admin edit product package size name "Auto package size Buyer catalog" by api
      | name                                   |
      | Auto package size Buyer catalog edited |
    And BUYER refresh browser
    And Buyer filter with package size
      | packageSize                            |
      | Auto package size Buyer catalog edited |
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api65 | 1SKU |
    And Buyer check price per unit of product on catalog
      | status  | product              | price        |
      | <price> | random product api65 | $10.00/ unit |

    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    #    Delete product package size
    And Admin delete product package size name "Auto package size Buyer catalog" by api
    And Admin delete product package size name "Auto package size Buyer catalog edited" by api
    And BUYER refresh browser
    And Check any text "not" showing on screen
      | Auto package size Buyer catalog |
    Examples:
      | role_            | buyer                            | pass      | role       | status   | price    |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing  | showing  |
      | Store sub buyer  | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | not show | not show |
      | Store manager PD | ngoctx+autobuyer60@podfoods.co   | 12345678a | buyer      | not show | not show |
      | Head buyer       | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | showing  | not show |

  @B_CATALOG_73
  Scenario Outline: Check display of master image on the product card when deactivates main SKU (check with normal buyers only)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api73 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api73" of product ""
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 2000      | 2000 |
    And Admin create SKU from admin with name "sku random api74" of product ""

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api73"
#    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price        |
      | <status> | Auto random Brand product | random product api73 | 2SKU | anhJPG2.jpg | $10.00/ unit |
    And Go to detail of product "random product api73" from catalog
    And Buyer check focus SKU on product detail
      | focus  | image       |
      | active | anhJPG2.jpg |
      | next   | anhJPEG.jpg |

#    Update main sku
    And Admin update SKU info "create by api" by api
      | product_variant[position] |
      | 1                         |
    And Buyer check focus SKU on product detail
      | focus  | image       |
      | active | anhJPG2.jpg |
      | next   | anhJPEG.jpg |
    And BUYER refresh browser
    And Buyer check focus SKU on product detail
      | focus  | image       |
      | active | anhJPG2.jpg |
      | next   | anhJPEG.jpg |
    And BUYER go back
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price        |
      | <status> | Auto random Brand product | random product api73 | 2SKU | anhJPEG.jpg | $20.00/ unit |
    And Go to detail of product "random product api73" from catalog
    And Buyer check focus SKU on product detail
      | focus  | image       |
      | next   | anhJPG2.jpg |
      | active | anhJPEG.jpg |
    Examples:
      | role_            | buyer                            | pass      | role  | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing |

  @B_CATALOG_75
  Scenario Outline: Check the display of promotion tag of a product card on the browsing history (check with normal buyers only)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api75 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random api75" of product ""
#Create promotion
    And Admin search promotion by Promotion Name "Auto Promotion buyer catalog"
    And Admin delete promotion by skuName ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                         | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto Promotion buyer catalog | Test API    | currentDate | currentDate | 2           | 3          | 3                | true           | [blank] | default    | [blank]       |
#
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api75"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price        |
      | <status> | Auto random Brand product | random product api75 | 1SKU | anhJPEG.jpg | $10.00/ unit |
    Then Verify promo preview "TPR" of product "random product api75" in "Catalog page"
      | name             | type | price | caseLimit |
      | sku random api75 | TPR  | $5.00 | 3         |

#  //Create promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                         | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion buyer catalog | Test        | currentDate | currentDate | 1           | 3          | 1                | true           | [blank] | default    | currentDate   | false   |

    And BUYER refresh browser
    Then Verify promo preview "Promotions" of product "random product api75" in "Catalog page"
      | name             | type        | price | caseLimit | expiryDate  |
      | sku random api75 | SHORT-DATED | $9.00 | 3         | currentDate |

    And Admin search promotion by Promotion Name "Auto Promotion buyer catalog"
    And Admin delete promotion by skuName ""
    Examples:
      | role_            | buyer                            | pass      | role  | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing |

  @B_CATALOG_77
  Scenario Outline: Check the display of promotion tag of a product card - multiple promotion
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api77 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random api77" of product ""
#Create promotion
    And Admin search promotion by Promotion Name "Auto Promotion buyer catalog"
    And Admin delete promotion by skuName ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                         | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto Promotion buyer catalog | Test API    | currentDate | currentDate | 2           | 3          | 3                | true           | [blank] | default    | [blank]       |

    And Admin create SKU from admin with name "sku random api78" of product ""
    #  //Create promotion 2
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                         | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | Auto Promotion buyer catalog | Test        | currentDate | currentDate | 1           | 3          | 1                | true           | [blank] | default    | currentDate   | false   |

    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api77"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price        |
      | <status> | Auto random Brand product | random product api77 | 2SKU | anhJPEG.jpg | $10.00/ unit |
    Then Verify promo preview "Promotions" of product "random product api77" in "Catalog page"
      | name             | type        | price | caseLimit | expiryDate  | caseMinimum |
      | sku random api77 | TPR         | $5.00 | 3         | [blank]     | 3           |
      | sku random api78 | SHORT-DATED | $9.00 | 3         | currentDate | [blank]     |
    Examples:
      | role_            | buyer                            | pass      | role  | status  |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing |

  @B_CATALOG_74
  Scenario: Check the display of promotion tag of a product card (Buy-in promotion)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api74 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random api74" of product ""
#Create promotion
    And Admin search promotion by Promotion Name "Auto Promotion buyer catalog"
    And Admin delete promotion by skuName ""
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                         | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto Promotion buyer catalog | Test API    | currentDate | currentDate | [blank]     | 3          | 3                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api74"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price        |
      | showing | Auto random Brand product | random product api74 | 1SKU | anhJPEG.jpg | $10.00/ unit |
    Then Verify promo preview "Buy in" of product "random product api74" in "Catalog page"
      | name             | type   | price | caseLimit | caseMinimum |
      | sku random api74 | BUY-IN | $5.00 | 3         | 3           |

#    Setup data
  @B_CATALOG_84 @B_CATALOG_88
  Scenario: Check the display of Express tag of a product card on the browsing history for PD buyers (Store manager+Store sub-buyer)
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api84 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create SKU from admin with name "sku random api84" of product ""

  @B_CATALOG_84 @B_CATALOG_88
  Scenario Outline: Check the display of Express tag of a product card on the browsing history for PD buyers (Store manager+Store sub-buyer)
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api84"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price   | expressTag   |
      | <status> | Auto random Brand product | random product api84 | 1SKU | anhJPEG.jpg | <price> | <expressTag> |
    Examples:
      | role_              | buyer                            | pass      | role       | status  | expressTag | price        |
      | Store manager PE   | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing | show       | $10.00/ unit |
      | Store sub buyer PE | ngoctx+autobuyer61@podfoods.co   | 12345678a | buyer      | showing | show       | $10.00/ unit |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer      | showing | not show   | $10.00/ unit |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | showing | not show   | $10.00/ unit |
      | Head buyer         | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | showing | show       | [blank]      |

    #    Setup data
  @B_CATALOG_86 @B_CATALOG_91
  Scenario: Check the display of Express tag of a product card on the browsing history for PD buyers
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api86 | create by api |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 2216             | Auto_BuyerCompany  | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api86" of product ""

  @B_CATALOG_86 @B_CATALOG_91
  Scenario Outline: Check the display of Express tag of a product card on the browsing history for PD buyers
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api86"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price   | expressTag   |
      | <status> | Auto random Brand product | random product api86 | 1SKU | anhJPG2.jpg | <price> | <expressTag> |
    Examples:
      | role_              | buyer                            | pass      | role  | status  | expressTag | price        |
      | Store manager PE   | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store sub buyer PE | ngoctx+autobuyerbao7@podfoods.co | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer | showing | not show   | $10.00/ unit |

    #    Setup data
  @B_CATALOG_85
  Scenario: Check the display of Express tag of a product card on the browsing history for PD buyers
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api85 | create by api |
    And Info of Store specific
      | store_id | store_name              | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
#      | 1762     | Auto Store PDM          | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api85" of product ""

  @B_CATALOG_85
  Scenario Outline: Check the display of Express tag of a product card on the browsing history for PD buyers 2
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api85"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price   | expressTag   |
      | <status> | Auto random Brand product | random product api85 | 1SKU | anhJPG2.jpg | <price> | <expressTag> |
    Examples:
      | role_              | buyer                            | pass      | role  | status  | expressTag | price        |
      | Store manager PE   | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store sub buyer PE | ngoctx+autobuyerbao7@podfoods.co | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer | showing | not show   | $10.00/ unit |
  #    Setup data
  @B_CATALOG_90
  Scenario: Check the display of Express tag of a product card on the browsing history for PE buyers
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api90 | create by api |
    And Info of Store specific
      | store_id | store_name     | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api90" of product ""

  @B_CATALOG_90
  Scenario Outline: Check the display of Express tag of a product card on the browsing history for PE buyers 2
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api90"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price   | expressTag   |
      | <status> | Auto random Brand product | random product api90 | 1SKU | anhJPG2.jpg | <price> | <expressTag> |
    Examples:
      | role_              | buyer                            | pass      | role  | status  | expressTag | price        |
      | Store manager PE   | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store sub buyer PE | ngoctx+autobuyerbao7@podfoods.co | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer | showing | not show   | $10.00/ unit |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer | showing | not show   | $10.00/ unit |
 #    Setup data
  @B_CATALOG_87 @B_CATALOG_92
  Scenario: Check the display of Express tag of a product card on the browsing history for PD buyers
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api87 | create by api |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Info of Store specific
      | store_id | store_name     | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
      | 2216             | Auto_BuyerCompany  | 58        | currentDate | currentDate | 1000             | 1000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api87" of product ""

  @B_CATALOG_87 @B_CATALOG_92
  Scenario Outline: Check the display of Express tag of a product card on the browsing history for PD buyers 2
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api87"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  | image       | price   | expressTag   |
      | <status> | Auto random Brand product | random product api87 | 1SKU | anhJPG2.jpg | <price> | <expressTag> |
    Examples:
      | role_              | buyer                            | pass      | role       | status  | expressTag | price        |
      | Store manager PE   | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing | not show   | $10.00/ unit |
      | Store sub buyer PE | ngoctx+autobuyerbao7@podfoods.co | 12345678a | buyer      | showing | not show   | $10.00/ unit |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer      | showing | not show   | $10.00/ unit |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | showing | not show   | $10.00/ unit |
      | Head buyer         | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | showing | not show   | [blank]      |

  @B_CATALOG_93
  Scenario: Check the display of Tags of a product card
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api93 | create by api |
    And Admin add tag to product "create by api" by api
      | tag_id | tag_name      | expiry_date |
      | 49     | 11111         | Plus1       |
      | 81     | Auto Bao Tags | Plus1       |
      | 74     | autoPuPT1     | Plus1       |
      | 76     | autoPuPT3     | Plus1       |
      | 77     | autoPuPT4     | Plus1       |
      | 78     | autoPuPT5     | Plus1       |
      | 79     | autoPuPT6     | Plus1       |
      | 80     | autoPuPT7     | Plus1       |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api93" of product ""

  @B_CATALOG_93
  Scenario Outline: Check the display of Tags of a product card
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api93"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                     | product              | sku  |
      | <status> | Auto random Brand product | random product api93 | 1SKU |

    And Check tags of product on catalog
      | product              | tag           |
      | random product api93 | 11111         |
      | random product api93 | Auto Bao Tags |
      | random product api93 | autoPuPT1     |
      | random product api93 | autoPuPT3     |
      | random product api93 | autoPuPT4     |
      | random product api93 | autoPuPT5     |
      | random product api93 | autoPuPT6     |
      | random product api93 | autoPuPT7     |
    Examples:
      | role_              | buyer                            | pass      | role       | status  |
      | Store manager PE   | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer      | showing |
      | Store sub buyer PE | ngoctx+autobuyerbao7@podfoods.co | 12345678a | buyer      | showing |
      | Store manager PD   | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer      | showing |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer      | showing |
      | Head buyer         | ngoctx+autobuyer49@podfoods.co   | 12345678a | head buyer | showing |

  @B_CATALOG_98
  Scenario: Check display of product card when admins draft or deactivate somethings
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search brand name "Auto random Brand product" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                      | description        | micro_description | city    | address_state_id | vendor_company_id |
      | Auto random Brand product | Auto Brand product | [blank]           | [blank] | 33               | 1937              |
    And Create product by api with file "CreateProduct.json" and info
      | name                 | brand_id      |
      | random product api98 | create by api |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api98" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api98"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                     | product              | sku  |
      | showing | Auto random Brand product | random product api98 | 1SKU |
# Inactive sku
    And Change state of SKU id: "sku random api98" to "draft"
#    Go to detail
    And Switch to actor BUYER
    And Go to detail of product "random product api98" from catalog
    And BUYER check page missing
#    Active SKU
    And Change state of SKU id: "sku random api98" to "active"
    And Switch to actor BUYER
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api98"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                     | product              | sku  |
      | showing | Auto random Brand product | random product api98 | 1SKU |
#    Update region to inactive
    And Admin change info of regions attributes of sku "sku random api98" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | inactive |
    And Switch to actor BUYER
    And Go to detail of product "random product api98" from catalog
    And BUYER check page missing
    #    Update region to active
    And Admin change info of regions attributes of sku "sku random api98" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |

    And Switch to actor BUYER
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api98"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                     | product              | sku  |
      | showing | Auto random Brand product | random product api98 | 1SKU |
#    Deactivate product
    And Admin change state of product id "random" to inactive by api
    And Switch to actor BUYER
    And Go to detail of product "random product api98" from catalog
    And BUYER check page missing
#    activate product
    And Admin change state of product id "random" to active by api
    And Change state of SKU id: "sku random api98" to "active"
       #    Update region to active
    And Admin change info of regions attributes of sku "sku random api98" state "active"
      | id      | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | [blank] | 26        | [blank]            | 1000             | 1000       | in_stock     | active |
    And Switch to actor BUYER
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api98"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                     | product              | sku  |
      | showing | Auto random Brand product | random product api98 | 1SKU |
#    Deactivate brand
    And Admin change state of brand "" to "inactive" by API
    And Switch to actor BUYER
    And Go to detail of product "random product api98" from catalog
    And BUYER check page missing

  @B_CATALOG_103
  Scenario: Check display of the Add to cart button when hover on any product card
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search product name "random product api103" by api
    And Admin delete product name "random product api103" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api103 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api103" of product ""
    And Clear Info of Region api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random 2 api103" of product ""

  @B_CATALOG_103 @B_CATALOG_104 @B_CATALOG_119
  Scenario Outline: Check display of the Add to cart button when hover on any product card
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api103"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                  | product               | sku   |
      | <status> | Auto Brand product mov | random product api103 | <sku> |
    And Buyer click add to cart product "random product api103" on popup cart
    And Buyer check items on popup add cart
      | type              | sku                 | product               | caseUnit    | price  | image       | quantity |
      | Pod Direct Items  | sku random 2 api103 | random product api103 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
      | Pod Express Items | sku random api103   | random product api103 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Check dialog button "Add to cart" is "disable"

    Examples:
      | role_            | buyer                            | pass      | role  | status  | sku   |
      | Store manager PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing | 2SKUs |
      | Store manager PD | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer | showing | 1SKU  |

  @B_CATALOG_103
  Scenario Outline: Check display of the Add to cart button when hover on any product card
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api103"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                  | product               | sku   |
      | <status> | Auto Brand product mov | random product api103 | <sku> |
    And Buyer check not show add to cart button of product "random product api103" on catalog

    Examples:
      | role_              | buyer                            | pass      | role  | status  | sku   |
      | Store sub buyer PE | ngoctx+autobuyerbao7@podfoods.co | 12345678a | buyer | showing | 2SKUs |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer | showing | 1SKU  |

  @B_CATALOG_103_1
  Scenario Outline: Check display of the Add to cart button when hover on any product card
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search product name "random product api103" by api
    And Admin delete product name "random product api103" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api103 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api103" of product ""
    And Admin Authorized SKU id "" to Store id "2561"
    And Clear Info of Region api
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random 2 api103" of product ""
    And Admin Authorized SKU id "" to Store id "1762"
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api103"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                  | product               | sku    |
      | <status> | Auto Brand product mov | random product api103 | <sku2> |
    And Buyer click add to cart product "random product api103" on popup cart
    And Buyer check items on popup add cart
      | type   | sku   | product               | caseUnit    | price  | image       | quantity |
      | <type> | <sku> | random product api103 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |
    And Check dialog button "Add to cart" is "disable"

    Examples:
      | role_              | buyer                            | pass      | role  | status  | sku                 | type              | sku2  |
      | Store sub buyer PE | ngoctx+autobuyerbao7@podfoods.co | 12345678a | buyer | showing | sku random api103   | Pod Express Items | 2SKUs |
      | Store sub buyer PD | ngoctx+autobuyer64@podfoods.co   | 12345678a | buyer | showing | sku random 2 api103 | Pod Direct Items  | 1SKU  |

  @B_CATALOG_108_1
  Scenario Outline: Check display of price/case shown for each SKU - PE buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search product name "random product api108" by api
    And Admin delete product name "random product api108" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api108 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
#      | Pod Direct Central  | 58 | active | in_stock     | 2000      | 2000 |
    And Info of Store specific
      | store_id | store_name              | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 3000             | 3000       | in_stock     |
#      | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 3000             | 3000       | in_stock     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 4000             | 4000       | in_stock     |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 4000             | 4000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api108" of product ""
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api108"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price  |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | $30.00 |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price  | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | $30.00 | anhJPG2.jpg | 0        |

    #    Update store specific to inactive
    And Admin change info of store specific of sku "create by api"
      | id            | region_id | store_id | store_name              | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | create by api      | 3000             | 3000       | in_stock     | active | Minus2     | Minus1   |

    And BUYER refresh browser
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price  |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | $40.00 |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price  | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | $40.00 | anhJPG2.jpg | 0        |
    #    Update buyer company  to inactive
    And Admin change info of buyer company specific of sku "create by api"
      | id            | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 26        | active              | 2216             | Auto_BuyerCompany  | create by api      | 4000             | 4000       | in_stock     | active | Minus2     | Minus1   |

    And BUYER refresh browser
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price  |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | $10.00 |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price  | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |

    Examples:
      | role_              | buyer                            | pass      | role  | status  | type              |
      | Store sub buyer PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing | Pod Express Items |

  @B_CATALOG_108_2
  Scenario Outline: Check display of price/case shown for each SKU - PD buyer
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search product name "random product api108" by api
    And Admin delete product name "random product api108" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api108 | 3087     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Info of Store specific
      | store_id | store_name     | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 3000             | 3000       | in_stock     |
      | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 3000             | 3000       | in_stock     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 4000             | 4000       | in_stock     |
#      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 4000             | 4000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api108" of product ""
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api108"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price  |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | $30.00 |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price  | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | $30.00 | anhJPG2.jpg | 0        |

    #    Update store specific to inactive
    And Admin change info of store specific of sku "create by api"
      | id            | region_id | store_id | store_name     | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 58        | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | create by api      | 3000             | 3000       | in_stock     | active | Minus2     | Minus1   |

    And BUYER refresh browser
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price  |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | $40.00 |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price  | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | $40.00 | anhJPG2.jpg | 0        |
    #    Update buyer company  to inactive
    And Admin change info of buyer company specific of sku "create by api"
      | id            | region_id | buyer_company_state | buyer_company_id | buyer_company_name | product_variant_id | case_price_cents | msrp_cents | availability | state  | start_date | end_date |
      | create by api | 58        | active              | 1664             | Tra Midwest 05     | create by api      | 4000             | 4000       | in_stock     | active | Minus2     | Minus1   |

    And BUYER refresh browser
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price  |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | $10.00 |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price  | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | $10.00 | anhJPG2.jpg | 0        |

    Examples:
      | role_              | buyer                          | pass      | role  | status  | type             |
      | Store sub buyer PD | ngoctx+autobuyer63@podfoods.co | 12345678a | buyer | showing | Pod Direct Items |

  @B_CATALOG_108
  Scenario Outline: Check display of price/case shown for each SKU
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search product name "random product api108" by api
    And Admin delete product name "random product api108" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api108 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 2000      | 2000 |
#    And Info of Store specific
#      | store_id | store_name     | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
##      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 3000             | 3000       | in_stock     |
#      | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 3000             | 3000       | in_stock     |
#    And Info of Buyer company specific
#      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
#      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 4000             | 4000       | in_stock     |
##      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 4000             | 4000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api108" of product ""
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api108"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price   |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | <price> |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price   | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | <price> | anhJPG2.jpg | 0        |

    Examples:
      | role_              | buyer                            | pass      | role  | status  | type              | price  |
      | Store sub buyer PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing | Pod Express Items | $10.00 |
      | Store sub buyer PD | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer | showing | Pod Direct Items  | $20.00 |

  @B_CATALOG_108_3
  Scenario Outline: Check display of price/case shown for each SKU
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search product name "random product api108" by api
    And Admin delete product name "random product api108" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api108 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
      | Pod Direct Central  | 58 | active | in_stock     | 2000      | 2000 |
#    And Info of Store specific
#      | store_id | store_name     | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
##      | 2561     | Auto Bao Store Express1 | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 3000             | 3000       | in_stock     |
#      | 1762     | Auto Store PDM | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 3000             | 3000       | in_stock     |
    And Info of Buyer company specific
      | buyer_company_id | buyer_company_name | region_id | start_date  | end_date    | case_price_cents | msrp_cents | availability |
      | 1664             | Tra Midwest 05     | 58        | currentDate | currentDate | 3000             | 3000       | in_stock     |
      | 1664             | Tra Midwest 05     | 26        | currentDate | currentDate | 5000             | 5000       | in_stock     |
      | 2216             | Auto_BuyerCompany  | 26        | currentDate | currentDate | 4000             | 4000       | in_stock     |
      | 2216             | Auto_BuyerCompany  | 58        | currentDate | currentDate | 6000             | 6000       | in_stock     |
    And Admin create a "active" SKU from admin with name "sku random api108" of product ""
    Given BUYER open web user
    When login to beta web with email "<buyer>" pass "<pass>" role "<role>"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api108"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status   | brand                  | product               | sku  | price   |
      | <status> | Auto Brand product mov | random product api108 | 1SKU | <price> |
    And Buyer click add to cart product "random product api108" on popup cart
    And Buyer check items on popup add cart
      | type   | sku               | product               | caseUnit    | price   | image       | quantity |
      | <type> | sku random api108 | random product api108 | 1 unit/case | <price> | anhJPG2.jpg | 0        |

    Examples:
      | role_          | buyer                            | pass      | role  | status  | type              | price  |
      | Store buyer PE | ngoctx+autobuyerbao5@podfoods.co | 12345678a | buyer | showing | Pod Express Items | $40.00 |
      | Store buyer PD | ngoctx+autobuyer63@podfoods.co   | 12345678a | buyer | showing | Pod Direct Items  | $60.00 |

  @B_CATALOG_110 @B_CATALOG_146 @B_CATALOG_147
  Scenario: Check display of promotion tag shown for each SKU - TPR, Short dated
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin search product name "random product api110" by api
    And Admin delete product name "random product api110" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api110 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api110" of product ""
#Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2561      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                         | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto Promotion Buyer Catalog | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api110"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api110 | 1SKU | $10.00 |
    Then Verify promo preview "Short dated" of product "random product api110" in "Product page"
      | name              | type        | price | caseLimit | oldPrice |
      | sku random api110 | SHORT-DATED | $5.00 | 1         | $10.00   |
    And Buyer click add to cart product "random product api110" on popup cart
    Then Verify promo preview "Short dated" of sku "sku random api110" is "show" on add cart popup
      | name              | type        | price | caseLimit | expiryDate  |
      | sku random api110 | Short-dated | $5.00 | 1         | currentDate |
    And Buyer check items on popup add cart
      | type              | sku               | product               | caseUnit    | price | image       | quantity |
      | Pod Express Items | sku random api110 | random product api110 | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2561      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                           | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion 2 Buyer Catalog | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |

    And Switch to actor BUYER
    And BUYER refresh browser
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api110 | 1SKU | $10.00 |
    Then Verify promo preview "Promotions" of product "random product api110" in "Product page"
      | name              | type | price | caseLimit | oldPrice |
      | sku random api110 | TPR  | $5.00 | 1         | $10.00   |
    And Buyer click add to cart product "random product api110" on popup cart
    Then Verify promo preview "TPR" of sku "sku random api110" is "show" on add cart popup
      | name              | type | price | caseLimit |
      | sku random api110 | TPR  | $5.00 | 1         |
    And Buyer check items on popup add cart
      | type              | sku               | product               | caseUnit    | price | image       | quantity |
      | Pod Express Items | sku random api110 | random product api110 | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |

    And Admin search promotion by Promotion Name "Auto Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Switch to actor BUYER
    And BUYER refresh browser
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api110 | 1SKU | $10.00 |
    Then Verify promo preview "Promotions" of product "random product api110" in "Product page"
      | name              | type | price | caseLimit | oldPrice |
      | sku random api110 | TPR  | $5.00 | 1         | $10.00   |
    And Buyer click add to cart product "random product api110" on popup cart
    Then Verify promo preview "TPR" of sku "sku random api110" is "show" on add cart popup
      | name              | type | price | caseLimit |
      | sku random api110 | TPR  | $5.00 | 1         |
    And Buyer check items on popup add cart
      | type              | sku               | product               | caseUnit    | price | image       | quantity |
      | Pod Express Items | sku random api110 | random product api110 | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |

  @B_CATALOG_112 @B_CATALOG_145
  Scenario: Check display of promotion tag shown for each SKU - Buy in
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Buy in Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin search product name "random product api112" by api
    And Admin delete product name "random product api112" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api112 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api112" of product ""
#Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                                | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto Buy in Promotion Buyer Catalog | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api112"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api112 | 1SKU | $10.00 |
    Then Verify promo preview "Buy in" of product "random product api112" in "Product page"
      | name              | type   | price | caseLimit | oldPrice |
      | sku random api112 | BUY-IN | $5.00 | 1         | $10.00   |
    And Buyer click add to cart product "random product api112" on popup cart
    Then Verify promo preview "Buy in" of sku "sku random api112" is "show" on add cart popup
      | name              | type   | price | caseLimit | expiryDate  |
      | sku random api112 | Buy-in | $5.00 | 1         | currentDate |
    And Buyer check items on popup add cart
      | type              | sku               | product               | caseUnit    | price | image       | quantity |
      | Pod Express Items | sku random api112 | random product api112 | 1 unit/case | $5.00 | anhJPG2.jpg | 0        |
    And Admin search promotion by Promotion Name "Auto Buy in Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""

  @B_CATALOG_115 @B_CATALOG_148
  Scenario: Check prioritizing store-specific promotions over region-specific promotions
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    Then Admin search promotion by Promotion Name "Auto Buy in Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin search product name "random product api115" by api
    And Admin delete product name "random product api115" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api115 | 3087     |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api115" of product ""
#Create promotion
    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type              | name                                | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::BuyIn | Auto Buy in Promotion Buyer Catalog | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       |

    And Admin add region by API
      | region              | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | random | 2561      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion TPR Buyer Catalog | Test API    | currentDate | currentDate | [blank]     | 1          | 1                | true           | [blank] | default    | [blank]       | false   |
#
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "buyer"
    And Buyer go to "Catalog" from menu bar
    And Buyer Search product by name "random product api115"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api115 | 1SKU | $10.00 |
    Then Verify promo preview "Promotions" of product "random product api115" in "Product page"
      | name              | type | price | caseLimit | oldPrice |
      | sku random api115 | TPR  | $8.00 | 1         | $10.00   |
    And Buyer click add to cart product "random product api115" on popup cart
    Then Verify promo preview "TPR" of sku "sku random api115" is "show" on add cart popup
      | name              | type | price | caseLimit |
      | sku random api115 | TPR  | $8.00 | 1         |
    And Buyer check items on popup add cart
      | type              | sku               | product               | caseUnit    | price | image       | quantity |
      | Pod Express Items | sku random api115 | random product api115 | 1 unit/case | $8.00 | anhJPG2.jpg | 0        |
    And Admin search promotion by Promotion Name "Auto Buy in Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion Buyer Catalog"
    And Admin delete promotion by skuName ""

  @B_CATALOG_120
  Scenario: Check when Buyer enter quantity and Add to cart with a product is applied MOV system
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
     # Change mov value
    And Admin change info of regions mov attributes with vendorID "1936"
      | id    | region_id | region_name        | region_type     | mov_cents | mov_currency |
      | 15924 | 58        | Pod Direct Central | Regions::Direct | 50000     | USD          |

    And Admin search product name "random product api120" by api
    And Admin delete product name "random product api120" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api120 | 3087     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api120" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Buyer Search product by name "random product api120"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api120 | 1SKU | $10.00 |
    And Buyer click add to cart product "random product api120" on popup cart
    And Buyer choose items an add cart product from popup
      | product               | sku               | amount |
      | random product api120 | sku random api120 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Add cart from product detail
      | product               | sku               |amount |
      | random product api120 | sku random api120 |1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Close popup add cart
    And Buyer click add to cart product "random product api120" on popup cart
    And Buyer choose items an add cart product from popup
      | product               | sku               | amount |
      | random product api120 | sku random api120 | 50     |
    And Verify item on cart tab on right side
      | brand                  | product               | sku               | price  | quantity |
      | Auto brand product mov | random product api120 | sku random api120 | $10.00 | 50       |
    And Clear cart to empty in cart before

  @B_CATALOG_122 @B_CATALOG_134 @B_CATALOG_135
  Scenario: Check when Buyer enter quantity and Add to cart with a product is applied MOV system - have promotion
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion 122 Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin search product name "random product api122" by api
    And Admin delete product name "random product api122" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api122 | 3087     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api122" of product ""
#Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 1762      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto Promotion 122 Buyer Catalog | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer63@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Buyer Search product by name "random product api122"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api122 | 1SKU | $10.00 |
    And Buyer click add to cart product "random product api122" on popup cart
    And Buyer choose items an add cart product from popup
      | product               | sku               | amount |
      | random product api122 | sku random api122 | 1      |
    And BUYER check dialog message
      | SKUs with short-dated promotions are not guaranteed sales and there are no refunds for expiration of these items |
    And Click on dialog button "I understand"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Close popup add cart
    And Buyer click add to cart product "random product api122" on popup cart
    And Buyer choose items an add cart product from popup
      | product               | sku               | amount |
      | random product api122 | sku random api122 | 50     |
    And Buyer change quantity of sku by button in before cart
      | skuID   | sku               | increase | decrease |
      | [blank] | sku random api122 | [blank]  | 1        |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $5.00   |
    And Close popup add cart
    And Buyer click add to cart product "random product api122" on popup cart
    And Buyer choose items an add cart product from popup
      | product               | sku               | amount |
      | random product api122 | sku random api122 | 51     |
    And BUYER check dialog message
      | SKUs with short-dated promotions are not guaranteed sales and there are no refunds for expiration of these items |
    And Click on dialog button "I understand"
    And Verify item on cart tab on right side
      | brand                  | product               | sku               | price | quantity | total   |
      | Auto Brand product mov | random product api122 | sku random api122 | $9.90 | 51       | $505.00 |
    And Buyer change quantity of sku by button in before cart
      | skuID   | sku               | increase | decrease |
      | [blank] | sku random api122 | [blank]  | 1        |
    And Buyer verify mov alert in catalog
      | title                           | brand                  | current | target      | description                                                                         |
      | Minimum order value is not met. | Auto Brand product mov | $495.00 | $500.00 MOV | Your order may not be fulfilled by the brand if the Minimum Order Value is not met. |
    And Clear cart to empty in cart before
    And Add cart from product detail
      | product               | sku               |amount |
      | random product api122 | sku random api122 |1      |
    And BUYER check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
    And Click on dialog button "I understand"
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $495.00 |
    And Close popup add cart

  @B_CATALOG_125
  Scenario: Check when Buyer enter quantity and Add to cart with a product is applied MOQ system
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add cart from product detail
      | product                      | sku                      |amount |
      | Auto product add to cart moq | Auto SKU add to cart moq |1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 7      |
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before
#    Check not met moq
    And Add to cart product "Auto product add to cart moq" sku "Auto SKU add to cart moq" and quantity "7" from product list
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Close popup add cart
    And Clear cart to empty in cart before

  @B_CATALOG_126
  Scenario: Check when Buyer enter quantity and Add to cart with a product is applied MOQ system 2
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion 126 Buyer Catalog"
    And Admin delete promotion by skuName ""
#Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 31025 | 2724      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.5         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::ShortDate | Auto Promotion 126 Buyer Catalog | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | currentDate   |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer43@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 1      |
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Add cart from product detail
      | product                      | sku                      |amount |
      | Auto product add to cart moq | Auto SKU add to cart moq |1      |
    And BUYER check dialog message
      | This product is not a guaranteed sale and there are no refunds for expiration of this item. |
    And Click on dialog button "I understand"
    And Check MOQ not met
      | message                                                                                                                                              | counter |
      | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! | 6 cases |
    And Close popup add cart
    And Search and check moq when add cart product from popup
      | product                      | sku                      | amount |
      | Auto product add to cart moq | Auto SKU add to cart moq | 7      |
    And Click on dialog button "Add to cart"
    And BUYER check dialog message
      | SKUs with short-dated promotions are not guaranteed sales and there are no refunds for expiration of these items |
    And Click on dialog button "I understand"
    And Check MOQ not met
      | message | counter |
      | [blank] | [blank] |
    And Verify item on cart tab on right side
      | brand                      | product                      | sku                      | price | quantity | total  | moq |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU add to cart moq | $9.29 | 7        | $65.00 | 7   |
    And Buyer change quantity of sku by button in before cart
      | skuID   | sku                      | increase | decrease |
      | [blank] | Auto SKU add to cart moq | [blank]  | 1        |
    And Verify item on cart tab on right side
      | brand                      | product                      | sku                      | price | quantity | total  | moq |
      | Auto brand add to cart moq | Auto product add to cart moq | Auto SKU add to cart moq | $9.17 | 6        | $55.00 | 7   |
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ alert on cart page
      | alert | notice | moq |
      | true  | true   | 7   |
    And Buyer go to "Catalog" from menu bar
    And Clear cart to empty in cart before
#    Delete promotion
    And Admin search promotion by Promotion Name "Auto Promotion 126 Buyer Catalog"
    And Admin delete promotion by skuName ""

  @B_CATALOG_139
  Scenario: Check display condition of the items in the Pod Direct Items list
    Given BAO_ADMIN login web admin by api
      | email            | password  |
      | bao6@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion 139 Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin search product name "random product api139" by api
    And Admin delete product name "random product api139" by api
    And Create product by api with file "CreateProduct.json" and info
      | name                  | brand_id |
      | random product api139 | 3087     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random api139" of product ""
    And Create product by api with file "CreateProduct.json" and info
      | name                    | brand_id |
      | random product 2 api139 | 3087     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 2000      | 2000 |
    And Admin create a "active" SKU from admin with name "sku random 2 api139" of product ""

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer63@podfoods.co" pass "12345678a" role "Buyer"
    And Clear cart to empty in cart before
    And Buyer Search product by name "random product api139"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                  | product               | sku  | price  |
      | showing | Auto Brand product mov | random product api139 | 1SKU | $10.00 |
    And Buyer click add to cart product "random product api139" on popup cart
    And Buyer choose items an add cart product from popup
      | product               | sku               | amount |
      | random product api139 | sku random api139 | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $490.00 |
    And Buyer check items on popup add cart not met MOV
      | type             | sku                 | product                 | caseUnit    | price  | image       | quantity |
      | Pod Direct Items | sku random api139   | random product api139   | 1 unit/case | $10.00 | anhJPG2.jpg | 1        |
      | Pod Direct Items | sku random 2 api139 | random product 2 api139 | 1 unit/case | $20.00 | anhJPG2.jpg | 0        |

  @B_CATALOG_117
  Scenario: Check the display of promotion tag when usage limit of promotion is used up
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto TPR sample Promotion"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer catalog 150 api" by api
    And Admin search product name "random product buyer catalog 150 api" by api
    And Admin delete product name "random product buyer catalog 150 api" by api
    And Admin change state of brand "3208" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer catalog 150 api | 3208     |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Florida Express | 63 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku catalog 150 api" of product ""
    And Admin add region by API
      | region          | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | FLorida Express | 63        | random | 2859      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                      | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | Auto TPR sample Promotion | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer62@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer Search product by name "random product buyer catalog 150 api"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                   | product                              | sku  | price  |
      | showing | Auto Bao Brand sample 1 | random product buyer catalog 150 api | 1SKU | $10.00 |
    Then Verify promo preview "TPR" of product "random product buyer catalog 150 api" in "Product page"
      | name                                 | type | price | caseLimit | oldPrice |
      | sku random buyer sku catalog 150 api | TPR  | $8.00 | 1         | $10.00   |

#  Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api63    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3387     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |

    And BUYER refresh browser
    And Verify tag "TPR" promotion is "not show" on product "random product buyer catalog 150 api"

    And Admin search promotion by Promotion Name "Auto TPR sample Promotion"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer catalog 150 api" by api
    And Admin search product name "random product buyer catalog 150 api" by api
    And Admin delete product name "random product buyer catalog 150 api" by api

  @B_CATALOG_150
  Scenario: Check the display of promotion tag when usage limit of promotion is used up - MOV alert
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao3@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "Auto Promotion TPR Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer catalog 150 api" by api
    And Admin search product name "random product buyer catalog 150 api" by api
    And Admin delete product name "random product buyer catalog 150 api" by api
    And Admin change state of brand "3208" to "active" by API
    And Create product by api with file "CreateProduct.json" and info
      | name                                 | brand_id |
      | random product buyer catalog 150 api | 3087     |
    And Info of Region
      | region             | id | state  | availability | casePrice | msrp |
      | Pod Direct Central | 58 | active | in_stock     | 1000      | 1000 |
    And Admin create a "active" SKU from admin with name "sku random buyer sku catalog 150 api" of product ""
#Create promotion
    And Admin add region by API
      | region             | region_id | idSKU  | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | random | 1762      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                             | description | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | Auto Promotion TPR Buyer Catalog | Test API    | currentDate | currentDate | 1           | 1          | 1                | true           | [blank] | default    | [blank]       | false   |
#
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer63@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer Search product by name "random product buyer catalog 150 api"
    And "BUYER" choose filter by "Order by Newest"
    And Buyer check product on catalog
      | status  | brand                  | product                              | sku  | price  |
      | showing | Auto Brand product mov | random product buyer catalog 150 api | 1SKU | $10.00 |
    Then Verify promo preview "TPR" of product "random product buyer catalog 150 api" in "Product page"
      | name                                 | type | price | caseLimit | oldPrice |
      | sku random buyer sku catalog 150 api | TPR  | $8.00 | 1         | $10.00   |
    And Buyer click add to cart product "random product buyer catalog 150 api" on popup cart
    And Buyer choose items an add cart product from popup
      | product                              | sku                                  | amount |
      | random product buyer catalog 150 api | sku random buyer sku catalog 150 api | 1      |
    And Check MOV not met
      | message                                                                                                                                                              | counter |
      | Please add more cases to any SKU below to meet the minimum order value required. Your order may not be fulfilled by the brand if the Minimum Order Value is not met. | $492.00 |
    Then Verify promo preview "TPR" of sku "sku random buyer sku catalog 150 api" is "show" on add cart popup have met MOV
      | name                                 | type | price | caseLimit |
      | sku random buyer sku catalog 150 api | TPR  | $8.00 | 1         |
#  Admin create order
    And Admin create line items attributes by API
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | create by api58    | create by api      | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1            | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3388     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 455 Madison Avenue | New York | 33               | 10022 | true          | [blank]    | [blank]            | [blank]            |
#
    And BUYER refresh browser
    And Verify tag "TPR" promotion is "not show" on product "random product buyer catalog 150 api"

    And Admin search promotion by Promotion Name "Auto Promotion TPR Buyer Catalog"
    And Admin delete promotion by skuName ""
    And Admin delete order by sku of product "random product buyer catalog 150 api" by api
    And Admin search product name "random product buyer catalog 150 api" by api
    And Admin delete product name "random product buyer catalog 150 api" by api

  @B_CATALOG_180
  Scenario: Check the Refer a Brand button
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName  | email           | contact | currentBrand |
      | Auto brand | bao@podfoods.co | contact | false        |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |
    And BUYER check dialog message
      | success@podfoods.co |
    And Click on dialog button "Continue shopping"

  @B_CATALOG_182
  Scenario: Check a new brand block on theBrand Referral form
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName  | email              | contact | currentBrand |
      | Auto brand | bao@podfoods.co    | contact | true         |
      | Auto brand | ngoctx@podfoods.co | contact | false        |
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |
    And BUYER check dialog message
      | success@podfoods.co |
    And Click on dialog button "Continue shopping"

  @B_CATALOG_183
  Scenario: Check validation of each field on each brand block on theBrand Referral form
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName | email   | contact | currentBrand |
      | [blank]   | [blank] | [blank] | [blank]      |
    And Click on button "Invite"
    And Admin check message showing of field
      | field      | message                         |
      | Brand name | Please enter a valid brand name |
    And Buyer enter Refer Brand info
      | brandName                                                                                                                                                                                                                                                         | email   | contact | currentBrand |
      | A character can be any letter, number, punctuation, special character, or space. Each of these characters takes up one byte of space in a computer's memory. Some Unicode characters, like emojis and some letters in non-Latin alphabet. 1245678901234567891234a | [blank] | [blank] | [blank]      |
    And Click on button "Invite"
    And BUYER check alert message
      | Referral brand items name is too long (maximum is 256 characters) |

  @B_CATALOG_188
  Scenario: Check the Delete button Brand Referral form
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Buyer go to "Refer a Brand" from menu bar
    And Check Refer Brand Page
    And Buyer enter Refer Brand info
      | brandName | email   | contact | currentBrand |
      | a         | [blank] | [blank] | [blank]      |
      | b         | [blank] | [blank] | [blank]      |
      | c         | [blank] | [blank] | [blank]      |
    And Buyer delete Refer Brand number 3
    And Click on button "Invite"
    And BUYER check dialog message
      | Thank you! |
    And BUYER check dialog message
      | Your form has been submitted. Brands will be invited to Pod Foods by email. Our team will also reach out promptly. Have questions? Email |
    And BUYER check dialog message
      | success@podfoods.co |
    And Click on dialog button "Continue shopping"

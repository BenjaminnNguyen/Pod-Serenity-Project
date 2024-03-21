#mvn clean verify -Dtestsuite="BuyerClaimsTestSuite" -Dcucumber.options="src/test/resources/features/buyer/claims"
@feature=BuyerClaims
Feature: Buyer Claims

  Narrative:
  Auto test claims

  @BuyerClaims_01 @BuyerClaims
  Scenario: Guest verify search and filter
    Given GUEST open web guest claim
    When Guest verify info default of claim page
    And Guest verify info blank field of claim page

  @BuyerClaims_02 @BuyerClaims
  Scenario: Guest verify picture field - file upload > 10MB
    Given GUEST open web guest claim
    When Guest verify info default of claim page
    And Guest fill info to claim of invoice
      | company | email                    | invoice  | issues  | affectedProduct | description |
      | guest   | companyGuest@podfoods.co | 12345790 | Damaged | abc             | [blank]     |
    And Guest upload file to claim
      | picture           |
      | samplepdf10mb.pdf |
    And Buyer finish form claim with message error "Claim documents attachment can't be blank"

  @BuyerClaims_02a @BuyerClaims
  Scenario: Guest verify upload multi picture field
    Given GUEST open web guest claim
    When Guest verify info default of claim page
    And Guest fill info to claim of invoice
      | company | email                    | invoice  | issues  | affectedProduct | description |
      | guest   | companyGuest@podfoods.co | 12345790 | Damaged | abc             | [blank]     |
    And Guest upload file to claim
      | picture   |
      | claim.jpg |
      | claim.jpg |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."

  @BuyerClaims_03 @BuyerClaims
  Scenario: Guest verify picture field - file upload invalid
    Given GUEST open web guest claim
    When Guest verify info default of claim page
    And Guest fill info to claim of invoice
      | company | email                    | invoice  | issues  | affectedProduct | description |
      | guest   | companyGuest@podfoods.co | 12345790 | Damaged | abc             | [blank]     |
    And Guest upload file to claim
      | picture          |
      | ImageInvalid.mp4 |
    And Guest verify message error "Invalid file type"

  @BuyerClaims_05 @BuyerClaims
  Scenario: Buyer submit claim success
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1301@podfoods.co | 12345678a |
      # Active buyer
    And Admin active buyer "3334" to activate by API

    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+stclaimny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 33816 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stclaimny01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page
    Then Buyer verify info default of claim page
      | company        | email                          | invoice |
      | ngoctx stclaim | ngoctx+stclaimny01@podfoods.co | [blank] |
    And Buyer fill info to claim of invoice "create by api"
      | issues  | description |
      | Damaged | Autotest    |
    And Guest upload file to claim
      | picture   |
      | claim.jpg |
      | claim.jpg |
    And Buyer check sku in affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 01 | 1        |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."
    And Buyer submit another claim by button here
    Then Buyer verify info default of claim page
      | company        | email                          | invoice |
      | ngoctx stclaim | ngoctx+stclaimny01@podfoods.co | [blank] |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1301@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    # verify search sub invoice
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status  | claimNumber | startDate | endDate | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny01 | create by api | Open   | Damaged |

  @BuyerClaims_06 @BuyerClaims
  Scenario: Buyer submit claim when admin inactive buyer
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1302@podfoods.co | 12345678a |
     # active store
    And Admin change state of store "3626" to "active"
       # Active buyer
    And Admin active buyer "3820" to activate by API

     # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 100 | 63663              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+stclaimny16@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 63663 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Active buyer
    Given NGOCTX login web admin by api
      | email                | password  |
      | ngoctx13@podfoods.co | 12345678a |
    And Admin active buyer "3804" to activate by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stclaimny16@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page by url
    Then Buyer verify info default of claim page
      | company        | email                          | invoice |
      | ngoctx stclaim | ngoctx+stclaimny16@podfoods.co | [blank] |
    And Buyer verify field invoice in claim form
    And Click on button "Submit"
    And BUYER check alert message
      | Please correct the errors on this form before continuing. |
    And Buyer fill info to claim of invoice "create by api"
      | issues  | description |
      | Damaged | Autotest    |
    And Guest upload file to claim
      | picture   |
      | claim.jpg |
    And Buyer check sku in affected products in claim form
      | sku              | quantity |
      | AT SKU Claim 100 | 1        |
    # Inactive buyer
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1302@podfoods.co | 12345678a |
    And Admin change state of store "3626" to "inactive"

    And Switch to actor BUYER
    And Buyer finish form claim when store inactive

  @BuyerClaims_07 @BuyerClaims
  Scenario: Buyer verify of Invoice field when admin delete order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1303@podfoods.co | 12345678a |

     # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 101 | 63664              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+stclaimny07@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 63664 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stclaimny07@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page by url
    Then Buyer verify info default of claim page
      | company        | email                          | invoice |
      | ngoctx stclaim | ngoctx+stclaimny07@podfoods.co | [blank] |
    And Buyer verify field invoice in claim form
    And Click on button "Submit"
    And BUYER check alert message
      | Please correct the errors on this form before continuing. |
    And Buyer fill info to claim of invoice "create by api"
      | issues   | description |
      | Shortage | Autotest    |
    And Buyer check sku in affected products in claim form
      | sku              | quantity |
      | AT SKU Claim 101 | 1        |
    # Delete order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1303@podfoods.co | 12345678a |
    When Search order by sku "63664" by api
    And Admin delete order of sku "" by api

    And Switch to actor BUYER
    And Click on button "Submit"
    And BUYER check alert message
      | Sub invoice can't be blank |

  @BuyerClaims_08 @BuyerClaims
  Scenario: Buyer verify of Invoice field when admin delete order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1304@podfoods.co | 12345678a |

    # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 102 | 63665              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+stclaimny08@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 63665 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stclaimny08@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page by url
    Then Buyer verify info default of claim page
      | company        | email                          | invoice |
      | ngoctx stclaim | ngoctx+stclaimny08@podfoods.co | [blank] |
    And Buyer verify field invoice in claim form
    And Click on button "Submit"
    And BUYER check alert message
      | Please correct the errors on this form before continuing. |
    And Buyer fill info to claim of invoice "create by api"
      | issues   | description |
      | Shortage | Autotest    |
    And Buyer check sku in affected products in claim form
      | sku              | quantity |
      | AT SKU Claim 102 | 1        |
    # Delete order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1304@podfoods.co | 12345678a |
    When Search order by sku "63665" by api
    And Admin delete order of sku "" by api

    And Switch to actor BUYER
    And Click on button "Submit"
    And BUYER check alert message
      | Sub invoice can't be blank |

  @BuyerClaims_09 @Claim
  Scenario: Buyer verify of Affected Products field - multi sku
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1305@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 02 | 39194              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+stclaimny09@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 33816 | 1        |
      | 7903      | 39194 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stclaimny09@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page by url
    Then Buyer verify info default of claim page
      | company        | email                          | invoice |
      | ngoctx stclaim | ngoctx+stclaimny09@podfoods.co | [blank] |
    And Buyer verify field invoice in claim form
    And Buyer fill info to claim of invoice "create by api"
      | issues   | description |
      | Shortage | [blank]     |
    And Buyer check sku in affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 02 | 2        |
      | AT SKU Claim 01 | 2        |
    And Buyer verify affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 02 | 1        |
      | AT SKU Claim 01 | 1        |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."

  @BuyerClaims_10 @BuyerClaims
  Scenario: Head buyer claim form
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1306@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                           | password  |
      | ngoctx+stbclaimny02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 33816 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+hclaimny02@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page
    Then Head buyer verify info default of claim page
      | email                         |
      | ngoctx+hclaimny02@podfoods.co |
    # Verify blank field
    And Head buyer verify info blank field of claim page
    And Head buyer verify field store in claim form
    And Head buyer fill info to claim of invoice "create by api"
      | store               | email                         | issues  | picture   | description |
      | ngoctx stclaim1ny01 | ngoctx+hclaimny02@podfoods.co | Damaged | claim.jpg | Autotest    |
    And Buyer check sku in affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 01 | 1        |
#   # Inactive buyer company
#    Given NGOCTX login web admin by api
#      | email                | password  |
#      | ngoctx1306@podfoods.co | 12345678a |
#    And Admin change state of buyer company "2543" to "inactive" by API
#
#    And Switch to actor HEAD_BUYER
#    And Buyer finish form claim when store inactive

  @BuyerClaims_11 @BuyerClaims
  Scenario: Head buyer verify of Invoice field when admin delete order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1307@podfoods.co | 12345678a |

      # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 103 | 63666              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                           | password  |
      | ngoctx+stbclaimny03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 63666 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+hclaimny02@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page by url
    Then Head buyer verify info default of claim page
      | email                         |
      | ngoctx+hclaimny02@podfoods.co |
    And Head buyer verify field invoice in claim form
      | store               |
      | ngoctx stclaim1ny01 |
    And Click on button "Submit"
    And HEAD_BUYER check alert message
      | Please correct the errors on this form before continuing. |

    And Head buyer fill info to claim of invoice "create by api"
      | store               | email                         | issues  | picture   | description |
      | ngoctx stclaim1ny01 | ngoctx+hclaimny02@podfoods.co | Damaged | claim.jpg | Autotest    |
    And Buyer check sku in affected products in claim form
      | sku              | quantity |
      | AT SKU Claim 103 | 1        |
    # Delete order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1307@podfoods.co | 12345678a |
    When Search order by sku "63666" by api
    And Admin delete order of sku "" by api

    And Switch to actor HEAD_BUYER
    And Click on button "Submit"
    And BUYER check alert message
      | Sub invoice can't be blank |

  @BuyerClaims_12 @BuyerClaims
  Scenario: Head buyer verify picture field
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1308@podfoods.co | 12345678a |

      # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                           | password  |
      | ngoctx+stbclaimny04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 33816 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+hclaimny02@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page by url
    Then Head buyer verify info default of claim page
      | email                         |
      | ngoctx+hclaimny02@podfoods.co |
    And Head buyer fill info to claim of invoice "create by api"
      | store               | email                         | issues  | description |
      | ngoctx stclaim1ny01 | ngoctx+hclaimny02@podfoods.co | Damaged | Autotest    |
    And Guest upload file to claim
      | picture           |
      | samplepdf10mb.pdf |
    And Buyer check sku in affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 01 | 1        |
    And Buyer finish form claim with message error "Claim documents attachment can't be blank"

  @BuyerClaims_13 @Claim
  Scenario: Head buyer verify of Affected Products field - multi sku
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1309@podfoods.co | 12345678a |

      # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
    # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 02 | 39194              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                           | password  |
      | ngoctx+stbclaimny05@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 33816 | 1        |
      | 7903      | 39194 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+hclaimny02@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand Claim 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer go to claim page by url
    Then Head buyer verify info default of claim page
      | email                         |
      | ngoctx+hclaimny02@podfoods.co |
    And Head buyer fill info to claim of invoice "create by api"
      | store               | email                         | issues  | description |
      | ngoctx stclaim1ny01 | ngoctx+hclaimny02@podfoods.co | Damaged | Autotest    |
    And Guest upload file to claim
      | picture   |
      | claim.jpg |
    And Buyer check sku in affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 02 | 2        |
      | AT SKU Claim 01 | 2        |
    And Buyer verify affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 02 | 1        |
      | AT SKU Claim 01 | 1        |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."

  @BuyerClaims_14 @Claim
  Scenario: Admin verify buyer field
    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1316@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    Then Admin verify info default of claim page
    Then Admin verify info blank field of claim page

  @BuyerClaims_15 @Claim
  Scenario: Admin create claim when inactive buyer
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1310@podfoods.co | 12345678a |
      # active store
    And Admin change state of store "3627" to "active"
     # Active buyer
    And Admin active buyer "3816" to activate by API
      # Active product and sku
    And Change state of SKU id: "33816" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 89010 | 53        | 33816              | 1000             | 1000       | in_stock     | active | [blank]                  |
      # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 89010              | 33816              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3816     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1310@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    And Admin verify field buyer in create claim form
    And Admin create claims
      | type  | buyer              | store                | buyerCompany   | orderID       | subInvoice | issue   | description | adminNote  |
      | buyer | ngoctx stclaimny15 | ngoctx stclaim15ny01 | ngoc cpn claim | create by api | 1          | Damaged | Description | Admin Note |
    And Admin check sku not check in affected products in claim form
    And Admin check sku in affected products in claim form
      | sku             | skuID | quantity |
      | AT SKU Claim 01 | 33816 | 1        |
    And Admin verify picture field in create claim form
    And Admin create claims
      | type  | buyer              | store                | buyerCompany   | orderID       | subInvoice | issue   | description | adminNote  |
      | buyer | ngoctx stclaimny15 | ngoctx stclaim15ny01 | ngoc cpn claim | create by api | 1          | Damaged | Description | Admin Note |
    And Admin upload picture to create claims
      | picture   |
      | claim.jpg |
      | claim.jpg |
     # active store
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1310@podfoods.co | 12345678a |
    And Admin change state of store "3627" to "inactive"
    And Admin create claims success

  @BuyerClaims_16 @Claim
  Scenario: Admin create claim with multi SKU
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1311@podfoods.co | 12345678a |

      # Active product and sku
    And Change state of SKU id: "33816" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 89010 | 53        | 33816              | 1000             | 1000       | in_stock     | active | [blank]                  |
      # Change info buyer company
    And Admin change info of buyer company "2452" by API
      | manager_id | launcher_id |
      | 87         | 87          |

      # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 02 | 39194              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 89010              | 33816              | 1        | false     | [blank]          |
      | 98255              | 39194              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1311@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    And Admin verify field buyer in create claim form
    And Admin create claims
      | type  | buyer              | store          | buyerCompany     | orderID       | subInvoice | issue   | description | adminNote  |
      | buyer | ngoctx stclaimny10 | ngoctx stclaim | ngoc cpn b order | create by api | 1          | Damaged | Description | Admin Note |
    And Admin upload picture to create claims
      | picture   |
      | claim.jpg |
    And Admin check sku in affected products in claim form
      | sku             | skuID | quantity |
      | AT SKU Claim 01 | 33816 | 1        |
      | AT SKU Claim 01 | 39194 | 1        |
    And Admin create claims success
    And Admin get claims id
    And Admin verify general information in claim detail
      | store          | buyer              | email                          | buyerCompany     | orderNumber   | sub | issue   | issueDescription | date        | status | manager | adminNote  | picture   |
      | ngoctx stclaim | ngoctx stclaimny10 | ngoctx+stclaimny10@podfoods.co | ngoc cpn b order | create by api | 1   | Damaged | Description      | currentDate | Open   | [blank] | Admin Note | claim.jpg |
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    # verify search sub invoice
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status  | claimNumber | startDate | endDate | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
    # verify search store
    And Admin search claims
      | sub | orderNumber   | store          | buyer   | buyerCompany | managedBy | status  | claimNumber | startDate | endDate | region  |
      | 1   | create by api | ngoctx stclaim | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
     # verify search buyer
    And Admin search claims
      | sub | orderNumber   | store   | buyer              | buyerCompany | managedBy | status  | claimNumber | startDate | endDate | region  |
      | 1   | create by api | [blank] | ngoctx stclaimny10 | [blank]      | [blank]   | [blank] | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
     # verify search buyer company
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany     | managedBy | status  | claimNumber | startDate | endDate | region  |
      | 1   | create by api | [blank] | [blank] | ngoc cpn b order | [blank]   | [blank] | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
      # verify search Managed by
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status  | claimNumber | startDate | endDate | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | ngoctx14  | [blank] | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
     # verify search Status
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status | claimNumber | startDate | endDate | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | Open   | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
    # verify search Claim number
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status | claimNumber     | startDate | endDate | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | Open   | create by admin | [blank]   | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
     # verify search Start date
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status | claimNumber | startDate | endDate | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | Open   | [blank]     | Minus1    | [blank] | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
     # verify search End date
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status | claimNumber | startDate | endDate     | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | Open   | [blank]     | [blank]   | currentDate | [blank] |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
    # verify search End date < Start date
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status | claimNumber | startDate | endDate     | region  |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | Open   | [blank]     | Plus1     | currentDate | [blank] |
    And Admin no found data in result
     # verify search Region
    And Admin search claims
      | sub | orderNumber   | store   | buyer   | buyerCompany | managedBy | status | claimNumber | startDate | endDate | region           |
      | 1   | create by api | [blank] | [blank] | [blank]      | [blank]   | Open   | [blank]     | [blank]   | [blank] | New York Express |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
     # verify search with all criteria
    And Admin search claims
      | sub | orderNumber   | store          | buyer              | buyerCompany     | managedBy | status | claimNumber     | startDate | endDate     | region           |
      | 1   | create by api | ngoctx stclaim | ngoctx stclaimny10 | ngoc cpn b order | ngoctx14  | Open   | create by admin | Minus1    | currentDate | New York Express |
    And Admin verify claim result after search
      | date        | store          | buyer              | order         | status | issue   |
      | currentDate | ngoctx stclaim | ngoctx stclaimny10 | create by api | Open   | Damaged |
    And Admin go to detail of claim order "create by api" index 1
    And Admin go to "buyer" in claim detail by redirect icon and verify
    And Admin go back with button
    And Admin go to "store" in claim detail by redirect icon and verify

  @BuyerClaims_17 @BuyerClaims
  Scenario: Guest submit claim success - valid buyer
    Given GUEST open web guest claim
    When Guest verify info default of claim page
    And Guest fill info to claim of invoice
      | company | email                          | invoice    | issues | affectedProduct | description |
      | guest   | ngoctx+stclaimny11@podfoods.co | 1234579017 | MISC   | abc             | [blank]     |
    And Guest upload file to claim
      | picture   |
      | claim.jpg |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1317@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    # verify search sub invoice
    And Admin search claims
      | sub        | orderNumber | store          | buyer   | buyerCompany | managedBy | status  | claimNumber | startDate | endDate | region  |
      | 1234579017 | [blank]     | ngoctx stclaim | [blank] | [blank]      | [blank]   | [blank] | [blank]     | [blank]   | [blank] | [blank] |
    And Admin verify first result after search
      | date        | store          | buyer              | order   | status | issue |
      | currentDate | ngoctx stclaim | ngoctx stclaimny11 | [blank] | Open   | MISC  |
    And Admin go to detail of claim order first result
    And Admin verify general information in claim detail
      | store          | buyer              | email                          | buyerCompany     | orderNumber | sub     | issue | issueDescription | date        | status | manager | adminNote | picture   |
      | ngoctx stclaim | ngoctx stclaimny11 | ngoctx+stclaimny11@podfoods.co | ngoc cpn b order | [blank]     | [blank] | MISC  | [blank]          | currentDate | Open   | [blank] | [blank]   | claim.jpg |
    And Admin upload picture in claims detail
      | picture   |
      | claim.jpg |
      | claim.jpg |
    And Admin remove picture in claims detail
    And Admin upload picture in claims detail
      | picture   |
      | claim.jpg |
    And Admin verify download picture "claim.jpg" in claims detail

  @BuyerClaims_18 @BuyerClaims
  Scenario: Guest submit claim success - invalid buyer
    Given GUEST open web guest claim
    When Guest verify info default of claim page
    And Guest fill info to claim of invoice
      | company | email               | invoice    | issues | affectedProduct | description |
      | guest   | test+01@podfoods.co | 1234579018 | MISC   | abc             | [blank]     |
    And Guest upload file to claim
      | picture   |
      | claim.jpg |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1318@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    # verify search sub invoice
    And Admin search claims
      | sub        | orderNumber | store   | buyer   | buyerCompany | managedBy | status  | claimNumber | startDate   | endDate     | region  |
      | 1234579018 | [blank]     | [blank] | [blank] | [blank]      | [blank]   | [blank] | [blank]     | currentDate | currentDate | [blank] |
    And Admin verify first result after search
      | date        | store   | buyer   | order   | status | issue |
      | currentDate | [blank] | [blank] | [blank] | Open   | MISC  |
    And Admin go to detail of claim order first result
    And Admin verify general information in claim detail
      | store   | buyer   | email               | buyerCompany | orderNumber | sub     | issue | issueDescription | date        | status | manager | adminNote | picture   |
      | [blank] | [blank] | test+01@podfoods.co | [blank]      | [blank]     | [blank] | MISC  | [blank]          | currentDate | Open   | [blank] | [blank]   | claim.jpg |

  @BuyerClaims_19 @BuyerClaims
  Scenario: Admin add item to claim - delete line item after add sku
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1312@podfoods.co | 12345678a |

     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 02 | 39194              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 89010              | 33816              | 1        | false     | [blank]          |
      | 98255              | 39194              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1312@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    And Admin create claims
      | type  | buyer              | store          | buyerCompany     | orderID       | subInvoice | issue    | description | adminNote  |
      | buyer | ngoctx stclaimny01 | ngoctx stclaim | ngoc cpn b order | create by api | 1          | Shortage | Description | Admin Note |
    And Admin check sku in affected products in claim form
      | sku             | skuID | quantity |
      | AT SKU Claim 01 | 33816 | 1        |
    And Admin create claims success
    And Admin verify sku in add item popup of claim detail
      | brand             | product           | sku             | skuID |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 02 | 39194 |
    And NGOC_ADMIN_14 refresh page admin
    And Admin add sku in claim form
      | sku             | skuID |
      | AT SKU Claim 02 | 39194 |
    And Admin verify affected products in claim detail
      | brand             | product           | sku             | skuID | quantity |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 01 | 33816 | 1        |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 02 | 39194 | 1        |
    # Delete line item of order
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1312@podfoods.co | 12345678a |
    And Admin delete line item of order "create by api"
      | order         | sku             | skuID | reason           |
      | create by api | AT SKU Claim 02 | 39194 | Buyer adjustment |
    And Switch to actor NGOC_ADMIN_14
    And Admin save claim in claim detail then see message "Claim items product variant doesn't relate to sub invoice"

  @BuyerClaims_20 @BuyerClaims
  Scenario: Admin add item to claim - delete line item before add sku
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1313@podfoods.co | 12345678a |

      # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 02 | 39194              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 89010              | 33816              | 1        | false     | [blank]          |
      | 98255              | 39194              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |
     # Delete line item of order
    And Admin delete line item of order "create by api"
      | order         | sku             | skuID | reason           |
      | create by api | AT SKU Claim 02 | 39194 | Buyer adjustment |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1313@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    And Admin create claims
      | type  | buyer              | store          | buyerCompany     | orderID       | subInvoice | issue    | description | adminNote  |
      | buyer | ngoctx stclaimny01 | ngoctx stclaim | ngoc cpn b order | create by api | 1          | Shortage | Description | Admin Note |
    And Admin check sku in affected products in claim form
      | sku             | skuID | quantity |
      | AT SKU Claim 01 | 33816 | 1        |
    And Admin create claims success
    And Admin verify no data in add item popup of claim detail

  @BuyerClaims_21 @BuyerClaims
  Scenario: Admin add item to claim - inactive sku
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1314@podfoods.co | 12345678a |

     # Active product and sku
    And Change state of SKU id: "63667" to "active"
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 130992 | 53        | 63667              | 1000             | 1000       | in_stock     | active | [blank]                  |
      # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 01 | 33816              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create inventory
    And Admin create inventory api1
      | index | sku              | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 104 | 63667              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 89010              | 33816              | 1        | false     | [blank]          |
      | 130992             | 63667              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1314@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    And Admin create claims
      | type  | buyer              | store          | buyerCompany     | orderID       | subInvoice | issue    | description | adminNote  |
      | buyer | ngoctx stclaimny01 | ngoctx stclaim | ngoc cpn b order | create by api | 1          | Shortage | Description | Admin Note |
    And Admin check sku in affected products in claim form
      | sku              | skuID | quantity |
      | AT SKU Claim 104 | 63667 | 1        |
    And Admin create claims success
     # Active product and sku
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1314@podfoods.co | 12345678a |
    And Change state of SKU id: "63667" to "inactive"
    And Admin change info of regions attributes with sku "inactive"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    | inventory_receiving_date |
      | 130992 | 53        | 63667              | 1000             | 1000       | in_stock     | inactive | [blank]                  |
    And Switch to actor NGOC_ADMIN_14
    And Admin add sku in claim form
      | sku             | skuID |
      | AT SKU Claim 01 | 33816 |
    And Admin save claims after edit
    And Admin verify affected products in claim detail
      | brand             | product           | sku              | skuID | quantity |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 01  | 33816 | 1        |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 104 | 63667 | 1        |
    And Admin remove item "AT SKU Claim 104" has been added in claim detail
    And Admin refresh page by button
    And Admin verify affected products in claim detail
      | brand             | product           | sku              | skuID | quantity |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 01  | 33816 | 1        |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 104 | 63667 | 1        |
    And Admin remove item "AT SKU Claim 104" has been added in claim detail
    And Admin save claims after edit
    And Admin verify affected products in claim detail
      | brand             | product           | sku             | skuID | quantity |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 01 | 33816 | 1        |
    And Admin remove item "AT SKU Claim 01" has been added in claim detail

  @BuyerClaims_22 @BuyerClaims
  Scenario: Admin create claim success
    Given NGOCTX login web admin by api
      | email                  | password  |
      | ngoctx1315@podfoods.co | 12345678a |

     # Create inventory
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Claim 02 | 39194              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 98255              | 39194              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3334     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 281 Columbus Avenue | New York | 33               | 10001 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_14 open web admin
    When login to beta web with email "ngoctx1315@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_14 navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin go to create claims page
    And Admin create claims
      | type  | buyer              | store          | buyerCompany     | orderID       | subInvoice | issue   | description | adminNote  |
      | buyer | ngoctx stclaimny01 | ngoctx stclaim | ngoc cpn b order | create by api | 1          | Damaged | Description | Admin Note |
    And Admin upload picture to create claims
      | picture   |
      | claim.jpg |
    And Admin check sku in affected products in claim form
      | sku             | skuID | quantity |
      | AT SKU Claim 02 | 39194 | 1        |
    And Admin create claims success
    And Admin verify general information in claim detail
      | store          | buyer              | email                          | buyerCompany     | orderNumber   | sub | issue   | issueDescription | date        | status | manager | adminNote  | picture   |
      | ngoctx stclaim | ngoctx stclaimny01 | ngoctx+stclaimny01@podfoods.co | ngoc cpn b order | create by api | 1   | Damaged | Description      | currentDate | Open   | [blank] | Admin Note | claim.jpg |
    And Admin verify affected products in claim detail
      | brand             | product           | sku             | skuID | quantity |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 02 | 39194 | 1        |


@feature=buyerOrder
Feature: Buyer Order

  @B_ORDERS_LIST_07a @BUYERORDER
  Scenario: Check displayed data on the Orders list when choose any tabs on the tab-bar (with role buyer)
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder07chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    Then Buyer verify no result found in tab "All"
    And BUYER quit browser

  @B_ORDERS_LIST_07b @BUYERORDER
  Scenario: Check displayed data on the Orders list when choose any tabs on the tab-bar (with sub buyer role)
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder07chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    Then Buyer verify no result found in tab "All"
    And BUYER quit browser

  @B_ORDERS_LIST_08 @BUYERORDER
  Scenario: Check displayed data on the Orders list when choose Store Buyer page
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder07chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Buyer navigate to "Store Buyers" in order by sidebar
    Then Buyer verify no result found in tab "All"
    And BUYER quit browser

  @B_ORDERS_LIST_09 @BUYERORDER
  Scenario: Check displayed data on the Orders list when choose Your Store page
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder09chi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product by name "AT Product PreOrder" and pre order with info
      | sku                | amount |
      | AT SKU PreOrder 01 | 1      |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                 | creator                    | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder09 | ngoctx stbuyerorder09chi01 | [blank] | [blank]     | $100.00 |
    And BUYER quit browser

    Given SUB_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder09schi01@podfoods.co" pass "12345678a" role "buyer"
    And SUB_BUYER Go to Dashboard
    And SUB_BUYER Navigate to "Orders" by sidebar
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                 | creator | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder09 | [blank] | [blank] | [blank]     | $100.00 |
    And SUB_BUYER quit browser

  @B_ORDERS_LIST_10 @BUYERORDER
  Scenario: Check displayed data on the Orders list when choose Store Buyer page
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder09schi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer search product by name "AT Product PreOrder" and pre order with info
      | sku                | amount |
      | AT SKU PreOrder 01 | 1      |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                 | creator                     | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder09 | ngoctx stbuyerorder09schi01 | [blank] | [blank]     | $100.00 |
    And BUYER quit browser

    Given SUB_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder09chi01@podfoods.co" pass "12345678a" role "buyer"
    And SUB_BUYER Go to Dashboard
    And SUB_BUYER Navigate to "Orders" by sidebar
    And Buyer navigate to "Store Buyers" in order by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store                 | creator                     | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder09 | ngoctx stbuyerorder09schi01 | [blank] | [blank]     | $100.00 |
    And SUB_BUYER quit browser

  @B_ORDERS_LIST_11 @B_ORDERS_LIST_12 @B_ORDERS_LIST_14 @BUYERORDER
  Scenario: Check displayed data on the Orders list when choose any small-tab on the state bar
    Given NGOCTX login web admin by api
      | email                 | password  |
      | ngoctx600@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 11 | 32879              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+stbuyerorder11chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch           | brand                   | name              | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Order 01 | AT Brand Buyer Order 01 | AT SKU B Order 11 | 1      |

    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                 | creator                    | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $130.00 |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                 | creator                    | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $130.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                 | creator                    | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $130.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_13 @BUYERORDER
  Scenario: Check displayed data on the Orders list when choose any small-tab on the state bar
    Given NGOCTX login web admin by api
      | email                 | password  |
      | ngoctx601@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 11 | 32879              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11schi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product B Order 01", sku "AT SKU B Order 11" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_15a @B_ORDERS_DETAILS_1 @B_ORDERS_DETAILS_2 @B_ORDERS_DETAILS_3 @B_ORDERS_DETAILS_4 @B_ORDERS_DETAILS_5 @B_ORDERS_DETAILS_7 @BUYERORDER
  Scenario: Check displayed data of each ORDER record created by admin - Store manager A belong to PE store
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx602@podfoods.co | 12345678a |
    When Search order by sku "32882" by api
    And Admin delete order of sku "32882" by api
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 15 | 32882              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx602@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                      | paymentType    | street                | city    | state    | zip   |
      | ngoctx stbuyerorder11chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU B Order 15"
    And Admin create order success
    And NGOC_ADMIN_06 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName                  | storeName             | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder | orderDate   |
      | ngoctx stbuyerorder11chi01 | ngoctx stBuyerOrder11 | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending | [blank]           | $30.00     | currentDate |
    And Check items in order detail
      | brandName               | productName           | skuName           | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order 15 | $100.00   | 1        | $100.00 | [blank] |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName                  | storeName             | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | ngoctx stbuyerorder11chi01 | ngoctx stBuyerOrder11 | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending | [blank]           | $30.00     |
    And Check items in order detail
      | brandName               | productName           | skuName           | casePrice | quantity | total   |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order 15 | $100.00   | 1        | $100.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_15b @BUYERORDER
  Scenario: Check displayed data of each ORDER record created by admin - Store sub-buyer A1 managered by A
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx603@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 15 | 32882              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx603@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                       | paymentType    | street                | city    | state    | zip   |
      | ngoctx stbuyerorder11schi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU B Order 15"
    And Admin create order success
    And NGOC_ADMIN_06 quit browser

    Given SUB_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11schi01@podfoods.co" pass "12345678a" role "buyer"
    And SUB_BUYER Go to Dashboard
    And SUB_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And SUB_BUYER quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Buyer navigate to "Store Buyers" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_15c @BUYERORDER
  Scenario: Check displayed data of each ORDER record created by admin - Store manager C belongs to PD store
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx604@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 15 | 32882              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx604@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                       | paymentType    | street                | city    | state    | zip   |
      | ngoctx stbuyerorder11bchi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU B Order 15"
    And Admin create order success
    And NGOC_ADMIN_06 quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11bchi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                  | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11b | Pod Foods Admin | Pending | Pending     | $100.00 |
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                  | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11b | Pod Foods Admin | Pending | Pending     | $100.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                  | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11b | Pod Foods Admin | Pending | Pending     | $100.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_16a @BUYERORDER
  Scenario: Check displayed data of each ORDER record created by buyer - Store manager A belong to PE store
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx605@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 15 | 32882              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

   # Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+stbuyerorder11chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 32882 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                    | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $130.00 |
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                    | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $130.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                    | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $130.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_16b @BUYERORDER
  Scenario: Check displayed data of each ORDER record created by buyer - Store sub-buyer A1 managered by A
  # Create order
    Given Buyer login web with by api
      | email                                   | password  |
      | ngoctx+stbuyerorder11schi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 32882 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given SUB_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11schi01@podfoods.co" pass "12345678a" role "buyer"
    And SUB_BUYER Go to Dashboard
    And SUB_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And SUB_BUYER quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And Buyer navigate to "Store Buyers" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11schi01 | Pending | Pending     | $130.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_16c @BUYERORDER
  Scenario: Check displayed data of each ORDER record created by buyer - Store manager C belongs to PD store
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx606@podfoods.co | 12345678a |
  # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 15 | 32882              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

  # Create order
    Given Buyer login web with by api
      | email                                   | password  |
      | ngoctx+stbuyerorder11bchi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 32882 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11bchi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                  | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11b | ngoctx stbuyerorder11bchi01 | Pending | Pending     | $100.00 |
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                  | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11b | ngoctx stbuyerorder11bchi01 | Pending | Pending     | $100.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                  | creator                     | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11b | ngoctx stbuyerorder11bchi01 | Pending | Pending     | $100.00 |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_17 @BUYERORDER
  Scenario Outline: Check display of orders which contains only OOS/LS items
    Given NGOCTX06 login web admin by api
      | email                | password  |
      | ngoctx06@podfoods.co | 12345678a |
    When Search order by sku "32883" by api
    And Admin delete order of sku "32883" by api
    # Active product and sku
    And Change state of SKU id: "32885" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 87029 | 26        | 32885              | 10000            | 10000      | sold_out     | active | [blank]                  |
      | 87030 | 58        | 32885              | 10000            | 10000      | sold_out     | active | [blank]                  |
    # Active product and sku
    And Change state of SKU id: "32883" to "active"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 87026 | 26        | 32883              | 10000            | 10000      | sold_out     | active | [blank]                  |
      | 87027 | 58        | 32883              | 10000            | 10000      | sold_out     | active | [blank]                  |

     # Create order
    And Admin create line items attributes by API1
      | variants_region_id    | product_variant_id | quantity | fulfilled | fulfillment_date |
      | <variants_region_id1> | 32883              | 1        | false     | [blank]          |
      | <variants_region_id2> | 32885              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id   | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | <buyer_id> | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "<email>" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by api" in tab result
    And BUYER quit browser

    Examples:
      | buyer_id | email                                   | variants_region_id1 | variants_region_id2 |
      | 3297     | ngoctx+stbuyerorder11chi01@podfoods.co  | 87026               | 87029               |
      | 3298     | ngoctx+stbuyerorder11schi01@podfoods.co | 87026               | 87029               |
      | 3299     | ngoctx+stbuyerorder11bchi01@podfoods.co | 87027               | 87030               |
      | 3297     | ngoctx+stbuyerorder11hchi01@podfoods.co | 87026               | 87029               |

  @B_ORDERS_LIST_18 @BUYERORDER
  Scenario: Check display of Fulfillment state field on a order record
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx607@podfoods.co | 12345678a |

    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 18 | 32891              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
       # Create inventory
    And Admin create inventory api1
      | index | sku                | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 18b | 32896              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87036              | 32891              | 1        | false     | [blank]          |
      | 87042              | 32896              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3297     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    Then Admin update line item in order by api
      | index | skuName           | skuId | order_id      | fulfilled |
      | 1     | AT SKU B Order 18 | 32891 | create by api | true      |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | In Progress | $230.00 |

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | In Progress | $230.00 |

    Then Admin update line item in order by api
      | index | skuName            | skuId | order_id      | fulfilled |
      | 1     | AT SKU B Order 18b | 32896 | create by api | true      |

    And BUYER wait 2000 mini seconds
    And BUYER refresh page
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | $230.00 |

    And HEAD_BUYER refresh page
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | $230.00 |
    And BUYER quit browser
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_19 @BUYERORDER
  Scenario: Check display of the store name field if buyer enter Order-specific store name when checkout
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx608@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 19 | 32897              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

      #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+stbuyerorder11chi02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    Given BUYER maximize browser
    When login to beta web with email "ngoctx+stbuyerorder11chi02@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Order 01", sku "AT SKU B Order 19" and add to cart with amount = "1"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | $30.00             | [blank]           | [blank] | $130.00 |
    And Buyer check out cart "Pay by invoice" with receiving info
      | customStore | customerPO | department | specialNote |
      | AT Store    | [blank]    | [blank]    | [blank]     |

    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName                  | storeName | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | ngoctx stbuyerorder11chi02 | AT Store  | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending | [blank]           | $30.00     |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName                  | storeName | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | ngoctx stbuyerorder11chi02 | AT Store  | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending | [blank]           | $30.00     |
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_20 @BUYERORDER
  Scenario: Check display of orders when fulfillment state changed - one item
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx609@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 20 | 32898              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87046              | 32898              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3297     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    # Check order in buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |

    # Check order in head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    # Fulfill order
    Then Admin update line item in order by api
      | index | skuName           | skuId | order_id      | fulfilled |
      | 1     | AT SKU B Order 20 | 32898 | create by api | true      |

    # Buyer check orer after fulfill
    And BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | $130.00 |
    And Search Order in tab "Fulfilled" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | $130.00 |
    # Head Buyer check order after fulfill
    And HEAD_BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | $130.00 |
    And Search Order in tab "Fulfilled" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | $130.00 |
     # UnFulfill order
    Then Admin update line item in order by api
      | index | skuName           | skuId | order_id      | fulfilled |
      | 1     | AT SKU B Order 20 | 32898 | create by api | false     |
     # Buyer check order after unfulfilled
    And BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
      # Head Buyer check order after unfulfilled

    And HEAD_BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And BUYER quit browser
    And HEAD_BUYER quit browser

  @B_ORDERS_LIST_21 @BUYERORDER
  Scenario Outline: Check display of orders when fulfillment state changed - multi item
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx610@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 20 | 32898              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 21 | 32907              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

     # Create order
    And Admin create line items attributes by API1
      | variants_region_id    | product_variant_id | quantity | fulfilled | fulfillment_date |
      | <variants_region_id1> | 32898              | 1        | false     | [blank]          |
      | <variants_region_id2> | 32907              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id   | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | <buyer_id> | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

     # Check order in buyer
    Given BUYER open web user
    When login to beta web with email "<email>" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | <total> |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | <total> |

    # Check order in head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | <total> |
    And Search Order in tab "Pending" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | <total> |
      # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName           | skuId | order_id      | fulfilled |
      | 1     | AT SKU B Order 20 | 32898 | create by api | true      |

      # Buyer check orer after fulfill 1 item
    And BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | In Progress | <total> |
    And Search Order in tab "In Progress" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | In Progress | <total> |

      # Head Buyer check orer after fulfill 1 item
    And HEAD_BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | In Progress | <total> |
    And Search Order in tab "In Progress" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | In Progress | <total> |
  # Fulfill 1 line item in order
    Then Admin update line item in order by api
      | index | skuName           | skuId | order_id      | fulfilled |
      | 1     | AT SKU B Order 21 | 32907 | create by api | true      |

        # Buyer check orer after fulfill
    And BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | <total> |
    And Search Order in tab "Fulfilled" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | <total> |
    And BUYER log out
    And BUYER quit browser

    # Head Buyer check orer after fulfill
    And HEAD_BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | <total> |
    And Search Order in tab "Fulfilled" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Fulfilled   | <total> |
    And HEAD_BUYER log out
    And HEAD_BUYER quit browser

    Examples:
      | buyer_id | email                                   | variants_region_id1 | variants_region_id2 | total   |
      | 3297     | ngoctx+stbuyerorder11chi01@podfoods.co  | 87046               | 87056               | $230.00 |
      | 3298     | ngoctx+stbuyerorder11schi01@podfoods.co | 87046               | 87056               | $230.00 |
      | 3299     | ngoctx+stbuyerorder11bchi01@podfoods.co | 87047               | 87057               | $200.00 |

#  @B_ORDERS_LIST_22 @BUYERORDER
#  Scenario Outline: Check displayed data of each PRE-ORDER record
#    Given NGOCTX06 login web admin by api
#      | email                 | password  |
#      | ngoctx611@podfoods.co | 12345678a |
#       # Create inventory
#    And Admin create inventory api1
#      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU B Order 22 | 32908              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
#
#    # Add cart this SKU and checkout
#    Given Buyer login web with by api
#      | email   | password  |
#      | <email> | 12345678a |
#    And Clear cart to empty in cart before by API
#
#    Given BUYER open web user
#    When login to beta web with email "<email>" pass "12345678a" role "buyer"
#    And Buyer search product by name "AT Product B Order 01" and pre order with info
#      | sku               | amount |
#      | AT SKU B Order 22 | 1      |
#    And BUYER Go to Dashboard
#    And BUYER Navigate to "Orders" by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
#    And Buyer verify pre-order in result
#      | index | order       | tag | number | store                 | creator   | payment | fulfillment | total   |
#      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder11 | <creator> | [blank] | [blank]     | $100.00 |
#    And Search Order in tab "Pre-order" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
#    And Buyer verify pre-order result in tab Pre-order
#      | index | order       | tag | number | store                 | creator   | total   |
#      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder11 | <creator> | $100.00 |
#    And Buyer navigate to "Your Store" in order by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
#    And Buyer verify pre-order in result
#      | index | order       | tag | number | store                 | creator   | payment | fulfillment | total   |
#      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder11 | <creator> | [blank] | [blank]     | $100.00 |
#    And Search Order in tab "Pre-order" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
#    And Buyer verify pre-order result in tab Pre-order
#      | index | order       | tag | number | store                 | creator   | total   |
#      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder11 | <creator> | $100.00 |
#    And BUYER log out
#
#    Given HEAD_BUYER open web user
#    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
#    And HEAD_BUYER Go to Dashboard
#    And HEAD_BUYER Navigate to "Orders" by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
#    And Buyer verify pre-order in result
#      | index | order       | tag | number | store                 | creator   | payment | fulfillment | total   |
#      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder11 | <creator> | [blank] | [blank]     | $100.00 |
#    And Search Order in tab "Pre-order" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
#    And Buyer verify pre-order result in tab Pre-order
#      | index | order       | tag | number | store                 | creator   | total   |
#      | 1     | currentDate | Pre | random | ngoctx stBuyerOrder11 | <creator> | $100.00 |
#    And HEAD_BUYER log out
#    Examples:
#      | email                                   | creator                     |
#      | ngoctx+stbuyerorder11chi03@podfoods.co  | ngoctx stbuyerorder11chi03  |
#      | ngoctx+stbuyerorder11schi02@podfoods.co | ngoctx stbuyerorder11schi02 |
#      | ngoctx+stbuyerorder11bchi02@podfoods.co | ngoctx stbuyerorder11bchi02 |

  @B_ORDERS_LIST_23 @B_ORDERS_LIST_24 @BUYERORDER
  Scenario Outline: Check a GHOST-ORDERS cannot be displayed on the Buyer Orders list but when convert them, they will be displayed
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx612@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 23 | 32911              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create ghost order
    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx612@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer   | paymentType    | street                | city    | state    | zip   |
      | <buyer> | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "AT SKU B Order 23"
    And Admin create order success

    # Verify ghost order no exist on buyer
    Given BUYER open web user
    Given BUYER maximize browser
    When login to beta web with email "<email>" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by admin" in tab result
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by admin" in tab result
    # Verify ghost order no exist on head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by admin" in tab result
    # Convert ghost order to real order
    And NGOC_ADMIN_06 convert ghost order to real order
    And Admin confirm convert ghost order to real order
    # Verify ghost order on buyer
    And BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | <total> |
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | <total> |
    And BUYER log out
    And BUYER quit browser
    # Verify ghost order on head buyer
    And HEAD_BUYER refresh page
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | <total> |
    And HEAD_BUYER log out
    And HEAD_BUYER quit browser

    Examples:
      | buyer                       | email                                   | total   |
      | ngoctx stbuyerorder11chi01  | ngoctx+stbuyerorder11chi01@podfoods.co  | $130.00 |
      | ngoctx stbuyerorder11schi01 | ngoctx+stbuyerorder11schi01@podfoods.co | $130.00 |
      | ngoctx stbuyerorder11bchi01 | ngoctx+stbuyerorder11bchi01@podfoods.co | $100.00 |

  @B_ORDERS_LIST_25 @B_ORDERS_LIST_31 @B_ORDERS_LIST_34 @B_ORDERS_LIST_35 @B_ORDERS_LIST_36 @BUYERORDER
  Scenario Outline: Check a deleted record cannot be shown in the orders list
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx613@podfoods.co | 12345678a |

      # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 25 | 32924              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87076              | 32924              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id   | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | <buyer_id> | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |
    # Delete order
    When Search order by sku "32924" by api
    And Admin delete order of sku "32924" by api

    # Verify order deleted no exist on buyer
    Given BUYER open web user
    When login to beta web with email "<email>" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | Minus1        | Plus1          |
    Then Buyer verify no found order "create by admin" in tab result
    And Buyer navigate to "Your Store" in order by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by admin" in tab result
    And BUYER quit browser

    # Verify order deleted no exist on head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by admin" in tab result
    And HEAD_BUYER quit browser

    Examples:
      | buyer_id | email                                   |
      | 3297     | ngoctx+stbuyerorder11chi01@podfoods.co  |
      | 3298     | ngoctx+stbuyerorder11schi01@podfoods.co |
      | 3299     | ngoctx+stbuyerorder11bchi01@podfoods.co |

  @B_ORDERS_LIST_28 @BUYERORDER
  Scenario: Checking filtering with Brand criteria
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Buyer search brand "AT Brand Buyer Order No Exist" in tab "All" then verify popup No Data
    And Buyer search brand "AT Brand Buyer Order Inactive" in tab "All" then verify popup No Data
    And HEAD_BUYER quit browser

    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx614@podfoods.co | 12345678a |
    And Admin search brand name "Vendor Brand Delete" by api
    And Admin delete brand by API
    And Admin create brand by API
      | name                | description         | micro_description | city    | address_state_id | vendor_company_id |
      | Vendor Brand Delete | Vendor Brand Delete | [blank]           | [blank] | 33               | 1937              |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Vendor Check Brand on Dashboard
      | brandName           | city    | state   | country | description         |
      | Vendor Brand Delete | [blank] | [blank] | [blank] | Vendor Brand Delete |
    And Admin edit brand "" by API
      | name                | description         | micro_description | city    | address_state_id | vendor_company_id |
      | Vendor Brand Delete | Vendor Brand Delete | [blank]           | Chicago | 33               | 1937              |
    And VENDOR refresh browser
    And Vendor Check Brand on Dashboard
      | brandName           | city    | state   | country | description         |
      | Vendor Brand Delete | Chicago | [blank] | [blank] | Vendor Brand Delete |
    And Admin delete brand "" by API
    And VENDOR refresh browser
    And Vendor check brand on Dashboard is not visible
      | brandName           | city    | state   | country | description         |
      | Vendor Brand Delete | [blank] | [blank] | [blank] | Vendor Brand Delete |
    And VENDOR quit browser

  @B_ORDERS_LIST_29 @B_ORDERS_LIST_30 @B_ORDERS_LIST_32 @B_ORDERS_LIST_33 @BUYERORDER
  Scenario: Checking filtering with Checkout criteria
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Buyer verify checkout "before" criteria
    And Buyer verify checkout "after" criteria
    And Search Order in tab "All" with
      | brand   | checkoutAfter | checkoutBefore |
      | [blank] | Plus1         | Minus1         |
    Then Buyer verify no result found in tab "All"
    And BUYER quit browser

  @B_ORDER_DETAILS_8 @B_ORDER_DETAILS_9 @BUYERORDER
  Scenario: Check displayed Shipping Address information of the Status block on General tab
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx615@podfoods.co | 12345678a |
        # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 11 | 32879              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

     # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail08chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 32879 | 1        |
    And Checkout cart with payment by "invoice" by API
    # Clear cart
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail08chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    # Create order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail08chi01@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Order 01", sku "AT SKU B Order 11" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Buyer check out cart
#    And Buyer open new shipping address popup
#    And Buyer edit shipping address
#      | name                         | street                | apt     | attn    | city    | state   | zip   | phone      |
#      | ngoctx stborderdetail08chi01 | 1544 West 18th Street | [blank] | [blank] | Chicago | Alabama | 60609 | 0123456789 |
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    And Check information in order detail
      | buyerName                    | storeName              | shippingAddress                                 | orderValue | total   | payment    | status  |
      | ngoctx stborderdetail08chi01 | ngoctx stBOderDetail08 | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending |
    And BUYER Go to Dashboard
    And Search product by name "AT Product B Order 01", sku "AT SKU B Order 11" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    And Check information in order detail
      | buyerName                    | storeName              | shippingAddress                                 | orderValue | total   | payment    | status  |
      | ngoctx stborderdetail08chi01 | ngoctx stBOderDetail08 | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending |
    And BUYER quit browser

  @B_ORDER_DETAILS_10 @B_ORDER_DETAILS_11 @BUYERORDER
  Scenario: Check display of Payment information with orders have payment method =  Via credit card
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx616@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 11 | 33151              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail11chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33151 | 1        |
    And Checkout cart with payment by "bank_or_cc" by API

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx616@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin create "create" sub-invoice with Suffix =""
      | skuName                  |
      | AT SKU B Order Detail 11 |
    When Admin fulfill all line items created by buyer
      | index | skuName                  | fulfillDate |
      | 1     | AT SKU B Order Detail 11 | currentDate |
    And Admin get ID of sub-invoice of order "direct"
    And Admin get sub invoice id to run job sidekiq
    And NGOC_ADMIN_06 quit browser

    #Run job to charge to paid order
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                  | creator                      | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBOderDetail11 | ngoctx stborderdetail11chi01 | Paid    | Fulfilled   | $100.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName              | shippingAddress                                 | orderValue | total   | payment                                 | status |
      | ngoctx stborderdetail11chi01 | ngoctx stBOderDetail11 | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $100.00 | Payment via credit card or bank account | Paid   |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 11 | $100.00   | 1        | $100.00 | [blank] |
    And BUYER quit browser

  @B_ORDER_DETAILS_12 @BUYERORDER
  Scenario: Check display of Payment information with orders have payment method = Bank account
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx617@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 12 | 33146              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                     | password  |
      | ngoctx+stborderdetail08bchi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33146 | 1        |
    And Checkout cart with payment by "bank_or_cc" by API

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx617@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin create "create" sub-invoice with Suffix =""
      | skuName                  |
      | AT SKU B Order Detail 12 |
    When Admin fulfill all line items created by buyer
      | index | skuName                  | fulfillDate |
      | 1     | AT SKU B Order Detail 12 | currentDate |
    And Admin get ID of sub-invoice of order "direct"
    And Admin get sub invoice id to run job sidekiq
    And NGOC_ADMIN_06 quit browser

    #Run job to charge to paid order
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq
    And ADMIN_OLD quit browser

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail08bchi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                   | creator                       | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBOderDetail08b | ngoctx stborderdetail08bchi01 | Paid    | Fulfilled   | $100.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                     | storeName               | shippingAddress                                 | orderValue | total   | payment                                 | status |
      | ngoctx stborderdetail08bchi01 | ngoctx stBOderDetail08b | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $100.00 | Payment via credit card or bank account | Paid   |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 12 | $100.00   | 1        | $100.00 | [blank] |
    And BUYER quit browser

  @B_ORDER_DETAILS_13 @BUYERORDER
  Scenario: Check the payment state of an order when it has both Paid invoice and Unpaid invoice - PD item
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx618@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 12 | 33146              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                     | password  |
      | ngoctx+stborderdetail08bchi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33146 | 1        |
    And Checkout cart with payment by "bank_or_cc" by API

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx618@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin create "create" sub-invoice with Suffix =""
      | skuName                  |
      | AT SKU B Order Detail 12 |
    When Admin fulfill all line items created by buyer
      | index | skuName                  | fulfillDate |
      | 1     | AT SKU B Order Detail 12 | currentDate |
    And Admin get ID of sub-invoice of order "direct"

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail08bchi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                   | creator                       | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBOderDetail08b | ngoctx stborderdetail08bchi01 | Pending | Fulfilled   | $100.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                     | storeName               | shippingAddress                                 | orderValue | total   | payment                                 | status  |
      | ngoctx stborderdetail08bchi01 | ngoctx stBOderDetail08b | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $100.00 | Payment via credit card or bank account | Pending |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 12 | $100.00   | 1        | $100.00 | [blank] |

    And NGOC_ADMIN_06 refresh page admin
    And Admin add line item in order detail
      | skuName                  | quantity | note    |
      | AT SKU B Order Detail 11 | 1        | [blank] |
    And NGOC_ADMIN_06 quit browser

    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                   | creator                       | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stBOderDetail08b | ngoctx stborderdetail08bchi01 | Pending | In Progress | $200.00 |
    And BUYER quit browser

  @B_ORDER_DETAILS_14 @BUYERORDER
  Scenario: Check the payment state of an order when it has both Paid invoice and Unpaid invoice - PE item
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx618@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 12 | 33146              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail14chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33146 | 1        |
    And Checkout cart with payment by "bank_or_cc" by API

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx618@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin create "create" sub-invoice with Suffix =""
      | skuName                  |
      | AT SKU B Order Detail 12 |
    When Admin fulfill all line items created by buyer
      | index | skuName                  | fulfillDate |
      | 1     | AT SKU B Order Detail 12 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail14chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                   | creator                      | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stborderdetail14 | ngoctx stborderdetail14chi01 | Pending | Fulfilled   | $130.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName               | shippingAddress                                 | orderValue | total   | payment                                 | status  | logisticSurcharge | smallOrder |
      | ngoctx stborderdetail14chi01 | ngoctx stborderdetail14 | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | Payment via credit card or bank account | Pending | [blank]           | $30.00     |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 12 | $100.00   | 1        | $100.00 | [blank] |

    And NGOC_ADMIN_06 refresh page admin
    And Admin add line item in order detail
      | skuName                  | quantity | note    |
      | AT SKU B Order Detail 11 | 1        | [blank] |
    And NGOC_ADMIN_06 quit browser

    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                   | creator                      | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx stborderdetail14 | ngoctx stborderdetail14chi01 | Pending | In Progress | $230.00 |
    And BUYER quit browser

  @B_ORDER_DETAILS_23 @BUYERORDER
  Scenario: Check displayed information in an PE invoice - Order created by buyer
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx619@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 23 | 33152              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Clear cart
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail23chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail23chi01@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Order 01", sku "AT SKU B Order Detail 23" and add to cart with amount = "1"
    And Buyer view cart
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    And See invoice
    And Buyer verify info in Invoice ""
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                               | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stborderdetail23chi01 - ngoctx stborderdetail23, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    And BUYER quit browser

  @B_ORDER_DETAILS_24 @BUYERORDER
  Scenario: Check displayed information in an PE invoice - Order created by admin
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx620@podfoods.co | 12345678a |
  # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 23 | 33152              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
  # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87828              | 33152              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3306     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail23chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                   | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stborderdetail23 | Pod Foods Admin | Pending | Pending     | $130.00 |
    And Go to order detail with order number "create by api"
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                               | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stborderdetail23chi01 - ngoctx stborderdetail23, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | [blank]           | 0.00         | 130.00 |
    And BUYER quit browser

  @B_ORDER_DETAILS_25 @BUYERORDER
  Scenario: Check displayed information in the Not in any invoice section - Order created by buyer
    # Clear cart
    Given Buyer login web with by api
      | email                                   | password  |
      | ngoctx+stbuyerorder11bchi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    Given BUYER maximize browser
    When login to beta web with email "ngoctx+stbuyerorder11bchi01@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Order 01", sku "AT SKU B Order Detail 25" and add to cart with amount = "1"
    And Buyer view cart
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    And Buyer verify invoice "No invoices have been created for this order."
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And Buyer verify invoice "No invoices have been created for this order."
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_26 @BUYERORDER
  Scenario: Check displayed information in the Not in any invoice section - Order created by admin
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx621@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87833              | 33154              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3299     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11bchi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer verify invoice "No invoices have been created for this order."
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer verify invoice "No invoices have been created for this order."
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_27 @BUYERORDER
  Scenario: Check displayed information in the Not in any invoice section - Order created by admin - PD and PE item
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx622@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87024              | 32882              | 1        | false     | [blank]          |
      | 87833              | 33154              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3297     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

      # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                           | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stbuyerorder11chi01 - ngoctx stBuyerOrder11, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | [blank]           | 0.00         | 130.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                           | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stbuyerorder11chi01 - ngoctx stBuyerOrder11, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | [blank]           | 0.00         | 130.00 |
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_28 @BUYERORDER
  Scenario: Check displayed information in an PD invoice - Create order by buyer
     # Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+stbuyerorder11chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33154 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx626@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin create "create" sub-invoice with Suffix =""
      | skuName                  |
      | AT SKU B Order Detail 25 |
    And Admin get ID of sub-invoice of order "direct"
    And Amin set deliverable for order "create by admin"
      | subInvoice    | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | create by api | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |
    And NGOC_ADMIN_06 quit browser

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer verify label pop direct item is "This item will be shipped directly to you from the vendor."
    And Buyer check confirm information
      | eta         | carrier | tracking  | comment   |
      | currentDate | USPS    | 123456789 | Auto test |
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                           | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stbuyerorder11chi01 - ngoctx stBuyerOrder11, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | [blank]            | [blank]           | 0.00         | 100.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer verify label pop direct item is "This item will be shipped directly to you from the vendor."
    And Buyer check confirm information
      | eta         | carrier | tracking  | comment   |
      | currentDate | USPS    | 123456789 | Auto test |
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                           | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stbuyerorder11chi01 - ngoctx stBuyerOrder11, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | [blank]            | [blank]           | 0.00         | 100.00 |
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_29 @BUYERORDER
  Scenario: Check displayed information in an PD invoice - Create order by admin
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx623@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87833              | 33154              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3297     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1544 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx623@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin create "create" sub-invoice with Suffix =""
      | skuName                  |
      | AT SKU B Order Detail 25 |
    And Admin get ID of sub-invoice of order "direct"
    And Amin set deliverable for order "create by admin"
      | subInvoice | deliveryMethod        | deliveryDate | carrier | trackingNumber | deliveryStarTime | deliveryToTime | comment   | proof   |
      | 1          | Ship direct to stores | currentDate  | USPS    | 123456789      | [blank]          | [blank]        | Auto test | [blank] |
    And NGOC_ADMIN_06 quit browser

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer verify label pop direct item is "This item will be shipped directly to you from the vendor."
    And Buyer check confirm information
      | eta         | carrier | tracking  | comment   |
      | currentDate | USPS    | 123456789 | Auto test |
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                           | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stbuyerorder11chi01 - ngoctx stBuyerOrder11, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | [blank]            | [blank]           | 0.00         | 100.00 |
    And BUYER quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Buyer verify label pop direct item is "This item will be shipped directly to you from the vendor."
    And Buyer check confirm information
      | eta         | carrier | tracking  | comment   |
      | currentDate | USPS    | 123456789 | Auto test |
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                           | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stbuyerorder11chi01 - ngoctx stBuyerOrder11, 1544 West 18th Street, Chicago, Illinois, 60608 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | [blank]            | [blank]           | 0.00         | 100.00 |
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_31 @BUYERORDER
  Scenario: Check display of ETA field with PE invoice (which under sub-invoice Total value) - Store set receiving weekdays full week
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx624@podfoods.co | 12345678a |
  # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 31 | 33153              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail31chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33153 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail31chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | eta   |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 31 | $100.00   | 1        | $100.00 | [blank] | Plus1 |
    And BUYER quit browser

  @B_ORDER_DETAILS_32 @BUYERORDER
  Scenario: Check display of ETA field with PE invoice (which under sub-invoice Total value) - Store set receiving weekdays within 7 business days
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx625@podfoods.co | 12345678a |
  # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 31 | 33153              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail32chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33153 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail32chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | eta   |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 31 | $100.00   | 1        | $100.00 | [blank] | Plus9 |
    And BUYER quit browser

  @B_ORDER_DETAILS_33 @B_ORDER_DETAILS_34 @BUYERORDER
  Scenario: Check display of ETA field with PE invoice (which under sub-invoice Total value) - Store create new sub invoice
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx626@podfoods.co | 12345678a |
   # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 31 | 33153              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail32chi02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33153 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Create new sub invoice
    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx626@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin create "create" sub-invoice with Suffix =""
      | skuName                  |
      | AT SKU B Order Detail 31 |
    And Admin get ID of sub-invoice of order "express"
    And Admin get ID of sub-invoice by info
      | index | skuName                  | type    |
      | 1     | AT SKU B Order Detail 31 | express |

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail32chi02@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 31 | $100.00   | 1        | $100.00 | [blank] |

    And NGOC_ADMIN_06 refresh page admin
    And Admin edit ETA of sub-invoice
      | index | skuName                  | eta         |
      | 1     | AT SKU B Order Detail 31 | currentDate |
    And NGOC_ADMIN_06 quit browser

    And BUYER refresh page
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | eta         |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 31 | $100.00   | 1        | $100.00 | [blank] | currentDate |
    And BUYER quit browser

  @B_ORDER_DETAILS_35 @BUYERORDER
  Scenario: Check sub-invoice ETA is automatically updated per the fulfillment date when the PO fulfillment date is entered
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx627@podfoods.co | 12345678a |
  # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 31 | 33153              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail31chi02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33153 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_06 open web admin
    When login to beta web with email "ngoctx627@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_06 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And NGOC_ADMIN_06 create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote |
      | Auto Ngoc LP Mix 01 | Unconfirmed      | [blank]         | [blank] | adminNote | lpNote |
    And Admin get ID of sub-invoice of order "express"
    And Admin get ID of sub-invoice by info
      | index | skuName                  | type    |
      | 1     | AT SKU B Order Detail 31 | express |
    And NGOC_ADMIN_06 quit browser

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail31chi02@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | eta   |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 31 | $100.00   | 1        | $100.00 | [blank] | Plus1 |
    And BUYER quit browser

  @B_ORDER_DETAILS_36 @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice confirmed with Delivery method = Ship direct to Store/ Use my own shipping label
    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail36chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33200 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Vendor confirm that item with Delivery method
    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                   | payment | fullfillment | total  |
      | currentDate | create by api | ngoctx stborderdetail36 | Pending | Pending      | $95.00 |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku                      | date  |
      | AT SKU B Order Detail 36 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store                   | address                                         |
      | Ship Direct to Store | ngoctx stborderdetail36 | 1554 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | [blank] | [blank]        | [blank] |

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | [blank] |
    And Buyer check confirm information
      | eta         | carrier | tracking |
      | currentDate | [blank] | [blank]  |

     # Vendor fill info to delivery method
    And VENDOR refresh page
    And Vendor edit shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment  |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | AutoTest |
    And VENDOR quit browser

    And BUYER refresh page
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | [blank] |
    And Buyer check confirm information
      | eta         | carrier | tracking | comment  |
      | currentDate | USPS    | 12345678 | AutoTest |
    And BUYER quit browser

  @B_ORDER_DETAILS_37 @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice - Delete shipment - No item fulfill
     # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail36chi05@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33200 | 1        |
    And Checkout cart with payment by "invoice" by API

  # Vendor confirm that item with Delivery method
    Given VENDOR open web user
    Given VENDOR maximize browser
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                   | payment | fullfillment | total  |
      | currentDate | create by api | ngoctx stborderdetail36 | Pending | Pending      | $95.00 |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku                      | date  |
      | AT SKU B Order Detail 36 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store                   | address                                         |
      | Ship Direct to Store | ngoctx stborderdetail36 | 1554 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | [blank] | [blank]        | [blank] |
    And Vendor delete shipping method
    And Vendor verify unconfirmed item
    And Vendor Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | podConsignment |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | not set        |
    And VENDOR quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by api" in tab result
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_37b @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice - Delete shipment - No item fulfill
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx628@podfoods.co | 12345678a |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 87971              | 33200              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1               | city    | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3312     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 1554 West 18th Street | Chicago | 14               | 60608 | true          | [blank]    | [blank]            | [blank]            |

  # Vendor confirm that item with Delivery method
    Given VENDOR open web user
    Given VENDOR maximize browser
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                   | payment | fullfillment | total  |
      | currentDate | create by api | ngoctx stborderdetail36 | Pending | Pending      | $95.00 |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku                      | date  |
      | AT SKU B Order Detail 36 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store                   | address                                         |
      | Ship Direct to Store | ngoctx stborderdetail36 | 1554 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | Plus1        | [blank] | [blank]        | [blank] |
    And Vendor get ID sub invoice
      | index | sku                      |
      | 1     | AT SKU B Order Detail 36 |
    And Vendor remove sub invoice "all"
      | index | sku                      | itemRemove               |
      | 1     | AT SKU B Order Detail 36 | AT SKU B Order Detail 36 |
    And Vendor verify unconfirmed item
    And Vendor Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | podConsignment |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | not set        |
    And VENDOR quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by api" in tab result
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_38a @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice - Delete shipment - at least an item fulfill
     # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail36chi02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33200 | 1        |
      | 7289      | 33154 | 1        |
    And Checkout cart with payment by "invoice" by API
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx629@podfoods.co | 12345678a |
    # Set invoice
    And Admin set Invoice by API
      | skuName                  | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU B Order Detail 36 | 33200 | create by api buyer | [blank]  | pending       | [blank] |
      | AT SKU B Order Detail 25 | 33154 | [blank]             | [blank]  | [blank]       | [blank] |
    # Fulfilled this order
    Then Admin update line item in order by api
      | index | skuName                  | skuId | order_id        | fulfilled |
      | 1     | AT SKU B Order Detail 36 | 33200 | create by buyer | true      |

    Given VENDOR open web user
    Given VENDOR maximize browser
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                   | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stborderdetail36 | [blank]       | [blank]   | [blank]      |
    And Vendor Go to order detail with order number ""
    Then Vendor remove item and verify message error
      | index | sku                      | subInvoice    | message                                                                      |
      | 1     | AT SKU B Order Detail 25 | create by api | Can not edit/delete because the shipment has at least 1 fulfilled line item. |
    And VENDOR quit browser

  @B_ORDER_DETAILS_39 @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice confirmed with Delivery method = Ship direct to Store/ Buy and Print shipping label (Shippo) - No item fulfill
     # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail36chi03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33200 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Vendor create shippo
    Given VENDOR open web user
    Given VENDOR maximize browser
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                   | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stborderdetail36 | [blank]       | [blank]   | [blank]      |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku                      | date  |
      | AT SKU B Order Detail 36 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store                   | address                                         |
      | Ship Direct to Store | ngoctx stborderdetail36 | 1554 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name     | company | address1              | city    | zipcode | state    | country | email           |
      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | AutoTest | company | 1554 West 18th Street | Chicago | 60608   | Illinois | US      | bao@podfoods.co |
    And Vendor select shippo and then confirm
    And Click on button "Buy"
    And Vendor check information after confirm
      | provider | tracking | eta    | status                    | size                       | weight     | line                 | price |
      | USPS     | [blank]  | ETA: - | Tracking status:  UNKNOWN | Size: 4.00 x 3.00 x 2.00cm | Weight: 5g | 1 line item (1 case) | USD   |
    And VENDOR quit browser

    # Verify invoice
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36chi03@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | [blank] |
    And Buyer check confirm information
      | eta     | carrier | tracking                   | comment               |
      | [blank] | [blank] | 92055903332000000000000018 | Shippo auto-generated |
    And BUYER quit browser

     # Verify invoice
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 |
    And Buyer check confirm information
      | eta     | carrier | tracking                   | comment               |
      | [blank] | [blank] | 92701903332000000000000014 | Shippo auto-generated |
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_40 @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice confirmed with Delivery method = Ship direct to Store/ Buy and Print shipping label (Shippo) - at least an item fulfill
     # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail36chi04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33200 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx630@podfoods.co | 12345678a |
    And Admin set Invoice by API
      | skuName                  | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU B Order Detail 36 | 33200 | create by api buyer | 33200    | pending       | [blank] |
    # Fulfilled this order
    And Admin "fulfilled" all line item in order "create by api" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region             | store                   | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | ngoctx stborderdetail36 | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number ""
    Then Vendor verify shippo is not display
    And VENDOR quit browser

  @B_ORDER_DETAILS_41 @B_ORDER_DETAILS_42a @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice confirmed with Delivery method = Self-deliver to Store - Delete shipment
    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail36chi06@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33200 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Vendor confirm that item with Delivery method
    Given VENDOR open web user
    Given VENDOR maximize browser
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                   | payment | fullfillment | total  |
      | currentDate | create by api | ngoctx stborderdetail36 | Pending | Pending      | $95.00 |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku                      | date  |
      | AT SKU B Order Detail 36 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery              | store                   | address                                         |
      | Self-deliver to Store | ngoctx stborderdetail36 | 1554 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from    | to      | comment |
      | currentDate  | [blank] | [blank] | [blank] |

    # Verify invoice in buyer
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36chi06@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | [blank] |
    And Buyer check confirm information
      | eta     | deliveryDate | eta2 |
      | [blank] | currentDate  | N/A  |

    # Verify invoice in head buyer
    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail36hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 |
    And Buyer check confirm information
      | eta     | deliveryDate | eta2 |
      | [blank] | currentDate  | N/A  |

     # Vendor fill info to delivery method
    And VENDOR refresh page
    And Vendor edit info to self-deliver to Store
      | deliveryDate | from  | to    | comment  |
      | currentDate  | 00:00 | 00:30 | AutoTest |

     # Verify invoice in buyer
    And BUYER refresh page
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | [blank] |
    Then Buyer check confirm information
      | eta     | deliveryDate | eta2                |
      | [blank] | currentDate  | 12:00 am - 12:30 am |

     # Verify invoice in head buyer
    And HEAD_BUYER refresh page
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 |
    Then Buyer check confirm information
      | eta     | deliveryDate | eta2                |
      | [blank] | currentDate  | 12:00 am - 12:30 am |

    # Vendor delete shipping method
    And VENDOR refresh page
    And Vendor delete shipping method
    And Vendor verify unconfirmed item
    And Vendor Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | podConsignment |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | not set        |

    # Verify invoice in buyer is delete
    And BUYER refresh page
    Then Buyer verify no found order "create by api" in tab result

     # Verify invoice in buyer is delete
    And HEAD_BUYER refresh page
    Then Buyer verify no found order "create by api" in tab result
    And VENDOR quit browser
    And BUYER quit browser
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_42b @BUYERORDER
  Scenario: Check display of Delivery information with an PD sub-invoice confirmed with Delivery method = Self-deliver to Store - Remove item
    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail36chi07@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33200 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Vendor confirm that item with Delivery method
    Given VENDOR open web user
    When login to beta web with email "ngoctx+atvendororder01@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                   | payment | fullfillment | total  |
      | currentDate | create by api | ngoctx stborderdetail36 | Pending | Pending      | $95.00 |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku                      | date  |
      | AT SKU B Order Detail 36 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery              | store                   | address                                         |
      | Self-deliver to Store | ngoctx stborderdetail36 | 1554 West 18th Street, Chicago, Illinois, 60608 |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from    | to      | comment |
      | currentDate  | [blank] | [blank] | [blank] |
    And Vendor get ID sub invoice
      | index | sku                      |
      | 1     | AT SKU B Order Detail 36 |
    And Vendor remove sub invoice "all"
      | index | sku                      | itemRemove               |
      | 1     | AT SKU B Order Detail 36 | AT SKU B Order Detail 36 |
    And Vendor verify unconfirmed item
    And Vendor Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | podConsignment |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 36 | $100.00   | 1        | $100.00 | not set        |
    And VENDOR quit browser

    Given HEAD_BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
    And HEAD_BUYER Go to Dashboard
    And HEAD_BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    Then Buyer verify no found order "create by api" in tab result
    And HEAD_BUYER quit browser

  @B_ORDER_DETAILS_44 @BUYERORDER
  Scenario: Check displayed information on each PE item with promotion
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx631@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 43 | 33434              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
  # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 42 | 33182              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    And Admin search promotion by Promotion Name "AT Promo Buyer Order 01"
    And Admin delete promotion by skuName ""

    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 87893 | 26        | 33182              | 10000            | 10000      | in_stock     | active |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 88469 | 26        | 33434              | 1000             | 1000       | in_stock     | inactive |
        # Create promotion
    And Admin add region by API
      | region              | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Chicagoland Express | 26        | 33434 | 2907      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                    | description             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Buyer Order 01 | AT Promo Buyer Order 01 | currentDate | currentDate | 2           | 3          | 1                | true           | [blank] | default    | [blank]       |

     # Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+stbuyerorder11chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33182 | 1        |
      | 7289      | 33434 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                 | creator                    | payment | fulfillment | total   |
      | currentDate | create by api | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $220.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                  | storeName             | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder | discount |
      | ngoctx stbuyerorder11chi01 | ngoctx stBuyerOrder11 | 1544 West 18th Street, Chicago, Illinois, 60608 | $200.00    | $220.00 | By invoice | Pending | [blank]           | $30.00     | -$10.00  |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 42 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 112314123155 |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 43 | $100.00   | 1        | $90.00  | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

    Given NGOCTX login web admin by api
      | email                 | password  |
      | ngoctx631@podfoods.co | 12345678a |
    When Search order by sku "33434" by api
    And Admin delete order of sku "33434" by api
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 01"
    And Admin delete promotion by skuName ""

  @B_ORDER_DETAILS_45 @BUYERORDER
  Scenario: Check displayed information on each PD item with promotion
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx632@podfoods.co | 12345678a |
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 02"
    And Admin delete promotion by skuName ""
     # Create promotion
    And Admin add region by API
      | region             | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | Pod Direct Central | 58        | 64331 | 2996      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                    | description             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate |
      | Promotions::OnGoing | AT Promo Buyer Order 02 | AT Promo Buyer Order 02 | currentDate | currentDate | 2           | 3          | 1                | true           | [blank] | default    | [blank]       |
    # Inactive region Chicago
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 88475 | 58        | 33437              | 10000            | 10000      | in_stock     | active |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 88474 | 26        | 33437              | 1000             | 1000       | in_stock     | inactive |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 132278 | 26        | 64331              | 1000             | 1000       | in_stock     | inactive |
     # Create order
    Given Buyer login web with by api
      | email                                     | password  |
      | ngoctx+stborderdetail43bchi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33437 | 1        |
      | 7289      | 64331 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail43bchi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                    | creator                       | payment | fulfillment | total   |
      | currentDate | create by api | ngoctx stborderdetail43b | ngoctx stborderdetail43bchi01 | Pending | Pending     | $190.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                     | storeName                | shippingAddress                                 | orderValue | total   | payment    | status  | discount |
      | ngoctx stborderdetail43bchi01 | ngoctx stborderdetail43b | 1554 West 18th Street, Chicago, Illinois, 60608 | $200.00    | $190.00 | By invoice | Pending | -$10.00  |
    And Check items in order detail
      | brandName               | productName           | skuName                   | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 43b | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 112314123155 |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 45  | $100.00   | 1        | $90.00  | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx632@podfoods.co | 12345678a |
    When Search order by sku "64331" by api
    And Admin delete order of sku "64331" by api
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 02"
    And Admin delete promotion by skuName ""

  @B_ORDER_DETAILS_46 @B_ORDER_DETAILS_47 @BUYERORDER
  Scenario: Check the item information is changed or not on the order details when admin/vendor edits them
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx633@podfoods.co | 12345678a |
    When Search order by sku "64332" by api
    And Admin delete order of sku "64332" by api
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 132282 | 26        | 64333              | 1000             | 1000       | in_stock     | active |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 132280 | 26        | 64332              | 1000             | 1000       | in_stock     | active |

     # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail b46 | 64333              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 46 | 64332              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

      # Create order
    Given Buyer login web with by api
      | email                                  | password  |
      | ngoctx+stbuyerorder11chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 64333 | 1        |
      | 7289      | 64332 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Verify order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                 | creator                    | payment | fulfillment | total  |
      | currentDate | create by api | ngoctx stBuyerOrder11 | ngoctx stbuyerorder11chi01 | Pending | Pending     | $50.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                  | storeName             | shippingAddress                                 | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder |
      | ngoctx stbuyerorder11chi01 | ngoctx stBuyerOrder11 | 1544 West 18th Street, Chicago, Illinois, 60608 | $20.00     | $50.00 | By invoice | Pending | [blank]           | $30.00     |
    And Check items in order detail
      | brandName               | productName           | skuName                   | casePrice | quantity | total  | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 46  | $10.00    | 1        | $10.00 | [blank] | Unit UPC / EAN: 112314123155 |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail b46 | $10.00    | 1        | $10.00 | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx633@podfoods.co | 12345678a |
    When Search order by sku "64332" by api
    And Admin delete order of sku "64332" by api
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 132282 | 26        | 64333              | 1000             | 1000       | in_stock     | inactive |
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 132280 | 26        | 64332              | 1000             | 1000       | in_stock     | inactive |

  @B_ORDER_DETAILS_48 @BUYERORDER
  Scenario: Check display of price/case shown for each SKU - SKU active on both region, store, buyer-specific
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx642@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 48 | 33441              | 1000     | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail50chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33441 | 1        |
    And Checkout cart with payment by "invoice" by API

     # Verify order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail50chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                   | creator                      | payment | fulfillment | total   |
      | currentDate | create by api | ngoctx stborderdetail50 | ngoctx stborderdetail50chi01 | Pending | Pending     | $130.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName               | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | ngoctx stborderdetail50chi01 | ngoctx stborderdetail50 | 1554 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending | [blank]           | $30.00     |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 48 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

  @B_ORDER_DETAILS_49 @BUYERORDER
  Scenario: Check display of price/case shown for each SKU - SKU active in region specific
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx643@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 49 | 33443              | 1000     | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail50chi02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33443 | 1        |
    And Checkout cart with payment by "invoice" by API

     # Verify order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail50chi02@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                   | creator                      | payment | fulfillment | total   |
      | currentDate | create by api | ngoctx stborderdetail50 | ngoctx stborderdetail50chi02 | Pending | Pending     | $130.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName               | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | ngoctx stborderdetail50chi02 | ngoctx stborderdetail50 | 1554 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $130.00 | By invoice | Pending | [blank]           | $30.00     |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 49 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

  @B_ORDER_DETAILS_51 @BUYERORDER
  Scenario: Check display of price/case shown for each SKU - SKU active in region specific
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx644@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 50 | 33440              | 1000     | random   | 90           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail50chi03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33440 | 1        |
    And Checkout cart with payment by "invoice" by API

     # Verify order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail50chi03@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                   | creator                      | payment | fulfillment | total  |
      | currentDate | create by api | ngoctx stborderdetail50 | ngoctx stborderdetail50chi03 | Pending | Pending     | $40.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName               | shippingAddress                                 | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder |
      | ngoctx stborderdetail50chi03 | ngoctx stborderdetail50 | 1554 West 18th Street, Chicago, Illinois, 60608 | $10.00     | $40.00 | By invoice | Pending | $20.00            | $30.00     |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total  | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 50 | $10.00    | 1        | $10.00 | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

  @B_ORDER_DETAILS_56 @BUYERORDER
  Scenario: Check prioritizing store-specific promotions over region-specific promotions
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx634@podfoods.co | 12345678a |
    When Search order by sku "33527" by api
    And Admin delete order of sku "33527" by api
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 03"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 04"
    And Admin delete promotion by skuName ""
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 88624 | 53        | 33527              | 10000            | 10000      | in_stock     | active |
     # Create promotion store specific
    And Admin add region by API
      | region  | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | [blank] | [blank]   | 33527 | 3003      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                    | description             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | AT Promo Buyer Order 03 | AT Promo Buyer Order 03 | currentDate | currentDate | 2           | 3          | 1                | true           | [blank] | default    | [blank]       | false   |
   # Create promotion region specific
    And Admin add region by API
      | region           | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | New York Express | 53        | 33527 | [blank]   | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                    | description             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | AT Promo Buyer Order 04 | AT Promo Buyer Order 04 | currentDate | currentDate | 2           | 3          | 1                | true           | [blank] | default    | 2023-06-13    | false   |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 56 | 33527              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail56chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33527 | 1        |
    And Checkout cart with payment by "invoice" by API

     # Verify order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                   | creator                      | payment | fulfillment | total   |
      | currentDate | create by api | ngoctx stborderdetail56 | ngoctx stborderdetail56chi01 | Pending | Pending     | $120.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName               | shippingAddress                                | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder | discount |
      | ngoctx stborderdetail56chi01 | ngoctx stborderdetail56 | 280 Columbus Avenue, New York, New York, 10023 | $100.00    | $120.00 | By invoice | Pending | [blank]           | $30.00     | -$10.00  |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total  | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 56 | $100.00   | 1        | $90.00 | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx634@podfoods.co | 12345678a |
    When Search order by sku "33527" by api
    And Admin delete order of sku "33527" by api
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 03"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 04"
    And Admin delete promotion by skuName ""

  @B_ORDER_DETAILS_57 @BUYERORDER
  Scenario: Check the priority when many created store-specific promotions for the same store and same SKUs
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx635@podfoods.co | 12345678a |
    When Search order by sku "64334" by api
    And Admin delete order of sku "64334" by api
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 05"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 06"
    And Admin delete promotion by skuName ""
    And Admin change info of regions attributes with sku "active"
      | id     | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 132284 | 53        | 64334              | 10000            | 10000      | in_stock     | active |
     # Create promotion store specific
    And Admin add region by API
      | region  | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | [blank] | [blank]   | 64334 | 3003      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.1         | false | 1      |
    And Admin create promotion by api with info
      | type                | name                    | description             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::OnGoing | AT Promo Buyer Order 05 | AT Promo Buyer Order 05 | currentDate | currentDate | 2           | 3          | 1                | true           | [blank] | default    | [blank]       | false   |
    # Create promotion store specific
    And Admin add region by API
      | region  | region_id | idSKU | store_ids | excluded_buyer_company_ids | buyer_company_ids | excluded_store_ids | type                     |
      | [blank] | [blank]   | 64334 | 3003      | [blank]                    | [blank]           | [blank]            | PromotionRules::LineItem |
    And Admin add stack deal of promotion by API
      | typeCharge                             | chargeValue | stack | minQty |
      | PromotionActions::PercentageAdjustment | 0.2         | false | 1      |
    And Admin create promotion by api with info
      | type                  | name                    | description             | starts_at   | expires_at  | usage_limit | case_limit | minimum_num_case | vendor_visible | buy_in  | actionType | skuExpireDate | overlap |
      | Promotions::ShortDate | AT Promo Buyer Order 06 | AT Promo Buyer Order 06 | currentDate | currentDate | 2           | 3          | 1                | true           | [blank] | default    | 2023-06-13    | false   |
    # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 57 | 64334              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail56chi02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 64334 | 1        |
    And Checkout cart with payment by "invoice" by API

     # Verify order
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi02@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                   | creator                      | payment | fulfillment | total   |
      | currentDate | create by api | ngoctx stborderdetail56 | ngoctx stborderdetail56chi02 | Pending | Pending     | $110.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName               | shippingAddress                                | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder | discount |
      | ngoctx stborderdetail56chi02 | ngoctx stborderdetail56 | 280 Columbus Avenue, New York, New York, 10023 | $100.00    | $110.00 | By invoice | Pending | [blank]           | $30.00     | -$20.00  |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total  | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 57 | $100.00   | 1        | $80.00 | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

  @B_ORDER_DETAILS_61 @BUYERORDER
  Scenario: Check redirection when click on any line-items
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx635@podfoods.co | 12345678a |
    When Search order by sku "33658" by api
    And Admin delete order of sku "33658" by api
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 05"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "AT Promo Buyer Order 06"
    And Admin delete promotion by skuName ""
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 88819 | 53        | 33658              | 10000            | 10000      | in_stock     | active |
    # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 61 | 33658              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail56chi03@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7716      | 33658 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Verify
    Given BUYER open web user
    Given BUYER maximize browser
    When login to beta web with email "ngoctx+stborderdetail56chi03@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 02 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName           | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand Buyer Order 02 | AT Product B Order 02 | AT SKU B Order 61 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 121241231241 |

    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx635@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 88819 | 53        | 33658              | 10000            | 10000      | in_stock     | inactive |

    And Switch to actor BUYER
    And Buyer redirection when click in line item
    And Clear cart to empty in cart before
    And Add to cart the sku "AT SKU B Order M" with quantity = "1"
    And Verify item on cart tab on right side
      | brand                   | product               | sku              | price   | quantity |
      | AT Brand Buyer Order 02 | AT Product B Order 02 | AT SKU B Order M | $100.00 | 1        |
    And BUYER quit browser

  @B_ORDER_DETAILS_62a @BUYERORDER
  Scenario: Check state of Add to cart button by default - line item inactive
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx636@podfoods.co | 12345678a |
    When Search order by sku "33669" by api
    And Admin delete order of sku "33669" by api
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 88826 | 53        | 33669              | 10000            | 10000      | in_stock     | active |
      # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 62 | 33669              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail56chi04@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33669 | 1        |
    And Checkout cart with payment by "invoice" by API

    # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi04@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 62 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 112314123155 |
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx636@podfoods.co | 12345678a |
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state    |
      | 88826 | 53        | 33669              | 10000            | 10000      | in_stock     | inactive |
    And BUYER refresh page
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart                                                        | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 62 | $100.00   | 1        | $100.00 | This product is removed or no longer available in your region. | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

#  @B_ORDER_DETAILS_62b @BUYERORDER
#  Scenario: Check state of Add to cart button by default - line item is active but its availability is launching soon
#    Given NGOCTX06 login web admin by api
#      | email                | password  |
#      | ngoctx06@podfoods.co | 12345678a |
#     # Create order
#    And Admin change info of regions attributes with sku "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
#      | 88829 | 53        | 33670              | 10000            | 10000      | in_stock     | active | [blank]                  |
#    And Admin create line items attributes by API1
#      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
#      | 88829              | 33670              | 1        | false     | [blank]          |
#    Then Admin create order by API
#      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
#      | 3319     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |
#    # Change SKU to launching soon
#    And Admin change info of regions attributes with sku "active"
#      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
#      | 88829 | 53        | 33670              | 10000            | 10000      | coming_soon  | active | 2023-08-28               |
#        # Verify
#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
#    And BUYER Go to Dashboard
#    And BUYER Navigate to "Orders" by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
#    And Go to order detail with order number "create by api"
#    And Check items in order detail
#      | brandName               | productName           | skuName                   | casePrice | quantity | total   | addCart | unitUPC                      |
#      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 62b | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 112314123155 |
#    And BUYER refresh page
#    And Check items in order detail
#      | brandName               | productName           | skuName                   | casePrice | quantity | total   | addCart                                                        | unitUPC                      |
#      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 62b | $100.00   | 1        | $100.00 | This product is removed or no longer available in your region. | Unit UPC / EAN: 112314123155 |

  @B_ORDER_DETAILS_62c @BUYERORDER
  Scenario: Check state of Add to cart button by default - line item is active but its availability is Out of stock
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx637@podfoods.co | 12345678a |
    When Search order by sku "33670" by api
    And Admin delete order of sku "33670" by api
      # Create inventory
    And Admin create inventory api1
      | index | sku                       | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 62b | 33670              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

     # Create order
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88829 | 53        | 33670              | 10000            | 10000      | in_stock     | active | [blank]                  |
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88829              | 33670              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3319     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |
    # Change SKU to launching soon
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date | out_of_stock_reason |
      | 88829 | 53        | 33670              | 10000            | 10000      | sold_out     | active | [blank]                  | vendor_short_term   |

        # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName                   | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 62b | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 112314123155 |
    And BUYER refresh page
    And Check items in order detail
      | brandName               | productName           | skuName                   | casePrice | quantity | total   | addCart                | unitUPC                      |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 62b | $100.00   | 1        | $100.00 | Currently out of stock | Unit UPC / EAN: 112314123155 |
    And BUYER quit browser

  @B_ORDER_DETAILS_63 @BUYERORDER
  Scenario: Check display of Add to cart button when admin inactivates or deletes something
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx638@podfoods.co | 12345678a |
    When Search order by sku "33671" by api
    And Admin delete order of sku "33671" by api
    # Active product and sku
    And Change state of product id: "6055" to "inactive"
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 88830 | 53        | 33671              | 10000            | 10000      | in_stock     | active | [blank]                  |
         # Create inventory
    And Admin create inventory api1
      | index | sku               | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order 63 | 33671              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |
     # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88830              | 33671              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3319     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 33               | 10023 | true          | [blank]    | [blank]            | [blank]            |
   # Inactive product
    And Change state of product id: "7744" to "inactive"

        # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Go to order detail with order number "create by api"
    And Check items in order detail
      | brandName               | productName           | skuName           | casePrice | quantity | total   | addCart                                                        | unitUPC                      |
      | AT Brand Buyer Order 03 | AT Product B Order 03 | AT SKU B Order 63 | $100.00   | 1        | $100.00 | This product is removed or no longer available in your region. | Unit UPC / EAN: 121241231241 |
    And BUYER quit browser

  @B_ORDER_DETAILS_70 @BUYERORDER
  Scenario: Check the payment state of an order when it has both Paid invoice and Unpaid invoice - PE item
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx645@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 63 | 33673              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail56chi05@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7289      | 33673 | 1        |
    And Checkout cart with payment by "bank_or_cc" by API

    # Verify info
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi05@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number        | store                   | creator                      | payment | fulfillment | total   |
      | currentDate | create by api | ngoctx stborderdetail56 | ngoctx stborderdetail56chi05 | Pending | Pending     | $130.00 |
    And Go to order detail with order number "create by api"
    And Check information in order detail
      | buyerName                    | storeName               | shippingAddress                                | orderValue | total   | payment                                 | status  | logisticSurcharge | smallOrder |
      | ngoctx stborderdetail56chi05 | ngoctx stborderdetail56 | 280 Columbus Avenue, New York, New York, 10023 | $100.00    | $130.00 | Payment via credit card or bank account | Pending | [blank]           | $30.00     |
    And Check items in order detail
      | brandName               | productName           | skuName                  | casePrice | quantity | total   | addCart |
      | AT Brand Buyer Order 01 | AT Product B Order 01 | AT SKU B Order Detail 63 | $100.00   | 1        | $100.00 | [blank] |
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                              | paymentMethod                           |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stborderdetail56chi05 - ngoctx stborderdetail56, 280 Columbus Avenue, New York, New York, 10023 | Payment via credit card or bank account |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | [blank]           | 0.00         | 130.00 |
    And BUYER quit browser

  @B_ORDER_DETAILS_71 @BUYERORDER
  Scenario: Check the payment state of an order when it has both Paid invoice and Unpaid invoice - PE item
    Given NGOCTX05 login web admin by api
      | email                 | password  |
      | ngoctx646@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 63 | 33673              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

    # Clear cart
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail56chi06@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi06@podfoods.co" pass "12345678a" role "buyer"
    And Buyer search and add to cart
      | typeSearchSKU | typeSort                    | typeSearch | valueSearch           | brand                   | name                     | amount |
      | absolute      | Order by Brand name — A > Z | product    | AT Product B Order 01 | AT Brand Buyer Order 01 | AT SKU B Order Detail 63 | 1      |
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | 30.00              | [blank]           | [blank] | $130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | 30.00              | [blank]           | [blank] | $130.00 |
    And Buyer check out cart "Pay by invoice" with receiving info
      | customStore | customerPO     | department    | specialNote |
      | [blank]     | AT Cusomter PO | AT Department | [blank]     |
    And See invoice
    And Buyer verify info in Invoice ""
      | orderDate   | invoiceNumber | customerPO     | deliveryDate | department    | deliverTo                                                                                              | paymentMethod       |
      | currentDate | [blank]       | AT Cusomter PO | [blank]      | At department | ngoctx stborderdetail56chi06 - ngoctx stborderdetail56, 280 Columbus Avenue, New York, New York, 10023 | Payment via invoice |
    And BUYER quit browser

  @B_ORDER_DETAILS_72 @B_ORDER_DETAILS_73 @BUYERORDER
  Scenario: Check hide Small order surcharge, Logistic surcharge field when SOS, LS = 0
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx639@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 63 | 33673              | 10       | random   | 91           | currentDate  | [blank]     | [blank] |

      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88832              | 33673              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3321     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 14               | 10023 | true          | [blank]    | [blank]            | [blank]            |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail72chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                   | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stborderdetail72 | Pod Foods Admin | Pending | Pending     | $100.00 |
    And Go to order detail with order number "create by api"
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                              | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stborderdetail72chi01 - ngoctx stborderdetail72, 280 Columbus Avenue, New York, Illinois, 10023 | Payment via invoice |
    And BUYER quit browser

  @B_ORDER_DETAILS_74 @BUYERORDER
  Scenario: Check display of the Delivery date field - PD items
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx639@podfoods.co | 12345678a |
      # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88835              | 33691              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3321     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 14               | 10023 | true          | [blank]    | [blank]            | [blank]            |
    And Admin set Invoice by API
      | skuName                  | skuId | order_id            | eta_date | payment_state | surfix  |
      | AT SKU B Order Detail 74 | 33691 | create by api buyer | [blank]  | pending       | [blank] |
    # Fulfilled this order
    Then Admin update line item in order by api
      | index | skuName                  | skuId | order_id      | fulfilled |
      | 1     | AT SKU B Order Detail 74 | 33691 | create by api | true      |

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail72chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                   | checkoutAfter | checkoutBefore |
      | AT Brand Buyer Order 01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number          | store                   | creator         | payment | fulfillment | total   |
      | currentDate | create by admin | ngoctx stborderdetail72 | Pod Foods Admin | Pending | Fulfilled   | $100.00 |
    And Go to order detail with order number "create by api"
    And See invoice
    And Buyer verify info in Invoice "create by api"
      | orderDate   | invoiceNumber | customerPO | deliveryDate | department | deliverTo                                                                                              | paymentMethod       |
      | currentDate | [blank]       | [blank]    | [blank]      | [blank]    | ngoctx stborderdetail72chi01 - ngoctx stborderdetail72, 280 Columbus Avenue, New York, Illinois, 10023 | Payment via invoice |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total      |
      | [blank]            | [blank]           | 0.00         | USD 100.00 |
    And BUYER quit browser

  @B_ORDER_DETAILS_75 @BUYERORDER
  Scenario: Check display of the Delivery date field - PD and PE items
    Given NGOCTX06 login web admin by api
      | email                | password  |
      | ngoctx06@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 63 | 33673              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88832              | 33673              | 1        | false     | [blank]          |
      | 88835              | 33691              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3319     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 14               | 10023 | true          | [blank]    | [blank]            | [blank]            |

    # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Go to order detail with order number "create by api"
    Then Buyer reorder by button reorder then verify popup add items
      | header            | product               | sku                      | unitcase    | price   | description                                                                          | addButton |
      | Pod Express Items | AT Product B Order 01 | AT SKU B Order Detail 63 | 1 unit/case | $100.00 | These items will be consolidated and delivered to you from our distribution centers. | [blank]   |
      | Pod Direct Items  | AT Product B Order 01 | AT SKU B Order Detail 74 | 1 unit/case | $100.00 | These items will be delivered directly from the vendors.                             | [blank]   |
    And BUYER quit browser

  @B_ORDER_DETAILS_76 @B_ORDER_DETAILS_78 @BUYERORDER
  Scenario: Check display of the Delivery date field - PD items
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx640@podfoods.co | 12345678a |
    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88835              | 33691              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3319     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 14               | 10023 | true          | [blank]    | [blank]            | [blank]            |

    # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Go to order detail with order number "create by api"
    Then Buyer reorder by button reorder then verify popup add items
      | header           | product               | sku                      | unitcase    | price   | description                                              | addButton |
      | Pod Direct Items | AT Product B Order 01 | AT SKU B Order Detail 74 | 1 unit/case | $100.00 | These items will be delivered directly from the vendors. | [blank]   |
    And BUYER quit browser

  @B_ORDER_DETAILS_77 @B_ORDER_DETAILS_79 @BUYERORDER
  Scenario: Check display of the Delivery date field - PE items
    Given NGOCTX06 login web admin by api
      | email                 | password  |
      | ngoctx641@podfoods.co | 12345678a |
  # Create inventory
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU B Order Detail 63 | 33673              | 1000     | random   | 91           | currentDate  | [blank]     | [blank] |

    # Create order
    And Admin create line items attributes by API1
      | variants_region_id | product_variant_id | quantity | fulfilled | fulfillment_date |
      | 88832              | 33673              | 1        | false     | [blank]          |
    Then Admin create order by API
      | buyer_id | admin_note | customer_po | payment_type | num_of_delay | attn    | street1             | city     | address_state_id | zip   | has_surcharge | department | address_state_code | address_state_name |
      | 3319     | [blank]    | [blank]     | invoice      | [blank]      | [blank] | 280 Columbus Avenue | New York | 14               | 10023 | true          | [blank]    | [blank]            | [blank]            |

    # Verify
    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Go to order detail with order number "create by api"
    Then Buyer reorder by button reorder then verify popup add items
      | header            | product               | sku                      | unitcase    | price   | description                                                                          | addButton |
      | Pod Express Items | AT Product B Order 01 | AT SKU B Order Detail 63 | 1 unit/case | $100.00 | These items will be consolidated and delivered to you from our distribution centers. | [blank]   |
    And BUYER quit browser

  @B_ORDER_DETAILS_81 @B_ORDER_DETAILS_82 @BUYERORDER
  Scenario: Check validation the quantity box
    # Clear cart
    Given Buyer login web with by api
      | email                                    | password  |
      | ngoctx+stborderdetail56chi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+stborderdetail56chi01@podfoods.co" pass "12345678a" role "buyer"
    And Search product by name "AT Product B Order 01", sku "AT SKU B Order Detail 62b" and verify message "This flavor is not available"
    And BUYER quit browser

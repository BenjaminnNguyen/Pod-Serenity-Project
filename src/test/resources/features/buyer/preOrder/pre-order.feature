@feature=@PreOrder-flow
Feature: PreOrder-flow

  @PreOrder_01a @PreOrder
  Scenario: Head-buyer (PE) verify display of Pre-order on Order list > Tab All
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stpreorderchi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Verify in pre-order detail of SKU "AT SKU PreOrder 01" of product "AT Product PreOrder"
      | button    | availability   |
      | Pre-order | Launching Soon |
    And Buyer search product by name "AT Product PreOrder" and pre order with info
      | sku                | amount |
      | AT SKU PreOrder 01 | 1      |
    And HEAD_BUYER_PE Go to Dashboard
    And HEAD_BUYER_PE Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store             | creator                | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stPreOrder | ngoctx stPreOrderCHI01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName              | storeName         | buyerEmail                         | shippingAddress                                 | total   |
      | ngoctx stPreOrderCHI01 | ngoctx stPreOrder | ngoctx+stpreorderchi01@podfoods.co | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00 |
    And Check items in pre order detail
      | brandName         | productName         | skuName            | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand PreOrder | AT Product PreOrder | AT SKU PreOrder 01 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123456789123 |
    And Buyer back to Orders
    And Search Order in tab "Pending" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    Then Verify no found pre-order "" in tab result
    And Search Order in tab "In Progress" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    Then Verify no found pre-order "" in tab result
    And Search Order in tab "Fulfilled" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    Then Verify no found pre-order "" in tab result
    And Search Order in tab "Pre-order" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order result in tab Pre-order
      | index | order       | tag | number | store             | creator                | total   |
      | 1     | currentDate | Pre | random | ngoctx stPreOrder | ngoctx stPreOrderCHI01 | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName              | storeName         | buyerEmail                         | shippingAddress                                 | total   |
      | ngoctx stPreOrderCHI01 | ngoctx stPreOrder | ngoctx+stpreorderchi01@podfoods.co | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00 |
    And Check items in pre order detail
      | brandName         | productName         | skuName            | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand PreOrder | AT Product PreOrder | AT SKU PreOrder 01 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123456789123 |

  @PreOrder_01b @PreOrder
  Scenario: Head-buyer (PE) verify display of Pre-order on Order list > Tab All
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stpreorderchi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Verify in pre-order detail of SKU "AT SKU PreOrder 01" of product "AT Product PreOrder"
      | button    | availability   |
      | Pre-order | Launching Soon |
    And Buyer search product by name "AT Product PreOrder" and pre order with info
      | sku                | amount |
      | AT SKU PreOrder 01 | 1      |
    And HEAD_BUYER_PE Go to Dashboard
    And HEAD_BUYER_PE Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order in result
      | index | order       | tag | number | store             | creator                | payment | fulfillment | total   |
      | 1     | currentDate | Pre | random | ngoctx stPreOrder | ngoctx stPreOrderCHI01 | [blank] | [blank]     | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName              | storeName         | buyerEmail                         | shippingAddress                                 | total   |
      | ngoctx stPreOrderCHI01 | ngoctx stPreOrder | ngoctx+stpreorderchi01@podfoods.co | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00 |
    And Check items in pre order detail
      | brandName         | productName         | skuName            | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand PreOrder | AT Product PreOrder | AT SKU PreOrder 01 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123456789123 |
    And Buyer back to Orders
    And Search Order in tab "Pending" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    Then Verify no found pre-order "" in tab result
    And Search Order in tab "In Progress" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    Then Verify no found pre-order "" in tab result
    And Search Order in tab "Fulfilled" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    Then Verify no found pre-order "" in tab result
    And Search Order in tab "Pre-order" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order result in tab Pre-order
      | index | order       | tag | number | store             | creator                | total   |
      | 1     | currentDate | Pre | random | ngoctx stPreOrder | ngoctx stPreOrderCHI01 | $100.00 |
    And Buyer go to Pre-order detail number ""
    And Buyer verify customer info in pre-order detail
      | buyerName              | storeName         | buyerEmail                         | shippingAddress                                 | total   |
      | ngoctx stPreOrderCHI01 | ngoctx stPreOrder | ngoctx+stpreorderchi01@podfoods.co | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00 |
    And Check items in pre order detail
      | brandName         | productName         | skuName            | casePrice | quantity | total   | addCart | unitUPC                      |
      | AT Brand PreOrder | AT Product PreOrder | AT SKU PreOrder 01 | $100.00   | 1        | $100.00 | [blank] | Unit UPC / EAN: 123456789123 |

  @PreOrder_13a @PreOrder
  Scenario: Check display of Pre-orders list on Admin
    Given Buyer login web with by api
      | email                              | password  |
      | ngoctx+stpreorderchi01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add item to pre-order by API
      | productId | skuId | quantity |
      | 6541      | 31405 | 1        |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "Preorders" by sidebar
    And Admin search Pre order with info
      | orderNumber | storeName         | buyer                  | brand             | managedBy | startDate   | endDate     | state       |
      | [blank]     | ngoctx stPreOrder | ngoctx stPreOrderCHI01 | AT Brand PreOrder | [blank]   | currentDate | currentDate | Unconverted |
    And Admin verify result search pre order
      | buyer                  | store             | createDate  | status      |
      | ngoctx stPreOrderCHI01 | ngoctx stPreOrder | currentDate | Unconverted |
    And Admin go to detail pre-order ""
    Then Admin verify general info of pre-order detail
      | date        | store             | total   | state       | address                                         |
      | currentDate | ngoctx stPreOrder | $100.00 | Unconverted | 1544 West 18th Street, Chicago, Illinois, 60608 |
    And Admin verify line item in pre-order detail
      | sku                | product             | brand             | casePrice | unit         | quantity | state       | availability   |
      | AT SKU PreOrder 01 | AT Product PreOrder | AT Brand PreOrder | $100.00   | 1 units/case | 1        | Unconverted | Launching soon |

  @PreOrder_20 @PreOrder
  Scenario: Check display of Add to cart Alert have both SKU Launching soon and SKU In stock, Out of stock
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stpreorderchi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Verify in pre-order detail of SKU "AT SKU PreOrder 02" of product "AT Product PreOrder"
      | button    | availability   |
      | Pre-order | Launching Soon |

  @PreOrder_21 @PreOrder
  Scenario: Check display of Add to cart Alert only have SKU is Launching soon
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stpreorderchi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Buyer verify popup add to cart pre order of product "AT Product PreOrder" with sku "AT SKU PreOrder 02"
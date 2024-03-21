@feature=tax
Feature: Tax

  @Tax @Tax_01
  Scenario: Head buyer (PE) checks out with Taxes uncheck
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+tax1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Product Tax", sku "Auto sku tax" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax  | total  |
      | 30.00              | 20.00             | 1.00 | 151.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax  | total  |
      | 30.00              | 20.00             | 1.00 | 151.00 |
    And Check out cart "Pay by invoice" and "see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax  | total  |
      | 30.00              | 20.00             | 1.00 | 151.00 |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | 20.00             | 1.00         | 151.00 |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer    | store       | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoc tax | ngoc st tax | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $0.00    | $1.00 | $30.00              | [blank]            | $25.00           | $131.00 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And See detail order by idInvoice
    Then Verify price of "Tax" not display in vendor

  @Tax @Tax_02
  Scenario: Head buyer (PD) checks out with Taxes check
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+taxpm@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Product Tax 1 Discount PD", sku "Auto sku tax discount PD" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax  | total |
      | [blank]            | [blank]           | 1.00 | 1.00  |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax  | total |
      | [blank]            | [blank]           | 1.00 | 1.00  |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax  | total |
      | [blank]            | [blank]           | 1.00 | 1.00  |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region             | buyer      | store        | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Pod Direct Central | ngoc taxPM | ngoc sttaxPM | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $200.00    | $200.00  | $1.00 | Not applied         | $0.00       | $10.00           | $1.00 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And See detail order by idInvoice
    Then Verify price of "Tax" not display in vendor

  @Tax @Tax_03
  Scenario: Sub buyer checks out with Taxes check
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+staxdiscount1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Product Tax Discount", sku "Auto sku tax discount" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 0.00  |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 0.00  |
    And Check out cart "Pay by invoice" and "see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 0.00  |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total |
      | [blank]            | [blank]           | 0.00         | 0.00  |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer             | store                | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoc staxdiscount | ngoc st tax discount | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $100.00    | $100.00  | $0.00 | Not applied         | $0.00       | $25.00           | $0.00 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And See detail order by idInvoice
    Then Verify price of "Tax" not display in vendor
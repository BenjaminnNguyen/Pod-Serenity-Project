@feature=Order
Feature: Order

  @Order @Order_01
  Scenario: Head buyer (PE) checking buyer payment of sub-invoice is paid with payment method is paying by invoice
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store    | buyer       | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoc st1 | ngoctx chi1 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoc st1"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer       | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx chi1 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer       | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx chi1 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |

    Then Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 150           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net   |
      | $0.00      | $150.00    | $0.00 | $0.00     | ($150.00) | $0.00 |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer       | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx chi1 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description              | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest payment | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($150.00) | ($150.00) |

    And HEAD_BUYER_PE Go to Dashboard
    And HEAD_BUYER_PE Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                 | checkoutAfter | checkoutBefore |
      | AutoTest Brand Ngoc01 | currentDate   | currentDate    |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName   | storeName | shippingAddress                                 | orderValue | total   | payment    | status | logisticSurcharge | smallOrder |
      | ngoctx chi1 | ngoc st1  | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $150.00 | By invoice | Paid   | $20.00            | $30.00     |
    And Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 111123123012 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer       | store    | email                   | serviceFee | orderValue | orderTotal | payment |
      | ngoctx chi1 | ngoc st1 | ngoctx+chi1@podfoods.co | -$25.00    | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer       | store    | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx chi1 | ngoc st1 | CHI    | $100.00 | $25.00    | Paid         | Fulfilled   | Pending       |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And QA go to detail email "order fulfill"
    And verify info email order fulfilled
      | name                | line1                                  | line2                                                         |
      | Hello  ngoctx chi1, | Congrats on your order from ngoc st1 ! | This order will be fulfilled when your inventory is received. |
    And Verify items in order detail in email Create Order
      | brand                 | sku                  | casePrice                                | quantity | total   | promotion |
      | AutoTest Brand Ngoc01 | Autotest SKU1 Ngoc02 | Autotest SKU1 Ngoc02 $100.00 × 1 $100.00 | 1        | $100.00 | [blank]   |

  @Order @Order_02
  Scenario: Head buyer (PD) checking buyer payment of sub-invoice is paid with payment method is paying by invoice
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+pdtexas01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AutoTest Product 2 Ngoc01", sku "Autotest SKU2 Ngoc01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 10.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 10.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 10.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin choose non-invoice to create sub-invoice
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName              |
      | Autotest SKU2 Ngoc01 |
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU2 Ngoc01 | currentDate |
    And Admin get ID of sub-invoice of order "direct"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store     | buyer            | statementMonth | region             | managedBy |
      | ngoc cpn1    | ngoctx PD | ngoctx pdTexas01 | currentDate    | Pod Direct Central | [blank]   |
    And Admin go to detail of store statement "ngoctx PD"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer            | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx pdTexas01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer            | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx pdTexas01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |

    Then Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 10            | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment  | net   |
      | $0.00      | $10.00     | $0.00 | $0.00     | ($10.00) | $0.00 |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer            | status | aging   | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx pdTexas01 | Paid   | [blank] | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description              | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest payment | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($10.00) | ($10.00) |

    And HEAD_BUYER_PE Go to Dashboard
    And HEAD_BUYER_PE Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                 | checkoutAfter | checkoutBefore |
      | AutoTest Brand Ngoc02 | currentDate   | currentDate    |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName        | storeName | shippingAddress                          | orderValue | total  | payment    | status | logisticSurcharge | smallOrder |
      | ngoctx pdTexas01 | ngoctx PD | 5306 Canal Street, Houston, Texas, 77011 | $10.00     | $10.00 | By invoice | Paid   | [blank]           | [blank]    |
    And Check items in order detail
      | brandName             | productName               | skuName              | casePrice | quantity | total  | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | AutoTest Brand Ngoc02 | AutoTest Product 2 Ngoc01 | Autotest SKU2 Ngoc01 | $10.00    | 1        | $10.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123124123415 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region             | store     | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | ngoctx PD | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer            | store     | email                        | serviceFee | orderValue | orderTotal | payment |
      | ngoctx pdTexas01 | ngoctx PD | ngoctx+pdtexas01@podfoods.co | -$2.50     | $10.00     | $7.50      | Pending |
    And Vendor Check items in order detail
      | brandName             | productName               | skuName              | casePrice | quantity | total  |
      | AutoTest Brand Ngoc02 | AutoTest Product 2 Ngoc01 | Autotest SKU2 Ngoc01 | $10.00    | 1        | $10.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer            | store     | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx pdTexas01 | ngoctx PD | PDC    | $10.00 | $2.50     | Paid         | Fulfilled   | Pending       |

  @Order @Order_03
  Scenario: Sub buyer checking buyer payment of sub-invoice is paid with payment method is paying by invoice
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+schi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store        | buyer      | statementMonth | region              | managedBy |
      | auto cpn1    | auto chi st1 | auto schi1 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "auto chi st1"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer      | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | auto schi1 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer      | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | auto schi1 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |

    Then Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 150           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net   |
      | $0.00      | $150.00    | $0.00 | $0.00     | ($150.00) | $0.00 |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer      | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | auto schi1 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description              | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest payment | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($150.00) | ($150.00) |

    And HEAD_BUYER_PE Go to Dashboard
    And HEAD_BUYER_PE Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                 | checkoutAfter | checkoutBefore |
      | AutoTest Brand Ngoc01 | currentDate   | currentDate    |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName  | storeName    | shippingAddress                                   | orderValue | total   | payment    | status | logisticSurcharge | smallOrder |
      | auto schi1 | auto chi st1 | 2601 South Cicero Avenue, Cicero, Illinois, 60804 | $100.00    | $150.00 | By invoice | Paid   | [blank]           | [blank]    |
    And Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 111123123012 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region              | store        | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | auto chi st1 | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer      | store        | email                    | serviceFee | orderValue | orderTotal | payment |
      | auto schi1 | auto chi st1 | ngoctx+schi1@podfoods.co | -$25.00    | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer      | store        | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | auto schi1 | auto chi st1 | CHI    | $100.00 | $25.00    | Paid         | Fulfilled   | Pending       |

  @Order @Order_04
  Scenario: Head buyer (PE) checking buyer payment of sub-invoice is paid with payment method is paying by valid credit card
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stcard01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Check out cart "Visa ending in 4242" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin get sub invoice id to run job sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer           | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCard | ngoctx stCard01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCard"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer           | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCard01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer           | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCard01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store               | buyer           | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCard | ngoctx stCard01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCard"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer           | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCard01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Stripe      | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($150.00) | ($150.00) |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region              | store               | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoctx stCreditCard | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer           | store               | email                       | serviceFee | orderValue | orderTotal | payment |
      | ngoctx stCard01 | ngoctx stCreditCard | ngoctx+stcard01@podfoods.co | -$25.00    | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer           | store               | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCard01 | ngoctx stCreditCard | CHI    | $100.00 | $25.00    | Paid         | Fulfilled   | Pending       |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with value "Payment confirmation"
    And QA go to first email with title "Payment confirmation"
    And verify info email payment confirmation
      | name                   | line1              | line2                                                       | shippingAddress                                 |
      | Hello ngoctx stCard01, | Your payment for # | We have received your payment via credit card for Invoice # | 1544 West 18th Street, Chicago, Illinois, 60608 |
    And verify order detail of payment confirmation
      | brand                 | sku                  | price   | quantity | price1  | subtotal | bottelDeposit | discount | sos    | ls     | specialDiscount | total   |
      | AutoTest Brand Ngoc01 | Autotest SKU1 Ngoc02 | $100.00 | 1        | $100.00 | $100.00  | $0.00         | $0.00    | $30.00 | $20.00 | $0.00           | $150.00 |

  @Order @Order_05
  Scenario: Head buyer (PD) checking buyer payment of sub-invoice is paid with payment method is paying by valid credit card
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stCreditCardPD01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AutoTest Product 2 Ngoc01", sku "Autotest SKU2 Ngoc01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 10.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 10.00 |
    And Check out cart "Visa ending in 4242" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total |
      | [blank]            | [blank]           | [blank] | 10.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName              |
      | Autotest SKU2 Ngoc01 |
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU2 Ngoc01 | currentDate |
    And Admin get ID of sub-invoice of order "direct"
    And Admin get sub invoice id to run job sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                 | buyer                   | statementMonth | region             | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardPD | ngoctx stCreditCardPD01 | currentDate    | Pod Direct Central | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardPD"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                   | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stCreditCardPD01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                   | status | aging | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stCreditCardPD01 | Unpaid | 0     | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                 | buyer                   | statementMonth | region             | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardPD | ngoctx stCreditCardPD01 | currentDate    | Pod Direct Central | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardPD"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                   | status | aging   | description | orderValue | discount | deposit | fee   | credit  | pymt    | total  |
      | random  | currentDate | currentDate  | ngoctx stCreditCardPD01 | Paid   | [blank] | [blank]     | $10.00     | [blank]  | $0.00   | $0.00 | [blank] | [blank] | $10.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Stripe      | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($10.00) | ($10.00) |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region             | store                 | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | ngoctx stCreditCardPD | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer                   | store                 | email                               | serviceFee | orderValue | orderTotal | payment |
      | ngoctx stCreditCardPD01 | ngoctx stCreditCardPD | ngoctx+stcreditcardpd01@podfoods.co | -$2.50     | $10.00     | $7.50      | Pending |
    And Vendor Check items in order detail
      | brandName             | productName               | skuName              | casePrice | quantity | total  |
      | AutoTest Brand Ngoc02 | AutoTest Product 2 Ngoc01 | Autotest SKU2 Ngoc01 | $10.00    | 1        | $10.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer                   | store                 | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCreditCardPD01 | ngoctx stCreditCardPD | PDC | $10.00 | $2.50     | Paid         | Fulfilled   | Pending       |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with value "Payment confirmation"
    And QA go to first email with title "Payment confirmation"
    And verify info email payment confirmation
      | name                           | line1              | line2                                                       | shippingAddress                          |
      | Hello ngoctx stCreditCardPD01, | Your payment for # | We have received your payment via credit card for Invoice # | 5306 Canal Street, Houston, Texas, 77011 |
    And verify order detail of payment confirmation
      | brand                 | sku                  | price   | quantity | price1 | subtotal | bottelDeposit | discount | sos     | ls      | specialDiscount | total  |
      | AutoTest Brand Ngoc02 | Autotest SKU2 Ngoc01 | $100.00 | 1        | $10.00 | $10.00   | $0.00         | $0.00    | [blank] | [blank] | $0.00           | $10.00 |

  @Order @Order_06
  Scenario: Sub buyer checking buyer payment of sub-invoice is paid with payment method is paying by valid credit card
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stcardsub01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Check out cart "Visa ending in 4242" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin get sub invoice id to run job sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store               | buyer              | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCard | ngoctx stcardsub01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCard"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer              | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stcardsub01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer              | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stcardsub01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store               | buyer              | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCard | ngoctx stcardsub01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCard"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer              | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stcardsub01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Stripe      | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($150.00) | ($150.00) |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region              | store               | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoctx stCreditCard | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer              | store               | email                          | serviceFee | orderValue | orderTotal | payment |
      | ngoctx stcardsub01 | ngoctx stCreditCard | ngoctx+stcardsub01@podfoods.co | -$25.00    | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer              | store               | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stcardsub01 | ngoctx stCreditCard | CHI    | $100.00 | $25.00    | Paid         | Fulfilled   | Pending       |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with value "Payment confirmation"
    And QA go to first email with title "Payment confirmation"
    And verify info email payment confirmation
      | name                      | line1              | line2                                                       | shippingAddress                                 |
      | Hello ngoctx stcardsub01, | Your payment for # | We have received your payment via credit card for Invoice # | 1544 West 18th Street, Chicago, Illinois, 60608 |
    And verify order detail of payment confirmation
      | brand                 | sku                  | price   | quantity | price1  | subtotal | bottelDeposit | discount | sos    | ls     | specialDiscount | total   |
      | AutoTest Brand Ngoc01 | Autotest SKU1 Ngoc02 | $100.00 | 1        | $100.00 | $100.00  | $0.00         | $0.00    | $30.00 | $20.00 | $0.00           | $150.00 |

  @Order @Order_07
  Scenario: Head buyer (PE) checking buyer payment of sub-invoice is paid with payment method is paying by invalid credit card
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stcardinvalid01@podfood.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |
    And Check out cart "Visa ending in 3178" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | [blank]           | [blank] | 130.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin get sub invoice id to run job sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                      | buyer                  | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardInvalid | ngoctx stCardInvalid01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardInvalid"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                      | buyer                  | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardInvalid | ngoctx stCardInvalid01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardInvalid"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status   | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Declined | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $30.00 | [blank] | [blank] | $130.00 |

    And HEAD_BUYER_PE Go to Dashboard
    And HEAD_BUYER_PE Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                 | checkoutAfter | checkoutBefore |
      | AutoTest Brand Ngoc01 | currentDate   | currentDate    |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName              | storeName                  | shippingAddress                                 | orderValue | total   | payment                                 | status   | smallOrder |
      | ngoctx stCardInvalid01 | ngoctx stCreditCardInvalid | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $150.00 | Payment via credit card or bank account | Declined | $30.00     |
    And Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 111123123012 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region              | store                      | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoctx stCreditCardInvalid | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer                  | store                      | email                             | serviceFee | orderValue | orderTotal | payment |
      | ngoctx stCardInvalid01 | ngoctx stCreditCardInvalid | ngoctx+stcardinvalid01@podfood.co | -$25.00    | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer                  | store                      | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCardInvalid01 | ngoctx stCreditCardInvalid | CHI    | $100.00 | $25.00    | Declined     | Fulfilled   | Pending       |

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                      | buyer                  | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardInvalid | ngoctx stCardInvalid01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardInvalid"
    Then Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note                      | creditMemos | unappliedPayment | adjustment |
      | random  | 150           | currentDate | Other       | Autotest payment declined | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net   |
      | $0.00      | $150.00    | $0.00 | $0.00     | ($150.00) | $0.00 |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description                       | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest payment declined | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($150.00) | ($150.00) |

  @Order @Order_08 @STORE-STATEMENT_34
  Scenario: Head buyer (PE) checking buyer payment of sub-invoice is paid with payment method is paying by invalid credit card
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stcardinvalid01@podfood.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Check out cart "Visa ending in 3178" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"
    And Admin get sub invoice id to run job sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store                      | buyer                  | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardInvalid | ngoctx stCardInvalid01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardInvalid"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin run job StripeChargeSubInvoiceJob in sidekiq

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                      | buyer                  | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardInvalid | ngoctx stCardInvalid01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardInvalid"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status   | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Declined | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with value "Order will be fulfilled when your inventory is received"
    And QA go to first email with title "Order will be fulfilled when your inventory is received"
    And verify info email order fulfilled
      | name             | line1                                                   | line2                                                         |
      | Hello ngoc vc 1, | Congrats on your order from ngoctx stCreditCardInvalid! | This order will be fulfilled when your inventory is received. |
    And Verify items in order detail in email Create Order
      | brand                 | sku                  | casePrice                                | quantity | total   | promotion |
      | AutoTest Brand Ngoc01 | Autotest SKU1 Ngoc02 | Autotest SKU1 Ngoc02 $100.00 × 1 $100.00 | 1        | $100.00 | [blank]   |

    And HEAD_BUYER_PE Go to Dashboard
    And HEAD_BUYER_PE Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                 | checkoutAfter | checkoutBefore |
      | AutoTest Brand Ngoc01 | currentDate   | currentDate    |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName              | storeName                  | shippingAddress                                 | orderValue | total   | payment                                 | status   | logisticSurcharge | smallOrder |
      | ngoctx stCardInvalid01 | ngoctx stCreditCardInvalid | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $150.00 | Payment via credit card or bank account | Declined | $20.00            | $30.00     |
    And Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 111123123012 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And HEAD_VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Fulfilled"
      | region              | store                      | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoctx stCreditCardInvalid | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor check general info
      | buyer                  | store                      | email                             | serviceFee | orderValue | orderTotal | payment |
      | ngoctx stCardInvalid01 | ngoctx stCreditCardInvalid | ngoctx+stcardinvalid01@podfood.co | -$25.00    | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName             | productName             | skuName              | casePrice | quantity | total   |
      | AutoTest Brand Ngoc01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $100.00   | 1        | $100.00 |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer                  | store                      | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCardInvalid01 | ngoctx stCreditCardInvalid | CHI    | $100.00 | $25.00    | Declined     | Fulfilled   | Pending       |

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store                      | buyer                  | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx stCreditCardInvalid | ngoctx stCardInvalid01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx stCreditCardInvalid"
    Then Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note                      | creditMemos | unappliedPayment | adjustment |
      | random  | 150           | currentDate | Other       | Autotest payment declined | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net   |
      | $0.00      | $150.00    | $0.00 | $0.00     | ($150.00) | $0.00 |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                  | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx stCardInvalid01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description                       | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest payment declined | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($150.00) | ($150.00) |


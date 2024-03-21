#mvn verify -Dtestsuite="ImportantFlowTestSuite" -Dcucumber.options="src/test/resources/features" -Denvironment=default -Dfailsafe.rerunFaillingTestsCount=1
@feature=important-flow
Feature: Important flow

  @Surcharge @Surcharge_01
  Scenario: Head buyer checks out with small order surcharge
    Given NGOCTX06 login web admin by api
      | email                | password  |
      | ngoctx06@podfoods.co | 12345678a |
    When Admin search order by API
      | skuID | fulfillment_state | buyer_payment_state |
      | 29988 | [blank]           | pending             |
    And Admin delete order of sku "29988" by api

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc01" and add to cart with amount = "1"
    And Search product by name "AutoTest Product 2 Ngoc01", sku "Autotest SKU2 Ngoc01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 256.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 256.00 |
    And Check out this order
    And Check out cart "Pay by invoice" and "see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 256.00 |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | 20.00             | 0.00         | 152.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then NGOC_ADMIN verify price in order details of Admin
      | smallOrderSurchage | logisticsSurchage | total  |
      | 30.00              | 20.00             | 256.00 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And See detail order by idInvoice
    Then Verify price of "Small Order Surchage" not display in vendor
    Then Verify price of "Logistics Surchage" not display in vendor

  @Surcharge @Surcharge_02
  Scenario: Head buyer PD checks out with small order surcharge
    Given HEAD_BUYER_PD open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AutoTest Product 2 Ngoc01", sku "Autotest SKU2 Ngoc01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout" not display and total = "104.00"
    Then Verify price in cart "details" not display and total = "104.00"
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 104.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName              |
      | Autotest SKU2 Ngoc01 |
    Given BUYER open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "Pending" with
      | brand                 | checkoutAfter | checkoutBefore |
      | AutoTest Brand Ngoc02 | currentDate   | [blank]        |
    And Go to order detail with order number ""
    And BUYER refresh page
    And BUYER verify sub-invoice is created
    Then Verify price in sub-invoice not display and total = "104.00"

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And See detail order by idInvoice
    Then Verify price of "Small Order Surchage" not display in vendor
    Then Verify price of "Logistics Surchage" not display in vendor

  @Surcharge @Surcharge_03
  Scenario: Sub buyer PE checks out with small order surcharge (price > threshold)
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc01" and add to cart with amount = "1"
    And Search product by name "AutoTest Product 2 Ngoc01", sku "Autotest SKU2 Ngoc01" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 256.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 256.00 |
    And Check out cart "Pay by invoice" and "see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 256.00 |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | 20.00             | 0.00         | 152.00 |

  @Buyer @Buyer_checkout_with_MOQ
  Scenario: Buyer checkout with MOQ
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer15@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto product check moq1"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                    | productName             | productBrand         | pricePerUnit | pricePerCase | availability |
      | Auto product check moq1 | Auto product check moq1 | Auto Brand check MOQ | $10.00       | $10.00       | In Stock     |
    And Clear cart to empty in cart before
    And Add to cart the sku "auto sku checkmoq1" with quantity = "1"
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 1        | 9        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check Items in MOQ alert
      | productName             | skuName               | unitCase    | price  | quantity |
      | Auto product check moq1 | auto sku checkmoq1    | 1 unit/case | $10.00 | 0        |
      | Auto product check moq1 | auto_flow create sku6 | 1 unit/case | $12.00 | 0        |
    And Check button update cart is "disabled" in MOQ alert
    And Close MOQ alert
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ alert on cart page
      | alert | notice | moq |
      | true  | true   | 10  |
    And Search item and go to detail of first result
      | item                    | productName             | productBrand         | pricePerUnit | pricePerCase | availability |
      | Auto product check moq1 | Auto product check moq1 | Auto Brand check MOQ | $10.00       | $10.00       | In Stock     |
    And Clear cart to empty in cart before
    And Add to cart the sku "auto sku checkmoq1" with quantity = "1"
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 1        | 9        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check Items in MOQ alert
      | productName             | skuName               | unitCase    | price  | quantity |
      | Auto product check moq1 | auto sku checkmoq1    | 1 unit/case | $10.00 | 0        |
      | Auto product check moq1 | auto_flow create sku6 | 1 unit/case | $12.00 | 0        |
    And Check button update cart is "disabled" in MOQ alert
    And Change quantity of skus in MOQ alert
      | skuName               | quantity |
      | auto sku checkmoq1    | 1        |
      | auto_flow create sku6 | 0        |
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 1        | 8        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check button update cart is "enable" in MOQ alert
    And Change quantity of skus in MOQ alert
      | skuName            | quantity |
      | auto sku checkmoq1 | 9        |
    And Check notice disappear in MOQ alert
    And Update cart MOQ Alert
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ alert on cart page
      | alert | notice | moq |
      | false | false  | 10  |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Check information in order detail
      | buyerName                        | storeName          | shippingAddress                               | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | Auto BuyerCheckMOQNewyorkExpress | Auto+StoreCheckMOQ | 455 Madison Avenue, New York, New York, 10022 | $100.00    | $150.00 | By invoice | Pending | $20.00            | $30.00     |
    And Check items in order detail
      | brandName            | productName             | skuName            | casePrice | quantity | total   | addCart |
      | Auto Brand check MOQ | Auto product check moq1 | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank] |

#    Check email to Admin
    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co New Order Received Auto BuyerCheckMOQNewyorkExpress"
    And QA go to first email with title "Pod Foods Order Details"
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                     | orderNumber  | orderDate  | orderDateState             | buyer                            | managerBy |
      | Auto BuyerCheckMOQNewyorkExpress from Auto+StoreCheckMOQ placed a new order. | Order Number | Order Date | Pacific Time (US & Canada) | Auto BuyerCheckMOQNewyorkExpress | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank]   |
    And Verify prices in order detail in email Create Order
      | orderValue         | discount      | subtotal        | smallOrderSurcharge         | logisticsSurcharge        | bottleDeposit       | specialDiscount       | total        |
      | Order value$100.00 | Discount$0.00 | Subtotal$100.00 | Small order surcharge$30.00 | Logistics surcharge$20.00 | Bottle Deposit$0.00 | Special discount$0.00 | Total$150.00 |
    And Check customer information in email Create Order
      | shippingAddress                                               | paymentInformation |
      | Shipping address455 Madison Avenue, New York, New York, 10022 | [blank]            |

#    Check email of Vendor
    Given USER_EMAIL2 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autovendor15@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                        | orderNumber  | orderDate  | orderDateState             | buyer                            | managerBy |
      | Congrats on your order from Auto+StoreCheckMOQ! | Order Number | Order Date | Pacific Time (US & Canada) | Auto BuyerCheckMOQNewyorkExpress | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank]   |

    #    Check email of Buyer
    Given USER_EMAIL3 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL3 search email with sender "to:ngoctx+autobuyer15@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                        | orderNumber  | orderDate  | orderDateState             | buyer                            | managerBy                                                                                                                                          |
      | Hello Auto BuyerCheckMOQNewyorkExpress,Thank you for your order with Pod Foods! | Order Number | Order Date | Pacific Time (US & Canada) | Auto BuyerCheckMOQNewyorkExpress | You can expect your order to be delivered within 3-5 days. You can always find up-to-date ETAs and your order details in your Pod Foods Dashboard. |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank]   |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                            | store              | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | Auto BuyerCheckMOQNewyorkExpress | Auto+StoreCheckMOQ | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $0.00    | $0.00 | $30.00              | [blank]            | $25.00           | $150.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                 | sku                | unitCase     | casePrice | quantity | endQuantity | total   |
      | Auto Brand check MOQ | Auto product check moq1 | auto sku checkmoq1 | 1 units/case | $10.00    | 10       | 0           | $100.00 |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor15@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor Check orders in dashboard order
      | ordered     | number  | store              | payment | fullfillment | total  |
      | currentDate | [blank] | Auto+StoreCheckMOQ | Pending | Pending      | $75.00 |
    And Vendor Go to order detail with order number ""
    And Vendor Check items in order detail
      | brandName            | productName             | skuName            | casePrice | quantity | total   | podConsignment |
      | Auto Brand check MOQ | Auto product check moq1 | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank]        |

  @Buyer @Buyer_checkout_with_MOQ2
  Scenario: Head BUYER PD checkout with MOQ
#    Head BUYER PD
    Given BUYER_PD open web user
    And login to beta web with email "ngoctx+autobuyer16@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto product check moq1"
    And Search item and go to detail of first result
      | item                    | productName             | productBrand         | pricePerUnit | pricePerCase | availability |
      | Auto product check moq1 | Auto product check moq1 | Auto Brand check MOQ | $10.00       | $10.00       | In Stock     |
#    And Check badge Direct is "true"
    And Add to cart the sku "auto sku checkmoq1" with quantity = "1"
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 0        | 9        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check Items in MOQ alert
      | productName             | skuName            | unitCase    | price  | quantity |
      | Auto product check moq1 | auto sku checkmoq1 | 1 unit/case | $10.00 | 1        |
    And Check button update cart is "disabled" in MOQ alert
    And Change quantity of skus in MOQ alert
      | skuName            | quantity |
      | auto sku checkmoq1 | 3        |
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 0        | 7        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check button update cart is "enable" in MOQ alert
    And Change quantity of skus in MOQ alert
      | skuName            | quantity |
      | auto sku checkmoq1 | 10       |
    And Check notice disappear in MOQ alert
    And Update cart MOQ Alert
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ alert on cart page
      | alert | notice | moq |
      | false | false  | 10  |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 100.00 |
    And Check information in order detail
      | buyerName            | storeName                                          | shippingAddress                                            | orderValue | total   | payment    | status  |
      | Auto BuyerCheckMOQPD | Auto Store CheckMOQ Pod Direct Southwest & Rockies | 9807 Bell Ranch Drive, Santa Fe Springs, California, 90670 | $100.00    | $100.00 | By invoice | Pending |
    And Check items in order detail
#    addCart = 'disabled' if want to check button addCart is disable
      | brandName            | productName             | skuName            | casePrice | quantity | total   | addCart |
      | Auto Brand check MOQ | Auto product check moq1 | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank] |

#    Check email to Admin
    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co Auto BuyerCheckMOQPD"
    And QA go to first email with title "Pod Foods Order Details"
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                                         | orderNumber  | orderDate  | orderDateState             | buyer                | managerBy |
      | Auto BuyerCheckMOQPD from Auto Store CheckMOQ Pod Direct Southwest & Rockies placed a new order. | Order Number | Order Date | Pacific Time (US & Canada) | Auto BuyerCheckMOQPD | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank]   |
    And Verify prices in order detail in email Create Order
      | orderValue         | discount      | subtotal        | smallOrderSurcharge | logisticsSurcharge | bottleDeposit       | specialDiscount       | total        |
      | Order value$100.00 | Discount$0.00 | Subtotal$100.00 | [blank]             | [blank]            | Bottle Deposit$0.00 | Special discount$0.00 | Total$100.00 |
    And Check customer information in email Create Order
      | shippingAddress                                                            | paymentInformation |
      | Shipping address9807 Bell Ranch Drive, Santa Fe Springs, California, 90670 | [blank]            |

#    Check email of Vendor
    Given USER_EMAIL2 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autovendor15@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                                   | orderNumber  | orderDate  | orderDateState             | buyer                | managerBy |
      | Congrats on your Pod Direct order from Auto Store CheckMOQ Pod Direct Southwest & Rockies! | Order Number | Order Date | Pacific Time (US & Canada) | Auto BuyerCheckMOQPD | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank]   |

    #    Check email of Buyer
    Given USER_EMAIL3 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL3 search email with sender "to:ngoctx+autobuyer16@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                            | orderNumber  | orderDate  | orderDateState             | buyer                | managerBy                                                                                                                                          |
      | Hello Auto BuyerCheckMOQPD,Thank you for your order with Pod Foods! | Order Number | Order Date | Pacific Time (US & Canada) | Auto BuyerCheckMOQPD | You can expect your order to be delivered within 3-5 days. You can always find up-to-date ETAs and your order details in your Pod Foods Dashboard. |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 10       | $100.00 | [blank]   |

  @Buyer @Real_order
  Scenario Outline: Head buyer preoder successfully -> Then convert item on pre order to real order
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                    | productState | brandName             | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Autotest product ngoc01 | Active       | AutoTest Brand Ngoc01 | ngoc vc 1     | Almond Milk | [blank]     | [blank]    | [blank]     | [blank] |
    And Change availability of SKU "Autotest sku preorder" in product "Autotest product ngoc01"
      | regionName          | casePrice | msrpunit | availability   |
      | Chicagoland Express | 100       | 100      | Launching soon |
    And Click Update

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "<user>" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Verify in pre-order detail of SKU "Autotest sku preorder" of product "Autotest product ngoc01"
      | button    | availability   |
      | Pre-order | Launching Soon |
    And Buyer search product by name "Autotest product ngoc01" and pre order with info
      | sku                   | amount |
      | Autotest sku preorder | 1      |
    And Verify pre-order in tag All of order just create
      | date        | tag | store   | creator   | total   |
      | currentDate | Pre | <store> | <creator> | $100.00 |
    And Verify pre-order in tag Pre-order of order just create
      | date        | tag | store   | creator   | total   |
      | currentDate | Pre | <store> | <creator> | $100.00 |

    And NGOC_ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                    | productState | brandName             | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Autotest product ngoc01 | Active       | AutoTest Brand Ngoc01 | ngoc vc 1     | Almond Milk | [blank]     | [blank]    | [blank]     | [blank] |
    And Change availability of SKU "Autotest sku preorder" in product "Autotest product ngoc01"
      | regionName          | casePrice | msrpunit | availability |
      | Chicagoland Express | 100       | 100      | In stock     |
    And Click Update

    And HEAD_BUYER_PE go to catalog "All"
    And Verify in pre-order detail of SKU "Autotest sku preorder" of product "Autotest product ngoc01"
      | button      | availability |
      | Add to Cart | In Stock     |

    And NGOC_ADMIN navigate to "Orders" to "Preorders" by sidebar
    And Admin search Pre order with info
      | orderNumber | storeName | buyer     | brand                 | managedBy | startDate   | endDate     | state       |
      | [blank]     | <store>   | <creator> | AutoTest Brand Ngoc01 | [blank]   | currentDate | currentDate | Unconverted |
    And Admin go to create order in pre order
    Then Verify price "in stock" in create new order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 1         | $100.00         | $0.00    | $0.00 | $30.00              | $20.00             | $0.00           | $150.00      |
    And Admin create order in pre order
      | street            | city      | state      | zip   |
      | 123 Alaska Avenue | Fairfield | California | 94533 |
    Then NGOC_ADMIN verify price in order details of Admin
      | smallOrderSurchage | logisticsSurchage | total  |
      | 30.00              | 20.00             | 150.00 |
    And NGOC_ADMIN navigate to "Orders" to "Preorders" by sidebar
    And Admin search Pre order with info
      | orderNumber | storeName | buyer     | brand                 | managedBy | startDate   | endDate     | state     |
      | [blank]     | <store>   | <creator> | AutoTest Brand Ngoc01 | [blank]   | currentDate | currentDate | Converted |
    And Admin verify result search pre order
      | buyer     | store   | createDate  | status    |
      | <creator> | <store> | currentDate | Converted |

    Examples:
      | user                  | creator       | store    |
      | ngoc+chi1@podfoods.co | ngoc chicago1 | ngoc st1 |
#      | ngoc+schi1@podfoods.co | auto schi1 | auto chi st1 |

  @Buyer @Buyer_checkout_with_MOQ3
  Scenario: Sub BUYER checkout with MOQ
      #    Sub BUYER
    Given SUB_BUYER open web user
    And login to beta web with email "ngoctx+autobuyer17@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "Auto product check moq1"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                    | productName             | productBrand         | pricePerUnit | pricePerCase | availability |
      | Auto product check moq1 | Auto product check moq1 | Auto Brand check MOQ | $10.00       | $10.00       | In Stock     |
    And Clear cart to empty in cart before
    And Add to cart the sku "auto sku checkmoq1" with quantity = "1"
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 1        | 9        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check Items in MOQ alert
      | productName             | skuName               | unitCase    | price  | quantity |
      | Auto product check moq1 | auto sku checkmoq1    | 1 unit/case | $10.00 | 0        |
      | Auto product check moq1 | auto_flow create sku6 | 1 unit/case | $12.00 | 0        |
    And Check button update cart is "disabled" in MOQ alert
    And Change quantity of skus in MOQ alert
      | skuName               | quantity |
      | auto sku checkmoq1    | 1        |
      | auto_flow create sku6 | 0        |
    And Check MOQ alert
      | quantity | caseMore | notice                                                                                                                                               |
      | 1        | 8        | Please add more cases to your order to meet the minimum number of cases required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Check button update cart is "enable" in MOQ alert
    And Change quantity of skus in MOQ alert
      | skuName            | quantity |
      | auto sku checkmoq1 | 10       |
    And Check notice disappear in MOQ alert
    And Update cart MOQ Alert
    And Go to Cart detail
    And Buyer close recommended items modal
    And Check MOQ alert on cart page
      | alert | notice | moq |
      | false | false  | 10  |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | $30.00             | $20.00            | [blank] | 160.00 |
    And Check information in order detail
      | buyerName             | storeName                  | shippingAddress                               | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | Auto SubBuyerCheckMOQ | Auto Store check MOQ Texas | 455 Madison Avenue, New York, New York, 10022 | $110.00    | $160.00 | By invoice | Pending | $20.00            | $30.00     |
    And Check items in order detail
#    addCart = 'disabled' if want to check button addCart is disable
      | brandName            | productName             | skuName            | casePrice | quantity | total   | addCart |
      | Auto Brand check MOQ | Auto product check moq1 | auto sku checkmoq1 | $10.00    | 11       | $110.00 | [blank] |

#    Check email to Admin
    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co Auto SubBuyerCheckMOQ"
    And QA go to first email with title "Pod Foods Order Details"
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                  | orderNumber  | orderDate  | orderDateState             | buyer                 | managerBy |
      | Auto SubBuyerCheckMOQ from Auto Store check MOQ Texas placed a new order. | Order Number | Order Date | Pacific Time (US & Canada) | Auto SubBuyerCheckMOQ | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 11       | $110.00 | [blank]   |
    And Verify prices in order detail in email Create Order
      | orderValue         | discount      | subtotal        | smallOrderSurcharge | logisticsSurcharge | bottleDeposit       | specialDiscount       | total        |
      | Order value$110.00 | Discount$0.00 | Subtotal$110.00 | $30.00              | $20.00             | Bottle Deposit$0.00 | Special discount$0.00 | Total$160.00 |
    And Check customer information in email Create Order
      | shippingAddress                                               | paymentInformation |
      | Shipping address455 Madison Avenue, New York, New York, 10022 | [blank]            |

#    Check email of Vendor
    Given USER_EMAIL2 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autovendor15@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                | orderNumber  | orderDate  | orderDateState             | buyer                 | managerBy |
      | Congrats on your order from Auto Store check MOQ Texas! | Order Number | Order Date | Pacific Time (US & Canada) | Auto SubBuyerCheckMOQ | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 11       | $110.00 | [blank]   |

    #    Check email of Buyer
    Given USER_EMAIL3 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL3 search email with sender "to:ngoctx+autobuyer17@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                             | orderNumber  | orderDate  | orderDateState             | buyer                 | managerBy                                                                                                                                          |
      | Hello Auto SubBuyerCheckMOQ,Thank you for your order with Pod Foods! | Order Number | Order Date | Pacific Time (US & Canada) | Auto SubBuyerCheckMOQ | You can expect your order to be delivered within 3-5 days. You can always find up-to-date ETAs and your order details in your Pod Foods Dashboard. |
    And Verify items in order detail in email Create Order
      | brand                | sku                | casePrice | quantity | total   | promotion |
      | Auto Brand check MOQ | auto sku checkmoq1 | $10.00    | 11       | $110.00 | [blank]   |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region         | buyer                 | store                      | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Dallas Express | Auto SubBuyerCheckMOQ | Auto Store check MOQ Texas | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $110.00    | $0.00    | $0.00 | $30.00              | [blank]            | $27.50           | $160.00 |
    And Admin check line items "sub invoice" in order details
      | brand                | product                 | sku                | unitCase     | casePrice | quantity | endQuantity | total   |
      | Auto Brand check MOQ | Auto product check moq1 | auto sku checkmoq1 | 1 units/case | $10.00    | 11       | [blank]     | $110.00 |

  @Vendor @Vendor_Create_Inbound_Inventory_successfully_and_then_become_to_real_Inventory
#    Giờ k cho vendor tạo inbound
  Scenario Outline: Vendor create an inbound inventory successfully -> Then process inbound inventory to real Inventory
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Delete all inventory with product "Auto product check inbound inventory"
    And Delete all Inbound inventory with brand "2832"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor18@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
#    And Click Create new inbound inventory
#    And Check General Instructions
    And Choose Region "South California Express" and check Instructions
    And Choose Region "Dallas Express" and check Instructions
    And Choose Region "North California Express" and check Instructions
    And Choose Region "New York Express" and check Instructions
    And Choose Region "Mid Atlantic Express" and check Instructions
    And Choose Region "Florida Express" and check Instructions
    And Choose Region "Chicagoland Express" and check Instructions
    And Choose Region "<region>" and check Instructions

    And Vendor input info of inbound inventory
      | deliveryMethod   | estimatedDateArrival | ofPallets  | ofSellableRetail   | ofMasterCarton   | ofSellableRetailPerCarton        | trackingNumber   | totalWeight | zipCode   |
      | <deliveryMethod> | <eta>                | <ofPallet> | <ofSellableRetail> | <ofMasterCarton> | <ofSellableRetailofMasterCarton> | <trackingNumber> | 1           | <zipCode> |
    And Add SKU to inbound inventory
      | index | sku   | caseOfSku | productLotCode                   | expiryDate |
      | 1     | <sku> | 10        | Auto sku check inbound inventory | <eta>      |
    And Confirm create inbound inventory
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region   | eta   | status    |
      | [blank]   | <region> | <eta> | Submitted |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate |
      | [blank] | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany   | brand   | region   | eta   | status    |
      | [blank] | <vendorCompany> | <brand> | <region> | <eta> | Submitted |
    And Go to detail of incoming inventory number ""
    And Admin check General Information of Incoming inventory
      | region   | deliveryMethod   | vendorCompany   | status    | warehouse | eta   | ofPallet   | ofMasterCarton   | ofSellableRetail   | ofSellableRetailPerCarton        | zipCode   | trackingNumber   |
      | <region> | <deliveryMethod> | <vendorCompany> | Submitted | N/A       | <eta> | <ofPallet> | <ofMasterCarton> | <ofSellableRetail> | <ofSellableRetailofMasterCarton> | <zipCode> | <trackingNumber> |

    And Check SKUs Information of Incoming inventory
      | index | brandSKU | productSKU | nameSKU | lotCodeSKU                       | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | <brand>  | <product>  | <sku>   | Auto sku check inbound inventory | 10        | <eta>         | <eta>            | [blank] |
    And Add the warehouse "<warehouse>" for incoming inventory
    And Approve for this incoming inventory

#    Vendor check inventory on vendor page
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region   | eta   | status   |
      | [blank]   | <region> | <eta> | Approved |

#Check on LP
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And LP search and check Inbound inventory
      | number  | brand   | eta   |
      | [blank] | <brand> | <eta> |
    And LP go to Inbound inventory detail of number ""
    And LP Check General Information of Inbound inventory
      | region   | deliveryMethod   | vendorCompany   | status   | eta   | ofPallet   | ofMasterCarton   | ofSellableRetail   | ofSellableRetailPerCarton        | trackingNumber   |
      | <region> | <deliveryMethod> | <vendorCompany> | Approved | <eta> | <ofPallet> | <ofMasterCarton> | <ofSellableRetail> | <ofSellableRetailofMasterCarton> | <trackingNumber> |
    And LP Check SKUs Information of Inbound inventory
      | brandSKU | productSKU | nameSKU | lotCodeSKU                       | ofCaseSKU | expiryDateSKU | receivingDateSKU |
      | <brand>  | <product>  | <sku>   | Auto sku check inbound inventory | 10        | <eta>         | <eta>            |

# Check email
    Given USER_EMAIL_VENDOR open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL_VENDOR search email shipment to pod inbound
    And go to email with title "Shipment to Pod Inbound Reference Number "
    And Verify approved Inbound Inventory in Vendor email
      | number  | region   |
      | [blank] | <region> |

    Given USER_EMAIL_INVENTORY open login gmail with email "thuy@podfoods.co" pass "Podfoodsco2101"
    And USER_EMAIL_INVENTORY search email with value "New Inbound Inventory form for Texas Express"
    And QA go to first email with title ""
    And Verify email new inbound inventory of user inventory with vendor company "<vendorCompany>" in region "<region>"

#    Admin process inbound inventory
    And Switch to actor ADMIN
    And Admin Process for this incoming inventory
    And Admin check General Information of Incoming inventory
      | region   | deliveryMethod   | vendorCompany   | status    | warehouse   | eta   | ofPallet   | ofMasterCarton   | ofSellableRetail   | ofSellableRetailPerCarton        | zipCode   | trackingNumber   |
      | <region> | <deliveryMethod> | <vendorCompany> | Processed | <warehouse> | <eta> | <ofPallet> | <ofMasterCarton> | <ofSellableRetail> | <ofSellableRetailofMasterCarton> | <zipCode> | <trackingNumber> |
    And Admin check all field of incoming inventory is disable

#    LP check inbound -> real inventory
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search "" and check No found Inbound inventory
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku   | product | vendorCompany | vendorBrand |
      | <sku> | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku   | distributionCenter | vendorCompany   | lotCode | currentQuantity | originalQuantity | received | expiry |
      | 1     | <sku> | <warehouse>        | <vendorCompany> | <sku>   | 10              | 10               | <eta>    | <eta>  |

#    //Check email
    And USER_EMAIL_VENDOR search email with sender "to:ngoctx+autovendor18@podfoods.co Inventory Processed "
    And QA go to first email with title ""
    And Verify arrived Inbound Inventory in Vendor email of Region "<region>"

    Examples:
      | sku                              | region         | vendorCompany                               | brand                              | product                              | eta      | deliveryMethod      | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailofMasterCarton | zipCode | trackingNumber | warehouse                     |
      | Auto sku check inbound inventory | Dallas Express | Auto vendor company check inbound inventory | Auto Brand check inbound inventory | Auto product check inbound inventory | 05/05/23 | Brand Self Delivery | 1        | 1              | 1                | 1                              | 11111   | 1              | Auto distribute Texas Express |

  @Admin @Admin_Create_Inbound_Inventory_successfully_and_then_become_to_real_Inventory
  Scenario Outline: Admin create an inbound inventory successfully -> Then process inbound inventory to real Inventory
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Delete all inventory with product "Auto product check inbound inventory"
    And Delete all Inbound inventory with brand "2832"

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany   | region   | ofSellableRetail   | ofPallet   | estimatedWeek | note    | adminNote |
      | <vendorCompany> | <region> | <ofSellableRetail> | <ofPallet> | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku   | ofCase |
      | <sku> | 10     |
    And Confirm Create Incoming inventory
    And ADMIN navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate |
      | [blank] | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany   | brand   | region   | eta     | status        |
      | [blank] | <vendorCompany> | <brand> | <region> | [blank] | Pod suggested |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor18@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region   | eta | status        |
      | [blank]   | <region> | -   | Pod suggested |
    And Vendor go to "Pod Suggested"
    And VENDOR Search and check Send Inventory
      | reference | region   | eta | status        |
      | [blank]   | <region> | -   | Pod suggested |

#    Check on LP
    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search "" and check No found Inbound inventory

    # Check email
    Given USER_EMAIL_VENDOR open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL_VENDOR search email with sender "to:ngoctx+autovendor18@podfoods.co <brand>"
    And QA go to first email with title ""
    And Verify content Inbound Inventory in Vendor email of Region "<region>"

#    Vendor check status = Pod suggested and update inventory -> Submitted
    And VENDOR Go to detail of inbound inventory have number: ""
    And Vendor input info of inbound inventory
      | deliveryMethod   | estimatedDateArrival | ofPallets  | ofSellableRetail   | ofMasterCarton   | ofSellableRetailPerCarton        | trackingNumber   | totalWeight | zipCode   |
      | <deliveryMethod> | <eta>                | <ofPallet> | <ofSellableRetail> | <ofMasterCarton> | <ofSellableRetailofMasterCarton> | <trackingNumber> | 1           | <zipCode> |
    And Edit info SKU of inbound inventory
      | index | sku   | caseOfSku | productLotCode                   | expiryDate |
      | 1     | <sku> | 10        | Auto sku check inbound inventory | <eta>      |
    And Vendor update request inbound inventory
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region   | eta   | status    |
      | [blank]   | <region> | <eta> | Submitted |

#    Check on admin status = Summited
    And ADMIN navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number  | vendorCompany | vendorBrand | region  | initiatedBy | status  | startDate | endDate |
      | [blank] | [blank]       | [blank]     | [blank] | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany   | brand   | region   | eta     | status    |
      | [blank] | <vendorCompany> | <brand> | <region> | [blank] | Submitted |

    And Go to detail of incoming inventory number ""
    And Admin check General Information of Incoming inventory
      | region   | deliveryMethod   | vendorCompany   | status    | warehouse | eta   | ofPallet   | ofMasterCarton   | ofSellableRetail   | ofSellableRetailPerCarton        | zipCode   | trackingNumber   |
      | <region> | <deliveryMethod> | <vendorCompany> | Submitted | N/A       | <eta> | <ofPallet> | <ofMasterCarton> | <ofSellableRetail> | <ofSellableRetailofMasterCarton> | <zipCode> | <trackingNumber> |

    And Check SKUs Information of Incoming inventory
      | index | brandSKU | productSKU | nameSKU | lotCodeSKU                       | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | <brand>  | <product>  | <sku>   | Auto sku check inbound inventory | 10        | <eta>         | <eta>            | [blank] |
    And Add the warehouse "<warehouse>" for incoming inventory
    And Approve for this incoming inventory

#    Vendor check inventory on vendor page
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region   | eta   | status   |
      | [blank]   | <region> | <eta> | Approved |

#Check on LP
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And LP search and check Inbound inventory
      | number  | brand   | eta   |
      | [blank] | <brand> | <eta> |
    And LP go to Inbound inventory detail of number ""
    And LP Check General Information of Inbound inventory
      | region   | deliveryMethod   | vendorCompany   | status   | eta   | ofPallet   | ofMasterCarton   | ofSellableRetail   | ofSellableRetailPerCarton        | trackingNumber   |
      | <region> | <deliveryMethod> | <vendorCompany> | Approved | <eta> | <ofPallet> | <ofMasterCarton> | <ofSellableRetail> | <ofSellableRetailofMasterCarton> | <trackingNumber> |
    And LP Check SKUs Information of Inbound inventory
      | brandSKU | productSKU | nameSKU | lotCodeSKU                       | ofCaseSKU | expiryDateSKU | receivingDateSKU |
      | <brand>  | <product>  | <sku>   | Auto sku check inbound inventory | 10        | <eta>         | <eta>            |

## Check email
#    Given USER_EMAIL_VENDOR open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
#    And USER_EMAIL_VENDOR search email with sender "to:ngoctx+autovendor18@podfoods.co"
#    And QA go to first email with title ""
#    And Verify approved Inbound Inventory in Vendor email
#      | number                                                                                | region                                                                                                                                      |
#      | Your Inbound Reference #220516015 must be included on your inbound shipment documents | Thank you for submitting your inbound inventory form -- your inbound is approved and we look forward to receiving it soon in Texas Express. |
#
#    Given USER_EMAIL_INVENTORY open login gmail with email "thuy@podfoods.co" pass "Podfoodsco2101"
#    And USER_EMAIL_INVENTORY search email with sender "to:thuy+inventory@podfoods.co"
#    And QA go to first email with title ""
#    And Verify email new inbound inventory of user inventory with vendor company "<vendorCompany>" in region "<region>"
#
#    Admin process inbound inventory
    And Switch to actor ADMIN
    And Admin Process for this incoming inventory
    And Admin check General Information of Incoming inventory
      | region   | deliveryMethod   | vendorCompany   | status    | warehouse   | eta   | ofPallet   | ofMasterCarton   | ofSellableRetail   | ofSellableRetailPerCarton        | zipCode   | trackingNumber   |
      | <region> | <deliveryMethod> | <vendorCompany> | Processed | <warehouse> | <eta> | <ofPallet> | <ofMasterCarton> | <ofSellableRetail> | <ofSellableRetailofMasterCarton> | <zipCode> | <trackingNumber> |
    And Admin check all field of incoming inventory is disable

#    LP check inbound -> real inventory
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search "" and check No found Inbound inventory
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku   | product | vendorCompany | vendorBrand |
      | <sku> | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku   | distributionCenter | vendorCompany   | lotCode | currentQuantity | originalQuantity | received | expiry |
      | 1     | <sku> | <warehouse>        | <vendorCompany> | <sku>   | 10              | 10               | <eta>    | <eta>  |

#    //Check email
    And USER_EMAIL_VENDOR search email with sender "to:ngoctx+autovendor18@podfoods.co Inventory Processed "
    And QA go to first email with title ""
    And Verify arrived Inbound Inventory in Vendor email of Region "<region>"

    Examples:
      | sku                              | region         | vendorCompany                               | brand                              | product                              | eta      | deliveryMethod      | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailofMasterCarton | zipCode | trackingNumber | warehouse                     |
      | Auto sku check inbound inventory | Dallas Express | Auto vendor company check inbound inventory | Auto Brand check inbound inventory | Auto product check inbound inventory | 05/05/23 | Brand Self Delivery | 1        | 1              | 1                | 1                              | 11111   | 1              | Auto distribute Texas Express |

  @Order @Buyer_Create_Order_LP_Fulfill_this_order
  Scenario Outline: Buyer create a order -> Lp fulfilled this order
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin create inventory api
      | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 30425              | 30       | A12345   | 104          | currentDate  | [blank]     | [blank] |

    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer20@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "<product>", sku "<sku>" and add to cart with amount = "10"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order just created
    And Check not found PO on all order page

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor23@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $0.00    | $0.00 | $30.00              | [blank]            | $25.00           | $150.00 |
    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku   | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |

    And Set receiving weekdays "<delivery>"
    And ADMIN create purchase order with info
      | driver             | fulfillmentState | fulfillmentDate | proof       | adminNote | lpNote |
      | Auto Bao LP Driver | [blank]          | tomorrow        | proof_1.jpg | adminNote | lpNote |

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |

    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order just created
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | create by buyer | [blank] |
    And Check order record on order page
      | ordered     | number  | store   | adminNote | lpNote | delivery   | route   | address   | fulfillment |
      | currentDate | [blank] | <store> | adminNote | lpNote | <delivery> | <route> | <address> | In progress |
    And LP go to order detail ""
    And LP verify information of order detail
      | orderDate   | fulfillment | buyer   | store   | address   | department | receivingWeekday | receivingTime | route   | adminNote | lpNote | fulfillmentDate |
      | currentDate | In progress | <buyer> | <store> | <address> | [blank]    | <delivery>       | [blank]       | <route> | adminNote | lpNote | tomorrow        |
    And LP check Distribution
      | distributionCenter | distributionCenterName |
      | <address>          | <distribute>           |
    And LP check line items
      | brand   | product   | sku   | pack        | unitUPC                      | quantity | podConsignment | storageCondition |
      | <brand> | <product> | <sku> | 1 unit/case | Unit UPC / EAN: 123456724242 | 10       | true           | 1 day - Dry      |
    And LP set fulfillment date "currentDate"

    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | [blank] | [blank]       | create by buyer | [blank] |
    And Check order record on order page
      | ordered     | number  | store   | adminNote | lpNote | delivery   | route   | address   | fulfillment |
      | currentDate | [blank] | <store> | adminNote | lpNote | <delivery> | <route> | <address> | Fulfilled   |

#    Check trên Vendor sau khi full filled
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $75.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  | fulfilled   |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $75.00 | currentDate |
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region   | orderDate   | fulfillmentStatus | fulfillmentDate |
      | <region> | currentDate | Fulfilled         | currentDate     |
    And Vendor check general info
      | buyer   | store   | email                          | weekday    | orderValue | orderTotal | payment |
      | <buyer> | <store> | ngoctx+autobuyer20@podfoods.co | <delivery> | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | podConsignment                    |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | Pod Consignment auto-confirmation |
#
#    Check on buyer
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $150.00 |

    And Search Order in tab "Pending" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "In Progress" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Fulfilled" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $150.00 |

    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $100.00    | $150.00 | By invoice | Pending | $20.00            | $30.00     |

    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123456724242 |

    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $0.00    | $0.00 | $30.00              | [blank]            | $25.00           | $150.00 |
    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku   | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
    And Admin verify Purchase order
      | logisticPartner    | status    | dateFulfill | adminNote | lpNote |
      | Auto Bao LP Driver | Fulfilled | currentDate | adminNote | lpNote |
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | <store> | <buyer> | New York | New York     | <route>   | Pending | $30.00     | currentDate     | 0 day(s)     |
    And Admin check express invoice in Order summary
      | totalDelivery | totalPayment | totalService | totalWeight | eta         |
      | $0.00         | $150.00      | $25.00       | 10.00 lbs   | currentDate |
    And Admin check invoice detail in Order summary
      | brand   | product   | sku   | tmp | delivery                                         | quantity | endQuantity | warehouse    | fulfillment |
      | <brand> | <product> | <sku> | Dry | Pod ConsignmentPod Consignment auto-confirmation | 10       | [blank]     | <distribute> | currentDate |

    And ADMIN navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany      | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | Auto_VendorCompany | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany      | month       | status | beginningBalance | endingBalance |
      | Auto_VendorCompany | currentDate | Unpaid | [blank]          | [blank]       |
    And Admin go to detail of vendor statement "Auto_VendorCompany"
    And Admin check the order in list
      | number  | orderDate   | description | store   | orderValue | serviceFee | netPayment |
      | [blank] | currentDate | [blank]     | <store> | $100.00    | ($25.00)   | $75.00     |

    Examples:
      | sku                    | store                 | region           | brand                  | product                   | address                                       | route             | delivery               | buyer                | distribute              |
      | Auto sku2 check order1 | Auto+StoreCheck Order | New York Express | Auto brand check order | Auto product2 check order | 455 Madison Avenue, New York, New York, 10022 | Auto Bao New York | Within 7 business days | Auto BuyerCheckOrder | Auto Distribute NewYork |

  @Order @Buyer_Create_Order_Admin_Fulfill_this_order
  Scenario Outline: Buyer create a order -> Admin fulfilled this order
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer22@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "<product>", sku "<sku>" and add to cart with amount = "10"
    And Search product by name "<product>", sku "<sku2>" and add to cart with amount = "10"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 250.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 250.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 250.00 |
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $200.00    | $250.00 | By invoice | Pending | $20.00            | $30.00     |
    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456724242 | $10.00/unit | 1 unit/case |
      | <brand>   | <product>   | <sku2>  | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456724242 | $10.00/unit | 1 unit/case |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order just created
    And Check not found PO on all order page

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor23@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Pending      | $150.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Pending      | $150.00 |
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $200.00    | $0.00    | $0.00 | $30.00              | $20.00             | $50.00           | $250.00 |
    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku    | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku>  | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
      | <brand> | <product> | <sku2> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
    And Admin check Sub invoice
      | eta   | paymentStatus | total   | totalQuantity | totalWeight |
      | Plus9 | Pending       | $200.00 | 20            | 240.00 lbs  |
#    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | <store> | <buyer> | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | totalDelivery | totalPayment | totalService | totalWeight | eta   |
      | $0.00         | $250.00      | $50.00       | 240.00 lbs  | Plus9 |
    And Admin check invoice detail in Order summary
      | brand   | product   | sku    | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | <brand> | <product> | <sku>  | Dry | Choose   | 10       | [blank]     | N/A       | [blank]     |
      | <brand> | <product> | <sku2> | Dry | Choose   | 10       | [blank]     | N/A       | [blank]     |
#
#Check email
#    Check email to Admin
    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co New Order Details"
    And QA go to first email with title "Pod Foods Order Details"
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                            | orderNumber  | orderDate  | orderDateState             | buyer        | managerBy |
      | New Order Received!Auto Buyer22 from Auto Store check Orrder NY placed a new order. | Order Number | Order Date | Pacific Time (US & Canada) | Auto Buyer22 | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                  | sku                    | casePrice                                 | quantity | total   | promotion |
      | Auto brand check order | Auto sku2 check order1 | Auto sku2 check order1$10.00 × 10 $100.00 | 10       | $100.00 | [blank]   |
      | Auto brand check order | Auto sku2 check order2 | Auto sku2 check order2$10.00 × 10 $100.00 | 10       | $100.00 | [blank]   |
    And Verify prices in order detail in email Create Order
      | orderValue         | discount      | subtotal        | smallOrderSurcharge         | logisticsSurcharge        | bottleDeposit       | specialDiscount       | total        |
      | Order value$200.00 | Discount$0.00 | Subtotal$200.00 | Small order surcharge$30.00 | Logistics surcharge$20.00 | Bottle Deposit$0.00 | Special discount$0.00 | Total$250.00 |
    And Check customer information in email Create Order
      | shippingAddress                                               | paymentInformation |
      | Shipping address455 Madison Avenue, New York, New York, 10022 | [blank]            |

#    Check email of Vendor
    Given USER_EMAIL2 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autovendor23@podfoods.co New Pod Direct Order"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                               | orderNumber  | orderDate  | orderDateState             | buyer             | managerBy |
      | Congrats on your Pod Direct order from Auto Store check Orrder NY!Please confirm order | Order Number | Order Date | Pacific Time (US & Canada) | BuyerAuto Buyer22 | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                  | sku                    | casePrice   | quantity | total   | promotion |
      | Auto brand check order | Auto sku2 check order2 | $10.00 × 10 | 10       | $100.00 | [blank]   |

    #    Check email of Buyer
    Given USER_EMAIL3 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL3 search email with sender "to:ngoctx+autobuyer22@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                    | orderNumber  | orderDate  | orderDateState             | buyer             | managerBy                                                                                                                                          |
      | Hello Auto Buyer22,Thank you for your order with Pod Foods! | Order Number | Order Date | Pacific Time (US & Canada) | BuyerAuto Buyer22 | You can expect your order to be delivered within 3-5 days. You can always find up-to-date ETAs and your order details in your Pod Foods Dashboard. |
    And Verify items in order detail in email Create Order
      | brand                  | sku                                             | casePrice | quantity | total   | promotion                                                                                                                                                                                                  |
      | Auto brand check order | Auto product2 check orderAuto sku2 check order2 | $10.00    | 10       | $100.00 | Note: This is not an invoice.Pod Direct - These items will be delivered directly from the vendor with the paper invoice included with the shipment. Please submit the paper invoice to your AP department. |
      | Auto brand check order | Auto product2 check orderAuto sku2 check order1 | $10.00    | 10       | $100.00 | Pod Express - These items will be consolidated and delivered to you from our warehouses and you will receive a paper invoice at receiving.                                                                 |

#    //Admin fulfill order
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku    | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku>  | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
      | <brand> | <product> | <sku2> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
    And Admin check Sub invoice
      | eta   | paymentStatus | total   | totalQuantity | totalWeight |
      | Plus9 | Pending       | $200.00 | 20            | 240.00 lbs  |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName |
      | <sku2>  |
    And Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | <sku>   | currentDate |
      | 1     | <sku2>  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Fulfilled   |
    #    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | <store> | <buyer> | New York | New York     | UNASSIGNED | Pending | $30.00     | currentDate     | 0 day(s)     |
    And Admin check express invoice in Order summary
      | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | $0.00         | $250.00      | $50.00       | 240.00 lbs  | -   |
    And Admin check invoice detail in Order summary
      | brand   | product   | sku    | tmp | delivery                    | quantity | endQuantity | warehouse | fulfillment |
      | <brand> | <product> | <sku2> | Dry | Please edit in order detail | 10       | [blank]     | Direct    | currentDate |
      | <brand> | <product> | <sku>  | Dry | Choose                      | 10       | [blank]     | N/A       | currentDate |

#    Check LP sau khi fulfill
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page

#    Check trên Vendor sau khi full filled
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $150.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   | fulfilled   |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $150.00 | currentDate |

    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region   | orderDate   | fulfillmentStatus | fulfillmentDate |
      | <region> | currentDate | Fulfilled         | currentDate     |
    And Vendor check general info
      | buyer   | store   | email                          | weekday    | orderValue | orderTotal | payment |
      | <buyer> | <store> | ngoctx+autobuyer22@podfoods.co | <delivery> | $200.00    | $150.00    | Pending |
    And Vendor Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | podConsignment |
      | <brand>   | <product>   | <sku2>  | $10.00    | 10       | $100.00 | not set        |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | not set        |
#
#    Check on buyer
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $250.00 |

    And Search Order in tab "Pending" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "In Progress" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Fulfilled" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $250.00 |

    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $200.00    | $250.00 | By invoice | Pending | $20.00            | $30.00     |

    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | <brand>   | <product>   | <sku2>  | $10.00    | 10       | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123456724242 |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123456724242 |

    Examples:
      | sku                    | sku2                   | store                      | region           | brand                  | product                   | address                                       | route             | delivery               | buyer        | distribute              |
      | Auto sku2 check order1 | Auto sku2 check order2 | Auto Store check Orrder NY | New York Express | Auto brand check order | Auto product2 check order | 455 Madison Avenue, New York, New York, 10022 | Auto Bao New York | Within 7 business days | Auto Buyer22 | Auto Distribute NewYork |

  @Buyer_Create_Order_Admin_Fulfill_this_order_with_Credit_card
  Scenario Outline: Buyer create a order -> Admin fulfilled an order with Credit card
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer22@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "<product>", sku "<sku>" and add to cart with amount = "10"
    And Search product by name "<product>", sku "<sku2>" and add to cart with amount = "10"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 250.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 250.00 |
    And Check out cart "Visa ending in 4242" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 250.00 |
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment                                 | status  | logisticSurcharge | smallOrder |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $200.00    | $250.00 | Payment via credit card or bank account | Pending | $20.00            | $30.00     |
    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456724242 | $10.00/unit | 1 unit/case |
      | <brand>   | <product>   | <sku2>  | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456724242 | $10.00/unit | 1 unit/case |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order just created
    And Check not found PO on all order page
#
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor23@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Pending      | $150.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Pending      | $150.00 |
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType                             | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via credit card or bank account | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $200.00    | $0.00    | $0.00 | $30.00              | $20.00             | $50.00           | $250.00 |
    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku    | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku>  | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
      | <brand> | <product> | <sku2> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
    And Admin check Sub invoice
      | eta   | paymentStatus | total   | totalQuantity | totalWeight |
      | Plus9 | Pending       | $100.00 | 10            | 120.00 lbs  |
#    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | <store> | <buyer> | New York | New York     | UNASSIGNED | Pending | $30.00     | [blank]         | [blank]      |
    And Admin check express invoice in Order summary
      | totalDelivery | totalPayment | totalService | totalWeight | eta   |
      | $0.00         | $150.00      | $25.00       | 120.00 lbs  | Plus9 |
    And Admin check invoice detail in Order summary
      | brand   | product   | sku   | tmp | delivery | quantity | endQuantity | warehouse | fulfillment |
      | <brand> | <product> | <sku> | Dry | Choose   | 10       | [blank]     | N/A       | [blank]     |
#
#  Check email to Admin
    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co New Order Details"
    And QA go to first email with title "Pod Foods Order Details"
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                            | orderNumber  | orderDate  | orderDateState             | buyer        | managerBy |
      | New Order Received!Auto Buyer22 from Auto Store check Orrder NY placed a new order. | Order Number | Order Date | Pacific Time (US & Canada) | Auto Buyer22 | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                  | sku                    | casePrice                                 | quantity | total   | promotion |
      | Auto brand check order | Auto sku2 check order1 | Auto sku2 check order1$10.00 × 10 $100.00 | 10       | $100.00 | [blank]   |
      | Auto brand check order | Auto sku2 check order2 | Auto sku2 check order2$10.00 × 10 $100.00 | 10       | $100.00 | [blank]   |
    And Verify prices in order detail in email Create Order
      | orderValue         | discount      | subtotal        | smallOrderSurcharge         | logisticsSurcharge        | bottleDeposit       | specialDiscount       | total        |
      | Order value$200.00 | Discount$0.00 | Subtotal$200.00 | Small order surcharge$30.00 | Logistics surcharge$20.00 | Bottle Deposit$0.00 | Special discount$0.00 | Total$250.00 |
    And Check customer information in email Create Order
      | shippingAddress                                               | paymentInformation |
      | Shipping address455 Madison Avenue, New York, New York, 10022 | [blank]            |

#    Check email of Vendor
    Given USER_EMAIL2 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autovendor23@podfoods.co New Pod Direct Order"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                                               | orderNumber  | orderDate  | orderDateState             | buyer             | managerBy |
      | Congrats on your Pod Direct order from Auto Store check Orrder NY!Please confirm order | Order Number | Order Date | Pacific Time (US & Canada) | BuyerAuto Buyer22 | [blank]   |
    And Verify items in order detail in email Create Order
      | brand                  | sku                    | casePrice   | quantity | total   | promotion |
      | Auto brand check order | Auto sku2 check order2 | $10.00 × 10 | 10       | $100.00 | [blank]   |

    #    Check email of Buyer
#    Given USER_EMAIL3 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autobuyer22@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                    | orderNumber  | orderDate  | orderDateState             | buyer             | managerBy                                                                                                                                          |
      | Hello Auto Buyer22,Thank you for your order with Pod Foods! | Order Number | Order Date | Pacific Time (US & Canada) | BuyerAuto Buyer22 | You can expect your order to be delivered within 3-5 days. You can always find up-to-date ETAs and your order details in your Pod Foods Dashboard. |
    And Verify items in order detail in email Create Order
      | brand                  | sku                                             | casePrice | quantity | total   | promotion                                                                                                                                                                                                  |
      | Auto brand check order | Auto product2 check orderAuto sku2 check order2 | $10.00    | 10       | $100.00 | Note: This is not an invoice.Pod Direct - These items will be delivered directly from the vendor with the paper invoice included with the shipment. Please submit the paper invoice to your AP department. |
      | Auto brand check order | Auto product2 check orderAuto sku2 check order1 | $10.00    | 10       | $100.00 | Pod Express - These items will be consolidated and delivered to you from our warehouses and you will receive a paper invoice at receiving.                                                                 |

    #    //Admin fulfill order
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku    | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku>  | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
      | <brand> | <product> | <sku2> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
    And Admin check Sub invoice
      | eta   | paymentStatus | total   | totalQuantity | totalWeight |
      | Plus9 | Pending       | $100.00 | 10            | 120.00 lbs  |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName |
      | <sku2>  |
    And Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | <sku>   | currentDate |
      | 1     | <sku2>  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType                             | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via credit card or bank account | Pending       | Fulfilled   |
    #    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName  | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | NY     | currentDate | <store> | <buyer> | New York | New York     | UNASSIGNED | Pending | $30.00     | currentDate     | 0 day(s)     |
    And Admin check express invoice in Order summary
      | totalDelivery | totalPayment | totalService | totalWeight | eta |
      | $0.00         | $150.00      | $25.00       | 120.00 lbs  | -   |
    And Admin check invoice detail in Order summary
      | brand   | product   | sku    | tmp | delivery                    | quantity | endQuantity | warehouse | fulfillment |
      | <brand> | <product> | <sku2> | Dry | Please edit in order detail | 10       | [blank]     | Direct    | currentDate |
      | <brand> | <product> | <sku>  | Dry | Choose                      | 10       | [blank]     | N/A       | currentDate |

#    Check LP sau khi fulfill
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page

#    Check trên Vendor sau khi full filled
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $150.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   | fulfilled   |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $150.00 | currentDate |

    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region   | orderDate   | fulfillmentStatus | fulfillmentDate |
      | <region> | currentDate | Fulfilled         | currentDate     |
    And Vendor check general info
      | buyer   | store   | email                          | weekday    | orderValue | orderTotal | payment |
      | <buyer> | <store> | ngoctx+autobuyer22@podfoods.co | <delivery> | $200.00    | $150.00    | Pending |
    And Vendor Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | podConsignment |
      | <brand>   | <product>   | <sku2>  | $10.00    | 10       | $100.00 | not set        |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | not set        |
#
#    Check on buyer
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $250.00 |

    And Search Order in tab "Pending" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "In Progress" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Fulfilled" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $250.00 |

    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment                                 | status  | logisticSurcharge | smallOrder |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $200.00    | $250.00 | Payment via credit card or bank account | Pending | $20.00            | $30.00     |

    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | <brand>   | <product>   | <sku2>  | $10.00    | 10       | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123456724242 |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123456724242 |

    Examples:
      | sku                    | sku2                   | store                      | region           | brand                  | product                   | address                                       | route             | delivery               | buyer        | distribute              |
      | Auto sku2 check order1 | Auto sku2 check order2 | Auto Store check Orrder NY | New York Express | Auto brand check order | Auto product2 check order | 455 Madison Avenue, New York, New York, 10022 | Auto Bao New York | Within 7 business days | Auto Buyer22 | Auto Distribute NewYork |

  @Order @Buyer_Create_Order_Admin_Fulfill_this_order_with_Credit_card2
  Scenario Outline: Buyer create a order -> Admin fulfilled an order with Credit card2
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer24@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "<product>", sku "<sku>" and add to cart with amount = "10"
    And Search product by name "<product2>", sku "<sku2>" and add to cart with amount = "10"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 200.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 200.00 |
    And Check out cart "Visa ending in 3178" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | [blank]            | [blank]           | [blank] | 200.00 |
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment                                 | status  |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $200.00    | $200.00 | Payment via credit card or bank account | Pending |
    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456724242 | $10.00/unit | 1 unit/case |
      | <brand>   | <product2>  | <sku2>  | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456724242 | $10.00/unit | 1 unit/case |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpdriver@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order just created
    And Check not found PO on all order page
#
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor23@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Pending      | $150.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Pending      | $150.00 |
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
#
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType                             | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via credit card or bank account | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $200.00    | $0.00    | $0.00 | [blank]             | [blank]            | $50.00           | $200.00 |
    And Admin check line items "sub invoice" in order details
      | brand   | product    | sku    | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product>  | <sku>  | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
      | <brand> | <product2> | <sku2> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
#    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | PDC    | currentDate | <store> | <buyer> | New York | New York     | [blank]   | [blank] | [blank]    | [blank]         | [blank]      |
#
#  Check email to Admin
    Given USER_EMAIL open login gmail with email "bao@podfoods.co" pass "Baovip99"
    And USER_EMAIL search email with sender "Pod Foods Co New Order Details"
    And QA go to first email with title "Pod Foods Order Details"
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                    | orderNumber  | orderDate  | orderDateState             | buyer   | managerBy |
      | New Order Received!<buyer> from <store> placed a new order. | Order Number | Order Date | Pacific Time (US & Canada) | <buyer> | [blank]   |
    And Verify items in order detail in email Create Order
      | brand   | sku    | casePrice                 | quantity | total   | promotion |
      | <brand> | <sku>  | <sku>$10.00 × 10 $100.00  | 10       | $100.00 | [blank]   |
      | <brand> | <sku2> | <sku2>$10.00 × 10 $100.00 | 10       | $100.00 | [blank]   |
    And Verify prices in order detail in email Create Order
      | orderValue         | discount      | subtotal        | smallOrderSurcharge | logisticsSurcharge | bottleDeposit       | specialDiscount       | total        |
      | Order value$200.00 | Discount$0.00 | Subtotal$200.00 | [blank]             | [blank]            | Bottle Deposit$0.00 | Special discount$0.00 | Total$200.00 |
    And Check customer information in email Create Order
      | shippingAddress                                               | paymentInformation |
      | Shipping address455 Madison Avenue, New York, New York, 10022 | [blank]            |

#    Check email of Vendor
    Given USER_EMAIL2 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autovendor23@podfoods.co New Pod Direct Order"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                                            | orderNumber  | orderDate  | orderDateState             | buyer   | managerBy |
      | Congrats on your Pod Direct order from <store>!Please confirm order | Order Number | Order Date | Pacific Time (US & Canada) | <buyer> | [blank]   |
    And Verify items in order detail in email Create Order
      | brand   | sku    | casePrice   | quantity | total   | promotion |
      | <brand> | <sku>  | $10.00 × 10 | 10       | $100.00 | [blank]   |
      | <brand> | <sku2> | $10.00 × 10 | 10       | $100.00 | [blank]   |

    #    Check email of Buyer
#    Given USER_EMAIL3 open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL2 search email with sender "to:ngoctx+autobuyer24@podfoods.co"
    And QA go to first email with title ""
    And verify order summary in email Create Order
      | buyerFromStorePlaceOrder                               | orderNumber  | orderDate  | orderDateState             | buyer   | managerBy                                                                                                                                          |
      | Hello <buyer>,Thank you for your order with Pod Foods! | Order Number | Order Date | Pacific Time (US & Canada) | <buyer> | You can expect your order to be delivered within 3-5 days. You can always find up-to-date ETAs and your order details in your Pod Foods Dashboard. |
    And Verify items in order detail in email Create Order
      | brand   | sku              | casePrice | quantity | total   | promotion                                                                                                                                                                                                  |
      | <brand> | <product><sku>   | $10.00    | 10       | $100.00 | Note: This is not an invoice.Pod Direct - These items will be delivered directly from the vendor with the paper invoice included with the shipment. Please submit the paper invoice to your AP department. |
      | <brand> | <product2><sku2> | $10.00    | 10       | $100.00 | Pod Direct - These items will be delivered directly from the vendor with the paper invoice included with the shipment. Please submit the paper invoice to your AP department.                              |

    #    //Admin fulfill order
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand   | product    | sku    | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product>  | <sku>  | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
      | <brand> | <product2> | <sku2> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
    And Admin create "create" sub-invoice with Suffix ="1"
      | skuName |
      | <sku>   |
    And Admin create "create" sub-invoice with Suffix ="2"
      | skuName |
      | <sku2>  |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 10            | 120.00 lbs  |
      | [blank] | Pending       | $100.00 | 10            | 120.00 lbs  |
    And Admin fulfill all line items
      | index | skuName | fulfillDate |
      | 1     | <sku>   | currentDate |
      | 2     | <sku2>  | currentDate |
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType                             | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via credit card or bank account | Pending       | Fulfilled   |
    #    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | PDC    | currentDate | <store> | <buyer> | New York | New York     | [blank]   | Pending | [blank]    | currentDate     | 0 day(s)     |

    And Admin check invoice detail in Order summary
      | brand   | product    | sku    | tmp | delivery                    | quantity | endQuantity | warehouse | fulfillment |
      | <brand> | <product2> | <sku2> | Dry | Please edit in order detail | 10       | [blank]     | Direct    | currentDate |
      | <brand> | <product>  | <sku>  | Dry | Please edit in order detail | 10       | [blank]     | Direct    | currentDate |

#    Check LP sau khi fulfill
    And USER_LP Navigate to "Orders" by sidebar
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Unconfirmed  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | In progress  | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page
    And USER_LP filter order by info
      | orderBy               | fulFillState | store   | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | [blank] | [blank]       | create by buyer | [blank] |
    And Check not found PO on all order page

#    Check trên Vendor sau khi full filled
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $150.00 |
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total   | fulfilled   |
      | currentDate | [blank] | <store> | Pending | Fulfilled    | $150.00 | currentDate |

    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region   | orderDate   | fulfillmentStatus | fulfillmentDate |
      | <region> | currentDate | Fulfilled         | currentDate     |
    And Vendor check general info
      | buyer   | store   | email                          | weekday    | orderValue | orderTotal | payment |
      | <buyer> | <store> | ngoctx+autobuyer24@podfoods.co | <delivery> | $200.00    | $150.00    | Pending |
    And Vendor Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 |
      | <brand>   | <product2>  | <sku2>  | $10.00    | 10       | $100.00 |
#
#    Check on buyer
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $200.00 |

    And Search Order in tab "Pending" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "In Progress" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Fulfilled" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   |
      | currentDate | [blank] | <store> | <buyer> | Pending | Fulfilled   | $200.00 |

    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment                                 | status  |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $200.00    | $200.00 | Payment via credit card or bank account | Pending |

    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | fulfilled   | unitUPC                      |
      | <brand>   | <product2>  | <sku2>  | $10.00    | 10       | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123456724242 |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | Fulfilled     | currentDate | Unit UPC / EAN: 123456724242 |

    Examples:
      | sku                    | sku2                   | store                             | region             | brand          | product                   | product2                  | address                                       | route             | delivery               | buyer       | distribute              |
      | Auto sku3 check order1 | Auto sku4 check order1 | Auto Store check order creditcard | Pod Direct Central | Auto Brand Bao | Auto product3 check order | Auto product4 check order | 455 Madison Avenue, New York, New York, 10022 | Auto Bao New York | Within 7 business days | Auto Buyer6 | Auto Distribute NewYork |

  @Order @Mark_as_paid
  Scenario: Checking vendor payment of order is paid with Payment type = Mark as paid
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    And Go to Cart detail
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
    Then NGOC_ADMIN verify price in order details of Admin
      | smallOrderSurchage | logisticsSurchage | total  |
      | 30.00              | 20.00             | 150.00 |
    When Admin fulfill all line items created by buyer
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And NGOC_ADMIN navigate to "Financial" to "Vendor statements" by sidebar
    And Admin fill password to authen permission
    And Admin search vendor statements
      | paymentStatus | email   | vendorCompany | ach     | statementMonth | prePayment |
      | [blank]       | [blank] | ngoc vc 1     | [blank] | currentDate    | [blank]    |
    Then Admin verify result vendor statements
      | vendorCompany | month       | status  | beginningBalance | endingBalance |
      | ngoc vc 1     | currentDate | [blank] | [blank]          | [blank]       |

  @Order @Order_Upload_CSV
  Scenario: Admin tạo order = Upload file CSV
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer        | paymentType    | street                | city       | state    | zip   |
      | ngoctx N_CHI | Pay by invoice | 123 Illinois Route 59 | Barrington | Illinois | 60010 |
    And Admin add line item is "AT SKU Upload08"
    Then Admin verify line item added
      | title          | brand           | product           | sku             | tag   | upc          | unit         |
      | Items with MOQ | AT Brand Upload | AT Product Upload | AT SKU Upload08 | 30645 | 180219931238 | 1 units/case |
    And Admin upload file order "autotest.csv"
    Then Admin verify info after upload file CSV
      | nameSKU              | info                                                          | warning                                    | danger                                                | uploadedPrice | estimatedPrice | quantity | promoPrice |
      | AT SKU Upload01      | empty                                                         | empty                                      | empty                                                 | $10.00        | $10.00         | 1        | empty      |
      | AT SKU Upload02      | This SKU is launching soon but it will be added on the order. | empty                                      | empty                                                 | $15.00        | $20.00         | 2        | empty      |
      | AT SKU Upload03      | This SKU is out of stock but it will be added on the order.   | This item’s quantity doesn't meet the MOQs | empty                                                 | $15.00        | $30.00         | 3        | empty      |
      | AT SKU Upload04      | empty                                                         | empty                                      | The UPC / EAN is used for multiple SKUs               | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload05      | empty                                                         | empty                                      | The UPC / EAN is used for multiple SKUs               | $15.00        | empty          | empty    | empty      |
      | empty                | empty                                                         | empty                                      | This item isn't available to the selected buyer/store | $15.00        | empty          | empty    | empty      |
      | empty                | empty                                                         | empty                                      | This upc / ean not found                              | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload08      | empty                                                         | empty                                      | This SKU was already uploaded                         | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload09      | empty                                                         | This item’s quantity doesn't meet the MOQs | Quantity should not be 0                              | $15.00        | $0.00          | 0        | empty      |
      | AT SKU Upload10      | empty                                                         | empty                                      | empty                                                 | $0.00         | $0.00          | 0        | empty      |
      | empty                | empty                                                         | empty                                      | This upc / ean not found                              | $15.00        | empty          | empty    | empty      |
      | AT SKU Upload MOV 01 | empty                                                         | empty                                      | empty                                                 | $15.00        | $144.00        | 12       | empty      |
      | AT SKU MOV2 01       | empty                                                         | empty                                      | empty                                                 | $15.00        | $1,690.00      | 13       | $1,680.00  |
      | AT SKU Upload14      | empty                                                         | empty                                      | This item isn't available to the selected buyer/store | $15.00        | empty          | empty    | empty      |
    And Admin verify price in create order upload file
      | type      | totalCase | totalOrderValue | discount | taxes | logisticsSurcharge | specialDiscount | totalPayment |
      | Total     | 31        | $1,894.00       | $10.00   | $0.00 | $20.00             | $0.00           | $1,904.00    |
      | In stock  | 26        | $1,844.00       | $10.00   | $0.00 | $20.00             | $0.00           | $1,854.00    |
      | OOS or LS | 5         | $50.00          | $0.00    | $0.00 | $0.00              | $0.00           | $50.00       |
    And Admin upload file CSV success
    Then Admin verify line item added
      | title          | brand           | product           | sku             | tag   | upc          | unit         |
      | Items with MOQ | AT Brand Upload | AT Product Upload | AT SKU Upload08 | 30645 | 180219931238 | 1 units/case |
    And Admin verify line item added with company name
      | brand            | product               | sku                  | tag   | upc          | status         | price     | newPrice  | quantity |
      | AT BRAND MOV     | AT Product Upload MOV | AT SKU Upload MOV 01 | 30653 | 123124123145 | In stock       | $144.00   | empty     | 12       |
      | AT BRAND MOV2 02 | AT Product MOV2 01    | AT SKU MOV2 01       | 30654 | 352341235123 | In stock       | $1,690.00 | $1,680.00 | 13       |
      | AT BRAND UPLOAD  | AT Product Upload     | AT SKU Upload08      | 30645 | 180219931238 | In stock       | $80.00    | empty     | 1        |
      | AT BRAND UPLOAD  | AT Product Upload     | AT SKU Upload01      | 30636 | 180219931231 | In stock       | $10.00    | empty     | 1        |
      | AT BRAND UPLOAD  | AT Product Upload     | AT SKU Upload02      | 30637 | 180219931232 | Launching soon | $20.00    | empty     | 2        |
      | AT BRAND UPLOAD  | AT Product Upload02   | AT SKU Upload03      | 30639 | 180219931233 | Out of stock   | $30.00    | empty     | 3        |
    And Admin check message of sku "AT SKU Upload MOV 01" is "Please add more case(s) to any SKU below to meet the minimum order value required. This vendor may not fulfill if this minimum is not met. Thank you!"

  @Vendor_confirm_PD_with_Ship_Direct_to_Store_Buy_and_Print_shipping_label
  Scenario Outline: Buyer create order with Pod Direct item and Vendor confirm Pod direct item with Delivery method Ship Direct to Store > Buy and Print shipping label
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer26@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "<product>", sku "<sku>" and add to cart with amount = "10"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment    | status  |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $100.00    | $100.00 | By invoice | Pending |
    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456789122 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |
#
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region   | orderDate   | fulfillmentStatus | fulfillmentDate |
      | <region> | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer   | store   | email                          | weekday    | orderValue | orderTotal | payment |
      | <buyer> | <store> | ngoctx+autobuyer26@podfoods.co | <delivery> | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 |
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor select items to confirm in order
      | sku   | date  |
      | <sku> | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store   | address   |
      | Ship Direct to Store | <store> | <address> |
    And Vendor choose shipping method
      | shippingMethod               | width | height | length | weight | distance | mass | name | company | address1             | city  | zipcode | state | country | email           |
      | Buy and Print shipping label | 2     | 3      | 4      | 5      | cm       | g    | name | company | 3740 White Plains Rd | Bronx | 10467   | NY    | US      | bao@podfoods.co |
    And Vendor select shippo and then confirm
    And Click on button "Buy"
    And Vendor check information after confirm
      | provider | tracking                    | eta    | status                    | size                       | weight     | line                   | price     |
      | USPS     | #92701901755477000000000011 | ETA: - | Tracking status:  UNKNOWN | Size: 4.00 x 3.00 x 2.00cm | Weight: 5g | 1 line item (10 cases) | 23.50 USD |
    And Vendor view delivery detail of "Ship Direct to Store"
      | item  | quantity | deliveryMethod       | store   | address   | deliveryDate | trackingStatus | from                                            | to                                            | trackingNumber             | parcelInfo                 |
      | <sku> | 10       | Ship Direct to Store | <store> | <address> | N/A          | UNKNOWN        | 3740 White Plains Rd, Bronx, NY, 10467-5724, US | 455 Madison Ave, New York, NY, 10022-6845, US | 92701901755477000000000011 | Size: 4.00 x 3.00 x 2.00cm |

#    Check on buyer
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   | confirmed |
      | currentDate | [blank] | <store> | <buyer> | Pending | Pending     | $100.00 | [blank]   |
    And Search Order in tab "In Progress" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Fulfilled" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Pending" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   | confirmed |
      | currentDate | [blank] | <store> | <buyer> | Pending | Pending     | $100.00 | [blank]   |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment    | status  |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $100.00    | $100.00 | By invoice | Pending |
    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456789122 |
    And Buyer check sub-invoice of order "create by api"
      | sub | payment | total   |
      | 1   | Pending | $100.00 |
    And Buyer check confirm information
      | eta     | carrier | tracking                   | comment               | deliveryDate | eta2    |
      | [blank] | [blank] | 92701901755477000000000011 | Shippo auto-generated | [blank]      | [blank] |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $0.00    | $0.00 | [blank]             | [blank]            | $25.00           | $100.00 |
    And Admin check Sub invoice
      | eta     | paymentStatus | total   | totalQuantity | totalWeight |
      | [blank] | Pending       | $100.00 | 10            | 120.00 lbs  |
    And Admin check delivery shippo
      | trackingStatus | nameTracking | numberTracking             |
      | Unknown        | USPS         | 92701901755477000000000011 |

    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku   | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
#    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | DAL    | currentDate | <store> | <buyer> | New York | New York     | [blank]   | [blank] | [blank]    | [blank]         | [blank]      |
    And Admin check delivery shippo
      | trackingStatus | nameTracking | numberTracking             |
      | Unknown        | USPS         | 92701901755477000000000011 |

    Examples:
      | sku                     | store                        | region         | brand          | product                     | address                                       | route             | delivery               | buyer        | distribute              |
      | Auto sku check order pd | Auto Store check order texas | Dallas Express | Auto Brand Bao | Auto product check order PD | 455 Madison Avenue, New York, New York, 10022 | Auto Bao New York | Within 7 business days | Auto Buyer26 | Auto Distribute NewYork |

  @Vendor_confirm_PD_with_Ship_Direct_to_Store_Use_my_own_shipping_label
  Scenario Outline:Buyer create order with Pod Direct item and Admin confirm Pod Direct sub-invoice with Delivery method Ship Direct to Store > Use my own shipping label
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer26@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "<product>", sku "<sku>" and add to cart with amount = "10"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment    | status  |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $100.00    | $100.00 | By invoice | Pending |
    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456789122 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor25@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "Unconfirmed"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |
    And Vendor search order "Fulfilled"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor check no order found
    And Vendor search order "All"
      | region  | store   | paymentStatus | orderType | checkoutDate |
      | [blank] | <store> | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store   | payment | fullfillment | total  |
      | currentDate | [blank] | <store> | Pending | Pending      | $75.00 |
#
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region   | orderDate   | fulfillmentStatus | fulfillmentDate |
      | <region> | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer   | store   | email                          | weekday    | orderValue | orderTotal | payment |
      | <buyer> | <store> | ngoctx+autobuyer26@podfoods.co | <delivery> | $100.00    | $75.00     | Pending |
    And Vendor Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 |
    And Vendor check step confirm
      | step1             | step2            | step3                       | step4              | step5                      |
      | Enter expiry date | Confirm Products | Select Delivery Type + Date | Print, Pack + Ship | Add Tracking or Upload POD |
    And Vendor select items to confirm in order
      | sku   | date  |
      | <sku> | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery             | store   | address   |
      | Ship Direct to Store | <store> | <address> |
    And Vendor choose shipping method
      | shippingMethod            | deliveryDate | carrier | trackingNumber | comment |
      | Use my own shipping label | currentDate  | USPS    | 12345678       | comment |
    And Vendor view delivery detail of "Ship Direct to Store"
      | item  | quantity | deliveryMethod       | store   | address   | deliveryDate | carrier | trackingNumber | comment |
      | <sku> | 10       | Ship Direct to Store | <store> | <address> | currentDate  | USPS    | 12345678       | comment |

#    Check on buyer
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   | confirmed |
      | currentDate | [blank] | <store> | <buyer> | Pending | Pending     | $100.00 | [blank]   |
    And Search Order in tab "In Progress" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Fulfilled" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer check no order found
    And Search Order in tab "Pending" with
      | brand   | checkoutAfter | checkoutBefore |
      | <brand> | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store   | creator | payment | fulfillment | total   | confirmed |
      | currentDate | [blank] | <store> | <buyer> | Pending | Pending     | $100.00 | [blank]   |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName | storeName | shippingAddress                               | orderValue | total   | payment    | status  |
      | <buyer>   | <store>   | 455 Madison Avenue, New York, New York, 10022 | $100.00    | $100.00 | By invoice | Pending |
    And Check items in order detail
      | brandName | productName | skuName | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      |
      | <brand>   | <product>   | <sku>   | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123456789122 |
    And Buyer check sub-invoice of order "create by api"
      | sub | payment | total   |
      | 1   | Pending | $100.00 |
    And Buyer check confirm information
      | eta         | carrier | tracking | comment | deliveryDate | eta2    |
      | currentDate | USPS    | 12345678 | comment | [blank]      | [blank] |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region   | buyer   | store   | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | <region> | <buyer> | <store> | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $0.00    | $0.00 | [blank]             | [blank]            | $25.00           | $100.00 |
    And Admin check Sub invoice
      | eta         | paymentStatus | total   | totalQuantity | totalWeight |
      | currentDate | Pending       | $100.00 | 10            | 120.00 lbs  |
    And Admin check line items "sub invoice" in order details
      | brand   | product   | sku   | unitCase     | casePrice | quantity | endQuantity | total   |
      | <brand> | <product> | <sku> | 1 units/case | $10.00    | 10       | [blank]     | $100.00 |
    And Admin check delivery shippo
      | trackingStatus | nameTracking | numberTracking |
      | [blank]        | [blank]      | [blank]        |

#    //Check on order summary
    And Admin go to Order summary from order detail
    And Admin check Order summary
      | region | date        | store   | buyer   | city     | addressState | routeName | status  | smallOrder | fulfillmentDate | dayToFulfill |
      | DAL    | currentDate | <store> | <buyer> | New York | New York     | [blank]   | [blank] | [blank]    | [blank]         | [blank]      |
    And Admin check delivery shippo
      | trackingStatus | nameTracking | numberTracking |
      | [blank]        | [blank]      | [blank]        |

    Examples:
      | sku                     | store                        | region         | brand          | product                     | address                                       | route             | delivery               | buyer        | distribute              |
      | Auto sku check order pd | Auto Store check order texas | Dallas Express | Auto Brand Bao | Auto product check order PD | 455 Madison Avenue, New York, New York, 10022 | Auto Bao New York | Within 7 business days | Auto Buyer26 | Auto Distribute NewYork |

  @Deliver @Deliver_01
  Scenario: Buyer create order with Pod Direct item and Vendor confirm Pod direct item with Delivery method Self-deliver to Store
    Given BUYER open web user
    When login to beta web with email "ngoctx+pdtexas01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AutoTest Product 2 Ngoc01", sku "Autotest SKU2 Ngoc01" and add to cart with amount = "10"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $100.00 |
    And Check information in order detail
      | buyerName        | storeName | shippingAddress                          | orderValue | total   | payment    | status  |
      | ngoctx pdTexas01 | ngoctx PD | 5306 Canal Street, Houston, Texas, 77011 | $100.00    | $100.00 | By invoice | Pending |
    And Check items in order detail
      | brandName             | productName               | skuName              | casePrice | quantity | total   | addCart | fulfillStatus | unitUPC                      | priceUnit   | caseUnit    |
      | AutoTest Brand Ngoc02 | AutoTest Product 2 Ngoc01 | Autotest SKU2 Ngoc01 | $10.00    | 10       | $100.00 | [blank] | In Progress   | Unit UPC / EAN: 123124123415 | $10.00/unit | 1 unit/case |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store     | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | ngoctx PD | Pending       | Direct    | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor select items to confirm in order
      | sku                  | date  |
      | Autotest SKU2 Ngoc01 | Plus1 |
    And Vendor confirm with delivery method with info
      | delivery              | store     | address                                  |
      | Self-deliver to Store | ngoctx PD | 5306 Canal Street, Houston, Texas, 77011 |
    And Vendor fill info to self-deliver to Store
      | deliveryDate | from  | to    | comment          |
      | currentDate  | 00:00 | 02:00 | AT self delivery |
    Then Vendor view delivery detail of "Self-deliver to Store"
      | item                 | quantity | deliveryMethod        | store     | address                                  | deliveryDate | from  | to    | comment          |
      | Autotest SKU2 Ngoc01 | 10       | Self-deliver to Store | ngoctx PD | 5306 Canal Street, Houston, Texas, 77011 | currentDate  | 00:00 | 02:00 | AT self delivery |

    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                 | checkoutAfter | checkoutBefore |
      | AutoTest Brand Ngoc02 | currentDate   | currentDate    |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName        | storeName | shippingAddress                          | orderValue | total   | payment    | status  |
      | ngoctx pdTexas01 | ngoctx PD | 5306 Canal Street, Houston, Texas, 77011 | $100.00    | $100.00 | By invoice | Pending |
    And Check items in order detail
      | brandName             | productName               | skuName              | casePrice | quantity | total   | addCart | unitUPC                      |
      | AutoTest Brand Ngoc02 | AutoTest Product 2 Ngoc01 | Autotest SKU2 Ngoc01 | $10.00    | 10       | $100.00 | [blank] | Unit UPC / EAN: 123124123415 |
    Then Buyer check confirm information
      | eta     | carrier | tracking | comment          | deliveryDate | eta2                |
      | [blank] | [blank] | [blank]  | AT self delivery | currentDate  | 12:00 am - 02:00 am |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Amin verify info of self deliver to store
      | deliveryMethod        | deliveryDate | from  | to    | proof               | comment          |
      | Self deliver to store | currentDate  | 00:00 | 02:00 | ProofOfDelivery.pdf | AT self delivery |

  @Admin_create_withdrawal_request
  Scenario: Checking withdrawal request flow when admin create request and Completed them
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany                          | pickerDate  | pickerFrom | pickerTo | region         | pickupType  | pickupPartner | contactEmail | palletWeight | bol        | comment |
      | Auto Vendor Company Withdraw inventory | currentDate | 00:30      | 01:00    | Dallas Express | Self pickup | Bao           | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | vendorBrand | skuName | productName | lotCode        | case |
      | [blank]     | [blank] | [blank]     | sku withdraw 6 | 5    |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany                          | pickupDate  | startTime | endTime  | region         | pickupType  | partner | palletWeight | status    | comment | bol        |
      | Auto Vendor Company Withdraw inventory | currentDate | 12:30 am  | 01:00 am | Dallas Express | Self pickup | Bao     | 10 lbs       | Submitted | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | product                                | sku            | lotCode        | endQty  | case |
      | Auto product check withdraw inventorty | sku withdraw 6 | sku withdraw 6 | [blank] | 5    |

    And ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName        | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | sku withdraw 6 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName        | skuName        | lotCode        | originalQuantity | currentQuantity | quantity     | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter | vendorCompany | region | createdBy |
      | 1     | Auto product check | sku withdraw 6 | sku withdraw 6 | 1000             | [blank]         | End Quantity | 0            | [blank]    | [blank]  | [blank]          | [blank]     | [blank]            | [blank]       | DAL    | [blank]   |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor28@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR open withdraw request
    And Vendor check withdrawal request just created on tab "All"
      | number  | requestDate | pickupDate  | case | status    |
      | [blank] | currentDate | currentDate | 5    | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number  | requestDate | pickupDate  | case | status    |
      | [blank] | currentDate | currentDate | 5    | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region         | type        | name | palletWeight | comment | bol        | endQuantity  |
      | Submitted | currentDate | 00:30      | 01:00    | Dallas Express | Self Pickup | Bao  | 10           | comment | anhPNG.png | End Quantity |
    And Vendor check lots in detail of withdrawal request
      | index | brand                               | product                                | sku            | skuID | lotCode        | quantity |
      | 1     | Auto brand check withdraw inventory | Auto product check withdraw inventorty | sku withdraw 6 | #     | sku withdraw 6 | 5        |

    Given ADMIN navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number          | vendorCompany                          | brand   | region  | status    | startDate | endDate |
      | create by admin | Auto Vendor Company Withdraw inventory | [blank] | [blank] | Submitted | [blank]   | [blank] |
    And Admin check record on list withdrawal request
      | number  | vendorCompany                          | brand                               | region         | status    | pickupDate  |
      | [blank] | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | Dallas Express | Submitted | currentDate |
    And Admin go to detail withdraw request number ""
    #Approve
    And Admin approve withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany                          | pickupDate  | startTime | endTime  | region         | pickupType  | partner | palletWeight | status   | comment | bol        |
      | Auto Vendor Company Withdraw inventory | currentDate | 12:30 am  | 01:00 am | Dallas Express | Self pickup | Bao     | 10 lbs       | Approved | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                                | sku            | lotCode        | endQty  | case |
      | 1     | Auto product check withdraw inventorty | sku withdraw 6 | sku withdraw 6 | [blank] | 5    |

    And ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName        | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | sku withdraw 6 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName        | skuName        | lotCode        | originalQuantity | currentQuantity | quantity           | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter | vendorCompany | region | createdBy |
      | 1     | Auto product check | sku withdraw 6 | sku withdraw 6 | 1000             | [blank]         | End Quantity After | 0            | [blank]    | [blank]  | [blank]          | [blank]     | [blank]            | [blank]       | DAL    | [blank]   |
    And VENDOR open withdraw request
    And Vendor check withdrawal request just created on tab "All"
      | number  | requestDate | pickupDate  | case | status   |
      | [blank] | currentDate | currentDate | 5    | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number  | requestDate | pickupDate  | case | status   |
      | [blank] | currentDate | currentDate | 5    | Approved |

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP Search Withdrawal Request
      | number  | vendorCompany | brand   | region  | from    |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |
    And LP Check record Withdrawal Request
      | number  | brand                               | pickupDate  | status   |
      | [blank] | Auto brand check withdraw inventory | currentDate | Approved |
    Given LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku            | product | vendorCompany | vendorBrand |
      | sku withdraw 6 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku            | distributionCenter            | vendorCompany                          | lotCode        | currentQuantity    | originalQuantity | received | expiry  |
      | 1     | sku withdraw 6 | Auto distribute Texas Express | Auto Vendor Company Withdraw inventory | sku withdraw 6 | End Quantity After | 1,000            | [blank]  | [blank] |

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName        | zeroQuantity | orderBy                 |
      | sku withdraw 6 | No           | Received - Latest first |
    And Vendor verify result in All Inventory
      | productName                            | skuName        | lotCode        | receivedQty | received | currentQty         | pulledQty | endQty             | expiryDate | pullDate |
      | Auto product check withdraw inventorty | sku withdraw 6 | sku withdraw 6 | 1,000       | [blank]  | End Quantity After | [blank]   | End Quantity After | 07/01/22   | 06/25/22 |

    Given ADMIN navigate to "Inventories" to "Withdrawal Requests" by sidebar
    When Admin search withdraw request
      | number          | vendorCompany                          | brand   | region  | status  | startDate | endDate |
      | create by admin | Auto Vendor Company Withdraw inventory | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin check record on list withdrawal request
      | number  | vendorCompany                          | brand                               | region         | status   | pickupDate  |
      | [blank] | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | Dallas Express | Approved | currentDate |
    And Admin go to detail withdraw request number ""
    And Admin Complete withdraw request
    And Admin check general information "complete" withdrawal request
      | vendorCompany                          | pickupDate  | startTime | endTime  | region         | pickupType  | partner | palletWeight | status    | comment | bol        |
      | Auto Vendor Company Withdraw inventory | currentDate | 12:30 am  | 01:00 am | Dallas Express | Self pickup | Bao     | 10 lbs       | Completed | comment | anhPNG.png |

    Given LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And Lp go to "Withdraw Inventory" tab
    And LP Search Withdrawal Request
      | number  | vendorCompany                          | brand                               | region  | from    |
      | [blank] | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | [blank] | [blank] |
    And LP Check record Withdrawal Request
      | number  | brand                               | pickupDate  | status    |
      | [blank] | Auto brand check withdraw inventory | currentDate | Completed |
    Given LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku            | product | vendorCompany | vendorBrand |
      | sku withdraw 6 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku            | distributionCenter            | vendorCompany                          | lotCode        | currentQuantity    | originalQuantity | received | expiry  |
      | 1     | sku withdraw 6 | Auto distribute Texas Express | Auto Vendor Company Withdraw inventory | sku withdraw 6 | End Quantity After | 1,000            | [blank]  | [blank] |
    And VENDOR open withdraw request
    And Vendor check withdrawal request just created on tab "All"
      | number  | requestDate | pickupDate  | case | status    |
      | [blank] | currentDate | currentDate | 5    | Completed |
    And Vendor check withdrawal request just created on tab "Completed"
      | number  | requestDate | pickupDate  | case | status    |
      | [blank] | currentDate | currentDate | 5    | Completed |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region         | type        | name | palletWeight | comment | bol        | endQuantity        |
      | Completed | currentDate | 00:30      | 01:00    | Dallas Express | Self Pickup | Bao  | 10           | comment | anhPNG.png | End Quantity After |

  @Financial_Pending
  Scenario: Buyer tạo Financial Pending order > Admin Approve
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Search order by sku "30752" by api
    And Admin delete order of sku "AT SKU Ngoc01" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]              | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Ngoc01           | AT Product Financial Pending | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Ngoc01" from API
    And Admin delete all inventory by API

    Given BUYER open web user
    When login to beta web with email "ngoctx+financialpending@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product Financial Pending", sku "AT SKU Ngoc01" and add to cart with amount = "1"
    And Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | $20.00            | $10.00 | $141.00 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | $20.00            | $10.00 | $141.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax    | total   |
      | $30.00             | $20.00            | $10.00 | $141.00 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer                   | store           | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment | financePending |
      | random | currentDate | ngoctx FinancialPending | ngoctx Financia | CHI    | $100.00 | $25.00    | Pending      | Pending     | Pending       | Yes            |
    When Admin go to detail after search
    And Verify general information of order detail
      | customerPo | date        | region              | buyer                   | store                      | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | approveToFulfill |
      | Empty      | currentDate | Chicagoland Express | ngoctx FinancialPending | ngoctx Financial pending01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | [blank]          |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $10.00   | $10.00 | $30.00              | $20.00             | $25.00           | $141.00 |
    And Admin verify receiving info
      | possibleReceiving      | setReceiving           | receivingTime              |
      | Within 7 business days | Within 7 business days | Pacific Time (US & Canada) |
    And Admin verify line item express "AT SKU Ngoc01" index "1" can "not" edit
    And Admin verify info vendor payment
      | fulfillment | paymentState | value   | discount | serviceFee | additionalFee | paid   | payoutDate | paymentType |
      | Pending     | Pending      | $100.00 | $10.00   | $25.00     | $0.00         | $65.00 | [blank]    | [blank]     |

    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku           | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | AT SKU Ngoc01 | 1        | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName       | productName                  | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Ngoc01 | AT Product Financial Pending | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Search inventory with lotcode "" in result table
    Then Verify result inventory by lotcode
      | productName                  | skuName       | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | AT Product Financial Pending | AT SKU Ngoc01 | random  | 1                | 1               | 1        | 0            | [blank]    | [blank]  | currentDate | Auto Ngoc Distribution CHI | ngoc vc2      | CHI    | Admin     |
    And Admin see detail inventory with lotcode "random"
    Then Verify inventory detail
      | product                      | sku           | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | AT Product Financial Pending | AT SKU Ngoc01 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 1           | 1          | 1      |
    And Verify no inventory activities found

    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Search Order in tab "All" with
      | brand                        | checkoutAfter | checkoutBefore |
      | AT Brand Financial Pending01 | currentDate   | [blank]        |
    And Buyer verify order in result
      | ordered     | number  | store                      | creator                 | payment | fulfillment | total   |
      | currentDate | [blank] | ngoctx Financial pending01 | ngoctx FinancialPending | Pending | Pending     | $141.00 |
    And Go to order detail with order number ""
    And Check information in order detail
      | buyerName               | storeName                  | shippingAddress                                 | orderValue | total   | payment    | status  | logisticSurcharge | smallOrder | discount | specialDiscount | tax    |
      | ngoctx FinancialPending | ngoctx Financial pending01 | 1544 West 18th Street, Chicago, Illinois, 60608 | $100.00    | $141.00 | By invoice | Pending | $20.00            | $30.00     | -$10.00  | -$9.00          | $10.00 |
    And Check items in order detail
      | brandName                    | productName                  | skuName       | casePrice | quantity | total  | addCart |
      | AT Brand Financial Pending01 | AT Product Financial Pending | AT SKU Ngoc01 | $100.00   | 1        | $90.00 | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v21@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region             | store     | paymentStatus | orderType | checkoutDate |
      | Pod Direct Central | ngoctx PD | Pending       | Direct    | currentDate  |
    And Vendor check no order found

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer                   | store           | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment | financePending |
      | random | currentDate | ngoctx FinancialPending | ngoctx Financia | CHI    | $100.00 | $25.00    | Pending      | Pending     | Pending       | Yes            |
    When Admin go to detail after search
    When Admin approve to fulfill this order

    And Verify general information of order detail
      | customerPo | date        | region              | buyer                   | store                      | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | financeApproval | financeApproveBy |
      | Empty      | currentDate | Chicagoland Express | ngoctx FinancialPending | ngoctx Financial pending01 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Approved        | Admin: NgocTX    |
    And Verify price in order details
      | orderValue | discount | taxes  | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $10.00   | $10.00 | $30.00              | $20.00             | $25.00           | $141.00 |
    And Admin verify receiving info
      | possibleReceiving      | setReceiving           | receivingTime              |
      | Within 7 business days | Within 7 business days | Pacific Time (US & Canada) |
    And Admin verify line item express "AT SKU Ngoc01" index "1" can "" edit
    And Admin verify info vendor payment
      | fulfillment | paymentState | value   | discount | serviceFee | additionalFee | paid   | payoutDate | paymentType |
      | Pending     | Pending      | $100.00 | $10.00   | $25.00     | $0.00         | $65.00 | [blank]    | [blank]     |
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution CHI"
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName       | productName                  | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Ngoc01 | AT Product Financial Pending | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Search inventory with lotcode "" in result table
    Then Verify result inventory by lotcode
      | productName                  | skuName       | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | AT Product Financial Pending | AT SKU Ngoc01 | random  | 1                | 1               | 0        | 0            | [blank]    | [blank]  | currentDate | Auto Ngoc Distribution CHI | ngoc vc2      | CHI    | Admin     |
    And Admin see detail inventory with lotcode "random"
    Then Verify inventory detail
      | product                      | sku           | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | AT Product Financial Pending | AT SKU Ngoc01 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 1           | 1          | 0      |
    And Verify subtraction item after ordered
      | date        | qty | category | description             | action  | order   |
      | currentDate | 1   | [blank]  | auto-confirmed, pending | [blank] | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v21@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region              | store                      | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoctx Financial pending01 | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor Check items in order detail
      | brandName                    | productName                  | skuName       | casePrice | quantity | total  | podConsignment                    |
      | AT Brand Financial Pending01 | AT Product Financial Pending | AT SKU Ngoc01 | $100.00   | 1        | $90.00 | Pod Consignment auto-confirmation |

    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
    And USER_EMAIL search email with value "ID Invoice"
    And go to email with title "Pod Foods "
    And Verify info email Financial Pending
      | name                           | line1                                    | line2        |
      | Hello ngoctx FinancialPending, | Thank you for your order with Pod Foods! | Order Number |
    And Verify items in order detail in email Create Order
      | brand                        | sku           | casePrice      | quantity | total  | promotion |
      | AT Brand Financial Pending01 | AT SKU Ngoc01 | $100.001$90.00 | 1        | $90.00 | [blank]   |

  @Vendor_create_withdrawal_request_Admin_approve_LP_Complete
  Scenario: Checking withdrawal request flow when Vendor created inbound > Admin Approved > LP Completed
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Search order by sku "30724" by api
    And Admin delete order of sku "AT SKU Ngoc01" by api

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor28@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR open withdraw request
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region           | carrier     | nameContact | palletWeight | comment | bol               |
      | Plus7      | 09:30      | 10:00    | New York Express | Self Pickup | Bao         | 10           | comment | images/anhPNG.png |
    And Vendor verify region available in withdrawal request
      | region                   |
      | Chicagoland Express      |
      | Florida Express          |
      | Mid Atlantic Express     |
      | New York Express         |
      | North California Express |
      | South California Express |
      | Dallas Express           |
    And Vendor add new lot code to withdrawal request 2
      | index | sku            | lotQuantity | lotCode |
      | 1     | sku withdraw 2 | 2           | random  |
    And Vendor click create withdrawal request
    And VENDOR open withdraw request
    And Vendor check withdrawal request just created on tab "All"
      | number  | requestDate | pickupDate | case | status    |
      | [blank] | currentDate | Plus6      | 2    | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number  | requestDate | pickupDate | case | status    |
      | [blank] | currentDate | Plus6      | 2    | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate | pickupFrom | pickupTo | region           | type        | name | palletWeight | comment | bol        | endQuantity  |
      | Submitted | Plus6      | 09:30      | 10:00    | New York Express | Self Pickup | Bao  | 24           | comment | anhPNG.png | End Quantity |
    And Vendor check lots in detail of withdrawal request
      | index | brand                               | product                                | sku            | skuID | lotCode        | quantity |
      | 1     | Auto brand check withdraw inventory | Auto product check withdraw inventorty | sku withdraw 2 | #     | sku withdraw 2 | 2        |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName        | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | sku withdraw 2 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName        | skuName        | lotCode        | originalQuantity | currentQuantity | quantity     | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter | vendorCompany | region | createdBy |
      | 1     | Auto product check | sku withdraw 2 | sku withdraw 2 | 1000             | [blank]         | End Quantity | 0            | [blank]    | [blank]  | [blank]          | [blank]     | [blank]            | [blank]       | NY     | [blank]   |

    And ADMIN navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number          | vendorCompany                          | brand   | region  | status    | startDate | endDate |
      | create by admin | Auto Vendor Company Withdraw inventory | [blank] | [blank] | Submitted | [blank]   | [blank] |
    And Admin check record on list withdrawal request
      | number  | vendorCompany                          | brand                               | region           | status    | pickupDate |
      | [blank] | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | New York Express | Submitted | Plus6      |
    And Admin go to detail withdraw request number ""
    And Admin check general information "submitted" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region           | pickupType  | partner | palletWeight | status    | comment | bol        |
      | Auto Vendor Company Withdraw inventory | Plus6      | 09:30 am  | 10:00 am | New York Express | Self pickup | Bao     | 24 lbs       | Submitted | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | product                                | sku            | lotCode        | endQty  | case |
      | Auto product check withdraw inventorty | sku withdraw 2 | sku withdraw 2 | [blank] | 2    |
    #Approve
    And Admin approve withdraw request success
    And Admin check general information "approved" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region           | pickupType  | partner | palletWeight | status   | comment | bol        |
      | Auto Vendor Company Withdraw inventory | Plus6      | 09:30 am  | 10:00 am | New York Express | Self pickup | Bao     | 24 lbs       | Approved | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | product                                | sku            | lotCode        | endQty  | case |
      | Auto product check withdraw inventorty | sku withdraw 2 | sku withdraw 2 | [blank] | 2    |

    And ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName        | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | sku withdraw 2 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName        | skuName        | lotCode        | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter | vendorCompany | region | createdBy |
      | 1     | Auto product check | sku withdraw 2 | sku withdraw 2 | 1000             | [blank]         | [blank]  | 0            | [blank]    | [blank]  | [blank]          | [blank]     | [blank]            | [blank]       | NY     | [blank]   |
    And VENDOR open withdraw request
    And Vendor check withdrawal request just created on tab "All"
      | number  | requestDate | pickupDate | case | status   |
      | [blank] | currentDate | Plus6      | 2    | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number  | requestDate | pickupDate | case | status   |
      | [blank] | currentDate | Plus6      | 2    | Approved |

    Given LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP Search Withdrawal Request
      | number  | vendorCompany | brand   | region  | from    |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |
    And LP Check record Withdrawal Request
      | number  | brand                               | pickupDate | status   |
      | [blank] | Auto brand check withdraw inventory | Plus6      | Approved |
    Given LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku            | product | vendorCompany | vendorBrand |
      | sku withdraw 2 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku            | distributionCenter      | vendorCompany                          | lotCode        | currentQuantity    | originalQuantity | received | expiry  |
      | 1     | sku withdraw 2 | Auto Distribute NewYork | Auto Vendor Company Withdraw inventory | sku withdraw 2 | End Quantity After | 1,000            | [blank]  | [blank] |

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName        | zeroQuantity | orderBy                 |
      | sku withdraw 2 | No           | Received - Latest first |
    And Vendor verify result in All Inventory
      | productName                            | skuName        | lotCode        | receivedQty | received | currentQty         | pulledQty | endQty             | expiryDate | pullDate |
      | Auto product check withdraw inventorty | sku withdraw 2 | sku withdraw 2 | 1,000       | [blank]  | End Quantity After | [blank]   | End Quantity After | N/A        | N/A      |

    Given ADMIN navigate to "Inventories" to "Withdrawal Requests" by sidebar
    When Admin search withdraw request
      | number          | vendorCompany                          | brand   | region  | status  | startDate | endDate |
      | create by admin | Auto Vendor Company Withdraw inventory | [blank] | [blank] | [blank] | [blank]   | [blank] |
    Then Admin check record on list withdrawal request
      | number  | vendorCompany                          | brand                               | region           | status   | pickupDate |
      | [blank] | Auto Vendor Company Withdraw inventory | Auto brand check withdraw inventory | New York Express | Approved | Plus6      |
    And Admin go to detail withdraw request number ""
    #Complete
    And Admin Complete withdraw request
    And Admin check general information "complete" withdrawal request
      | vendorCompany                          | pickupDate | startTime | endTime  | region           | pickupType  | partner | palletWeight | status    | comment | bol        |
      | Auto Vendor Company Withdraw inventory | Plus6      | 09:30 am  | 10:00 am | New York Express | Self pickup | Bao     | 24 lbs       | Completed | comment | anhPNG.png |

    And LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP Search Withdrawal Request
      | number  | vendorCompany | brand   | region  | from    |
      | [blank] | [blank]       | [blank] | [blank] | [blank] |
    And LP Check record Withdrawal Request
      | number  | brand                               | pickupDate | status    |
      | [blank] | Auto brand check withdraw inventory | Plus6      | Completed |
    Given LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku            | product | vendorCompany | vendorBrand |
      | sku withdraw 2 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku            | distributionCenter      | vendorCompany                          | lotCode        | currentQuantity    | originalQuantity | received | expiry  |
      | 1     | sku withdraw 2 | Auto Distribute NewYork | Auto Vendor Company Withdraw inventory | sku withdraw 2 | End Quantity After | 1,000            | [blank]  | [blank] |
    And VENDOR open withdraw request
    And Vendor check withdrawal request just created on tab "All"
      | number  | requestDate | pickupDate | case | status    |
      | [blank] | currentDate | Plus6      | 2    | Completed |
    And Vendor check withdrawal request just created on tab "Completed"
      | number  | requestDate | pickupDate | case | status    |
      | [blank] | currentDate | Plus6      | 2    | Completed |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate | pickupFrom | pickupTo | region           | type        | name | palletWeight | comment | bol        | endQuantity        |
      | Completed | Plus6      | 09:30      | 10:00    | New York Express | Self Pickup | Bao  | 24           | comment | anhPNG.png | End Quantity After |

  @Brand_Referral @sualai
  Scenario: Buyer invite Brand Referral > Admin mark as onboarded
    Given BUYER open web user
    When login to beta web with email "ngoctx+brandReferral01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER go to Brand Referral
    Then Buyer verify message after click invite
    When Buyer fill info to form brand referral
      | brand       | email                          | contactName       | work | addMore |
      | AT_Brand_01 | ngoctx+AT_Brand_01@podfoods.co | Contact Ngoctx_01 | Yes  | Yes     |
      | AT_Brand_02 | ngoctx+AT_Brand_02@podfoods.co | Contact Ngoctx_02 | Yes  | Yes     |
      | AT_Brand_03 | ngoctx+AT_Brand_03@podfoods.co | Contact Ngoctx_03 | Yes  | Yes     |
      | AT_Brand_04 | ngoctx+AT_Brand_04@podfoods.co | Contact Ngoctx_04 | Yes  | [blank] |
    And Buyer invite success
#
#    Given USER_EMAIL open login gmail with email "ngoctx@podfoods.co" pass "ngocmotchinba"
#    And Verify info brand referral
#      | title                      | brand       | line1                                  |
#      | Ngoctx brandReferral wants | AT_Brand_01 | ngoctx brandReferral wants AT_Brand_01 |
#      | Ngoctx brandReferral wants | AT_Brand_02 | ngoctx brandReferral wants AT_Brand_02 |
#      | Ngoctx brandReferral wants | AT_Brand_03 | ngoctx brandReferral wants AT_Brand_03 |
#      | Ngoctx brandReferral wants | AT_Brand_04 | ngoctx brandReferral wants AT_Brand_04 |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Brands" to "Brand referrals" by sidebar
    And Admin search brand referral with info
      | brand   | store                | email   | contact | onboarded | vendorCompany |
      | [blank] | ngoctx brandReferral | [blank] | [blank] | No        | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                | buyer                | brand       | email                          | contactName       | working | onboarded | vendorCompany |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_01 | ngoctx+AT_Brand_01@podfoods.co | Contact Ngoctx_01 | yes     | no        | [blank]       |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_02 | ngoctx+AT_Brand_02@podfoods.co | Contact Ngoctx_02 | yes     | no        | [blank]       |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_03 | ngoctx+AT_Brand_03@podfoods.co | Contact Ngoctx_03 | yes     | no        | [blank]       |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_04 | ngoctx+AT_Brand_04@podfoods.co | Contact Ngoctx_04 | yes     | no        | [blank]       |
    When Admin go to brand referrals details
    And Admin edit info of brand referral
      | brand       | email                          | contact           | work | vendorCompany | note    |
      | AT_Brand_01 | ngoctx+AT_Brand_01@podfoods.co | Contact Ngoctx_01 | Yes  | [blank]       | [blank] |
      | AT_Brand_02 | ngoctx+AT_Brand_02@podfoods.co | Contact Ngoctx_04 | Yes  | [blank]       | [blank] |
      | AT_Brand_03 | ngoctx+AT_Brand_03@podfoods.co | Contact Ngoctx_03 | Yes  | [blank]       | [blank] |
      | AT_Brand_04 | ngoctx+AT_Brand_04@podfoods.co | Contact Ngoctx_04 | Yes  | [blank]       | [blank] |
    And Admin save action in brand referral
    And Admin choose brand, edit and mark as onboarded
      | choose | vendorCompany |
      | Yes    | [blank]       |
      | Yes    | ngoc vc2      |
      | Yes    | [blank]       |
      | Yes    | ngoc vc 1     |
#    Then Admin verify result brand referrals after mark as onboarded
#      | brand       | email                          | contactName       | working | onboarded | vendorCompany | note |
#      | AT_Brand_01 | ngoctx+AT_Brand_01@podfoods.co | Contact Ngoctx_01 | Yes     | yes       | ngoc vc 1     | [blank]  |
#      | AT_Brand_02 | ngoctx+AT_Brand_02@podfoods.co | Contact Ngoctx_02 | Yes     | yes       | ngoc vc 1     | [blank]  |
#      | AT_Brand_03 | ngoctx+AT_Brand_03@podfoods.co | Contact Ngoctx_03 | Yes     | yes       | ngoc vc2      | [blank]  |
#      | AT_Brand_04 | ngoctx+AT_Brand_04@podfoods.co | Contact Ngoctx_04 | Yes     | yes       | ngoc vc2      | [blank]  |
    And NGOC_ADMIN navigate to "Brands" to "Brand referrals" by sidebar
    And Admin search brand referral with info
      | brand   | store                | email   | contact | onboarded | vendorCompany |
      | [blank] | ngoctx brandReferral | [blank] | [blank] | Yes       | [blank]       |
    Then Admin verify result brand referrals
      | date        | store                | buyer                | brand       | email                          | contactName       | working | onboarded | vendorCompany |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_01 | ngoctx+AT_Brand_01@podfoods.co | Contact Ngoctx_01 | yes     | yes       | ngoc vc 1     |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_02 | ngoctx+AT_Brand_02@podfoods.co | Contact Ngoctx_02 | yes     | yes       | ngoc vc 1     |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_03 | ngoctx+AT_Brand_03@podfoods.co | Contact Ngoctx_03 | yes     | yes       | ngoc vc2      |
      | currentDate | ngoctx brandReferral | ngoctx brandReferral | AT_Brand_04 | ngoctx+AT_Brand_04@podfoods.co | Contact Ngoctx_04 | yes     | yes       | ngoc vc2      |

    And NGOC_ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name      | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | ngoc vc 1 | No         | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name      | region  | email   | ein     | website | managedBy | launchBy |
      | ngoc vc 1 | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank]  |
    And Admin go to detail vendor company "ngoc vc 1"
    Then Admin verify general info vendor company
      | state  | name      | ein     | companySize | avg     | manager | launcher | referredName |
      | Active | ngoc vc 1 | [blank] | <25k        | [blank] | [blank] | [blank]  | ngoc cpn1    |
    And NGOC_ADMIN navigate to "Vendors" to "Companies" by sidebar
    And Admin search vendor company
      | name     | prepayment | region  | website | ein     | email   | managedBy | ach     | tag     |
      | ngoc vc2 | No         | [blank] | [blank] | [blank] | [blank] | [blank]   | [blank] | [blank] |
    And Admin verify info vendor company
      | name     | region | email   | ein     | website | managedBy | launchBy |
      | ngoc vc2 | CHI    | [blank] | [blank] | [blank] | [blank]   | [blank]  |
    And Admin go to detail vendor company "ngoc vc2"
    Then Admin verify general info vendor company
      | state  | name     | ein     | companySize | avg     | manager | launcher | referredName |
      | Active | ngoc vc2 | [blank] | <25k        | [blank] | [blank] | [blank]  | ngoc cpn1    |

  @inventory-flow @inventory-01
  Scenario: Check inventory flow if buyer checkout with quantity is less than or equal to end quantity
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create SKU from admin with name "sku random" of product "6059"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 10       | A1234   | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName         | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | random  | A1234   | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory
    Then Verify inventory detail
      | index | product             | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | A1234   | 10          | 10         | 10     |
    And NGOC_ADMIN navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName         | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc Inventory | 10               | 0                 | 10              | 0               | 0                    | 10          |

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 0                    | [blank] | [blank]     | [blank]               | 10 cases in inventory |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Ngoc Inventory", sku "random" and add to cart with amount = "1"
    And Go to Cart detail
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor Check items in order detail
      | brandName             | productName         | skuName | casePrice | quantity | total   | podConsignment                    |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | random  | $100.00   | 1        | $100.00 | Pod Consignment auto-confirmation |
    And Vendor navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 9      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 9      | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 1               | 0                    | 9      | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status               |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 1               | 0                    | [blank] | [blank]     | [blank]               | 9 cases in inventory |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution CHI"
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName         | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | random  | A1234   | 10               | 10              | 9        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory
    Then Verify inventory detail
      | product             | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | A1234   | 10          | 10         | 9      |
    And Verify subtraction item after ordered
      | date        | qty | category | description             | action  | order   |
      | currentDate | 1   | [blank]  | auto-confirmed, pending | [blank] | [blank] |

    And NGOC_ADMIN navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName         | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product            | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc Inventor | 10               | 0                 | 10              | 1               | 0                    | 9           |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Admin get ID SKU by name "" from product id "6059" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "" from API
    And Admin delete inventory "all" by API
    # Delete sku
    And Admin delete sku "" in product "6059" by api

  @inventory-flow @inventory-02
  Scenario: Check inventory flow if buyer checkout with quantity is equal to end quantity
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create SKU from admin with name "sku random" of product "6059"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 10       | A1234   | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName         | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | random  | A1234   | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory
    Then Verify inventory detail
      | index | product             | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | A1234   | 10          | 10         | 10     |
    And NGOC_ADMIN navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName         | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product            | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc Inventor | 10               | 0                 | 10              | 0               | 0                    | 10          |

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 0                    | [blank] | [blank]     | [blank]               | 10 cases in inventory |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Ngoc Inventory", sku "random" and add to cart with amount = "10"
    And Go to Cart detail
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | total     |
      | [blank]            | [blank]           | $1,020.00 |

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor Check items in order detail
      | brandName             | productName         | skuName | casePrice | quantity | total     | podConsignment                    |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | random  | $100.00   | 10       | $1,000.00 | Pod Consignment auto-confirmation |
    And Vendor navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 0      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 0      | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 10              | 0                    | 0      | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status           |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 10              | 0                    | [blank] | [blank]     | [blank]               | Only 0 case left |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution CHI"
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName         | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | random  | A1234   | 10               | 10              | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory
    Then Verify inventory detail
      | index | product             | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | A1234   | 10          | 10         | 0      |
    And Verify subtraction item after ordered
      | date        | qty | category | description             | action  | order   |
      | currentDate | 10  | [blank]  | auto-confirmed, pending | [blank] | [blank] |
    And NGOC_ADMIN navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName         | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product            | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc Inventor | 10               | 0                 | 10              | 10              | 0                    | 0           |
    And NGOC_ADMIN navigate to "Inventories" to "Zero quantity" by sidebar
    And Admin search inventory in zero quantity
      | skuName | productName         | vendorCompany | vendorBrand | region              |
      | random  | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express |
    Then Admin verify inventory zero quantity
      | product             | sku    | originalQty | currentQty | qty | pullQty | brand                 | vendorCompany | region |
      | Auto Ngoc Inventory | random | 10          | 10         | 0   | 0       | AT Brand Inventory 01 | ngoc vc 1     | CHI    |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Admin get ID SKU by name "" from product id "6059" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | random                  | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "" from API
    And Admin delete inventory "all" by API
    # Delete sku
    And Admin delete sku "" in product "6059" by api

  @inventory-flow @inventory-03
  Scenario: Check inventory flow if buyer checkout with more than end quantity
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
    And Admin create SKU from admin with name "sku random" of product "6059"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 10       | A1234   | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName         | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | random  | A1234   | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory
    Then Verify inventory detail
      | index | product             | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | A1234   | 10          | 10         | 10     |
    And NGOC_ADMIN navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName         | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc Inventory | 10               | 0                 | 10              | 0               | 0                    | 10          |

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 0                    | 10     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 0                    | [blank] | [blank]     | [blank]               | 10 cases in inventory |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Ngoc Inventory", sku "random" and add to cart with amount = "15"
    And Go to Cart detail
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | total    |
      | [blank]            | [blank]           | 1,520.00 |

    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unconfirmed"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And Vendor Go to order detail with order number ""
    And Vendor Check items in order detail
      | brandName             | productName         | skuName | casePrice | quantity | total     | podConsignment |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | random  | $100.00   | 1        | $1,500.00 | not set        |
    And Vendor navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | random  | A1234   | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 15                   | -5     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status         |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | random | 10               | 0                | 10              | 0               | 15                   | [blank] | [blank]     | [blank]               | 5 cases needed |

    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then Admin verify pod consignment deliverable not set
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName         | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | random  | A1234   | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory
    Then Verify inventory detail
      | product             | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | A1234   | 10          | 10         | 10     |
    And Verify no inventory activities found

    And NGOC_ADMIN navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName         | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc Inventory | 10               | 0                 | 10              | 0               | 15                   | -5          |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Admin get ID SKU by name "" from product id "6059" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | random                  | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "" from API
    And Admin delete inventory "all" by API
    # Delete sku
    And Admin delete sku "" in product "6059" by api

  @Test1111
  Scenario: Test onboarding
    Given USER open web user
    And User register onboard
      | nameCompany          | email                       | website               | hear     | comment |
      | Auto Onboard Ngoc 02 | auto_onboard_ngoc@gmail.com | auto_onboard_ngoc.com | Retailer | Comment |
    And User choose contact type and fill info
      | role             | firstname | lastname | phone     | contactRole |
      | Retailer (Buyer) | Auto      | Test     | 012345678 | QA Auto     |
    And User choose region store located in
      | region      |
      | Chicagoland |
    And User choose category
      | category     |
      | Baby & Child |
    And User go to Next
    Then User verify about your company
      | nameCompany          | email                       |
      | Auto Onboard Ngoc 02 | auto_onboard_ngoc@gmail.com |
    And User fill info about company
      | nameCompany | nameCompanyDBA | date     | fein      | email                 | storePhone | storeSize | storeTypes    |
      | random      | random         | 05/01/20 | 123456789 | mailCompany@gmail.com | 0123456789 | <50k      | Grocery Store |
    And User fill info your company address
      | address1               | address2 | city    | state    | zip   | timeZone                   |
      | 700 North Clark Street | [blank]  | Chicago | Illinois | 60654 | Central Time (US & Canada) |
    Then User verify about your account
      | firstName | lastName | phone    |
      | Auto      | Test     | 01234567 |
    And User fill info your account
      | firstName | lastName | email  | phone      | password  | confirmPass |
      | Auto      | Onboard  | random | 0123456789 | 12345678a | 12345678a   |
    And User get started
    And User verify onboard login screen
      | email  | role  |
      | random | buyer |
    When login to onboard web
    Then User verify info Receiving in Retailer Details
      | address                | city    | state    | zip   | phone      |
      | 700 North Clark Street | Chicago | Illinois | 60654 | 0123456789 |
    When User fill info Receiving in Retailer Details
      | receivingDay | earliestTime | latestTime | deliveryInstructions  | deliveryNote  | liftDate | pallets |
      | Monday       | 00:00        | 06:00      | Delivery Instructions | Delivery Note | Yes      | No      |
    Then User verify field empty Buying in Retailer Details
    When User fill info Buying in Retailer Details
      | prefered | category | departmentBuyerName   | departmentBuyerEmail | departmentBuyerPhone | additionalDepartment  | additionalDepartmentBuyerName    | additionalDepartmentBuyerEmail | additionalDepartmentBuyerInfo    | interested |
      | Email    | Dairy    | Department Buyer Name | autotest@gmail.com   | 0123456789           | Additional Department | Additional Department Buyer Name | autoOnboard@gmail.com          | Additional Department Infomation | Yes        |
    Then User verify field empty Trade references in Retailer Details
    When User fill info Trade references in Retailer Details
      | trade1                 | trade2                 | trade3                 |
      | Auto Trade Reference 1 | Auto Trade Reference 2 | Auto Trade Reference 3 |
    Then User verify field empty Financial in Retailer Details
    When User fill info Financial in Retailer Details
      | accountPlayableName | accountPlayableEmail          | accountPlayablePhone | accountPlayableMailingAddress | bankruptcy | receiveInvoice |
      | Auto AP 1105        | ngoc+auto_ap_1105@podfoods.co | 0987654321           | [blank]                       | Yes        | Yes            |
    Then User verify empty in Certificate
    When User upload file Certificated
      | businessCertificate | resaleCertificate |
      | anhJPEG.jpg         | anhPNG.png        |
    When User verify after upload in Certificate
    Then User verify Review Tos in Certificate
      | name         | date        |
      | Auto Onboard | currentDate |
    When User check Term in Review Tos
    And User summit to finish

    Given BUYER open web user
    When login to onboard web with email "random" pass "12345678a" role "buyer"
    And User go to General Page
    Then User verify Personal Information in General Settings
      | firstName | lastName | email  | phone      |
      | Auto      | Onboard  | random | 0123456789 |
    Then User verify Store Information in General Settings
      | nameBusiness | phoneBusiness | typeStore     | sizeStore | address                 | timeZone                   |
      | random       | 0123456789    | Grocery Store | <50k      | 700 North Clark Street, | Central Time (US & Canada) |
    Then User verify Company Information in General Settings
      | nameCompany | ein       | document            | businessCerti | resaleCerti |
      | random      | 123456789 | No documents found. | anhJPEG.jpg   | anhPNG.png  |
    And User verify message under review "display" in page "Analytics" and "No orders found..."
    And User verify message under review "display" in page "Orders" and "No results found..."
    And User verify message under review "display" in page "Samples" and "No results found..."
    And User verify message under review "display" in page "Payments" and "No credit memos found..."
    And User verify message under review "display" in page "Settings" and ""
    And User verify can't add to cart of product "Autotest product ngoc01"
    And User verify don't see add to cart of product "Autotest product ngoc01" in product detail
    And Vendor go to all brands page
    And Vendor search brand on catalog
      | brandName             | city    | state      |
      | AutoTest Brand Ngoc02 | Chicago | California |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name   | status    | tag     |
      | random | In Review | [blank] |
    Then Admin verify result buyer company
      | name        | ein       | website               | status    |
      | AutoOnboard | 123456789 | auto_onboard_ngoc.co… | In review |
    When Admin go to detail of buyer company "AutoOnboard"
    And Admin verify general information of buyer company
      | state  | name   | ein       | website               | limit     | onboardStatus | businessCertificate | resaleCertificate |
      | Active | random | 123456789 | auto_onboard_ngoc.com | $1,000.00 | In review     | anhJPEG.jpg         | anhPNG.png        |
    And NGOC_ADMIN navigate to "Buyers" to "All buyers" by sidebar
    And Admin search all buyer
      | anyText | fullName | email   | role          | store  | managedBy | tag     | status  |
      | random  | [blank]  | [blank] | Store manager | random | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name         | region | role          | email       | store       |
      | Auto Onboard | N      | Store manager | autoonboard | AutoOnboard |
    When Admin go to detail of buyer "Auto Onboard"
    And Admin verify general information of all buyer
      | email  | firstName | lastName | contact    | region | store  | role          |
      | random | Auto      | Onboard  | 0123456789 | N/A    | random | Store manager |
    And NGOC_ADMIN navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name   | sos | size | type          | city    | state    | receive | region  | route   | managedBy | tag     | buyerCompany | status  |
      | random | Yes | <50k | Grocery Store | Chicago | Illinois | Monday  | [blank] | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store       | region | sos | size | type          | contact                       | delivery |
      | AutoOnboard | N      | Yes | <50k | Grocery Store | 700 North Clark Street, Chica | Mon      |
    When Admin go to detail of store "Auto Onboard"
    And Admin verify general information of all store
      | name   | nameCompany | stateStore | storeSize | storeType     | invoiceOption | sendInvoice | threshold | region | street                 | city    | state    | zip   | email                 | apEmail                       | phone      | timezone                   | day | start | end   | route   | referredBy |
      | random | random      | Active     | <50k      | Grocery Store | Yes           | Yes         | 35 day(s) | N/A    | 700 North Clark Street | Chicago | Illinois | 60654 | mailCompany@gmail.com | ngoc+auto_ap_1105@podfoods.co | 0123456789 | Central Time (US & Canada) | Mon | 00:00 | 06:00 | [blank] | [blank]    |
#     thực hiện approve onboard
    And NGOC_ADMIN navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name   | status    | tag     |
      | random | In Review | [blank] |
    When Admin go to detail of buyer company "AutoOnboard"
    And Admin choose region "Chicagoland Express" and approve buyer company
    And NGOC_ADMIN navigate to "Buyers" to "Buyer companies" by sidebar
    And Admin search buyer company
      | name   | status   | tag     |
      | random | Approved | [blank] |
    Then Admin verify result buyer company
      | name        | ein       | website               | status   |
      | AutoOnboard | 123456789 | auto_onboard_ngoc.co… | Approved |
    When Admin go to detail of buyer company "AutoOnboard"
    And Admin verify general information of buyer company
      | state  | name   | ein       | website               | limit     | onboardStatus | businessCertificate | resaleCertificate |
      | Active | random | 123456789 | auto_onboard_ngoc.com | $1,000.00 | Approved      | anhJPEG.jpg         | anhPNG.png        |
    And NGOC_ADMIN navigate to "Buyers" to "All buyers" by sidebar
    And Admin search all buyer
      | anyText | fullName | email   | role          | store  | managedBy | tag     | status  |
      | random  | [blank]  | [blank] | Store manager | random | [blank]   | [blank] | [blank] |
    Then Admin verify result all buyer
      | name         | region | role          | email       | store       |
      | Auto Onboard | CHI    | Store manager | autoonboard | AutoOnboard |
    When Admin go to detail of buyer "Auto Onboard"
    And Admin verify general information of all buyer
      | email  | firstName | lastName | contact    | region              | store  | role          |
      | random | Auto      | Onboard  | 0123456789 | Chicagoland Express | random | Store manager |
    And NGOC_ADMIN navigate to "Stores" to "All stores" by sidebar
    And Admin search all store
      | name   | sos | size | type          | city    | state    | receive | region              | route   | managedBy | tag     | buyerCompany | status  |
      | random | Yes | <50k | Grocery Store | Chicago | Illinois | Monday  | Chicagoland Express | [blank] | [blank]   | [blank] | [blank]      | [blank] |
    Then Admin verify result all store
      | store       | region | sos | size | type          | contact                       | delivery |
      | AutoOnboard | CHI    | Yes | <50k | Grocery Store | 700 North Clark Street, Chica | Mon      |
    When Admin go to detail of store "Auto Onboard"
    And Admin verify general information of all store
      | name   | nameCompany | stateStore | storeSize | storeType     | invoiceOption | sendInvoice | threshold | region              | street                 | city    | state    | zip   | email                 | apEmail                       | phone      | timezone                   | day | start | end   | route   | referredBy |
      | random | random      | Active     | <50k      | Grocery Store | Yes           | Yes         | 35 day(s) | Chicagoland Express | 700 North Clark Street | Chicago | Illinois | 60654 | mailCompany@gmail.com | ngoc+auto_ap_1105@podfoods.co | 0123456789 | Central Time (US & Canada) | Mon | 00:00 | 06:00 | [blank] | [blank]    |

    Given HEAD_BUYER_PE open web user
    When login to onboard web with email "random" pass "12345678a" role "buyer"
    And HEAD_BUYER_PE Navigate to Dashboard
    And User verify message under review "not display" in page "Analytics" and "No orders found..."
    And User verify message under review "not display" in page "Orders" and "No results found..."
    And User verify message under review "not display" in page "Samples" and "No results found..."
    And User verify message under review "not display" in page "Payments" and "No credit memos found..."
    And User verify message under review "not display" in page "Settings" and ""
    And HEAD_BUYER_PE go to catalog "All"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc01" and add to cart with amount = "1"
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 152.00 |
    And Check out cart "Pay by invoice" and "see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 152.00 |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | 20.00             | [blank]      | 152.00 |
    # tạo pre order
    Given HEAD_BUYER_PE open web user
    When login to onboard web with email "random" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Verify in pre-order detail of SKU "AT SKU PreOrder 01" of product "AT Product PreOrder"
      | button    | availability   |
      | Pre-order | Launching Soon |
    And Buyer search product by name "AT Product PreOrder" and pre order with info
      | sku                | amount |
      | AT SKU PreOrder 01 | 1      |
    And Verify pre-order in tag All of order just create
      | date        | tag | store  | creator      | total   |
      | currentDate | Pre | random | Auto Onboard | $100.00 |
    And Search Order in tab "Pre-order" with
      | brand             | checkoutAfter | checkoutBefore |
      | AT Brand PreOrder | currentDate   | [blank]        |
    And Buyer verify pre-order result in tab Pre-order
      | index | order       | tag | number | store       | creator      | total   |
      | 1     | currentDate | Pre | random | AutoOnboard | Auto Onboard | $100.00 |

  @Admin @TC_Admin_create_Brand_Product_Sku_with_MOQs
  Scenario: Admin_create_Brand_Product_Sku_with_MOQs
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 03 | [blank]       | [blank]   | Active | [blank] |
    And Admin remove the brand the first record
    And Admin go to create brand
    And Admin create new brand
      | name                 | description | microDescriptions | city | state   | vendorCompany           |
      | Auto Create Brand 03 | description | microDescriptions | city | Alabama | Auto_Vendor_Company_MOQ |
    And Admin create brand success
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 03 | [blank]       | [blank]   | Active | [blank] |
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Create new Product
      | brandName            | productName   | status | allowRequestSamples | vendorCompany           | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions |
      | Auto Create Brand 03 | auto_product3 | Active | Yes                 | Auto_Vendor_Company_MOQ | 0.00%         | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 10             | 10            | 10                  | 0                      | 0                    | 0                          | 0                         | 0                          | 0                | [blank]           |
    And Admin regional MOQS
      | east | central | west |
      | 1    | 1       | 1    |
    And Check product not have SKU
    And Add new SKU
      | skuName               | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto_flow create sku3 | [blank] | [blank] | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | [blank]         | 10                 | 40                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | Dallas Express           | 12        | 15       | In stock     | [blank]  |
      | Chicagoland Express      | 12        | 15       | In stock     | [blank]  |
      | Florida Express          | 12        | 15       | In stock     | [blank]  |
      | Mid Atlantic Express     | 12        | 15       | Out of stock | [blank]  |
#      | New York Express               | 12        | 15       | Launching soon | currentDate |
      | North California Express | 12        | 15       | In stock     | [blank]  |
      | South California Express | 12        | 15       | In stock     | [blank]  |
      | Pod Direct Central       | 12        | 15       | In stock     | [blank]  |
#      | Pod Direct Northeast           | 12        | 15       | Launching soon | currentDate |
      | Pod Direct East          | 12        | 15       | Out of stock | [blank]  |
#      | Pod Direct Southwest & Rockies | 12        | 15       | In stock     | [blank]  |
      | Pod Direct West          | 12        | 15       | In stock     | [blank]  |
    And Click Create
    Given VENDOR open web user
    When login to beta web with email "ngoctx+vendormoq@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Vendor Check Brand on Dashboard
      | brandName            | city | state   | country | description |
      | Auto Create Brand 03 | city | Alabama | U.S     | description |
    And Vendor check brand in detail
      | brandName            | city | state   | country | description |
      | Auto Create Brand 03 | city | Alabama | U.S     | description |
    And Vendor go to all brands page
    And Vendor search brand on catalog
      | brandName            | city | state   |
      | Auto Create Brand 03 | city | Alabama |
    And Vendor go to brand "Auto Create Brand 03" detail on catalog
    And Vendor check brand detail on catalog
      | brandName            | city | state   | description |
      | Auto Create Brand 03 | city | Alabama | description |
    And Vendor check a product on brand detail
      | auto_product3 |
    And Vendor Go to product detail
      | productName   | unitDimension   | caseDimension   | unitSize | casePack |
      | auto_product3 | 12" x 12" x 12" | 12" x 12" x 12" | 8.0      | 12       |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp   | availability | moq |
      | Pod Direct West          | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
#      | Pod Direct Southwest & Rockies | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | Pod Direct East          | $1.00 | $12.00    | $15.00 | Out of Stock | 1   |
#      | Pod Direct Northeast           | $1.00 | $12.00    | $15.00 | Launching Soon | 1   |
      | Pod Direct Central       | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | South California Express | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | North California Express | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
#      | New York Express               | $1.00 | $12.00    | $15.00 | Launching Soon | 1   |
      | Mid Atlantic Express     | $1.00 | $12.00    | $15.00 | Out of Stock | 1   |
      | Florida Express          | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | Chicagoland Express      | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
      | Dallas Express           | $1.00 | $12.00    | $15.00 | In Stock     | 1   |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

#    Verify on Head buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyerbao5@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

#    Verify on Head buyer with sku Launching soon
    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyerbaony5@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability   | arrivingDate |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Launching Soon | currentDate  |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    Verify on Head buyer with sku Out of stock
    Given BUYER3 open web user
    And login to beta web with email "ngoctx+autobuyerbaomidalantic5@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Out of Stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

#  Verify on Direct buyer
    Given BUYER4 open web user
    And login to beta web with email "ngoctx+autobuyerbao6@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "false"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | In Stock     |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    And Check badge Direct is "true"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 03 | auto_product3 | $1.00     | 1         |


#  Verify on Direct buyer with sku Launching soon
    Given BUYER5 open web user
    And login to beta web with email "ngoctx+autobuyerbaopdnt6@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "false"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability   | arrivingDate |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Launching Soon | currentDate  |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    And Check badge Direct is "true"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 03 | auto_product3 | $1.00     | 1         |


#  Verify on Direct buyer with sku Out of stock
    Given BUYER6 open web user
    And login to beta web with email "ngoctx+autobuyerbaopdst6@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check tag Express is "false"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Out of Stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    And Check badge Direct is "true"
    And Search Brand and go to detail
      | brand                | productName   | unitPrice | numberSku |
      | Auto Create Brand 03 | auto_product3 | $1.00     | 1         |

#    Verify on Sub buyer with sku instock
    Given BUYER7 open web user
    And login to beta web with email "ngoctx+autobuyerbao7@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Check button add to cart on product detail is disable
#    Verify on Sub buyer with sku Launching soon
    Given BUYER8 open web user
    And login to beta web with email "ngoctx+autobuyerbaony7@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability   | arrivingDate |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Launching Soon | currentDate  |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |

          #    Verify on Sub buyer with sku Out of stock
    Given BUYER9 open web user
    And login to beta web with email "ngoctx+autobuyerbaopdst7@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku3"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku3 | auto_product3 | Auto Create Brand 03 | $1.00        | $12.00       | Out of Stock |
    And Check more information of SKU
      | unitUpcEan   | grossMargin | msrp   | minimumOrder | unitDimension   | caseDimension   | unitSize | casePack          |
      | 123456789098 | 93%         | $15.00 | 1            | 12" x 12" x 12" | 12" x 12" x 12" | 8.0 g    | 12 units per case |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Check button add to cart on product detail is disable

  @Admin @TC_Admin_create_Brand_Product_Sku_with_MOV
  Scenario: Admin_create_Brand_Product_Sku_with_MOV
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 04 | [blank]       | [blank]   | Active | [blank] |
    And Admin remove the brand the first record
    And Admin go to create brand
    And Admin create new brand
      | name                 | description | microDescriptions | city | state   | vendorCompany        |
      | Auto Create Brand 04 | description | microDescriptions | city | Alabama | AutoVendorCompanyMOV |
    And Admin create brand success
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 04 | [blank]       | [blank]   | Active | [blank] |
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Create new Product
      | brandName            | productName   | status | allowRequestSamples | vendorCompany        | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions |
      | Auto Create Brand 04 | auto_product4 | Active | Yes                 | AutoVendorCompanyMOV | 0.00%         | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 10             | 10            | 10                  | 0                      | 0                    | 0                          | 0                         | 0                          | 0                | [blank]           |
    And Check product not have SKU
    And Add new SKU
      | skuName               | state   | mainSKU | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto_flow create sku4 | [blank] | [blank] | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | Dry             | 10                 | 40                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |
    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | North California Express | 12        | 15       | In stock     | [blank]  |
    And Click Create

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendormov@poodfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Vendor Check Brand on Dashboard
      | brandName            | city | state   | country | description |
      | Auto Create Brand 04 | city | Alabama | U.S     | description |
    And Vendor check brand in detail
      | brandName            | city | state   | country | description |
      | Auto Create Brand 04 | city | Alabama | U.S     | description |
    And Vendor go to all brands page
    And Vendor search brand on catalog
      | brandName            | city | state   |
      | Auto Create Brand 04 | city | Alabama |
    And Vendor go to brand "Auto Create Brand 04" detail on catalog
    And Vendor check brand detail on catalog
      | brandName            | city | state   | description |
      | Auto Create Brand 04 | city | Alabama | description |
    And Vendor check a product on brand detail
      | auto_product4 |
    And Vendor Go to product detail
      | productName   | unitDimension   | caseDimension   | unitSize | casePack |
      | auto_product4 | 12" x 12" x 12" | 12" x 12" x 12" | 8.0      | 12       |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp   | availability | moq     |
      | North California Express | $1.00 | $12.00    | $15.00 | In Stock     | [blank] |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
#    Verify on Head buyer
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyerbao8@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku4"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku4 | auto_product4 | Auto Create Brand 04 | $1.00        | $12.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
      #    Verify on Direct buyer
    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyerbao9@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku4"
    And Check have no product showing
# Không hiển thị SKU trên Catalog của Direct buyer

#    Verify on Sub buyer
    Given BUYER3 open web user
    And login to beta web with email "ngoctx+autobuyerbao10@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku4"
    And Check tag Express is "true"
    And Check button add to cart is disable
    And Search item and go to detail of first result
      | item                  | productName   | productBrand         | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku4 | auto_product4 | Auto Create Brand 04 | $1.00        | $12.00       | In Stock     |
    And Check button add to cart on product detail is disable

  @Admin @TC_Admin_create_sku_with_price_show_on_Region_specifics_Tab_and_Buyer_company_specifics_tab
  Scenario: Admin_create_sku_with_price_show_on_Region_specifics_Tab_and_Buyer_company_specifics_tab
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer12@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API

    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer13@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term          | productState | brandName      | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product5 | [blank]      | Auto Brand Bao | [blank]       | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin remove the product on first record
    And Create new Product
      | brandName      | productName   | status | allowRequestSamples | vendorCompany      | additionalFee | category | type  | tags    | unitLength | unitWidth | unitHeight | caseLength | caseWidth | caseHeight | caseWeight | packageSize | unitSize | casesPerPallet | casesPerLayer | layersPerFullPallet | masterCartonsPerPallet | casesPerMasterCarton | masterCaseDimensionsLength | masterCaseDimensionsWidth | masterCaseDimensionsHeight | masterCaseWeight | microDescriptions |
      | Auto Brand Bao | auto_product5 | Active | Yes                 | Auto_VendorCompany | 0.00%         | Dairy    | Bread | [blank] | 12         | 12        | 12         | 12         | 12        | 12         | 12         | Bulk        | 8        | 10             | 10            | 10                  | 0                      | 0                    | 0                          | 0                         | 0                          | 0                | [blank]           |
    And Check product not have SKU
#    And Add new SKU
#      | skuName               | state | mainSKU | unitsCase | individualUnitUPC | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                             | leadTime | description | expireDayThreshold |
#      | auto_flow create sku5 | [blank]  | [blank]  | 12        | 123456789098      | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]  | 10              | Dry             | 10                 | 40                 | New York | New York         | Sodium Laureth Sulfate,Hexylene Glycol | 5        | abc         | 100                |
    And Add new SKU
      | skuName               | state   | mainSKU | unitsCase | individualUnitUPC | individualUnitEANType | masterImage     | caseUPC      | unitUpcImage | caseUpcImage  | storageShelfLife | storageCondition | retailShelfLife | retailCondition | tempRequirementMin | tempRequirementMax | city     | stateManufacture | ingredient                              | leadTime | description | expireDayThreshold |
      | auto_flow create sku5 | [blank] | [blank] | 12        | 123456789098      | no                    | masterImage.jpg | 123456789098 | UPCImage.png | CaseImage.png | 30               | [blank]          | 10              | Dry             | 10                 | 40                 | New York | New York         | Sodium Laureth Sulfate, Hexylene Glycol | 5        | abc         | 100                |


    And with Nutrition labels
      | nutritionLabel     | nutritionLabelDescription |
      | nutritionImage.jpg | [blank]                   |
    And with Qualities
      | 100% Natural |
      | Gluten-Free  |
    And with region specific
      | regionName               | casePrice | msrpunit | availability | arriving |
      | North California Express | 12        | 15       | In stock     | [blank]  |
      | Dallas Express           | 10        | 15       | In stock     | [blank]  |
    And Go to "Buyer company-specific" tab
    And Admin search Buyer Company specific "Auto_BuyerCompany"
    And Admin choose regions and add to Buyer Company specific
      | regions                  |
      | North California Express |
    And with Buyer Company-specific
      | buyerCompany      | region                   | msrpUnit | casePrice | availability | startDate   | endDate | inventoryArrivingAt | category |
      | Auto_BuyerCompany | North California Express | 21       | 20        | In stock     | currentDate | Plus1   | [blank]             | [blank]  |
    And Click Create

#    Check on Dashboard
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor12@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail just created
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "auto_flow create sku5"
    And Vendor check SKU general detail
      | skuName               | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country | city     | state    | storage | retail | minTemperature | maxTemperature |
      | auto_flow create sku5 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 12       | 123456789098 | 123456789098 | U.S     | New York | New York | 30      | 10     | 10.0           | 40.0           |
    And Vendor check Region-Specific of SKU
      | regionName               | casePrice | msrpUnit | availability |
      | Dallas Express           | 10        | 15       | In Stock     |
      | North California Express | 12        | 15       | In Stock     |
    And Vendor go to "Buyer-Company-Specific Price" tab on SKU detail
    And Vendor check Buyer-Company Specific tap
      | buyerCompany      | region | msrpUnit | casePrice | availability | startDate | endDate |
      | Auto_BuyerCompany | SF     | 21       | 20        | In stock     | [blank]   | [blank] |

#Check on catalog
    And Vendor search product "auto_flow create sku5" on catalog
    And Vendor Go to product detail
      | productName   | unitDimension   | caseDimension   | unitSize | casePack |
      | auto_product5 | 12" x 12" x 12" | 12" x 12" x 12" | 8.0      | 12       |
    And Vendor check regions detail
      | region                   | price | casePrice | msrp   | availability | moq |
      | Dallas Express           | $0.83 | $10.00    | $15.00 | In Stock     | 1   |
      | North California Express | $1.00 | $12.00    | $15.00 | In Stock     | 1   |

#Check on buyer catalog
##    Verify on Head buyer of North california express
#    Giá ăn theo Buyer-Company specific
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer12@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku5"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand   | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku5 | auto_product5 | Auto Brand Bao | $1.67        | $20.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Clear cart to empty in cart before
    And Add to cart the sku "auto_flow create sku5" with quantity = "1"
    And Verify item on cart tab on right side
      | brand          | product       | sku                   | price  | quantity |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $20.00 | 1        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
    And Go to Cart detail
    And Check item in Cart detail
      | brand          | product       | sku                   | price  | quantity |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $20.00 | 1        |
    And and check price on cart detail
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
#    And Clear cart to empty in cart before

#    Check trên Buyer thuộc Taxas Express,
#    Giá ăn theo Region specific
    Given BUYER2 open web user
    And login to beta web with email "ngoctx+autobuyer13@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_flow create sku5"
    And Check tag Express is "true"
    And Search item and go to detail of first result
      | item                  | productName   | productBrand   | pricePerUnit | pricePerCase | availability |
      | auto_flow create sku5 | auto_product5 | Auto Brand Bao | $0.83        | $10.00       | In Stock     |
    And and check details information
      | brandLocation      | storage     | retail      | ingredients                             |
      | New York, New York | 30 days Dry | 10 days Dry | Sodium Laureth Sulfate, Hexylene Glycol |
    And and product qualities
      | Gluten-Free  |
      | 100% Natural |
    And Clear cart to empty in cart before
    And Add to cart the sku "auto_flow create sku5" with quantity = "1"
    And Verify item on cart tab on right side
      | brand          | product       | sku                   | price  | quantity |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $10.00 | 1        |
    And and verify price on cart tab on right side
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
    And Go to Cart detail
    And Check item in Cart detail
      | brand          | product       | sku                   | price  | quantity |
      | Auto Brand Bao | auto_product5 | auto_flow create sku5 | $10.00 | 1        |
    And and check price on cart detail
      | logisticsSurcharge | smallOrderSurcharge |
      | $20.00             | $30.00              |
#    And Clear cart to empty in cart before

  @Admin @TC_Admin_deactivate_brand_check_all_screen
  Scenario: Admin_deactivate_brand_check_all_screen
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Change state of Brand id: "2820" to "active"
#    State (active, inactive)
    And Change state of product id: "6055" to "active"
#    State (active, inactive, draft)
    And Update all SKU of product "6055" to "active"

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Brands" to "All brands" by sidebar
    And Admin search the brand by info then system show result
      | name                 | vendorCompany | managedBy | state  | tags    |
      | Auto Create Brand 06 | [blank]       | [blank]   | Active | [blank] |
    And Go to brand detail
    And Admin verify general information in brand detail
      | name                 | description | microDescriptions | city    | state  | vendorCompany      | tags    |
      | Auto Create Brand 06 | [blank]     | [blank]           | [blank] | Active | Auto_VendorCompany | [blank] |
#    Deactive brand
    And Deactivate this brand
    And Admin verify general information in brand detail
      | name                 | description | microDescriptions | city    | state    | vendorCompany      | tags    |
      | Auto Create Brand 06 | [blank]     | [blank]           | [blank] | Inactive | Auto_VendorCompany | [blank] |
#    Check Product is inactive
    And ADMIN navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term          | productState | brandName            | vendorCompany      | productType | packageSize | sampleable | availableIn | tags    |
      | auto_product6 | Inactive     | Auto Create Brand 06 | Auto_VendorCompany | Bread       | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Check product not have SKU
    And Go to inactive SKU tab
    And Admin check SKU Inactive info
      | skuName               | unitUpc      | caseUpc      | status   |
      | auto_flow create sku6 | 123456789098 | 123456789098 | Inactive |
      | auto_flow create sku7 | 123456789098 | 123456789098 | Inactive |

#        Check on Vendor Dashboard
    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor12@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Brands" by sidebar
    And Vendor check Brand "Auto Create Brand 06" is "not showing" on dashboard
    And Search "Products" in dashboard by name "auto_product6"
    And Check no result found

 #    Check on Head Buyer catalog
    Given BUYER open web user
    And login to beta web with email "ngoctx+autobuyer12@podfoods.co" pass "12345678a" role "Buyer"
    And Search item "auto_product6"
    And Check have no product showing
    And Search Brand item "Auto Create Brand 06"
    And Check have no brands showing
    And Go to Recommended products
    And Check have no product showing
    And Go to Promotions
    And Show detail of all promotions
    And Check SKU "auto_flow create sku6" not in of all promotions
    And Check SKU "auto_flow create sku7" not in of all promotions
    And Go to Order guide
    And Check orders in order guild
      | brandName            | productName   | skuName               | unitPerCase | orderDate | quantity | addCart  |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku7 | [blank]     | 05/09/22  | 1        | disabled |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku6 | [blank]     | 05/09/22  | 1        | disabled |
    And BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    And Buyer verify order in result
      | ordered  | number     | store                       | creator         | payment | fulfillment | total  |
      | 05/09/22 | #220509886 | Auto Store North California | Bao AutoBuyer12 | Pending | Pending     | $52.00 |
    And Go to order detail with order number "220509886"
    And Check items in order detail
      | brandName            | productName   | skuName               | casePrice | quantity | total | addCart  |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku6 | $1.00     | 1        | $1.00 | disabled |
      | Auto Create Brand 06 | auto_product6 | auto_flow create sku7 | $1.00     | 1        | $1.00 | disabled |

#    //Tạo sample = api
#    And BUYER Navigate to "Samples" by sidebar
#    And Check Sample request in dashboard
#      | requested | number     | store                       | brand                | product       | fulfillment |
#      | 05/09/22  | #220509306 | Auto Store North California | Auto Create Brand 06 | auto_product6 | Pending     |
#    And Go to sample request detail with number "220509306"
#    And Check items in sample request detail
#      | brandName            | skuName               | status        | addCart  |
#      | Auto Create Brand 06 | auto_flow create sku7 | Not Available | disabled |
#      | Auto Create Brand 06 | auto_flow create sku6 | Not Available | disabled |

  @Order @Order_01
  Scenario: Head buyer (PE) checking buyer payment of sub-invoice is paid with payment method is paying by invoice
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "29918" by api
    And Admin delete order of sku "29918" by api

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
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
    And USER_EMAIL search email with value "Order will be fulfilled when your inventory is received"
    And QA go to first email with title "Order will be fulfilled when your inventory is received"
    And verify info email order fulfilled
      | name             | line1                                 | line2                                                         |
      | Hello ngoc vc 1, | Congrats on your order from ngoc st1! | This order will be fulfilled when your inventory is received. |
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
      | buyerName        | storeName | shippingAddress                          | orderValue | total  | payment    | status |
      | ngoctx pdTexas01 | ngoctx PD | 5306 Canal Street, Houston, Texas, 77011 | $10.00     | $10.00 | By invoice | Paid   |
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
      | buyerName  | storeName    | shippingAddress                                   | orderValue | total   | payment    | status |
      | auto schi1 | auto chi st1 | 2601 South Cicero Avenue, Cicero, Illinois, 60804 | $100.00    | $150.00 | By invoice | Paid   |
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
      | order  | checkout    | buyer           | store           | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCard01 | ngoctx stCredit | CHI    | $100.00 | $25.00    | Paid         | Fulfilled   | Pending       |

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
      | order  | checkout    | buyer                   | store           | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCreditCardPD01 | ngoctx stCredit | PDC    | $10.00 | $2.50     | Paid         | Fulfilled   | Pending       |

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
      | order  | checkout    | buyer              | store           | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stcardsub01 | ngoctx stCredit | CHI    | $100.00 | $25.00    | Paid         | Fulfilled   | Pending       |

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
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
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
      | order  | checkout    | buyer                  | store           | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCardInvalid01 | ngoctx stCredit | CHI    | $100.00 | $25.00    | Declined     | Fulfilled   | Pending       |

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

  @Order @Order_08
  Scenario: Head buyer (PE) checking buyer payment of sub-invoice is paid with payment method is paying by invalid credit card
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+stcardinvalid01@podfood.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Autotest product ngoc01", sku "Autotest SKU1 Ngoc02" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total  |
      | 30.00              | 20.00             | [blank] | 150.00 |
    And Go to Cart detail
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
      | order  | checkout    | buyer                  | store           | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stCardInvalid01 | ngoctx stCredit | CHI    | $100.00 | $25.00    | Declined     | Fulfilled   | Pending       |

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

  @StoreStatement @StoreStatement01
  Scenario: Store statement > Admin record payment: Credit memo, Adjustment, Unapplied payment, Sub-invoice of Current Month
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststate01chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin fill password to authen permission
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate01"
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    Then Admin verify "sub invoice" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Unpaid | 0     | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |

    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment | adjustment |
      | random  | 200           | currentDate | Other       | Autotest payment | [blank]     | [blank]          | [blank]    |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo  | unapplied | payment   | net      |
      | $0.00      | $150.00    | $0.00 | $0.00     | ($200.00) | ($50.00) |
    When Admin add record payment success
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify payment after record in bottom of store statements detail
      | type    | checkout    | deliveryDate | buyer   | status  | aging   | description              | orderValue | discount | deposit | fee     | credit  | pymt      | total     |
      | Payment | currentDate | currentDate  | [blank] | [blank] | [blank] | Other - Autotest payment | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($150.00) | ($150.00) |
    And Admin get id of Unapplied payment after record payment success
    And Admin verify unapplied payment in "middle" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |
    And Admin verify unapplied payment in "bottom" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status   | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Not used | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |

    And NGOC_ADMIN navigate to "Financial" to "Credit memos" by sidebar
    When Admin create credit memo with info
      | buyer                 | orderID | type              | amount | description      | file                 |
      | ngoctx ststate01chi01 | random  | Credit memo test1 | 10     | Auto Credit Memo | CreateCreditMemo.pdf |
    And Admin create credit memo success

    And NGOC_ADMIN navigate to "Orders" to "Create new order" by sidebar
    And Admin create new order
      | buyer                 | paymentType    | street                | city    | state    | zip   |
      | ngoctx ststate01chi01 | Pay by invoice | 1544 West 18th Street | Chicago | Illinois | 60608 |
    And Admin add line item is "Autotest SKU1 Ngoc02"
    And Admin create order success
    When Admin fulfill all line items
      | index | skuName              | fulfillDate |
      | 1     | Autotest SKU1 Ngoc02 | currentDate |
    And Admin get ID of sub-invoice of order "express"

    And NGOC_ADMIN navigate to "Financial" to "Store statements" by sidebar
    And Admin search store statements
      | buyerCompany | store            | buyer                 | statementMonth | region              | managedBy |
      | ngoc cpn1    | ngoctx ststate01 | ngoctx ststate01chi01 | currentDate    | Chicagoland Express | [blank]   |
    And Admin go to detail of store statement "ngoctx ststate01"
    And Admin add an adjustment
      | value | type         | subInvoice | deliveryDate | description     |
      | 10    | adjustment 1 | random     | currentDate  | Auto Adjustment |
    And Admin verify "credit memo" in "middle" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status   | aging | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Not used | 0     | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "middle" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    And Admin verify "credit memo" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status   | aging | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Not used | 0     | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Unpaid | 0     | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    When Admin add record payment
      | orderID | paymentAmount | paymentDate | paymentType | note             | creditMemos | unappliedPayment  | adjustment   |
      | random  | 100           | currentDate | Other       | Autotest payment | random      | Unapplied Payment | adjustment 1 |
    Then Admin verify summary in popup record payment
      | adjustment | subinvoice | memo     | unapplied | payment   | net   |
      | $10.00     | $150.00    | ($10.00) | ($50.00)  | ($100.00) | $0.00 |
    When Admin add record payment success

    And Admin verify "credit memo" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee     | credit   | pymt    | total    |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Used   | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | ($10.00) | [blank] | ($10.00) |
    And Admin verify "adjustment" in "bottom" of store statements details
      | orderID      | checkout    | deliveryDate | buyer   | status | aging   | description     | orderValue | discount | deposit | fee     | credit  | pymt   | total  |
      | adjustment 1 | currentDate | currentDate  | [blank] | Paid   | [blank] | Auto Adjustment | [blank]    | [blank]  | [blank] | [blank] | [blank] | $10.00 | $10.00 |
    Then Admin verify "sub invoice" in "bottom" of store statements details
      | orderID | checkout    | deliveryDate | buyer                 | status | aging   | description | orderValue | discount | deposit | fee    | credit  | pymt    | total   |
      | random  | currentDate | currentDate  | ngoctx ststate01chi01 | Paid   | [blank] | [blank]     | $100.00    | [blank]  | $0.00   | $50.00 | [blank] | [blank] | $150.00 |
    And Admin verify unapplied payment in "bottom" of store statements detail of "current" month
      | type              | checkout    | deliveryDate | buyer   | status | aging   | description | orderValue | discount | deposit | fee     | credit  | pymt     | total    |
      | Unapplied Payment | currentDate | currentDate  | [blank] | Used   | [blank] | [blank]     | [blank]    | [blank]  | [blank] | [blank] | [blank] | ($50.00) | ($50.00) |
    When Admin verify sum of "order-value" in "bottom" of store statements details
    When Admin verify sum of "deposit" in "bottom" of store statements details
    When Admin verify sum of "fee" in "bottom" of store statements details
    When Admin verify sum of "memo" in "bottom" of store statements details
    When Admin verify sum of "payment" in "bottom" of store statements details
    When Admin verify sum of "total" in "bottom" of store statements details

  @Promotion @Promotion01
  Scenario: Head buyer checks out with buy-in promotion
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Product Buy In api1" by api
    And Admin search product name "Product Buy In api1" by api
    And Admin delete product name "Product Buy In api1" by api
    And Admin search promotion by Promotion Name "Auto Short-dated Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto TPR Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Pod-sponsored Promotion"
    And Admin delete promotion by skuName ""
    And Admin search promotion by Promotion Name "Auto Buy-in Promotion"
    And Admin delete promotion by skuName ""

    And Admin create product by api with info
      | fileName           | product             | brandID |
      | CreateProduct.json | Product Buy In api1 | 2857    |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp  |
      | Chicagoland Express | 26 | active | in_stock     | 10000     | 10000 |
      | New York Express    | 53 | active | in_stock     | 13000     | 13000 |
    And Admin create SKU from admin with name "sku random" of product ""

    And Admin search promotion by Promotion Name "Auto Buy In Promotion"
    And Admin delete promotion by skuName "Auto Buy In Promotion"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Promotions" to "All promotions" by sidebar
    And Create promotion
      | name                  | description      | type   | expirySKU | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | specSKU | store    | typePromo  | amount | excludeStore | includedBuyerCompany | excludedBuyerCompany |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]   | [blank]    | 10        | 1           | 05/04/22 | currentDate | Yes        | random  | ngoc st1 | Percentage | 10     | [blank]      | [blank]              | [blank]              |
    And Choose regions to promo
      | region              |
      | Chicagoland Express |
    And Create promo success
    And Search promotion by info
      | name                  | type   | store    | brand   | productName | skuName | region              | startAt    | expireAt    |
      | Auto Buy In Promotion | Buy-in | ngoc st1 | [blank] | [blank]     | [blank] | Chicagoland Express | 2022-05-04 | currentDate |
    Then Verify promotion show in All promotion page
      | name                  | type   | region | startAt    | expireAt    | usageLimit | CaseLimit |
      | Auto Buy In Promotion | Buy-in | CHI    | 2022-05-04 | currentDate | [blank]    | 10        |
    And Verify promotion info in Promotion detail
      | name                  | description      | type   | usageLimit | caseLimit | caseMinimum | fromDate | toDate      | showVendor | specSKU | store    | typePromo  | amount |
      | Auto Buy In Promotion | Auto Description | Buy-in | [blank]    | 10        | 1           | 05/04/22 | currentDate | is-checked | random  | ngoc st1 | Percentage | 10     |
    And Verify amount of promotion with "no" stack deal
      | type | amount |
      | %    | 10     |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName              | orderBrand | time    |
      | AutoTest Promo BuyIn 2 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type   | pricePromoted | minimumPurchase | limitedTo                   | start    | expired     |
      | Buy in | $90.00        | 1 Case          | 10 cases of the first order | 05/04/22 | currentDate |
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Promo BuyIn 2"
    Then Verify promo preview "Buy in" of product "Product Buy In api1" in "Product page"
      | name   | type   | price  | caseLimit |
      | random | BUY-IN | $90.00 | 10        |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product Buy In api1", sku "random" and add to cart with amount = "1"
    Then Verify promo preview "Buy in" of product "Product Buy In api1" in "Catalog page"
      | name   | type   | price  | caseLimit |
      | random | BUY-IN | $90.00 | 10        |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product Buy In api1" and sku "random" in product detail
      | unitPrice | casePrice | typePromo        | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00    | Buy-in Promotion | 10% off  | $90.00   | 10        | 10%                |
    When Add product "Product Buy In api1" to favorite
    Then Verify promo preview "Buy in" of product "Product Buy In api1" in "Favorite page"
      | name   | type   | price  | caseLimit |
      | random | BUY-IN | $90.00 | 10        |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Verify price promo in order buyer is "-$10.00"
    And See invoice
    Then Verify price promo in Invoice is "- USD 10.00"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then NGOC_ADMIN verify price promo in order details of Admin is "$10.00"
    And Admin verify price promo in sku "random" of order
      | endQuantity | total  |
      | $90.00      | $90.00 |
    And NGOC_ADMIN create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | [blank]          | currentDate     | [blank] | [blank]   | [blank] |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store    | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | ngoc st1 | [blank]       | create by buyer | [blank] |
    And See invoice then check promotion
      | promoDiscount |
      | - USD 10.00   |

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Search order by sku "32204" by api
    And Admin delete order of sku "32204" by api
    And Admin search promotion by skuName "AT Sku Buyin1"
    And Admin delete promotion by skuName "AT Sku Buyin1"

  @Promotion
  Scenario: Head buyer/Sub buyer PE and Head buyer PD checks out with on-going promotion
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Search order by sku "30125" by api
    And Admin delete order of sku "Autotest sku ongoing" by api

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName             | orderBrand | time    |
      | AutoTest Brand Ngoc01 | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type | pricePromoted | minimumPurchase | limitedTo        | start    | expired  |
      | TPR  | $90.00        | 1 Case          | 10000 cases only | 06/13/22 | 06/13/23 |
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Brand Ngoc01"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Product page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product On Going api", sku "Autotest sku ongoing" and add to cart with amount = "1"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Catalog page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product On Going api" and sku "Autotest sku ongoing" in product detail
      | unitPrice | casePrice | typePromo     | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00    | TPR Promotion | 10% off  | $90.00   | 10,000    | 10%                |
    When Go to favorite page of "Product On Going api"
    Then Verify promo preview "TPR" of product "Product On Going api" in "Favorite page"
      | name                 | type | price  | caseLimit |
      | Autotest sku ongoing | TPR  | $90.00 | 10,000    |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Verify price promo in order buyer is "-$10.00"
    And See invoice
    Then Verify price promo in Invoice is "- USD 10.00"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then NGOC_ADMIN verify price promo in order details of Admin is "$10.00"
    And Admin verify price promo in sku "Autotest sku ongoing" of order
      | endQuantity | total  |
      | $90.00      | $90.00 |
    And NGOC_ADMIN create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | currentDate      | Fulfilled       | [blank] | [blank]   | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And Vendor search order "Fulfilled"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And See detail order by idInvoice
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$10.00   | $90.00       |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store    | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | ngoc st1 | [blank]       | create by buyer | [blank] |
    And See invoice then check promotion
      | promoDiscount |
      | - USD 10.00   |

  @Promotion @Promotion03
  Scenario: Head buyer/Sub buyer PE and Head buyer PD checks out with shorted-date promotion
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Search order by sku "30126" by api
    And Admin delete order of sku "Autotest sku shortdate" by api

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    And Go to tab "Promotions"
    And Search promotions by info
      | brandName                | orderBrand | time    |
      | AutoTest Promo ShortDate | [blank]    | [blank] |
    And Show details of promotion then verify info
      | type        | pricePromoted | minimumPurchase | limitedTo        | start    | expired  |
      | Short dated | $90.00        | 1 Case          | 10000 cases only | 06/13/22 | 06/13/23 |
    And Clear cart to empty in cart before
    And Search Brands by name "AutoTest Promo ShortDate"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Product page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    And HEAD_BUYER_PE go to catalog "All"
    And Search product by name "Product Short Dated api", sku "Autotest sku shortdate" and add to cart with amount = "1"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Catalog page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    And Verify Promotional Discount in "before cart"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Verify Promotional Discount of "Product Short Dated api" and sku "Autotest sku shortdate" in product detail
      | unitPrice | casePrice | typePromo             | discount | newPrice | caseLimit | discountThumbnails |
      | $90.00    | $90.00    | Short-dated Promotion | 10% off  | $90.00   | 10,000    | 10%                |
    When Go to favorite page of "Product Short Dated api"
    Then Verify promo preview "Short dated" of product "Product Short Dated api" in "Favorite page"
      | name                   | type        | price  | caseLimit |
      | Autotest sku shortdate | SHORT-DATED | $90.00 | 10,000    |
    And Verify Promotional Discount in "details"
      | priceSKU | discount | totalSKU |
      | $90.00   | -$10.00  | $90.00   |
    And Buyer check out cart
    And Buyer place order cart "Pay by invoice"
    And Buyer view order after place order
    Then Verify price promo in order buyer is "-$10.00"
    And See invoice
    Then Verify price promo in Invoice is "- USD 10.00"

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    Then NGOC_ADMIN verify price promo in order details of Admin is "$10.00"
    And Admin verify price promo in sku "Product Short Dated api" of order
      | endQuantity | total  |
      | $90.00      | $90.00 |
    And NGOC_ADMIN create purchase order with info
      | driver              | fulfillmentState | fulfillmentDate | proof   | adminNote | lpNote  |
      | Auto Ngoc LP Mix 01 | Fulfilled        | currentDate     | [blank] | [blank]   | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And Vendor search order "Fulfilled"
      | region              | store    | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | ngoc st1 | Pending       | Express   | currentDate  |
    And See detail order by idInvoice
    Then Verify promotion in order of vendor
      | promotion | currentPrice |
      | -$10.00   | $90.00       |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP filter order by info
      | orderBy               | fulFillState | store    | fulFilledDate | order           | po      |
      | Ordered, Latest first | Fulfilled    | ngoc st1 | [blank]       | create by buyer | [blank] |
    And See invoice then check promotion
      | promoDiscount |
      | - USD 10.00   |

  @Promotion @Promotion04
  Scenario: Head buyer/Sub buyer PE and Head buyer PD checks out with Pod-sponsored promotion
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin

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
      | $100.00    | $0.00    | $1.00 | $30.00              | $20.00             | $25.00           | $151.00 |

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
      | $200.00    | $200.00  | $1.00 | Not applied         | $0.00              | $10.00           | $1.00 |

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
      | $100.00    | $100.00  | $0.00 | Not applied         | $0.00              | $25.00           | $0.00 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And See detail order by idInvoice
    Then Verify price of "Tax" not display in vendor

  @Delete_order
  Scenario: Admin/Buyer delete order then delete order
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Search order by sku "31495" by api
    And Admin delete order of sku "" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Order 01         | AT Product Order | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Order 01" from API
    And Admin delete all inventory by API

    When Search order by sku "31633" by api
    And Admin delete order of sku "" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]  | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Order 02         | AT Product Order | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Order 02" from API
    And Admin delete all inventory by API

    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku             | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Order 01 | 31495              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      | 2     | AT SKU Order 01 | 31633              | 15       | random   | 99           | currentDate  | [blank]     | [blank] |

    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoctx+storderchi01@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "AT Product Order", sku "AT SKU Order 01" and add to cart with amount = "3"
    And Search product by name "AT Product Order", sku "AT SKU Order 02" and add to cart with amount = "5"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $726.86 |
    And Go to Cart detail
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $726.86 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax     | total   |
      | [blank]            | [blank]           | [blank] | $726.86 |

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store          | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store          | payment | fullfillment | total   |
      | currentDate | [blank] | ngoctx stOrder | Pending | Pending      | $581.40 |
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer               | store          | email                           | orderValue | orderTotal | payment |
      | ngoctx stOrderCHI01 | ngoctx stOrder | ngoctx+storderchi01@podfoods.co | $816.00    | $581.40    | Pending |
    And Vendor Check items in order detail
      | brandName      | productName      | skuName         | casePrice | quantity | total   | podConsignment                    |
      | AT Brand Order | AT Product Order | AT SKU Order 01 | $102.00   | 3        | $275.40 | Pod Consignment auto-confirmation |
      | AT Brand Order | AT Product Order | AT SKU Order 02 | $102.00   | 5        | $510.00 | Pod Consignment auto-confirmation |

    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName         | productName      | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Order 01 | AT Product Order | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 01 | randomIndex | 10               | 10              | 7        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin search inventory
      | skuName         | productName      | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Order 02 | AT Product Order | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 02 | randomIndex | 15               | 15              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    # Delete line item
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin delete line item created by buyer
      | index | skuName         | type    | deduction |
      | 1     | AT SKU Order 01 | express | No        |
    # Check info sau khi delete line item
    And Verify general information of order detail
      | customerPo | date        | region              | buyer               | store          | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrderCHI01 | ngoctx stOrder | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $510.00    | $30.60   | $0.00 | Not applied         | $0.00              | $127.50          | $479.00 | $51.00          |
    And Admin go to Order summary from order detail
    And Admin check invoice detail in Order summary
      | brand          | product          | sku             | tmp | delivery                                         | quantity | endQuantity | warehouse                  | fulfillment |
      | AT Brand Order | AT Product Order | AT SKU Order 02 | Dry | Pod ConsignmentPod Consignment auto-confirmation | 5        | 10          | Auto Ngoc Distribution CHI | [blank]     |
    # Check inventory sau khi delete line item
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName         | productName      | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Order 01 | AT Product Order | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 01 | randomIndex | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Verify no inventory activities found
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName         | productName      | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Order 02 | AT Product Order | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 01 | randomIndex | 15               | 15              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Verify subtraction item on inventory
      | quantity | category | description        | date        | order   | comment  |
      | 1        | Donated  | Created by NgocTX. | currentDate | [blank] | Autotest |
    # Check vendor order sau khi delete line item
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region  | store          | paymentStatus | orderType | checkoutDate |
      | [blank] | ngoctx stOrder | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number  | store          | payment | fullfillment | total   |
      | currentDate | [blank] | ngoctx stOrder | Pending | Pending      | $382.50 |
    And Vendor Go to order detail with order number ""
    And Vendor check order detail info
      | region              | orderDate   | fulfillmentStatus | fulfillmentDate |
      | Chicagoland Express | currentDate | Pending           | currentDate     |
    And Vendor check general info
      | buyer               | store          | email                           | orderValue | orderTotal | payment |
      | ngoctx stOrderCHI01 | ngoctx stOrder | ngoctx+storderchi01@podfoods.co | $510.00    | $382.50    | Pending |
    And Vendor Check items in order detail
      | brandName      | productName      | skuName         | casePrice | quantity | total   | podConsignment                    |
      | AT Brand Order | AT Product Order | AT SKU Order 02 | $102.00   | 5        | $510.00 | Pod Consignment auto-confirmation |
     # Delete order
    And NGOC_ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin delete order by order number by info
      | orderNumber   | reason           | note    | passkey      |
      | create by api | Buyer adjustment | [blank] | pizza4cheese |
    And Admin search the orders ""
    And Admin no found order in result
    # Check delete orders
    And NGOC_ADMIN navigate to "Orders" to "Deleted orders" by sidebar
    And Admin search the orders ""
    Then Admin verify result order in all order
      | order  | checkout    | buyer               | store          | region | total   | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | random | currentDate | ngoctx stOrderCHI01 | ngoctx stOrder | CHI    | $510.00 | $127.50   | Pending      | Pending     | Pending       |
    When Admin go to detail after search
    And Admin verify general information of delete order detail
      | customerPo | date        | region              | buyer               | store          | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment | deletedBy     | deletedOn | deletedReason    |
      | Empty      | currentDate | Chicagoland Express | ngoctx stOrderCHI01 | ngoctx stOrder | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     | Admin: NgocTX | 08/01/22  | Buyer adjustment |
    And Admin verify price in delete order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   | specialDiscount |
      | $510.00    | $30.60   | $0.00 | Not applied         | $0.00              | $127.50          | $479.00 | $51.00          |
    And Admin check line items "sub invoice" in order details
      | brand          | product          | sku             | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Order | AT Product Order | AT SKU Order 02 | 1 units/case | $102.00   | 5        | [blank]     | $510.00 |
      | AT Brand Order | AT Product Order | AT SKU Order 01 | 1 units/case | $102.00   | 3        | [blank]     | $275.40 |
     # Check inventory sau khi delete order
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName         | productName      | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Order 01 | AT Product Order | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 01 | randomIndex | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Verify no inventory activities found
    And NGOC_ADMIN navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName         | productName      | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Order 02 | AT Product Order | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName      | skuName         | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | AT Product Order | AT SKU Order 01 | randomIndex | 15               | 15              | 15       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Verify subtraction item on inventory
      | quantity | category | description        | date        | order   | comment  |
      | 1        | Donated  | Created by NgocTX. | currentDate | [blank] | Autotest |

  @BuyerClaimFrom
  Scenario: Buyer/Head buyer submit a claim form
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Admin search claim by api
      | q[sub_invoice_number] | q[buyer_id] | q[store_id] | q[buyer_company_id] | q[status] |
      | [blank]               | 3334        | 3015        | 2452                | open      |
    And Admin delete claim "" by api
    When Search order by sku "33816" by api
    And Admin delete order of sku "" by api
    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+stclaimny01@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 7903      | 33816 | 1        |
    And Checkout cart with payment by "invoice" by API
    # Buyer create claim
    Given BUYER_PD open web user
    When login to beta web with email "ngoctx+stclaimny01@podfoods.co" pass "12345678a" role "buyer"
    And BUYER_PD Go to Dashboard
    And BUYER_PD Navigate to "Orders" by sidebar
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
    And Buyer check sku in affected products in claim form
      | sku             | quantity |
      | AT SKU Claim 01 | 1        |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."
    And Buyer submit another claim by button here
    Then Buyer verify info default of claim page
      | company        | email                          | invoice |
      | ngoctx stclaim | ngoctx+stclaimny01@podfoods.co | [blank] |
    # Admin verify claim
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to claims by sidebar
    And Admin search claims
      | subInvoice    | store   | buyer   | buyerCompany | managedBy | status  |
      | create by api | [blank] | [blank] | [blank]      | [blank]   | [blank] |
    And Admin verify claim result after search
      | store          | buyer              | order         | status | issue   |
      | ngoctx stclaim | ngoctx stclaimny01 | create by api | Open   | Damaged |
    And Admin go to detail of claim order "create by api" index 1
    Then Admin verify general information
      | store          | buyer              | buyerCompany     | orderID       | subInvoice    | issue   | issueDescription | dateOfSubmission | status |
      | ngoctx stclaim | ngoctx stclaimny01 | ngoc cpn b order | create by api | create by api | Damaged | Autotest         | currentDate      | Open   |
    Then Admin verify pictures
      | picture   |
      | claim.jpg |
    Then Admin verify affected products
      | brand             | product           | sku             | skuID | quantity |
      | AT BRAND CLAIM 01 | AT Brand Claim 01 | AT SKU Claim 01 | 33816 | 1        |

  @GuestClaimFrom
  Scenario: Guest submit a claim form
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Admin search claim by api
      | q[sub_invoice_number] | q[buyer_id] | q[store_id] | q[buyer_company_id] | q[status] |
      | 1234567890            | 3334        | 3015        | 2452                | open      |
    And Admin delete claim "" by api
    # Guest create claim
    Given GUEST open web guest claim
    When Guest verify info default of claim page
    And Guest fill info to claim of invoice
      | company | email                    | invoice  | issues   | affectedProduct | description |
      | guest   | companyGuest@podfoods.co | 12345790 | Shortage | abc             | [blank]     |
    And Buyer finish form claim with message "Thanks for submitting the form. Our Claims team is reviewing it and they will be in touch within 48 hours."
    And Buyer submit another claim by button here
    When Guest verify info default of claim page
    # Admin verify record claim of guest
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Claims" to "Buyer Claims" by sidebar
    And Admin search claims
      | subInvoice | store   | buyer   | buyerCompany | managedBy | status  |
      | 1234567890 | [blank] | [blank] | [blank]      | [blank]   | [blank] |
    And Admin verify first result after search
      | date    | store   | buyer   | order   | status | issue    |
      | [blank] | [blank] | [blank] | [blank] | Open   | Shortage |
    And Admin go to detail of claim order first result
    Then Admin verify general information of guest claim
      | store | buyer                    | buyerCompany | orderID | subInvoice | issue    | issueDescription | dateOfSubmission | status |
      | Empty | companyGuest@podfoods.co | [blank]      | [blank] | 1234567890 | Shortage | Empty            | currentDate      | Open   |

  @GhostOrder
  Scenario: Admin create new ghost order > Convert order
    Given NGOCTX login web admin by api
      | email              | password  |
      | ngoctx@podfoods.co | 12345678a |
    When Search order by sku "34107" by api
    And Admin delete order of sku "34107" by api
    # Create ghost order
    Given NGOC_ADMIN open web admin
    When NGOC_ADMIN login to web with role Admin
    And NGOC_ADMIN navigate to "Orders" to "Ghost orders" by sidebar
    And Admin create new ghost order
      | buyer                        | paymentType    | street              | city     | state    | zip   |
      | ngoctx stborderdetail56chi01 | Pay by invoice | 280 Columbus Avenue | New York | New York | 10023 |
    And Admin add line item "AT SKU Ghost MOV 01" and quantities "1"
    And Admin verify MOV require of line items in create new ghost orders
      | companyName             | totalPayment | movPrice      | message                                                                                                                                               |
      | AUTO VENDOR COMPANY MOV | $100.00      | $1,000.00 MOV | Please add more case(s) to any SKU below to meet the minimum order value required. This vendor may not fulfill if this minimum is not met. Thank you! |
    And Admin verify line items in create new ghost orders
      | brand                 | product                 | sku                 | skuID | unitUPC      | unitCase     | status   | region | price   | quantity |
      | AT BRAND GHOST MOV 01 | AT Product Ghost MOV 01 | AT SKU Ghost MOV 01 | 34104 | 123124123123 | 1 units/case | In stock | PDE    | $100.00 | 1        |
    And Admin add line item "AT SKU Ghost MOV 02" and quantities "9"
    And Admin verify line items in create new ghost orders
      | brand                 | product                 | sku                 | skuID | unitUPC      | unitCase     | status         | region | price   | quantity |
      | AT BRAND GHOST MOV 01 | AT Product Ghost MOV 01 | AT SKU Ghost MOV 02 | 34105 | 123124123123 | 1 units/case | Launching soon | PDE    | $900.00 | 9        |
    And Admin add line item "Autotest SKU1 Ngoc02" and quantities "1"
    And Admin verify line items in create new ghost orders
      | brand                 | product                 | sku                  | skuID | unitUPC      | unitCase     | status   | region | price   | quantity |
      | AUTOTEST BRAND NGOC01 | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | 29918 | 111123123012 | 1 units/case | In stock | NY     | $200.00 | 1        |
    And Admin add line item "AT SKU Ghost 02" and quantities "1"
    And Admin verify MOQ require of line items in create new ghost orders
      | itemMOQ        | message                                                                           |
      | ITEMS WITH MOQ | The line-item(s) highlighted below doesn't meet the minimum order quantity (MOQ). |
    And Admin verify line items in create new ghost orders
      | brand                   | product             | sku             | skuID | unitUPC      | unitCase     | status   | region | price   | quantity |
      | AT BRAND GHOST ORDER 01 | AT Product Ghost 01 | AT SKU Ghost 02 | 34107 | 112312123131 | 1 units/case | In stock | NY     | $100.00 | 1        |
    Then Verify price "total" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 12        | $1,300.00       | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    Then Verify price "in stock" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 3         | $400.00         | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    Then Verify price "OOS or LS" in create new order
      | totalCase | totalOrderValue | discount | taxes   | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 9         | $900.00         | [blank]  | [blank] | [blank]             | [blank]            | [blank]         | [blank]      |
    And Admin create order success
    Then Admin verify general information of ghost order detail
      | customerPo | date        | region           | buyer                        | store                   | orderValue | creator | managed | launched | address                                        | adminNote |
      | [blank]    | currentDate | New York Express | ngoctx stborderdetail56chi01 | ngoctx stborderdetail56 | $1,300.00  | NgocTX  | N/A     | N/A      | 280 Columbus Avenue, New York, New York, 10023 | [blank]   |
#    Then Admin verify MOQ require of line items in convert ghost orders
#      | message                                                                           |
#      | The line-item(s) highlighted below doesn't meet the minimum order quantity (MOQ). |
    Then Admin verify line items in ghost order detail
      | brand                   | product                 | sku                  | skuID | unitCase     | tagPD   | tagPE   | price   | quantity | endQuantity | total   |
      | AT Brand Ghost MOV 01   | AT Product Ghost MOV 01 | AT SKU Ghost MOV 01  | 34104 | 1 units/case | Yes     | [blank] | $100.00 | 1        | 0           | $100.00 |
      | AutoTest Brand Ngoc01   | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | 29918 | 1 units/case | [blank] | Yes     | $200.00 | 1        | 0           | $200.00 |
      | AT Brand Ghost Order 01 | AT Product Ghost 01     | AT SKU Ghost 02      | 34107 | 1 units/case | [blank] | Yes     | $100.00 | 1        | 0           | $100.00 |
      | AT Brand Ghost MOV 01   | AT Product Ghost MOV 01 | AT SKU Ghost MOV 02  | 34105 | 1 units/case | Yes     | [blank] | $100.00 | 9        | 0           | $900.00 |
    # Convert ghost order to real order
    And NGOC_ADMIN convert ghost order to real order
    # Verify info in convert ghost order
    And Admin verify line item in convert ghost order
      | skuID | brand                   | product                 | sku                  | price   | units        | quantity | endQuantity | total   |
      | 29918 | AutoTest Brand Ngoc01   | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | $200.00 | 1 units/case | 1        | 0           | $200.00 |
      | 34107 | AT Brand Ghost Order 01 | AT Product Ghost 01     | AT SKU Ghost 02      | $100.00 | 1 units/case | 1        | 0           | $100.00 |
      | 34107 | AT Brand Ghost MOV 01   | AT Product Ghost MOV 01 | AT SKU Ghost MOV 01  | $100.00 | 1 units/case | 1        | 0           | $100.00 |
      | 34105 | AT Brand Ghost MOV 01   | AT Product Ghost MOV 01 | AT SKU Ghost MOV 02  | $100.00 | 1 units/case | 9        | 0           | $900.00 |
    And Admin verify summary "total" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 12        | $1,300.00       | $0.00    | $0.00 | $30.00              | $20.00             | $0.00           | $1,350.00    |
    And Admin verify summary "in stock" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 3         | $400.00         | $0.00    | $0.00 | $30.00              | $20.00             | $0.00           | $450.00      |
    And Admin verify summary "OOS or LS" in convert ghost order
      | totalCase | totalOrderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | specialDiscount | totalPayment |
      | 9         | $900.00         | $0.00    | $0.00 | $0.00               | $0.00              | $0.00           | $900.00      |
     # Confirm convert ghost order to real order
    And Admin confirm convert ghost order to real order
    # Verify general information of real order
    And Verify general information of order detail
      | customerPo | date        | region           | buyer                        | store                   | customStore | creator  | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | New York Express | ngoctx stborderdetail56chi01 | ngoctx stborderdetail56 | [blank]     | ngoctx01 | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $400.00    | $0.00    | $0.00 | $30.00              | $20.00             | $86.00           | $450.00 |
    And Admin check line items "sub invoice" in order details
      | brand                   | product                 | sku                  | unitCase     | casePrice | quantity | endQuantity | total   | skuID |
      | AutoTest Brand Ngoc01   | Autotest product ngoc01 | Autotest SKU1 Ngoc02 | 1 units/case | $200.00   | 1        | 0           | $200.00 | 29918 |
      | AT Brand Ghost Order 01 | AT Product Ghost 01     | AT SKU Ghost 02      | 1 units/case | $200.00   | 1        | 0           | $100.00 | 34107 |
    And Admin check line items "non invoice" in order details
      | brand                 | product                 | sku                 | unitCase     | casePrice | quantity | endQuantity | total   | skuID |
      | AT Brand Ghost MOV 01 | AT Product Ghost MOV 01 | AT SKU Ghost MOV 01 | 1 units/case | $100.00   | 1        | 0           | $100.00 | 34104 |
    And Admin check line items "deleted or shorted items" in order details
      | brand                 | product                 | sku                 | unitCase     | casePrice | quantity | endQuantity | total   | skuID |
      | AT Brand Ghost MOV 01 | AT Product Ghost MOV 01 | AT SKU Ghost MOV 02 | 1 units/case | $100.00   | 9        | [blank]     | $900.00 | 34105 |
    # Verify ghost order no exist on buyer

#    Given BUYER open web user
#    When login to beta web with email "ngoctx+stbuyerorder11chi01@podfoods.co " pass "12345678a" role "buyer"
#    And BUYER Go to Dashboard
#    And BUYER Navigate to "Orders" by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]  |
#    Then Buyer verify no found order "create by admin" in tab result
#    And Buyer navigate to "Your Store" in order by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]  |
#    Then Buyer verify no found order "create by admin" in tab result
#    # Verify ghost order no exist on head buyer
#    Given HEAD_BUYER open web user
#    When login to beta web with email "ngoctx+stbuyerorder11hchi01@podfoods.co" pass "12345678a" role "buyer"
#    And HEAD_BUYER Go to Dashboard
#    And HEAD_BUYER Navigate to "Orders" by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]  |
#    Then Buyer verify no found order "create by admin" in tab result
#    # Convert ghost order to real order
#    And NGOC_ADMIN_06 convert ghost order to real order
#    And Admin confirm convert ghost order to real order
#    # Verify ghost order on buyer
#    And BUYER refresh page
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]  |
#    And Buyer verify order in result
#      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
#      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $150.00 |
#    And Buyer navigate to "Your Store" in order by sidebar
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]  |
#    And Buyer verify order in result
#      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
#      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $150.00 |
#    And BUYER log out
#    # Verify ghost order on head buyer
#    And HEAD_BUYER refresh page
#    And Search Order in tab "All" with
#      | brand                   | checkoutAfter | checkoutBefore |
#      | AT Brand Buyer Order 01 | currentDate   | [blank]  |
#    And Buyer verify order in result
#      | ordered     | number          | store                 | creator         | payment | fulfillment | total   |
#      | currentDate | create by admin | ngoctx stBuyerOrder11 | Pod Foods Admin | Pending | Pending     | $150.00 |
#    And HEAD_BUYER log out
#
  @Session_Not_Login
  Scenario: Verify if clear cookie and session before login web beta
    Given BUYER open web user
    And BUYER delete all cookies and session
    And BUYER refresh page
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"

  @Session_Login
  Scenario: Verify if clear cookie and session before login web beta
    Given BUYER open web user
    When login to beta web with email "ngoc+chi1@podfoods.co" pass "12345678a" role "buyer"
    Given BUYER delete all cookies and session
    And BUYER refresh page
    When BUYER verify login button
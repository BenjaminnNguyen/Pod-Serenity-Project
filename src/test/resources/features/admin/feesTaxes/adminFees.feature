@feature=AdminFeesTaxes
Feature: Admin Fees Taxes

  @AD_FEES_TAXES_1 @AD_FEES_TAXES_11
  Scenario: Create new Fee form
    Given BAO_ADMIN12 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin search fees by api
      | Auto Admin create fees 1 |
    And Admin delete fee by api

    Given BAO_ADMIN12 open web admin
    When BAO_ADMIN12 login to web with role Admin
    And BAO_ADMIN12 navigate to "Fees & Taxes" to "State fees" by sidebar
    And Click on button "Create"
    And Click on dialog button "Create"
    And BAO_ADMIN8 check error message is showing of fields on dialog
      | field                      | message                            |
      | Name                       | Please input Fee name              |
      | State (Province/Territory) | Please select a state for this Fee |
    And Admin create state fees with info
      | name | description | state   | freeFill |
      | Auto | [blank]     | [blank] | [blank]  |

    And Click on dialog button "Create"
    And BAO_ADMIN12 check error message not showing of fields on dialog
      | field | message               |
      | Name  | Please input Fee name |
    And BAO_ADMIN8 check error message is showing of fields on dialog
      | field                      | message                            |
      | State (Province/Territory) | Please select a state for this Fee |
    And Admin create state fees with info
      | name                     | description      | state    | freeFill |
      | Auto Admin create fees 1 | Auto description | Colorado | yes      |
    And Click on dialog button "Create"
    And Admin check alert message
      | Master data updated |
    And Admin check fees list
      | id      | name                     | description      |
      | [blank] | Auto Admin create fees 1 | Auto description |
    And Click on button "Create"
    And Admin create state fees with info
      | name                     | description      | state    | freeFill |
      | Auto Admin create fees 1 | Auto description | Colorado | yes      |
    And Click on dialog button "Create"
    And BAO_ADMIN12 check alert message
      | Name has already been taken |
#    Delete fee
    And Admin search fees by api
      | Auto Admin create fees 1 |
    And Admin delete fee by api

  @AD_FEES_TAXES_8
  Scenario: Check when taxes are applied for a real order
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
      | smallOrderSurchage | logisticsSurchage | tax   | total |
      | [blank]            | [blank]           | $1.00 | $1.00 |
    And Check out cart "Pay by invoice" and "don't see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax   | total |
      | [blank]            | [blank]           | $1.00 | $1.00 |

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

  @AD_FEES_TAXES_9
  Scenario: Head buyer (PE) checks out with Taxes uncheck
    Given HEAD_BUYER_PE open web user
    When login to beta web with email "ngoc+tax1@podfoods.co" pass "12345678a" role "buyer"
    And Clear cart to empty in cart before
    And Search product by name "Auto Product Tax", sku "Auto sku tax" and add to cart with amount = "1"
    Then Verify price in cart "before checkout"
      | smallOrderSurchage | logisticsSurchage | tax   | total  |
      | 30.00              | [blank]           | $1.00 | 131.00 |
    And Go to Cart detail
    And Buyer close recommended items modal
    Then Verify price in cart "details"
      | smallOrderSurchage | logisticsSurchage | tax  | total  |
      | 30.00              | [blank]           | 1.00 | 131.00 |
    And Check out cart "Pay by invoice" and "see" Invoice
      | smallOrderSurchage | logisticsSurchage | tax  | total  |
      | 30.00              | [blank]           | 1.00 | 131.00 |
    Then Verify price in cart Invoice
      | smallOrderSurchage | logisticsSurchage | botteDeposit | total  |
      | 30.00              | [blank]           | 1.00         | 131.00 |

    Given ADMIN open web admin
    When ADMIN login to web with role Admin
    And ADMIN navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer    | store       | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | [blank]    | currentDate | Chicagoland Express | ngoc tax | ngoc st tax | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total   |
      | $100.00    | $0.00    | $1.00 | $30.00              | [blank]            | [blank]          | $131.00 |

    Given HEAD_VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And See detail order by idInvoice
    Then Verify price of "Tax" not display in vendor

  @AD_FEES_TAXES_16
  Scenario: Edit a state fee form
    Given BAO_ADMIN12 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin search fees by api
      | Auto Admin create fees 2 |
    And Admin delete fee by api

    Given BAO_ADMIN12 open web admin
    When BAO_ADMIN12 login to web with role Admin
    And BAO_ADMIN12 navigate to "Fees & Taxes" to "State fees" by sidebar
    And Click on button "Create"
    And Admin create state fees with info
      | name                     | description      | state    | freeFill |
      | Auto Admin create fees 2 | Auto description | Illinois | yes      |
    And Click on dialog button "Create"
    And Admin check alert message
      | Master data updated |
    And Admin check fees list
      | id      | name                     | description      |
      | [blank] | Auto Admin create fees 2 | Auto description |
    And Admin open detail state fee
      | name                     | description      | state    | freeFill |
      | Auto Admin create fees 2 | Auto description | Illinois | yes      |
    And Admin create state fees with info
      | name                          | description           | state   | freeFill |
      | Auto Admin create fees 2 edit | Auto description edit | Alabama | no       |
    And Click on dialog button "Update"
    And Admin check alert message
      | Master data updated |
    And Admin check fees list
      | id      | name                          | description           |
      | [blank] | Auto Admin create fees 2 edit | Auto description edit |
    And Admin open detail state fee
      | name                          | description           | state   | freeFill |
      | Auto Admin create fees 2 edit | Auto description edit | Alabama | no       |
    And Admin Clear field "Name"
    And Click on dialog button "Update"
    And BAO_ADMIN8 check error message is showing of fields on dialog
      | field | message               |
      | Name  | Please input Fee name |
    And Admin close popup edit adjustment
    And Admin check fees list
      | id      | name                          | description           |
      | [blank] | Auto Admin create fees 2 edit | Auto description edit |
    And Admin open detail state fee
      | name                          | description           | state   | freeFill |
      | Auto Admin create fees 2 edit | Auto description edit | Alabama | no       |
    And Admin create state fees with info
      | name                     | description      | state    | freeFill |
      | Auto Admin create fees 2 | Auto description | Illinois | yes      |
    And Click on dialog button "Update"
    And Admin check alert message
      | Master data updated |
    And Admin search fees by api
      | Auto Admin create fees 2 |
    And Admin delete fee by api

  @AD_FEES_TAXES_23
  Scenario: Small order surcharge list
    Given BAO_ADMIN12 login web admin by api
      | email             | password  |
      | bao12@podfoods.co | 12345678a |
    And Admin update small order surcharge by api
      | amount_cents | flat_fee_cents | name    |
      | 50000        | 3000           | [blank] |
    Given BAO_ADMIN12 open web admin
    When BAO_ADMIN12 login to web with role Admin
    And BAO_ADMIN12 navigate to "Fees & Taxes" to "Small order surcharge" by sidebar
    And Admin check Small order surcharge list
      | charge | forOrder |
      | $30.00 | $500.00  |
    And Admin open detail Small order surcharge
      | charge | forOrder |
      | 30     | 500      |
    And Admin Clear field "Charge"
    And Click on dialog button "Update"
    And Admin check alert message
      | Flat fee cents must be greater than or equal to 1 |
    And Admin Clear field "For order less than"
    And Click on dialog button "Update"
    And Admin check alert message
      | Amount cents must be greater than or equal to 1 |
    And Admin edit Small order surcharge
      | charge | forOrder |
      | 0      | 10       |
    And Admin check alert message
      | Flat fee cents must be greater than or equal to 1 |
    And Admin edit Small order surcharge
      | charge | forOrder |
      | 10     | 0        |
    And Admin check alert message
      | Amount cents must be greater than or equal to 1 |
    And Admin edit Small order surcharge
      | charge | forOrder |
      | 30     | 500      |
    And Admin check alert message
      | Master data updated |
    And BAO_ADMIN12 navigate to "Stores" to "All stores" by sidebar
    And Admin go to create store
    And BAO_ADMIN12 check value of field
      | field                           | value |
      | Small order surcharge threshold | 500   |
      | Small order surcharge amount    | 30    |

  @AD_FEES_TAXES_37
  Scenario: Create new Miscellaneous Fees form
    Given BAO_ADMIN12 open web admin
    When BAO_ADMIN12 login to web with role Admin
    And BAO_ADMIN12 navigate to "Fees & Taxes" to "Miscellaneous Fees" by sidebar
    And Click on button "Create"
    And Admin create Miscellaneous fees with info
      | feeType      | serviceYear | serviceMonth | type          | vendorCompany           | amount | region              | note      | file      |
      | Disposal fee | 2023        | Oct          | Vendor Charge | Auto vendor company mov | 1      | Chicagoland Express | Auto note | test.docx |
    And Admin check alert message
      | Master data updated |
    And Admin check Miscellaneous fees list
      | date        | feeType      | serviceTime | type          | vendorCompany           | amount | region | admin             |
      | currentDate | Disposal fee | 10/2023     | Vendor Charge | Auto vendor company mov | $1.00  | CHI    | bao12@podfoods.co |
    And Admin search Miscellaneous fees
      | year | month | type          | vendorCompany           | region              | coveredBy | lpCompany |
      | 2023 | Oct   | Vendor Charge | Auto vendor company mov | Chicagoland Express | [blank]   | [blank]   |
    And Admin check Miscellaneous fees list
      | date        | feeType      | serviceTime | type          | vendorCompany           | amount | region | admin             |
      | currentDate | Disposal fee | 10/2023     | Vendor Charge | Auto vendor company mov | $1.00  | CHI    | bao12@podfoods.co |
    And Admin "Understand & Continue" delete first record Miscellaneous fee
    And Admin check alert message
      | Master data updated |

  @AD_FEES_TAXES_38
  Scenario: Create new Miscellaneous Fees form - validate
    Given BAO_ADMIN12 open web admin
    When BAO_ADMIN12 login to web with role Admin
    And BAO_ADMIN12 navigate to "Fees & Taxes" to "Miscellaneous Fees" by sidebar
    And Click on button "Create"
    And Admin create Miscellaneous fees with info
      | feeType | serviceYear | serviceMonth | type    | vendorCompany | amount  | region  | note    | file    |
      | [blank] | [blank]     | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] |
#      | Disposal fee | 2023        | Oct          | Vendor Charge | Auto vendor company mov | 1      | Chicagoland Express | Auto note | test.docx |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field                      | message                                         |
      | Fee type                   | Please select a fee type                        |
      | Type                       | Please select a type                            |
      | Vendor company             | Please select a vendor company                  |
      | Amount to charge or payout | Please enter a valid amount to charge or payout |
      | Express region             | Please select a Express region                  |
    And Admin create Miscellaneous fees with info
      | feeType | feeTypeText | serviceYear | serviceMonth | type    | vendorCompany | amount  | region  | note    | file    |
      | Other   | [blank]     | [blank]     | [blank]      | [blank] | [blank]       | [blank] | [blank] | [blank] | [blank] |
#      | Disposal fee | 2023        | Oct          | Vendor Charge | Auto vendor company mov | 1      | Chicagoland Express | Auto note | test.docx |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field                      | message                                         |
      | Fee type text              | Please select a fee type text                   |
      | Type                       | Please select a type                            |
      | Vendor company             | Please select a vendor company                  |
      | Amount to charge or payout | Please enter a valid amount to charge or payout |
      | Express region             | Please select a Express region                  |
    And Admin create Miscellaneous fees with info
      | feeType | feeTypeText | serviceYear | serviceMonth | type          | coveredBy | vendorCompany | amount  | region  | note    | file    |
      | Other   | other       | [blank]     | [blank]      | Vendor Payout | [blank]   | [blank]       | [blank] | [blank] | [blank] | [blank] |
    And BAO_ADMIN12 check error message not showing of fields on dialog
      | field         | message                       |
      | Fee type      | Please select a fee type      |
      | Fee type text | Please select a fee type text |
      | Type          | Please select a type          |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field                      | message                                         |
      | Covered by                 | Please select covered by Pod Foods or LP        |
      | Vendor company             | Please select a vendor company                  |
      | Amount to charge or payout | Please enter a valid amount to charge or payout |
      | Express region             | Please select a Express region                  |
    And Admin create Miscellaneous fees with info
      | feeType | feeTypeText | serviceYear | serviceMonth | type    | coveredBy | lpCompany | vendorCompany | amount  | region  | note    | file    |
      | [blank] | [blank]     | [blank]     | [blank]      | [blank] | LP        | [blank]   | [blank]       | [blank] | [blank] | [blank] | [blank] |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field                      | message                                         |
      | LP company                 | Please select a logistic partner                |
      | Vendor company             | Please select a vendor company                  |
      | Amount to charge or payout | Please enter a valid amount to charge or payout |
      | Express region             | Please select a Express region                  |
    And Admin create Miscellaneous fees with info
      | feeType | feeTypeText | serviceYear | serviceMonth | type    | coveredBy | lpCompany          | vendorCompany           | amount | region              | note    | file    |
      | [blank] | [blank]     | [blank]     | [blank]      | [blank] | [blank]   | Auto Bao LP Driver | Auto vendor company mov | -1     | Chicagoland Express | [blank] | [blank] |
    And BAO_ADMIN12 check error message is showing of fields on dialog
      | field                      | message                                         |
      | Amount to charge or payout | Please enter a valid amount to charge or payout |
    And Admin create Miscellaneous fees with info
      | feeType | feeTypeText | serviceYear | serviceMonth | type    | coveredBy | lpCompany | vendorCompany | amount | region  | note    | file    |
      | [blank] | [blank]     | [blank]     | [blank]      | [blank] | [blank]   | [blank]   | [blank]       | 0.1    | [blank] | [blank] | [blank] |
    And Admin check alert message
      | Master data updated |
    And Admin check Miscellaneous fees list
      | date        | feeType | serviceTime | type          | vendorCompany           | amount | region | admin             |
      | currentDate | Other   | currentDate | Vendor Payout | Auto vendor company mov | $0.10  | CHI    | bao12@podfoods.co |
    And Admin search Miscellaneous fees
      | year        | month       | type          | vendorCompany           | region              | coveredBy | lpCompany          |
      | currentDate | currentDate | Vendor Payout | Auto vendor company mov | Chicagoland Express | LP        | Auto Bao LP Driver |
    And Admin check Miscellaneous fees list
      | date        | feeType | serviceTime | type          | vendorCompany           | amount | region | admin             |
      | currentDate | Other   | currentDate | Vendor Payout | Auto vendor company mov | $0.10  | CHI    | bao12@podfoods.co |
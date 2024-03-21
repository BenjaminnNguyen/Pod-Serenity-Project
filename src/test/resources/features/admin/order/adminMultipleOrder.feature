@feature=adminMultipleOrder
Feature: Admin Multiple Order

  @AD_CREATE_MULTIPLE_ORDERS_1 @AD_CREATE_MULTIPLE_ORDERS_13 @AD_CREATE_MULTIPLE_ORDERS_3 @AD_CREATE_MULTIPLE_ORDERS_4
  Scenario: Check information shown in the Upload your CSV file popup
    Given BAO_AUTO18 open web admin
    When login to beta web with email "bao18@podfoods.co" pass "12345678a" role "Admin"
    And BAO_AUTO18 navigate to "Orders" to "Create multiple orders" by sidebar
    And Admin go to create new multiple order
    And Admin edit instruction create multiple order
      | random |
    And Admin check instruction create multiple order
      | content | history                        | date        |
      | random  | ( Last edit by Admin: bao18 on | currentDate |
    And Admin create multiple order with upload CSV file "empty_file.csv"
    And Admin verify no order uploaded in multi order
    And Check any text "is" showing on screen
      | The payment options will be set as pay by invoice                                                                           |
      | The default store addresses will be used                                                                                    |
      | Make sure you enter the same customer PO # by order by buyer. Different customer PO #s will be treated as different orders. |
    And Admin go back with button
    And Admin verify list multiple order
      | id      | name           | creator | date        | status |
      | [blank] | empty_file.csv | bao18   | currentDate | 0 / 0  |
    And Admin search multiple order
      | creator |
      | bao25   |
    And Admin check no data found
    And Admin reset filter
    And Admin search multiple order
      | creator |
      | bao18   |
    And Admin verify list multiple order
      | id      | name           | creator | date        | status |
      | [blank] | empty_file.csv | bao18   | currentDate | 0 / 0  |
    And Admin reset filter
    Then Admin verify pagination function
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_require_filed.csv"
    And Admin verify no order uploaded in multi order
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                                        | creator | date        | status |
      | [blank] | incorrect_format_file_not_require_filed.csv | bao18   | currentDate | 0 / 0  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_item.csv"
    And Admin verify line item in multiple order detail
      | product | sku     | skuID   | state | upc     | status  | price | quantity | error                                                 |
      | [blank] | [blank] | [blank] | 0 / 1 | [blank] | Pending | $0.00 | 1        | This item isn't available to the selected buyer/store |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin check line items not available in multiple order detail
      | sku     |
      | [blank] |
    And Admin go back with button
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_buyer.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | [blank] | 250419980001 | Pending | $0.00 | 1        | Buyer must be filled\nThis item isn't available to the selected buyer/store |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store   | customPO | lineItems | status | quantity |
      | [blank] | [blank] | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin check line items not available in multiple order detail
      | sku                      |
      | AT SKU Multiple Order 01 |
    And Admin go back with button
    And Admin verify list multiple order
      | id      | name                                | creator | date        | status |
      | [blank] | incorrect_format_file_not_buyer.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_price.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                                | creator | date        | status |
      | [blank] | incorrect_format_file_not_price.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_quantity.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price | quantity | error                                                               |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $0.00 | 0        | Quantity must be filled\nThis item's quantity doesn't meet the MOQs |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 0        |
    And Admin check line items not available in multiple order detail
      | sku                      |
      | AT SKU Multiple Order 01 |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                                   | creator | date        | status |
      | [blank] | incorrect_format_file_not_quantity.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_UPC.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                              | creator | date        | status |
      | [blank] | incorrect_format_file_not_UPC.csv | bao18   | currentDate | 0 / 1  |

    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_PO.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | [blank]  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                             | creator | date        | status |
      | [blank] | incorrect_format_file_not_PO.csv | bao18   | currentDate | 0 / 1  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_format_file_not_item_code.csv"
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | [blank]  | 1         | 0 / 1  | 1        |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                                    | creator | date        | status |
      | [blank] | incorrect_format_file_not_item_code.csv | bao18   | currentDate | 0 / 1  |
    And Admin delete multi order record "incorrect_format_file_not_item_code.csv"
    And Admin delete multi order record "incorrect_format_file_not_PO.csv"
    And Admin delete multi order record "incorrect_format_file_not_UPC.csv"
    And Admin delete multi order record "incorrect_format_file_not_quantity.csv"
    And Admin delete multi order record "incorrect_format_file_not_price.csv"
    And Admin delete multi order record "incorrect_format_file_not_buyer.csv"
    And Admin delete multi order record "incorrect_format_file_not_item.csv"

  @AD_CREATE_MULTIPLE_ORDERS_26
  Scenario: Check validation of the fields after upload CSV file template
    Given BAO_AUTO18 open web admin
    When login to beta web with email "bao18@podfoods.co" pass "12345678a" role "Admin"
    And BAO_AUTO18 navigate to "Orders" to "Create multiple orders" by sidebar
#    And Admin go to create new multiple order
#    And Admin create multiple order with upload CSV file "incorrect_data_file_buyer.csv"
#    And Admin verify info of order number 1 in multiple order detail
#      | number  | store   | customPO         | lineItems | status | quantity |
#      | [blank] | [blank] | Auto Customer PO | 1         | 0 / 1  | 1        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                       |
#      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | [blank] | 250419980001 | Pending | $0.00 | 1        | Buyer must be filled\nThis item isn't available to the selected buyer/store |
#    And Admin verify info of order number 2 in multiple order detail
#      | number  | store   | customPO         | lineItems | status | quantity |
#      | [blank] | [blank] | Auto Customer PO | 1         | 0 / 1  | 2        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                                               |
#      | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | [blank] | 250419980002 | Pending | $0.00 | 2        | Buyer must be an integer\nThis item isn't available to the selected buyer/store\nBuyer is not found |
#    And Admin verify info of order number 3 in multiple order detail
#      | number  | store   | customPO         | lineItems | status | quantity |
#      | [blank] | [blank] | Auto Customer PO | 1         | 0 / 1  | 3        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state   | upc          | status  | price | quantity | error                                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 03 | 44182 | [blank] | 250419980003 | Pending | $0.00 | 3        | This item isn't available to the selected buyer/store\nBuyer is not found |
#    And Admin verify info of order number 4 in multiple order detail
#      | number  | store    | customPO         | lineItems | status | quantity |
#      | [blank] | ngoc st1 | Auto Customer PO | 1         | 0 / 1  | 4        |
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
#      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | In stock | 250419980004 | Pending | $40.00 | 4        | [blank] |
#    And Admin go back with button
#    And Admin reset filter
#    And Admin verify list multiple order
#      | id      | name                          | creator | date        | status |
#      | [blank] | incorrect_data_file_buyer.csv | bao18   | currentDate | 0 / 4  |
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "incorrect_data_item_code_file.csv"
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 6         | 0 / 6  | 6        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 26 | 65652 | Out of stock | 250419980026 | Pending | $20.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 25 | 65651 | Out of stock | 250419980025 | Pending | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 24 | 65650 | Out of stock | 250419980024 | Pending | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 22 | 65648 | [blank]      | 250419980022 | Pending | $0.00  | 1        | This item isn't available to the selected buyer/store       |
      | Auto Product Multiple Order | AT SKU Multiple Order 23 | 65649 | [blank]      | 250419980023 | Pending | $0.00  | 1        | This item isn't available to the selected buyer/store       |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock     | 250419980001 | Pending | $10.00 | 1        | [blank]                                                     |
    And Admin verify info of order number 2 in multiple order detail
      | number  | store               | customPO | lineItems | status | quantity |
      | [blank] | Auto Store Chicago1 | Auto PO  | 1         | 0 / 1  | 1        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price  | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock | 250419980001 | Pending | $10.00 | 1        | [blank] |
    And Admin choose line item to convert to order in multi
      | sku                      | quantity |
      | AT SKU Multiple Order 01 | 1        |
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Click on button "Create order"
    And Admin check alert message
      | Line items The itemcode #44180 is not available to this sub-buyer. Please visit here (https://adminbeta.podfoods.co/buyers/3365?head_buyer=false) and update his/her allowlist |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                          | creator | date        | status |
      | [blank] | incorrect_data_file_buyer.csv | bao18   | currentDate | 0 / 4  |
#    And Admin create multiple order with upload CSV file "empty_file.csv"
#    And Admin delete multi order record "empty_file.csv"
#    And Admin upload CSV file "multiple_order_file.csv" to create multiple order
#    And Admin verify order uploaded of file "multiple_order_file.csv" in multi order
#      | store    | customerPO | lineItem | status | quantity |
#      | ngoc st1 | Auto PO    | 21       | 0 / 21 | 21       |
#    And Admin go to detail of multiple order
#    And Admin verify line item in multiple order detail
#      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                       |
#      | Auto Product Multiple Order | AT SKU Multiple Order 21 | 44200 | In stock     | 250419980021 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 20 | 44199 | In stock     | 250419980020 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 19 | 44198 | In stock     | 250419980019 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 18 | 44197 | In stock     | 250419980018 | Pending | $10.00 | 1        | [blank]                                                     |
#      | Auto Product Multiple Order | AT SKU Multiple Order 17 | 44196 | In stock     | 250419980017 | Pending | $10.00 | 1        | [blank]                                                     |
#   And Admin verify "total" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
#    And Admin verify "in stock" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
#    And Admin verify "OOS or LS" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
#    And Admin choose line item to convert to order in multi
#      | sku                      | quantity |
#      | AT SKU Multiple Order 20 | 1        |
#      | AT SKU Multiple Order 19 | 1        |
#      | AT SKU Multiple Order 18 | 1        |
#      | AT SKU Multiple Order 17 | 1        |
#      | AT SKU Multiple Order 16 | 1        |
#
#    And Admin verify "total" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 20        | $200.00         | $0.00    | $0.00 | $0.00           | $200.00      |
#    And Admin verify "in stock" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 19        | $190.00         | $0.00    | $0.00 | $0.00           | $190.00      |
#    And Admin verify "OOS or LS" in multiple order detail
#      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
#      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
#    And Admin create multiple order from detail with customer PO

  @AD_CREATE_MULTIPLE_ORDERS_66
  Scenario: Check convert the uploaded CSV file 2
    Given NGOCTX login web admin by api
      | email            | password  |
      | bao4@podfoods.co | 12345678a |
    When Search order by sku "65651" by api
    And Admin delete order of sku "65651" by api
    Given BAO_AUTO18 open web admin
    When login to beta web with email "bao18@podfoods.co" pass "12345678a" role "Admin"
    And BAO_AUTO18 navigate to "Orders" to "Create multiple orders" by sidebar
    And Admin go to create new multiple order
    And Admin create multiple order with upload CSV file "multiple_order_file.csv"
    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 4         | 0 / 4  | 4        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 25 | 65651 | Out of stock | 250419980025 | Pending | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | In stock     | 250419980004 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | In stock     | 250419980002 | Pending | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock     | 250419980001 | Pending | $10.00 | 1        | [blank]                                                     |
    And Admin choose all line item to convert multiple order
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 4         | $40.00          | $0.00    | $0.00 | $0.00           | $40.00       |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 3         | $30.00          | $0.00    | $0.00 | $0.00           | $30.00       |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Admin choose all line item to convert multiple order
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin choose line item to convert to order in multi
      | sku                      | quantity |
      | AT SKU Multiple Order 25 | 1        |
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 1         | $10.00          | $0.00    | $0.00 | $0.00           | $10.00       |
    And Click on button "Create order"
    And Admin check dialog message
      | The customer PO number was used by the order(s) listed below. Do you still want to continue? |
    And Click on any text "Don’t remind me for the next 30 mins"
    And Click on dialog button "Understand & Continue"
    And Admin check alert message
      | Selected items have been converted successfully! |

    And Admin verify info of order number 1 in multiple order detail
      | number  | store    | customPO | lineItems | status | quantity |
      | [blank] | ngoc st1 | Auto PO  | 4         | 1 / 4  | 4        |
    And Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status    | price  | quantity | error                                                       |
      | Auto Product Multiple Order | AT SKU Multiple Order 25 | 65651 | Out of stock | 250419980025 | Converted | $10.00 | 1        | This SKU is out of stock but it will be added on the order. |
      | Auto Product Multiple Order | AT SKU Multiple Order 04 | 44183 | In stock     | 250419980004 | Pending   | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 02 | 44181 | In stock     | 250419980002 | Pending   | $10.00 | 1        | [blank]                                                     |
      | Auto Product Multiple Order | AT SKU Multiple Order 01 | 44180 | In stock     | 250419980001 | Pending   | $10.00 | 1        | [blank]                                                     |
    And Admin choose all line item to convert multiple order
    And Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 3         | $30.00          | $0.00    | $0.00 | $0.00           | $30.00       |
    And Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 3         | $30.00          | $0.00    | $0.00 | $0.00           | $30.00       |
    And Admin verify "OOS or LS" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 0         | $0.00           | $0.00    | $0.00 | $0.00           | $0.00        |
    And Admin check line items not available in multiple order detail
      | sku                      |
      | AT SKU Multiple Order 25 |
    And Admin go back with button
    And Admin reset filter
    And Admin verify list multiple order
      | id      | name                    | creator | date        | status |
      | [blank] | multiple_order_file.csv | bao18   | currentDate | 0 / 2  |
    And Admin delete multi order record "multiple_order_file.csv"
    And Admin check alert message
      | This csv cannot be deleted since it is associated converted items |
#    # Verify in order detail
    And BAO_AUTO18 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber | orderSpecific | store    | buyer        | buyerCompany | vendorCompany | brand   | sku                      | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | empty       | [blank]       | ngoc st1 | ngoctx N_CHI | [blank]      | [blank]       | [blank] | AT SKU Multiple Order 25 | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    Then Admin verify result order in all order
      | order | customerPO | creator | checkout    | buyer        | store    | region | total | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | Auto PO    | bao18   | currentDate | ngoctx N_CHI | ngoc st1 | CHI    | $0.00 | $0.00     | Pending      | Pending     | Pending       |
    When Admin go to detail first result search
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store    | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Auto PO    | currentDate | Chicagoland Express | ngoctx N_CHI | ngoc st1 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total |
      | $0.00      | $0.00    | $0.00 | Not applied         | $0.00              | $0.00            | $0.00 |
    And Admin check line items "deleted or shorted items" in order details
      | brand                      | product                     | sku                      | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 25 | 1 units/case | $10.00    | 1        | 0           | $10.00 | 65651 |

  @AD_CREATE_MULTIPLE_ORDERS_67
  Scenario: Check convert the uploaded CSV file
    Given BAO_AUTO18 login web admin by api
      | email             | password  |
      | bao18@podfoods.co | 12345678a |
    When Search order by sku "66289" by api
    And Admin delete order of sku "66289" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name]  | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Multiple Order 28 | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get ID inventory by product "Auto Product Multiple Order" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API
    And Admin create inventory api1
      | index | sku                      | product_variant_id | quantity | lot_code                 | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Multiple Order 28 | 66289              | 5        | AT SKU Multiple Order 28 | 99           | Plus1        | Plus1       | [blank] |
#
    Given BAO_AUTO18 open web admin
    When login to beta web with email "bao18@podfoods.co" pass "12345678a" role "Admin"
    Then BAO_AUTO18 navigate to "Orders" to "Create multiple orders" by sidebar
    And Admin go to create new multiple order
    * Admin create multiple order with upload CSV file "multiple_order_file3.csv"
    * Admin verify info of order number 2 in multiple order detail
      | number  | store               | customPO | lineItems | status | quantity |
      | [blank] | Auto Store Chicago1 | Auto PO  | 1         | 0 / 1  | 1        |
    * Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state        | upc          | status  | price  | quantity | error                                                                                                               |
      | Auto Product Multiple Order | AT SKU Multiple Order 27 | 66288 | Out of stock | 250419980027 | Pending | $10.00 | 1        | UPC/EAN is used for multiple SKUsClick here to resolve\nThis SKU is out of stock but it will be added on the order. |
    * Admin resolve UPC of item multiple order
      | oldSKU                   | newSKU                   | upc          |
      | AT SKU Multiple Order 27 | AT SKU Multiple Order 28 | 250419980027 |
    * Admin verify line item in multiple order detail
      | product                     | sku                      | skuID | state    | upc          | status  | price         | quantity | error   |
      | Auto Product Multiple Order | AT SKU Multiple Order 28 | 66289 | In stock | 250419980027 | Pending | $9.00\n$10.00 | 1        | [blank] |
    * Admin choose line item to convert to order in multi
      | sku                      | quantity |
      | AT SKU Multiple Order 28 | 5        |
    * Admin verify "total" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 5         | $50.00          | $5.00    | $0.00 | $0.00           | $45.00       |
    * Admin verify "in stock" in multiple order detail
      | totalCase | totalOrderValue | discount | taxes | specialDiscount | totalPayment |
      | 5         | $50.00          | $5.00    | $0.00 | $0.00           | $45.00       |
    * Admin create multiple order from detail with customer PO
    * Admin verify info of order number 2 in multiple order detail
      | number  | store               | customPO | lineItems | status | quantity |
      | [blank] | Auto Store Chicago1 | Auto PO  | 1         | 1 / 1  | 5        |
       # Verify in order detail
    Then BAO_AUTO18 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders by info
      | orderNumber | orderSpecific | store               | buyer        | buyerCompany | vendorCompany | brand   | sku                      | upc     | fulfillment | buyerPayment | region  | route   | managed | pod     | tracking | startDate | endDate | temp    | oos     | orderType | exProcess | pendingFinancial |
      | empty       | [blank]       | Auto Store Chicago1 | Auto Buyer59 | [blank]      | [blank]       | [blank] | AT SKU Multiple Order 28 | [blank] | [blank]     | [blank]      | [blank] | [blank] | [blank] | [blank] | [blank]  | [blank]   | [blank] | [blank] | [blank] | [blank]   | [blank]   | [blank]          |
    * Admin verify result order in all order
      | order | customerPO | creator | checkout    | buyer        | store      | region | total  | vendorFee | buyerPayment | fulfillment | vendorPayment |
      | empty | Auto PO    | bao18   | currentDate | Auto Buyer59 | Auto Store | CHI    | $50.00 | $13.00    | Pending      | Pending     | Pending       |
    * Admin go to detail first result search
    * Verify general information of order detail
      | customerPo | date        | region              | buyer        | store               | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Auto PO    | currentDate | Chicagoland Express | Auto Buyer59 | Auto Store Chicago1 | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    * Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | fuelSurcharge | vendorServiceFee | total  |
      | $50.00     | $5.00    | $0.00 | $30.00              | [blank]            | $0.00         | $13.00           | $75.00 |
    * Admin check line items "sub invoice" in order details
      | brand                      | product                     | sku                      | unitCase     | casePrice | quantity | endQuantity | total  | skuID |
      | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 28 | 1 units/case | $10.00    | 5        | 0           | $45.00 | 66289 |
    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    Then VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "Unfulfilled"
      | region              | store               | paymentStatus | orderType | checkoutDate |
      | Chicagoland Express | Auto Store Chicago1 | Pending       | Express   | currentDate  |
    * Vendor Check orders in dashboard order
      | ordered     | number | store               | payment | fullfillment | total  | orderType |
      | currentDate | 2      | Auto Store Chicago1 | Pending | Pending      | $32.00 | Express   |
    Given BUYER open web user
    When login to beta web with email "ngoctx+autobuyer59@podfoods.co" pass "12345678a" role "buyer"
    Then BUYER Go to Dashboard
    And BUYER Navigate to "Orders" by sidebar
    * Search Order in tab "Pending" with
      | brand                      | checkoutAfter | checkoutBefore |
      | AT Brand Multiple Order 01 | currentDate   | [blank]        |
    * Go to order detail with order number ""
    * Check information in order detail
      | buyerName    | storeName           | shippingAddress                               | orderValue | total  | payment    | status  | logisticSurcharge | smallOrder | discount |
      | Auto Buyer59 | Auto Store Chicago1 | 455 Madison Avenue, New York, New York, 10022 | $50.00     | $75.00 | By invoice | Pending | [blank]           | $30.00     | -$5.00   |
    * Buyer check items in order detail have multi sub invoice
      | sub | index | brandName                  | productName                 | skuName                  | unitPerCase | casePrice | quantity | total  | addCart | unitUPC                      | priceUnit   | caseUnit    | eta     |
      | 1   | 1     | AT Brand Multiple Order 01 | Auto Product Multiple Order | AT SKU Multiple Order 28 | 1 unit/case | $10.00    | 5        | $45.00 | [blank] | Unit UPC / EAN: 250419980027 | $10.00/unit | 1 unit/case | [blank] |

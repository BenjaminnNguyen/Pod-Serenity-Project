#mvn clean verify -Dtestsuite="FlowInventoryTestSuite" -Dcucumber.options="src/test/resources/features/flow" -Dsurefire.rerunFailingTestsCount=1 -Drp.launch=Admin-Inventory -Drp.project=podfoodsweb
@feature=flow-inventory
Feature: Inventory flow

  Narrative:
  Auto test admin inventory

  #low quantity threshold =  Average daily sales over the past 90 days of an Express region  *42 days. (eg: sale quantity = 10 -> lowquantity = (10/90)*42 = ) (round up, eg: result = 3.2 -> threshold = 4)
  @Inventory01 @Inventory
  Scenario: Admin create a lot has quantity less than qty of threshold
    #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx301@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "6288"

    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 30       | random   | 90           | currentDate  | [blank]     | [blank] |

    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 6288      | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

#    Fulfilled this order
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx301@podfoods.co | 12345678a |
    And Admin "fulfill" all line item in order "create by api" by api

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"

    #Create inventory with quantity < low quantity threshold
    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx301@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 1        | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And Verify inventory detail
      | index | product                              | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product low quantity thresshold | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 1           | 1          | 1      |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName                          | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto product low quantity thresshold | random  | random  | 1                | 1               | 1        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | [blank]       | CHI    | Admin     |

    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName | vendorCompany | vendorBrand | region              |
      | [blank] | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                              | product                              | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
      | random | Auto Brand low quantity thresshold | Auto product low quantity thresshold | 31               | 0                 | 31              | 20              | 0                    | 11          | 11 cases in inventory |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                          | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product low quantity thresshold | random  | random  | 1           | currentDate | 1          | 0         | 1      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                          | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product low quantity thresshold | random  | random  | 1           | currentDate | 1          | 0         | 1      | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                              | brand                              | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto product low quantity thresshold | Auto Brand low quantity thresshold | random | 1                | 0                | 1               | 0               | 0                    | 1      | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                              | brand                              | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto product low quantity thresshold | Auto Brand low quantity thresshold | random | 1                | 0                | 1               | 0               | 0                    | [blank] | [blank]     | [blank]               | 11 cases in inventory |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany       | lotCode | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | Auto vendor company | random  | 1               | 1                | [blank]  | [blank] |

    And LP quit browser
    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser
    And ADMIN_OLD quit browser

  @Inventory02 @Inventory
  Scenario: Admin create a lot has quantity more than qty of threshold
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx302@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product low quantity 1 thresshold" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto product low quantity 1 thresshold | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product low quantity 1 thresshold" from API
    And Admin delete inventory "all" by API
   # Delete sku
    And Admin delete all sku in product id "6288" by api

    #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx302@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "27440"

     # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 30       | random   | 90           | currentDate  | [blank]     | [blank] |

    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 27440     | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"

    #Create inventory with quantity < low quantity threshold
    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx302@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 20       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And Verify inventory detail
      | index | product                                | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product low quantity 1 thresshold | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 20          | 20         | 0      |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName                            | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto product low quantity 1 thresshold | random  | random  | 20               | 20              | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | [blank]       | CHI    | Admin     |

    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName | vendorCompany | vendorBrand | region              |
      | [blank] | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                              | product                                | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
      | random | Auto Brand low quantity thresshold | Auto product low quantity 1 thresshold | 50               | 0                 | 50              | 20              | 0                    | 30          | 30 cases in inventory |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                            | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product low quantity 1 thresshold | random  | random  | 20          | currentDate | 20         | 0         | 0      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                            | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product low quantity 1 thresshold | random  | random  | 20          | currentDate | 20         | 0         | 0      | N/A        | N/A      |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                                | brand                              | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto product low quantity 1 thresshold | Auto Brand low quantity thresshold | random | 50               | 0                | 50              | 20              | 0                    | 30     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product                                | brand                              | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto product low quantity 1 thresshold | Auto Brand low quantity thresshold | random | 50               | 0                | 50              | 20              | 0                    | [blank] | [blank]     | [blank]               | 30 cases in inventory |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany       | lotCode | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | Auto vendor company | random  | 20              | 20               | [blank]  | [blank] |

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx302@podfoods.co | 12345678a |
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto product low quantity 1 thresshold | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product low quantity 1 thresshold" from API
    And Admin delete inventory "all" by API
   # Delete sku
    And Admin delete sku "" in product "27440" by api

    And LP quit browser
    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser
    And ADMIN_OLD quit browser

  @Inventory03 @Inventory
  Scenario: PE Buyer checkout with the quantity is more than end quantity
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx303@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product2 low quantity thresshold" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto product2 low quantity thresshold | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product2 low quantity thresshold" from API
    And Admin delete inventory "all" by API
   # Delete sku
    And Admin delete all sku in product id "6292" by api

    #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx303@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "6292"

     # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 30       | random   | 90           | currentDate  | [blank]     | [blank] |

    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer30@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 6292      | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Create inventory with quantity
    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx303@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 10       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And Verify inventory detail
      | index | product                               | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product2 low quantity thresshold | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 10          | 10         | 10     |
    And Verify no inventory activities found

    Given NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store                              | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer30 | Auto Store check inventory Chicago | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $2.00      | $0.00    | $0.00 | $30.00              | $0.00              | $0.50            | $32.00 |
    And Admin check line items "sub invoice" in order details
      | brand                              | product                               | sku    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand low quantity thresshold | Auto product2 low quantity thresshold | random | 1 units/case | $0.10     | 20       | [blank]     | $2.00 |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                              | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                          | productName                           | skuName | casePrice | quantity | total | podConsignment  |
      | Auto Brand low quantity thresshold | Auto product2 low quantity thresshold | random  | $0.10     | 20       | $2.00 | POD CONSIGNMENT |

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product2 low quantity thresshold | random  | random  | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product2 low quantity thresshold | random  | random  | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx303@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product2 low quantity thresshold" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto product2 low quantity thresshold | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product2 low quantity thresshold" from API
    And Admin delete inventory "all" by API
#    Delete sku
    And Admin delete all sku in product id "6292" by api

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

  @Inventory03.1 @Inventory
  Scenario: Sub Buyer checkout with the quantity is more than end quantity
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx304@podfoods.co | 12345678a |
    And Admin delete order by sku of product "Auto product3 low quantity thresshold" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto product3 low quantity thresshold | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product3 low quantity thresshold" from API
    And Admin delete inventory "all" by API
   # Delete sku
    And Admin delete all sku in product id "6293" by api

    #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx304@podfoods.co | 12345678a |
    And Info of Region
      | region         | id | state  | availability | casePrice | msrp |
      | Dallas Express | 61 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "6293"

    # Authorized SKUs to Sub buyer able to buy this sku
    And Admin Authorized SKU id "" to Store id "2597"

     # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 30       | random   | 88           | currentDate  | [blank]     | [blank] |

    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer33@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 6293      | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Create inventory with quantity
    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx304@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar

    And Admin create new inventory
      | distribution                  | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto distribute Texas Express | random | 10       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And Verify inventory detail
      | index | product                               | sku    | createdBy | region         | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product3 low quantity thresshold | random | Admin     | Dallas Express | Auto distribute Texas Express | currentDate | [blank]    | [blank]  | random  | 10          | 10         | 10     |
    And Verify no inventory activities found

    Given NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region         | buyer        | store                        | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Dallas Express | Auto Buyer33 | Auto Store check order texas | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $2.00      | $0.00    | $0.00 | $30.00              | $0.00              | $0.50            | $32.00 |
    And Admin check line items "sub invoice" in order details
      | brand                              | product                               | sku    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand low quantity thresshold | Auto product3 low quantity thresshold | random | 1 units/case | $0.10     | 20       | [blank]     | $2.00 |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                        | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Store check order texas | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                          | productName                           | skuName | casePrice | quantity | total | podConsignment  |
      | Auto Brand low quantity thresshold | Auto product3 low quantity thresshold | random  | $0.10     | 20       | $2.00 | POD CONSIGNMENT |

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product3 low quantity thresshold | random  | random  | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
    And Vendor search All Inventory "DAL"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product3 low quantity thresshold | random  | random  | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx304@podfoods.co | 12345678a |
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto product3 low quantity thresshold | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product3 low quantity thresshold" from API
    And Admin delete inventory "all" by API
    # Delete sku
    And Admin delete all sku in product id "6293" by api

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

  @Inventory04_Head_Buyer_PE @Inventory
  Scenario: Buyer checkout with the quantity is less than end quantity
    #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx305@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "6295"

    #Create inventory with quantity
    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx305@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 30       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success

       #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer34@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 6295      | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    And Switch to actor NGOC_ADMIN_03
    And Admin refresh page by button

    And Verify inventory detail
      | index | product                               | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product4 low quantity thresshold | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 30          | 30         | 10     |
    And Verify subtraction item after ordered
      | date        | qty | category | description             | action  | order   |
      | currentDate | 20  | [blank]  | auto-confirmed, pending | [blank] | [blank] |

    Given NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store                              | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer34 | Auto Store check inventory Chicago | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $2.00      | $0.00    | $0.00 | $30.00              | $0.00              | $0.50            | $32.00 |
    And Admin check line items "sub invoice" in order details
      | brand                              | product                               | sku    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand low quantity thresshold | Auto product4 low quantity thresshold | random | 1 units/case | $0.10     | 20       | [blank]     | $2.00 |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                              | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                              | payment | fullfillment | total |
      | currentDate | create by api | Auto Store check inventory Chicago | Pending | Pending      | $1.50 |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                          | productName                           | skuName | casePrice | quantity | total | podConsignment  |
      | Auto Brand low quantity thresshold | Auto product4 low quantity thresshold | random  | $0.10     | 20       | $2.00 | POD CONSIGNMENT |

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product4 low quantity thresshold | random  | random  | 30          | currentDate | 30         | 0         | 10     | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product4 low quantity thresshold | random  | random  | 30          | currentDate | 30         | 0         | 10     | N/A        | N/A      |

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx305@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | [blank]                 | Auto product4 low quantity thresshold | 90              | 26           | Admin           | 2946        | 1847                 | [blank]               | 1    |
    And Admin get list ID inventory by sku "Auto product4 low quantity thresshold" from API
    And Admin delete inventory "all" by API
    # Delete sku
    And Admin delete all sku in product id "6295" by api

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

  @Inventory04.1_Sub_Buyer @Inventory
  Scenario: Buyer checkout with the quantity is equal than end quantity
    #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx306@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "27441"
    And Admin Authorized SKU id "" to Store id "2681"

    #Create inventory with quantity
    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx306@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 20       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success

     #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer35@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 27441     | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    And Switch to actor NGOC_ADMIN_03
    And Admin refresh page by button

    And Verify inventory detail
      | index | product                                | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product4a low quantity thresshold | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 20          | 20         | 0      |
    And Verify subtraction item after ordered
      | date        | qty | category | description             | action  | order   |
      | currentDate | 20  | [blank]  | auto-confirmed, pending | [blank] | [blank] |

    Given NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Verify general information of order detail
      | customerPo | date        | region              | buyer        | store                              | customStore | adminNote | buyerPayment | paymentType         | vendorPayment | fulfillment |
      | Empty      | currentDate | Chicagoland Express | Auto Buyer35 | Auto Store check inventory Chicago | [blank]     | [blank]   | Pending      | Payment via invoice | Pending       | Pending     |
    And Verify price in order details
      | orderValue | discount | taxes | smallOrderSurcharge | logisticsSurcharge | vendorServiceFee | total  |
      | $2.00      | $0.00    | $0.00 | $30.00              | $0.00              | $0.50            | $32.00 |
    And Admin check line items "sub invoice" in order details
      | brand                              | product                                | sku    | unitCase     | casePrice | quantity | endQuantity | total |
      | Auto Brand low quantity thresshold | Auto product4a low quantity thresshold | random | 1 units/case | $0.10     | 20       | 0           | $2.00 |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                              | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | currentDate  |
    And Vendor Check orders in dashboard order
      | ordered     | number        | store                              | payment | fullfillment | total |
      | currentDate | create by api | Auto Store check inventory Chicago | Pending | Pending      | $1.50 |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                          | productName                            | skuName | casePrice | quantity | total | podConsignment  |
      | Auto Brand low quantity thresshold | Auto product4a low quantity thresshold | random  | $0.10     | 20       | $2.00 | POD CONSIGNMENT |

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                            | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product4a low quantity thresshold | random  | random  | 20          | currentDate | 20         | 0         | 0      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                            | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product4a low quantity thresshold | random  | random  | 20          | currentDate | 20         | 0         | 0      | N/A        | N/A      |

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx306@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]                        | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto product4a low quantity thresshold | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto product4a low quantity thresshold" from API
    And Admin delete inventory "all" by API
      # Delete sku
    And Admin delete sku "" in product "27441" by api

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

  @Inventory05 @Inventory
  Scenario: Check the in stock Availability of sku if end quantity increasing from 0 to positive number
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx307@podfoods.co | 12345678a |
    And Delete all inventory with product "Auto product check availability"

    # comming_soon, sold_out
    And Update regions info of SKU "30901"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82788 | 26        | 30901              | 1000             | 1200       | sold_out     | active |
      | 82787 | 61        | 30901              | 1000             | 1200       | coming_soon  | active |
    # And Update Availability of SKU "30901" to "coming_soon"
    And Admin create inventory api
      | product_variant_id | quantity | lot_code                        | warehouse_id | receive_date | expiry_date | comment |
      | 30901              | 1        | Auto product check availability | 88           | currentDate  | [blank]     | [blank] |
    And Admin create inventory api
      | product_variant_id | quantity | lot_code                         | warehouse_id | receive_date | expiry_date | comment |
      | 30901              | 1        | Auto product check availability2 | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx307@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                            | productState | brandName | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto product check availability | [blank]      | [blank]   | [blank]       | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Admin check product detail
      | stateStatus | productName                     | brand                         | vendorCompany       | sampleable | packageSize | unitLWH     | caseLWH     | caseWight | unitSize | additionalFee | category | type    | casePerPallet | casePerLayer | layerPerPallet | masterCarton | caseMaster | masterCaseWeight | masterCase |
      | Active      | Auto product check availability | Auto Brand check availability | Auto vendor company | Yes        | Bulk        | 12"×12"×12" | 12"×12"×12" | 10.00 lbs | 10.0 g   | 0.00%         | Dairy    | / Bread | 12            | 12           | 12             | 0            | 0          | 0.00 lbs         | [blank]    |
    And Admin check SKU info
      | skuName                 | unitUpc      | caseUpc      | status |
      | Auto SKU availability 1 | 121212121212 | 121212121212 | Active |
    And Admin go to SKU detail "Auto SKU availability 1"
    And Admin go to region-specific of SKU then verify
      | regionName          | casePrice | msrpunit | availability |
      | Chicagoland Express | 10        | 12       | In stock     |
      | Dallas Express      | 10        | 12       | In stock     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Products" by sidebar
    And Vendor go to product detail by name "Auto product check availability"
    And Vendor go to SKUs tap
    And Vendor go to detail of SKU "Auto SKU availability 1"
    And Vendor check SKU general detail
      | skuName                 | ingredients                            | description | leadTime | unitCase | unitUPC      | caseUPC      | country       | city | state    | storage | retail | minTemperature | maxTemperature |
      | Auto SKU availability 1 | Sodium Laureth Sulfate,Hexylene Glycol | abc         | 5        | 1        | 121212121212 | 121212121212 | United States | abc  | New York | 1       | 1      | [blank]        | [blank]        |
    And Vendor go to Manage SKU price tab
    And Vendor check Region-Specific of SKU
      | regionName          | casePrice | msrpUnit | availability |
      | Chicagoland Express | 10        | 12       | In Stock     |
      | Dallas Express      | 10        | 12       | In Stock     |

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

  @Inventory06 @Inventory
  Scenario: Edit to Quantity on order is less than/equal to End quantity of Lot
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx308@podfoods.co | 12345678a |
    When Search order by sku "30910" by api
    And Admin delete order of sku "30910" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | Auto SKU 2 availability | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "Auto SKU 2 availability" from API
    And Admin delete inventory "all" by API
    And Admin create inventory api1
      | index | sku                     | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Auto SKU 2 availability | 30910              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 82799 | 26        | 30910              | 10000            | 10000      | in_stock     | active |

    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer35@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6303      | 30910 | 5        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx308@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin update quantity of line items
      | item                    | quantity |
      | Auto SKU 2 availability | 9        |
    And Admin check line items "sub invoice" in order details
      | brand                         | product                           | sku                     | unitCase     | casePrice | quantity | endQuantity | total   |
      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 2 availability | 1 units/case | $100.00   | 9        | 1           | $900.00 |
    And Admin go to Order summary from order detail
    And Admin check invoice detail in Order summary
      | index | brand                         | product                           | sku                     | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | 1     | Auto Brand check availability | Auto product 2 check availability | Auto SKU 2 availability | Dry | Confirmed | 9        | 1           | Auto Ngoc Distribution CHI | [blank]     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                              | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                     | productName                       | skuName                 | casePrice | quantity | total   | podConsignment  |
      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 2 availability | $100.00   | 9        | $900.00 | POD CONSIGNMENT |

    Given NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                 | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | Auto SKU 2 availability | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | productName                       | skuName                 | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany       | region | createdBy |
      | Auto product 2 check availability | Auto SKU 2 availability | random  | 10               | 10              | 1        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | Auto vendor company | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName                 | lotCode |
      | 1     | Auto SKU 3 availability | random  |
    Then Verify inventory detail
      | product                           | sku                     | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto product 2 check availability | Auto SKU 2 availability | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 10          | 10         | 1      |
    And Verify subtraction item after ordered
      | date        | qty | category | description             | action  | order         |
      | currentDate | 9   | [blank]  | auto-confirmed, pending | [blank] | create by api |

    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName                 | productName | vendorCompany | vendorBrand | region              |
      | [blank] | Auto SKU 2 availability | [blank]     | [blank]       | [blank]     | Chicagoland Express |
    Then Verify result inventory status
      | sku                     | brand                         | product                           | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | Auto SKU 2 availability | Auto Brand check availability | Auto product 2 check availability | 10               | 0                 | 10              | 9               | 0                    | 1           |

    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName                 | zeroQuantity | orderBy                 |
      | Auto SKU 2 availability | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                       | skuName                 | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product 2 check availability | Auto SKU 2 availability | random  | 10          | currentDate | 10         | 0         | 1      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName                 | zeroQuantity | orderBy                 |
      | Auto SKU 2 availability | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                       | skuName                 | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product 2 check availability | Auto SKU 2 availability | random  | 10          | currentDate | 10         | 0         | 1      | N/A        | N/A      |

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

#    Given NGOC_ADMIN_03 open web admin
#    When NGOC_ADMIN_03 login to web with role Admin
#    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
#    And Admin search the orders "create by api"
#    And Admin go to order detail number "create by api"
#    And Admin check line items "sub invoice" in order details
#      | brand                         | product                           | sku                     | unitCase     | casePrice | quantity | endQuantity | total  |
#      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | 1 units/case | $10.00    | 1        | 9           | $10.00 |
#
#    And Admin update quantity of line items
#      | item                    | quantity |
#      | Auto SKU 3 availability | 11       |
#    And Admin check line items "sub invoice" in order details
#      | brand                         | product                           | sku                     | unitCase     | casePrice | quantity | endQuantity | total   |
#      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | 1 units/case | $10.00    | 11       | 10          | $110.00 |
#    And Admin go to Order summary from order detail
#    And Admin check invoice detail in Order summary
#      | brand                         | product                           | sku                     | tmp | delivery      | quantity | endQuantity | warehouse | fulfillment |
#      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | Dry | Not confirmed | 11       | 10          | N/A       | [blank]     |
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Orders" by sidebar
#    And Vendor search order "All"
#      | region  | store                              | paymentStatus | orderType | checkoutDate |
#      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | 06/13/22     |
#    And Vendor Go to order detail with order number "create by api"
#    And Vendor Check items in order detail
#      | brandName                     | productName                       | skuName                 | casePrice | quantity | total   | podConsignment |
#      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | $10.00    | 11       | $110.00 | POD CONSIGNMENT      |
#
#    Given NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
#    And Admin search inventory
#      | skuName                 | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
#      | Auto SKU 3 availability | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
#    Then Verify result inventory
#      | productName                       | skuName                 | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany       | region | createdBy |
#      | Auto product 2 check availability | Auto SKU 3 availability | random  | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | Auto vendor company | CHI    | Admin     |
#    And Admin see detail inventory with lotcode
#      | index | skuName                 | lotCode |
#      | 1     | Auto SKU 3 availability | random  |
#    Then Verify inventory detail
#      | product                           | sku                     | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
#      | Auto product 2 check availability | Auto SKU 3 availability | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 10          | 10         | 10     |
#    And Verify no inventory activities found
#
#    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
#    And Admin search inventory status
#      | anyText | skuName                 | productName | vendorCompany | vendorBrand | region              |
#      | [blank] | Auto SKU 3 availability | [blank]     | [blank]       | [blank]     | Chicagoland Express |
#    Then Verify result inventory status
#      | sku                     | brand                         | product                           | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
#      | Auto SKU 3 availability | Auto Brand check availability | Auto product 2 check availability | 10               | 0                 | 10              | 0               | 11                   | -1          |
#
#    Given VENDOR Navigate to "Inventory" by sidebar
#    And Vendor go to "All Inventory" tab
#    And Vendor search All Inventory "All regions"
#      | skuName                 | zeroQuantity | orderBy                 |
#      | Auto SKU 3 availability | No           | Received - Latest first |
#    Then Vendor verify result in All Inventory
#      | productName                       | skuName                 | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
#      | Auto product 2 check availability | Auto SKU 3 availability | random  | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
#    And Vendor search All Inventory "CHI"
#      | skuName                 | zeroQuantity | orderBy                 |
#      | Auto SKU 3 availability | No           | Received - Latest first |
#    Then Vendor verify result in All Inventory
#      | productName                       | skuName                 | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
#      | Auto product 2 check availability | Auto SKU 3 availability | random  | 10          | currentDate | 10         | 0         | 10     | N/A        | N/A      |
#
#    And Vendor search Inventory Status "All regions"
#      | skuName                 | orderBy                     |
#      | Auto SKU 3 availability | Current Qty - Highest first |
#    Then Vendor verify result in Inventory Status
#      | product                           | brand                         | sku                     | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
#      | Auto product 2 check availability | Auto Brand check availability | Auto SKU 3 availability | 10               | 0                | 10              | 0               | 11                   | -1     | [blank]     | [blank]               | [blank] |
#    And Vendor search Inventory Status "CHI"
#      | skuName                 | orderBy                     |
#      | Auto SKU 3 availability | Current Qty - Highest first |
#    Then Vendor verify result in Inventory Status
#      | product                           | brand                         | sku                     | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status        |
#      | Auto product 2 check availability | Auto Brand check availability | Auto SKU 3 availability | 10               | 0                | 10              | 0               | 11                   | [blank] | [blank]     | [blank]               | 1 case needed |
#
#    Given LP open web LP
#    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
#    And LP Navigate to "Inventory" by sidebar
#    And Lp go to All inventory tab
#    And LP search "All" inventory
#      | sku                     | product | vendorCompany | vendorBrand |
#      | Auto SKU 3 availability | [blank] | [blank]       | [blank]     |
#    And Check search result in All inventory
#      | index | sku                     | distributionCenter         | vendorCompany       | lotCode | currentQuantity | originalQuantity | received | expiry  |
#      | 1     | Auto SKU 3 availability | Auto Ngoc Distribution CHI | Auto vendor company | random  | 10              | 10               | [blank]  | [blank] |

  @Inventory09 @Inventory
  Scenario: Check the inventory with fulfilled sku story
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx310@podfoods.co | 12345678a |
    When Search order by sku "35089" by api
    And Admin delete order of sku "35089" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | Auto SKU 4 availability | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "Auto SKU 4 availability" from API
    And Admin delete inventory "all" by API
       # Create inventory
    And Admin create inventory api1
      | index | sku                     | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Auto SKU 4 availability | 35089              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer29@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 8470      | 35089 | 9        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx310@podfoods.co" pass "12345678a" role "Admin"
    Given NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand                         | product                           | sku                     | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand check availability | Auto product 3 check availability | Auto SKU 4 availability | 1 units/case | $10.00    | 9        | [blank]     | $90.00 |
    And Admin fulfill all line items
      | index | skuName                 | fulfillDate |
      | 1     | Auto SKU 4 availability | currentDate |
    And Admin wait 2000 mini seconds
    And Admin go to Order summary from order detail
    And Admin check invoice detail in Order summary
      | brand                         | product                           | sku                     | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | Auto Brand check availability | Auto product 3 check availability | Auto SKU 4 availability | Dry | Confirmed | 9        | [blank]     | Auto Ngoc Distribution CHI | currentDate |

    Given NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName                 | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | Auto SKU 4 availability | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | productName                       | skuName                 | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | receiveDate | dayUntilPullDate | distributionCenter         | vendorCompany       | region | createdBy |
      | Auto product 3 check availability | Auto SKU 4 availability | random  | 10               | 1               | 1        | 0            | [blank]    | [blank]  | currentDate | [blank]          | Auto Ngoc Distribution CHI | Auto vendor company | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | skuName                 | lotCode |
      | Auto SKU 4 availability | random  |
    Then Verify inventory detail
      | product                           | sku                     | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto product 3 check availability | Auto SKU 4 availability | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 10          | 1          | 1      |
    And Verify subtraction item after ordered
      | date        | qty | category | description               | action  | order         |
      | currentDate | 9   | [blank]  | auto-confirmed, fulfilled | [blank] | create by api |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                              | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                     | productName                       | skuName                 | casePrice | quantity | total  | podConsignment  |
      | Auto Brand check availability | Auto product 3 check availability | Auto SKU 4 availability | $10.00    | 9        | $90.00 | POD CONSIGNMENT |

    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName                 | zeroQuantity | orderBy                 |
      | Auto SKU 4 availability | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                       | skuName                 | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product 3 check availability | Auto SKU 4 availability | random  | 10          | currentDate | 1          | 0         | 1      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName                 | zeroQuantity | orderBy                 |
      | Auto SKU 4 availability | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                       | skuName                 | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product 3 check availability | Auto SKU 4 availability | random  | 10          | currentDate | 1          | 0         | 1      | N/A        | N/A      |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku                     | product | vendorCompany | vendorBrand |
      | Auto SKU 4 availability | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                     | distributionCenter         | vendorCompany       | lotCode | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | Auto SKU 4 availability | Auto Ngoc Distribution CHI | Auto vendor company | random  | 1               | 10               | currentDate | [blank] |

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser
    And LP quit browser

  @Inventory07 @Inventory
  Scenario: Edit to Quantity on order is more than End quantity of Lot
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx309@podfoods.co | 12345678a |
    When Search order by sku "34508" by api
    And Admin delete order of sku "34508" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | Auto SKU 3 availability | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "Auto SKU 3 availability" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku                     | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | Auto SKU 3 availability | 34508              | 11       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Change region to active
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  |
      | 90930 | 26        | 34508              | 1000             | 1000       | in_stock     | active |
    # Create order
    Given Buyer login web with by api
      | email                          | password  |
      | ngoctx+autobuyer35@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6303      | 34508 | 1        |
    And Checkout cart with payment by "invoice" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx309@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin check line items "sub invoice" in order details
      | brand                         | product                           | sku                     | unitCase     | casePrice | quantity | endQuantity | total  |
      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | 1 units/case | $10.00    | 1        | 10          | $10.00 |

    And Admin update quantity of line items
      | item                    | quantity |
      | Auto SKU 3 availability | 11       |
    And Admin check line items "sub invoice" in order details
      | brand                         | product                           | sku                     | unitCase     | casePrice | quantity | endQuantity | total   |
      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | 1 units/case | $10.00    | 11       | 0           | $110.00 |
    And Admin go to Order summary from order detail
    And Admin check invoice detail in Order summary
      | brand                         | product                           | sku                     | tmp | delivery  | quantity | endQuantity | warehouse                  | fulfillment |
      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | Dry | Confirmed | 11       | 0           | Auto Ngoc Distribution CHI | [blank]     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor36@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Orders" by sidebar
    And Vendor search order "All"
      | region  | store                              | paymentStatus | orderType | checkoutDate |
      | [blank] | Auto Store check inventory Chicago | [blank]       | [blank]   | currentDate  |
    And Vendor Go to order detail with order number "create by api"
    And Vendor Check items in order detail
      | brandName                     | productName                       | skuName                 | casePrice | quantity | total   | podConsignment  |
      | Auto Brand check availability | Auto product 2 check availability | Auto SKU 3 availability | $10.00    | 11       | $110.00 | POD CONSIGNMENT |
    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

  @Inventory10 @Inventory
  Scenario: Admin create a subtraction story: - end quantity after creating is less than low quantity threshold
     #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx311@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "inventory10 random" of product "27444"
     # Delete inventory
    And Admin delete order by sku of product "Auto Ngoc 1 Inventory" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | [blank]                 | Auto Ngoc 1 Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get ID inventory by product "Auto Ngoc 1 Inventory" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx311@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 30       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success

     #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 27444     | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"

    And Switch to actor NGOC_ADMIN_03
    And Admin refresh page by button

    And Verify inventory detail
      | index | product               | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc 1 Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 30          | 30         | 10     |
    And Admin create subtraction items
      | quantity | category          | subCategory | comment  |
      | 1        | Pull date reached | Donated     | Autotest |
    And Verify subtraction item on inventory
      | quantity | category | description           | date        | order   | comment  |
      | 1        | Donated  | Created by ngoctx311. | currentDate | [blank] | Autotest |
    And Verify inventory detail
      | index | product               | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc 1 Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 30          | 29         | 9      |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | Yes          | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc 1 Inventory | random  | random  | 30          | currentDate | 29         | 0         | 9      | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc 1 Inventory | random  | random  | 30          | currentDate | 29         | 0         | 9      | N/A        | N/A      |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | random  | 29              | 30               | [blank]  | [blank] |

    Given NGOCTX03 login web admin by api
      | email                | password  |
      | ngoctx03@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
     # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | random                  | Auto Ngoc 1 Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "" from API
    And Admin delete inventory "all" by API
      # Delete sku
    And Admin delete sku "" in product "27444" by api

    And LP quit browser
    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser
    And ADMIN_OLD quit browser

  @Inventory11 @Inventory
  Scenario: Admin create a subtraction story: - end quantity after creating is more than low quantity threshold
      #Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx312@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "27445"

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx312@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | random | 50       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success

     #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 27445     | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"

    And Switch to actor NGOC_ADMIN_03
    And Admin refresh page by button

    And Verify inventory detail
      | index | product               | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc 2 Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 50          | 50         | 30     |
    And Admin create subtraction items
      | quantity | category          | subCategory | comment  |
      | 1        | Pull date reached | Donated     | Autotest |
    And Verify subtraction item on inventory
      | quantity | category | description           | date        | order   | comment  |
      | 1        | Donated  | Created by ngoctx312. | currentDate | [blank] | Autotest |
    And Verify inventory detail
      | index | product               | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc 2 Inventory | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 50          | 49         | 29     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | Yes          | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc 2 Inventory | random  | random  | 50          | currentDate | 49         | 0         | 29     | N/A        | N/A      |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc 2 Inventory | random  | random  | 50          | currentDate | 49         | 0         | 29     | N/A        | N/A      |

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | random  | 49              | 50               | [blank]  | [blank] |

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx312@podfoods.co | 12345678a |
    When Admin get ID SKU by id "" from product id "27445" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | random                  | Auto Ngoc 2 Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "" from API
    And Admin delete inventory "all" by API
    # Delete sku
    And Admin delete sku "" in product "27445" by api

    And LP quit browser
    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser
    And ADMIN_OLD quit browser
  #bug ko xóa dc subtraction 14/09
  @Inventory12 @Inventory
  Scenario: Admin delete subtraction
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx313@podfoods.co | 12345678a |
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name]     | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | Auto SKU delete subtraction | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "Auto SKU delete subtraction" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx313@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
#    And Admin verify sku textbox in search all inventory
#      | searchValue                        | brand                              | product                         | sku                         |
#      | 30914                              | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto Brand low quantity thresshold | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto product delete subtraction    | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
#      | Auto SKU delete subtraction        | Auto Brand low quantity thresshold | Auto product delete subtraction | Auto SKU delete subtraction |
    And Admin create new inventory
      | distribution                  | sku                         | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto distribute Texas Express | Auto SKU delete subtraction | 20       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product                         | sku                         | createdBy | region         | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto product delete subtraction | Auto SKU delete subtraction | Admin     | Dallas Express | Auto distribute Texas Express | currentDate | [blank]    | [blank]  | random  | 20          | 20         | 20     |
    And Admin create subtraction items
      | quantity | category | subCategory | comment  |
      | 1        | Donated  | [blank]     | Autotest |
    And Verify subtraction item on inventory
      | quantity | category | description           | date        | order   | comment  |
      | 1        | Donated  | Created by ngoctx313. | currentDate | [blank] | Autotest |
    And Verify inventory detail
      | index | product                         | sku                         | createdBy | region         | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product delete subtraction | Auto SKU delete subtraction | Admin     | Dallas Express | Auto distribute Texas Express | currentDate | [blank]    | [blank]  | random  | 20          | 19         | 19     |
    And Admin delete first subtraction items with comment "donated"
    And Verify subtraction item on inventory
      | quantity | category | description                                 | date        | order   | comment  |
      | [blank]  | [blank]  | ngoctx313 removed subtraction/addition item | currentDate | [blank] | donated  |
      | 1        | [blank]  | Created by ngoctx313.                       | currentDate | [blank] | Autotest |
    And Verify inventory detail
      | index | product                         | sku                         | createdBy | region         | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | 1     | Auto product delete subtraction | Auto SKU delete subtraction | Admin     | Dallas Express | Auto distribute Texas Express | currentDate | [blank]    | [blank]  | random  | 20          | 20         | 20     |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName                     | zeroQuantity | orderBy                 |
      | Auto SKU delete subtraction | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                     | skuName                     | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product delete subtraction | Auto SKU delete subtraction | random  | 20          | currentDate | 20         | 0         | 20     | N/A        | N/A      |
    And Vendor search All Inventory "DAL"
      | skuName                     | zeroQuantity | orderBy                 |
      | Auto SKU delete subtraction | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName                     | skuName                     | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto product delete subtraction | Auto SKU delete subtraction | random  | 20          | currentDate | 20         | 0         | 20     | N/A        | N/A      |

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx313@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name]     | q[product_name]                 | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | Auto SKU delete subtraction | Auto product delete subtraction | 88              | 61           | Admin           | 2946        | 1847                 | 0                     | 1    |
    And Admin get ID inventory by lotcote "" from API
    And Admin delete inventory "" by API

    And VENDOR quit browser
    And NGOC_ADMIN_03 quit browser

  @Inventory14 @Inventory
  Scenario: If the ending qty equal 0 the stock availability of sku change from in stock to out of stock story - admin/buyer create order
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx315@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT SKU Inventory 14" from product id "6059" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Inventory 14     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Inventory 14" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx315@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku                 | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | AT SKU Inventory 14 | 10       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 14 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 10          | 10         | 10     |

    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6059      | 31072 | 10       |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_03 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                | productState | brandName             | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto Ngoc Inventory | Active       | AT Brand Inventory 01 | ngoc vc 1     | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Admin go to SKU detail "AT SKU Inventory 14"
    And Admin go to region-specific of SKU then verify
      | regionName          | casePrice | msrpunit | availability |
      | Chicagoland Express | 100       | 100      | Out of stock |

    And NGOC_ADMIN_03 quit browser

  @Inventory15 @Inventory
  Scenario: LP create a new inventory that has the quantity more than the quantity threshold story
#    Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx316@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "inventory15 random" of product "27446"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP go to create new inventory
    And LP create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate  | comment  |
      | Auto Ngoc Distribution CHI | random | 50       | random  | currentDate | currentDate | Autotest |
    And LP create new inventory successfully
    Then LP verify info of inventory detail
      | product               | sku    | quantity | totalCase | distribution               | lotCode | receiveDate | expiryDate  | comment  |
      | Auto Ngoc 3 Inventory | random | 50       | 50        | Auto Ngoc Distribution CHI | random  | currentDate | currentDate | Autotest |
    And LP go to back all inventory from detail

        #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 27446     | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"
    And ADMIN_OLD quit browser

    And Switch to actor USER_LP
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | random  | 50              | 50               | currentDate | [blank] |
    And USER_LP quit browser

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx316@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName           | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc 3 Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName           | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy  |
      | 1     | Auto Ngoc 3 Inventory | random  | random  | 50               | 50              | 30       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | ngoctx lp1 |
    And Admin see detail inventory
    Then Verify inventory detail
      | product               | sku    | createdBy  | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto Ngoc 3 Inventory | random | ngoctx lp1 | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 50          | 50         | 30     |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName           | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc 3 Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product               | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc 3 Inventory | 50               | 0                 | 50              | 20              | 0                    | 30          |
    And NGOC_ADMIN_03 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoc+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | Auto Ngoc 3 Inventory | random  | random  | 50          | currentDate | 50         | 0         | 30     | currentDate | [blank]  |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | Auto Ngoc 3 Inventory | random  | random  | 50          | currentDate | 50         | 0         | 30     | currentDate | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product               | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc 3 Inventory | AT Brand Inventory 01 | random | 50               | 0                | 50              | 20              | 0                    | 30     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product               | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc 3 Inventory | AT Brand Inventory 01 | random | 50               | 0                | 50              | 20              | 0                    | [blank] | [blank]     | [blank]               | 30 cases in inventory |
    And VENDOR quit browser

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx316@podfoods.co | 12345678a |
    When Admin get ID SKU by name "" from product id "27446" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | random                  | Auto Ngoc 3 Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "" from API
    And Admin delete inventory "all" by API
    And Admin delete sku "" in product "27446" by api

  @Inventory13 @Inventory
  Scenario: If the ending qty equal 0 the stock availability of sku change from in stock to out of stock story - admin create subtraction
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx314@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT SKU Inventory 13" from product id "6059" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Inventory 13     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Inventory 13" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx314@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku                 | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | AT SKU Inventory 13 | 10       | random  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 13 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 10          | 10         | 10     |
    And Admin create subtraction items
      | quantity | category | subCategory | comment  |
      | 10       | Donated  | [blank]     | Autotest |
    And Verify subtraction item on inventory
      | quantity | category | description           | date        | order   | comment  |
      | 10       | Donated  | Created by ngoctx314. | currentDate | [blank] | Autotest |
    And NGOC_ADMIN_03 navigate to "Products" to "All products" by sidebar
    And Search the product by info then system show result
      | term                | productState | brandName             | vendorCompany | productType | packageSize | sampleable | availableIn | tags    |
      | Auto Ngoc Inventory | Active       | AT Brand Inventory 01 | ngoc vc 1     | [blank]     | [blank]     | [blank]    | [blank]     | [blank] |
    And Admin go to product detail from just searched
    And Admin go to SKU detail "AT SKU Inventory 13"
    And Admin go to region-specific of SKU then verify
      | regionName          | casePrice | msrpunit | availability |
      | Chicagoland Express | 100       | 100      | Out of stock |

    And NGOC_ADMIN_03 quit browser

  @Inventory16 @Inventory
  Scenario: LP create a new inventory that has the quantity less than the quantity threshold story
    # Create SKU
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx329@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "inventory15 random" of product "27446"

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP go to create new inventory
    And LP create new inventory
      | distribution               | sku    | quantity | lotCode | receiveDate | expiryDate  | comment  |
      | Auto Ngoc Distribution CHI | random | 30       | random  | currentDate | currentDate | Autotest |
    And LP create new inventory successfully
    Then LP verify info of inventory detail
      | product               | sku    | quantity | totalCase | distribution               | lotCode | receiveDate | expiryDate  | comment  |
      | Auto Ngoc 3 Inventory | random | 30       | 30        | Auto Ngoc Distribution CHI | random  | currentDate | currentDate | Autotest |
    And LP go to back all inventory from detail

      #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+chi2@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 27446     | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"
    And ADMIN_OLD quit browser

    And Switch to actor USER_LP
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | random  | 30              | 30               | currentDate | [blank] |
    And USER_LP quit browser

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx329@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName           | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc 3 Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName           | skuName | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy  |
      | 1     | Auto Ngoc 3 Inventory | random  | random  | 30               | 30              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | ngoctx lp1 |
    And Admin see detail inventory
    Then Verify inventory detail
      | product               | sku    | createdBy  | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
      | Auto Ngoc 3 Inventory | random | ngoctx lp1 | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | random  | 30          | 30         | 10     |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName | productName           | vendorCompany | vendorBrand           | region              |
      | [blank] | random  | Auto Ngoc 3 Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express |
    Then Verify result inventory status
      | sku    | brand                 | product               | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity |
      | random | AT Brand Inventory 01 | Auto Ngoc 3 Inventory | 30               | 0                 | 30              | 20              | 0                    | 10          |
    And NGOC_ADMIN_03 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v2@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | Auto Ngoc 3 Inventory | random  | random  | 30          | currentDate | 30         | 0         | 10     | currentDate | [blank]  |
    And Vendor search All Inventory "CHI"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName           | skuName | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate  | pullDate |
      | Auto Ngoc 3 Inventory | random  | random  | 30          | currentDate | 30         | 0         | 10     | currentDate | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product               | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc 3 Inventory | AT Brand Inventory 01 | random | 30               | 0                | 30              | 20              | 0                    | 10     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName | orderBy                     |
      | random  | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product               | brand                 | sku    | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc 3 Inventory | AT Brand Inventory 01 | random | 30               | 0                | 30              | 20              | 0                    | [blank] | [blank]     | [blank]               | [blank] |
    And VENDOR quit browser

    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx316@podfoods.co | 12345678a |
    When Admin get ID SKU by name "" from product id "27446" by API
    # Delete order
    When Search order by sku "" by api
    And Admin delete order of sku "" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]       | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | random                  | Auto Ngoc 3 Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "" from API
    And Admin delete inventory "all" by API
    And Admin delete sku "" in product "27446" by api

  @Inventory17 @Inventory
  Scenario: Inventory deduction rule Pull From The most-prioritized warehouse in the order that has sufficient inventory AND closest with store
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx317@podfoods.co | 12345678a |
    When Search order by sku "31108" by api
    And Admin delete order of sku "31108" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 17     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 17" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx317@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 17 | 10       | LotCode01 | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 17 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | currentDate | [blank]    | [blank]  | LotCode01 | 10          | 10         | 10     |

    And NGOC_ADMIN_03 quit browser

  @Inventory19 @Inventory
  Scenario: Inventory deduction rule Pull from earliest receive date (From this rule it will be used for inventory with the same warehouse)
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx318@podfoods.co | 12345678a |
    When Search order by sku "31132" by api
    And Admin delete order of sku "31132" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 19     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 19" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx318@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 19 | 10       | LotCode01 | Plus1       | [blank]    | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 19 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | [blank]    | [blank]  | LotCode01 | 10          | 10         | 10     |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 19 | 10       | LotCode02 | Plus10      | [blank]    | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 19 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus10      | [blank]    | [blank]  | LotCode02 | 10          | 10         | 10     |

    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+tx02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6059      | 31132 | 5        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand                 | product             | sku                 | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 19 | 1 units/case | $100.00   | 5        | 15          | $500.00 |
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution TX 01"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName             | productName         | vendorCompany | vendorBrand | region         | distribution                 | createdBy | lotCode | pulled  |
      | AT SKU Inventory 19 | Auto Ngoc Inventory | [blank]       | [blank]     | Dallas Express | Auto Ngoc Distribution TX 01 | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName             | lotCode   | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter           | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 19 | LotCode01 | 10               | 10              | 5        | 0            | [blank]    | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
      | 2     | Auto Ngoc Inventory | AT SKU Inventory 19 | LotCode02 | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | Plus10      | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName             | productName         | vendorCompany | vendorBrand           | region         |
      | [blank] | AT SKU Inventory 19 | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Dallas Express |
    Then Verify result inventory status
      | sku                 | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
      | AT SKU Inventory 19 | AT Brand Inventory 01 | Auto Ngoc Inventory | 20               | 0                 | 20              | 5               | 0                    | 15          | 15 cases in inventory |
    And NGOC_ADMIN_03 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product             | vendorCompany | vendorBrand |
      | AT SKU Inventory 19 | Auto Ngoc Inventory | ngoc vc 1     | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter           | vendorCompany | lotCode   | currentQuantity | originalQuantity | received | expiry  |
      | 1     | AT SKU Inventory 19 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode01 | 10              | 10               | Plus1    | [blank] |
      | 2     | AT SKU Inventory 19 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode02 | 10              | 10               | Plus10   | [blank] |
    And USER_LP quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 19 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 19 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | N/A        | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 19 | LotCode02 | 10          | Plus10   | 10         | 0         | 10     | N/A        | [blank]  |
    And Vendor search All Inventory "DAL"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 19 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 19 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | N/A        | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 19 | LotCode02 | 10          | Plus10   | 10         | 0         | 10     | N/A        | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName             | orderBy                     |
      | AT SKU Inventory 19 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 19 | 20               | 0                | 20              | 5               | 0                    | 15     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "DAL"
      | skuName             | orderBy                     |
      | AT SKU Inventory 19 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 19 | 20               | 0                | 20              | 5               | 0                    | [blank] | [blank]     | [blank]               | 15 cases in inventory |
    And VENDOR quit browser

  @Inventory21 @Inventory
  Scenario: Inventory deduction rule Pull From The Lot With Lowest End Quantity Of Case Story (If both receive dates and expiration dates are the same)
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx319@podfoods.co | 12345678a |
    When Search order by sku "31134" by api
    And Admin delete order of sku "31134" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     |
      | AT SKU Inventory 21     | Auto Ngoc Inventory |
    And Admin get list ID inventory by sku "AT SKU Inventory 21" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx319@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 21 | 10       | LotCode01 | Plus1       | Plus2      | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 21 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus2      | [blank]  | LotCode01 | 10          | 10         | 10     |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 21 | 15       | LotCode02 | Plus1       | Plus2      | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 21 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus2      | [blank]  | LotCode02 | 15          | 15         | 15     |

    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+tx02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6059      | 31134 | 5        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand                 | product             | sku                 | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 21 | 1 units/case | $100.00   | 5        | 20          | $500.00 |
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution TX 01"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName             | productName         | vendorCompany | vendorBrand | region         | distribution                 | createdBy | lotCode | pulled  |
      | AT SKU Inventory 21 | Auto Ngoc Inventory | [blank]       | [blank]     | Dallas Express | Auto Ngoc Distribution TX 01 | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName             | lotCode   | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter           | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 21 | LotCode01 | 10               | 10              | 5        | 0            | Plus2      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
      | 2     | Auto Ngoc Inventory | AT SKU Inventory 21 | LotCode02 | 15               | 15              | 15       | 0            | Plus2      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName             | productName         | vendorCompany | vendorBrand           | region         |
      | [blank] | AT SKU Inventory 21 | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Dallas Express |
    Then Verify result inventory status
      | sku                 | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
      | AT SKU Inventory 21 | AT Brand Inventory 01 | Auto Ngoc Inventory | 25               | 0                 | 25              | 5               | 0                    | 20          | 20 cases in inventory |
    And NGOC_ADMIN_03 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product             | vendorCompany | vendorBrand |
      | AT SKU Inventory 21 | Auto Ngoc Inventory | ngoc vc 1     | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter           | vendorCompany | lotCode   | currentQuantity | originalQuantity | received | expiry |
      | 1     | AT SKU Inventory 21 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode01 | 10              | 10               | Plus1    | Plus2  |
      | 2     | AT SKU Inventory 21 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode02 | 15              | 15               | Plus1    | Plus2  |
    And USER_LP quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 21 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 21 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 21 | LotCode02 | 10          | Plus10   | 15         | 0         | 15     | Plus2      | [blank]  |
    And Vendor search All Inventory "DAL"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 21 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 21 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 21 | LotCode02 | 10          | Plus10   | 10         | 0         | 10     | Plus2      | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName             | orderBy                     |
      | AT SKU Inventory 21 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 21 | 25               | 0                | 25              | 5               | 0                    | 20     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "DAL"
      | skuName             | orderBy                     |
      | AT SKU Inventory 21 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 21 | 25               | 0                | 25              | 5               | 0                    | [blank] | [blank]     | [blank]               | 20 cases in inventory |
    And VENDOR quit browser

  @Inventory22 @Inventory
  Scenario: Inventory deduction rule: Pull From The Lot With Earliest Data Entry Date Story
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx320@podfoods.co | 12345678a |
    When Search order by sku "31135" by api
    And Admin delete order of sku "31135" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 22     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 22" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx320@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 22 | 10       | LotCode01 | Plus1       | Plus2      | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | index | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 22 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus2      | [blank]  | LotCode01 | 10          | 10         | 10     |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 22 | 10       | LotCode02 | Plus1       | Plus2      | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 22 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus2      | [blank]  | LotCode02 | 10          | 10         | 10     |

    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+tx02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6059      | 31135 | 5        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand                 | product             | sku                 | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 22 | 1 units/case | $100.00   | 5        | 15          | $500.00 |
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution TX 01"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName             | productName         | vendorCompany | vendorBrand | region         | distribution                 | createdBy | lotCode | pulled  |
      | AT SKU Inventory 22 | Auto Ngoc Inventory | [blank]       | [blank]     | Dallas Express | Auto Ngoc Distribution TX 01 | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName             | lotCode   | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter           | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 22 | LotCode01 | 10               | 10              | 5        | 0            | Plus2      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
      | 2     | Auto Ngoc Inventory | AT SKU Inventory 22 | LotCode02 | 10               | 10              | 10       | 0            | Plus2      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName             | productName         | vendorCompany | vendorBrand           | region         |
      | [blank] | AT SKU Inventory 22 | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Dallas Express |
    Then Verify result inventory status
      | sku                 | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
      | AT SKU Inventory 22 | AT Brand Inventory 01 | Auto Ngoc Inventory | 20               | 0                 | 20              | 5               | 0                    | 15          | 15 cases in inventory |
    And NGOC_ADMIN_03 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product             | vendorCompany | vendorBrand |
      | AT SKU Inventory 22 | Auto Ngoc Inventory | ngoc vc 1     | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter           | vendorCompany | lotCode   | currentQuantity | originalQuantity | received | expiry |
      | 1     | AT SKU Inventory 22 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode01 | 10              | 10               | Plus1    | Plus2  |
      | 2     | AT SKU Inventory 22 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode02 | 10              | 10               | Plus1    | Plus2  |
    And USER_LP quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 22 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 22 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 22 | LotCode02 | 10          | Plus10   | 10         | 0         | 10     | Plus2      | [blank]  |
    And Vendor search All Inventory "DAL"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 22 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 22 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 22 | LotCode02 | 10          | Plus10   | 10         | 0         | 10     | Plus2      | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName             | orderBy                     |
      | AT SKU Inventory 22 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 22 | 20               | 0                | 20              | 5               | 0                    | 15     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "DAL"
      | skuName             | orderBy                     |
      | AT SKU Inventory 22 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 22 | 20               | 0                | 20              | 5               | 0                    | [blank] | [blank]     | [blank]               | 15 cases in inventory |
    And VENDOR quit browser

  @Inventory18 @Inventory
  Scenario: Inventory deduction rule Pull From The most-prioritized warehouse in the order that has sufficient inventory AND closest with store
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx318@podfoods.co | 12345678a |
    When Admin search order by API
      | skuID | fulfillment_state | buyer_payment_state |
      | 31111 | [blank]           | pending             |
    And Admin delete order of sku "31111" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 18     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 18" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx318@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 18 | 10       | LotCode01 | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 18 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | currentDate | [blank]    | [blank]  | LotCode01 | 10          | 10         | 10     |
    And NGOC_ADMIN_03 quit browser

  @Inventory23 @Inventory
  Scenario: Inventory deduction rule: Pull From The Lot With Earliest Data Entry Date Story
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx321@podfoods.co | 12345678a |
    When Search order by sku "31136" by api
    And Admin delete order of sku "31136" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 23     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 23" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx321@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 23 | 10       | LotCode01 | Plus1       | Plus2      | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 23 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus2      | [blank]  | LotCode01 | 10          | 10         | 10     |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 23 | 20       | LotCode02 | Plus1       | Plus2      | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 23 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus2      | [blank]  | LotCode02 | 20          | 20         | 20     |

    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+tx02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6059      | 31136 | 5        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand                 | product             | sku                 | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 23 | 1 units/case | $100.00   | 5        | 25          | $500.00 |
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution TX 01"
    When Admin edit pod consignment of line item
      | sku                 | comment  |
      | AT SKU Inventory 23 | AutoTest |
    And Admin verify deliverable detail of line item
      | sku                 | deliveryMethod  | comment  |
      | AT SKU Inventory 23 | Pod Consignment | AutoTest |
    And NGOC_ADMIN_03 refresh browser

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName             | productName         | vendorCompany | vendorBrand | region         | distribution                 | createdBy | lotCode | pulled  |
      | AT SKU Inventory 23 | Auto Ngoc Inventory | [blank]       | [blank]     | Dallas Express | Auto Ngoc Distribution TX 01 | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName             | lotCode   | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter           | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 23 | LotCode01 | 10               | 10              | 5        | 0            | Plus2      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
      | 2     | Auto Ngoc Inventory | AT SKU Inventory 23 | LotCode02 | 20               | 20              | 20       | 0            | Plus2      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName             | productName         | vendorCompany | vendorBrand           | region         |
      | [blank] | AT SKU Inventory 23 | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Dallas Express |
    Then Verify result inventory status
      | sku                 | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
      | AT SKU Inventory 23 | AT Brand Inventory 01 | Auto Ngoc Inventory | 30               | 0                 | 30              | 5               | 0                    | 25          | 25 cases in inventory |
    And NGOC_ADMIN_03 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product             | vendorCompany | vendorBrand |
      | AT SKU Inventory 23 | Auto Ngoc Inventory | ngoc vc 1     | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter           | vendorCompany | lotCode   | currentQuantity | originalQuantity | received | expiry |
      | 1     | AT SKU Inventory 23 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode01 | 10              | 10               | Plus1    | Plus2  |
      | 2     | AT SKU Inventory 23 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode02 | 20              | 20               | Plus1    | Plus2  |
    And USER_LP quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 23 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 23 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 23 | LotCode02 | 20          | Plus10   | 20         | 0         | 20     | Plus2      | [blank]  |
    And Vendor search All Inventory "DAL"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 23 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 23 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 23 | LotCode02 | 20          | Plus10   | 20         | 0         | 20     | Plus2      | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName             | orderBy                     |
      | AT SKU Inventory 23 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 23 | 30               | 0                | 30              | 5               | 0                    | 25     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "DAL"
      | skuName             | orderBy                     |
      | AT SKU Inventory 23 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 23 | 30               | 0                | 30              | 5               | 0                    | [blank] | [blank]     | [blank]               | 25 cases in inventory |
    And VENDOR quit browser

  @Inventory24 @Inventor
  Scenario: Inventory deduction rule: Pull From The Lot With Earliest Data Entry Date Story
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx322@podfoods.co | 12345678a |
    When Search order by sku "31137" by api
    And Admin delete order of sku "31137" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 24     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 24" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx322@podfoods.co" pass "12345678a" role "Admin"
#    Given NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
#    And Search the orders by info then system show result
#    And Admin verify pod consignment deliverable not set
#    And Admin verify not set distribution center
#
    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Orders" by sidebar
#    And Vendor search order "Unconfirmed"
#      | region        | store         | paymentStatus | orderType | checkoutDate |
#      | Dallas Express | ngoctx stTX01 | Pending       | Express   | currentDate  |
#    And Vendor Go to order detail with order number "create by api"
#    And Vendor Check items in order detail
#      | brandName             | productName         | skuName             | casePrice | quantity | total   | podConsignment |
#      | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 24 | $100.00   | 5        | $500.00 | POD CONSIGNMENT       |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 24 | 10       | LotCode01 | Plus1       | Plus2      | [blank] |
    And Admin add image to create new inventory
      | index | file        | comment       |
      | 1     | anhJPEG.jpg | Auto Upload 1 |
      | 2     | anhJPEG.jpg | Auto Upload 2 |
      | 3     | anhJPEG.jpg | Auto Upload 3 |
    And Admin create new inventory success

    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+tx02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6059      | 31137 | 5        |
    And Checkout cart with payment by "invoice" by API

    And Switch to actor NGOC_ADMIN_03
    And Admin refresh page by button

    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 24 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus2      | [blank]  | LotCode01 | 10          | 10         | 5      |
    And Verify subtraction item after ordered
      | date        | qty | category | description             | action  | order   |
      | currentDate | 5   | [blank]  | auto-confirmed, pending | [blank] | [blank] |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName             | productName         | vendorCompany | vendorBrand           | region         |
      | [blank] | AT SKU Inventory 24 | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Dallas Express |
    Then Verify result inventory status
      | sku                 | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status               |
      | AT SKU Inventory 24 | AT Brand Inventory 01 | Auto Ngoc Inventory | 10               | 0                 | 10              | 5               | 0                    | 5           | 5 cases in inventory |

    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand                 | product             | sku                 | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 24 | 1 units/case | $100.00   | 5        | 5           | $500.00 |
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution TX 01"
    And NGOC_ADMIN_03 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product             | vendorCompany | vendorBrand |
      | AT SKU Inventory 24 | Auto Ngoc Inventory | ngoc vc 1     | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter           | vendorCompany | lotCode   | currentQuantity | originalQuantity | received | expiry |
      | 1     | AT SKU Inventory 24 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode01 | 10              | 10               | Plus1    | Plus2  |
    And USER_LP quit browser

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 24 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 24 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
    And Vendor search All Inventory "DAL"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 24 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 24 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus2      | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName             | orderBy                     |
      | AT SKU Inventory 24 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 24 | 10               | 0                | 10              | 5               | 0                    | 5      | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "DAL"
      | skuName             | orderBy                     |
      | AT SKU Inventory 24 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status               |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 24 | 10               | 0                | 10              | 5               | 0                    | [blank] | [blank]     | [blank]               | 5 cases in inventory |
    And VENDOR quit browser

  @Inventory25 @Inventory
  Scenario: Admin Check Embedded Link Of Product In Lot Detail Story
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx323@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "31138" by api
    And Admin delete order of sku "31138" by api

    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Inventory 25     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Inventory 25" from API
    And Admin delete inventory "all" by API

    # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inventory 25 | 31138              | 10       | Lotcode01 | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx323@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName             | productName         | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Inventory 25 | Auto Ngoc Inventory | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Admin see detail inventory
    And Admin go to product from inventory detail
    Then Admin verify page title is "Product #6059 — Auto Ngoc Inventory"
    And NGOC_ADMIN_03 quit browser

  @Inventory26 @Inventory
  Scenario: Admin Check Inventory Detail When Edit Inventory Photos Story
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx324@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "31141" by api
    And Admin delete order of sku "31141" by api

    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Inventory 26     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Inventory 26" from API
    And Admin delete inventory "all" by API

    # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inventory 26 | 31138              | 10       | Lotcode01 | 90           | currentDate  | [blank]     | [blank] |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 26     | Auto Ngoc Inventory | 90              | 26           | Admin           | 2872        | 1787                 | 0                     | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 26" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx324@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku                 | quantity | lotCode | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | AT SKU Inventory 26 | 30       | A12345  | currentDate | [blank]    | [blank] |
    And Admin create new inventory success
    And Admin add image to create new inventory
      | index | file        | comment       |
      | 1     | anhJPEG.jpg | Auto Upload 1 |
      | 2     | anhJPEG.jpg | Auto Upload 2 |
      | 3     | anhJPEG.jpg | Auto Upload 3 |
    And Admin save image upload success
    And NGOC_ADMIN_03 quit browser

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku                 | product | vendorCompany | vendorBrand |
      | AT SKU Inventory 26 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter         | vendorCompany | lotCode | currentQuantity | originalQuantity | received | expiry  |
      | 1     | AT SKU Inventory 26 | Auto Ngoc Distribution CHI | ngoc vc 1     | A12345  | 30              | 30               | [blank]  | [blank] |
    And LP go to detail inventory "A12345"
    And LP check inventory image
      | index | file        | comment     |
      | 1     | anhJPEG.jpg | Auto Upload |
      | 2     | anhJPEG.jpg | Auto Upload |
      | 3     | anhJPEG.jpg | Auto Upload |
    And LP quit browser

  @Inventory27 @Inventor
  Scenario: Check Lot code show on About To Expire tab
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx325@podfoods.co | 12345678a |
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 27     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 27" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx325@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku                 | quantity | lotCode  | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | AT SKU Inventory 27 | 1        | LotCode1 | currentDate | Minus1     | [blank] |
    And Admin create new inventory success
    And Verify inventory detail
      | index | product             | sku                 | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode  | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 27 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | Minus1     | [blank]  | LotCode1 | 1           | 1          | 1      |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution               | sku                 | quantity | lotCode  | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution CHI | AT SKU Inventory 27 | 1        | LotCode2 | currentDate | Plus1      | [blank] |
    And Admin create new inventory success
    And Verify inventory detail
      | index | product             | sku                 | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode  | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 27 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | Plus1      | [blank]  | LotCode2 | 1           | 1          | 1      |

    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "vendor_inventory_expiring_soon_reminder"
    And ADMIN_OLD quit browser

    And NGOC_ADMIN_03 navigate to "Inventories" to "About to expire" by sidebar
    And Admin verify red number expire
    And Admin search expire inventory
      | skuName             | productName         | vendorCompany | vendorBrand           | region              | distribution | createdBy | lotZero | storageSheftLife | tag     | dayUntilPullDate | dayUntilPullDateCondition | pullStartDate | pullEndDate |
      | AT SKU Inventory 27 | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank]          | [blank] | [blank]          | [blank]                   | [blank]       | [blank]     |
    And Verify result inventory
      | index | productName         | skuName             | lotCode  | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 27 | LotCode1 | 1                | 1               | 1        | 0            | Minus1     | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_03 quit browser

    Given LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku                 | product | vendorCompany | vendorBrand |
      | AT SKU Inventory 27 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter         | vendorCompany | lotCode  | currentQuantity | originalQuantity | received    | expiry |
      | 1     | AT SKU Inventory 27 | Auto Ngoc Distribution CHI | ngoc vc 1     | LotCode1 | 1               | 1                | currentDate | Minus1 |
      | 2     | AT SKU Inventory 27 | Auto Ngoc Distribution CHI | ngoc vc 1     | LotCode2 | 1               | 1                | currentDate | Plus1  |
    And LP search "About to expire" inventory
      | sku                 | product | vendorCompany | vendorBrand |
      | AT SKU Inventory 27 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter         | vendorCompany | lotCode  | currentQuantity | originalQuantity | received    | expiry |
      | 1     | AT SKU Inventory 27 | Auto Ngoc Distribution CHI | ngoc vc 1     | LotCode1 | 1               | 1                | currentDate | Minus1 |
    And LP quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                 |
      | AT SKU Inventory 27 | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode  | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 27 | LotCode1 | 1           | currentDate | 1          | 0         | 1      | Minus1     | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 27 | LotCode2 | 1           | currentDate | 1          | 0         | 1      | Plus1      | [blank]  |
    And Vendor search All Inventory "CHI"
      | skuName             | zeroQuantity | orderBy                 |
      | AT SKU Inventory 27 | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode  | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 27 | LotCode1 | 1           | currentDate | 1          | 0         | 1      | Minus1     | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 27 | LotCode2 | 1           | currentDate | 1          | 0         | 1      | Plus1      | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName             | orderBy                     |
      | AT SKU Inventory 27 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 27 | 2                | 0                | 2               | 0               | 0                    | [blank] | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "CHI"
      | skuName             | orderBy                     |
      | AT SKU Inventory 27 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status               |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 27 | 2                | 0                | 2               | 0               | 0                    | [blank] | [blank]     | [blank]               | 2 cases in inventory |
    And VENDOR quit browser

#  @Inventory28 @Inventory
#  Scenario: Check SKU show on Running low tab - SKU is active
#    Given NGOCTX03 login web admin by api
#      | email                 | password  |
#      | ngoctx326@podfoods.co | 12345678a |
#    When Admin get ID SKU by name "AT SKU Inventory 28" from product id "6059" by API
#    # Delete order
#    When Search order by sku "" by api
#    And Admin delete order of sku "" by api
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | AT SKU Inventory 28     | Auto Ngoc Inventory | 90              | 26           | Admin           | 2872        | 1787                 | 0                     | 1    |
#    And Admin get list ID inventory by sku "AT SKU Inventory 28" from API
#    And Admin delete inventory "all" by API
#    And Admin delete sku "" in product "6059" by api
#   # Create SKU
#    Given NGOCTX03 login web admin by api
#      | email                 | password  |
#      | ngoctx326@podfoods.co | 12345678a |
#    And Info of Region
#      | region              | id | state  | availability | casePrice | msrp |
#      | Chicagoland Express | 26 | active | in_stock     | 10        | 10   |
#      | Dallas Express       | 61 | active | in_stock     | 20        | 20   |
#    And Admin create SKU from admin with name "AT SKU Inventory 28" of product "6059"
#
#    #Add cart this SKU and checkout
#    Given Buyer login web with by api
#      | email                   | password  |
#      | ngoctx+chi1@podfoods.co | 12345678a |
#    And Clear cart to empty in cart before by API
#    And Add an item to cart by API
#      | productId | skuId   | quantity |
#      | 6059      | [blank] | 30       |
#    And Checkout cart with payment by "invoice" by API

  @Inventory20 @Inventory
  Scenario: Inventory deduction rule Pull from earliest receive date (From this rule it will be used for inventory with the same warehouse)
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx318@podfoods.co | 12345678a |
    When Search order by sku "31133" by api
    And Admin delete order of sku "31133" by api
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT SKU Inventory 20     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT SKU Inventory 20" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx318@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 20 | 10       | LotCode01 | Plus1       | Plus1      | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 20 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus1      | [blank]  | LotCode01 | 10          | 10         | 10     |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin create new inventory
      | distribution                 | sku                 | quantity | lotCode   | receiveDate | expiryDate | comment |
      | Auto Ngoc Distribution TX 01 | AT SKU Inventory 20 | 10       | LotCode02 | Plus1       | Plus10     | [blank] |
    And Admin create new inventory success
    Then Verify inventory detail
      | product             | sku                 | createdBy | region         | distributionCenter           | receiveDate | expireDate | pullDate | lotCode   | originalQty | currentQty | endQty |
      | Auto Ngoc Inventory | AT SKU Inventory 20 | Admin     | Dallas Express | Auto Ngoc Distribution TX 01 | Plus1       | Plus10     | [blank]  | LotCode02 | 10          | 10         | 10     |

    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+tx02@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId | quantity |
      | 6059      | 31133 | 5        |
    And Checkout cart with payment by "invoice" by API

    And NGOC_ADMIN_03 navigate to "Orders" to "All orders" by sidebar
    And Search the orders by info then system show result
    And Admin check line items "sub invoice" in order details
      | brand                 | product             | sku                 | unitCase     | casePrice | quantity | endQuantity | total   |
      | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 20 | 1 units/case | $100.00   | 5        | 15          | $500.00 |
    Then Verify pod consignment and preferment warehouse is "Auto Ngoc Distribution TX 01"
    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName             | productName         | vendorCompany | vendorBrand | region         | distribution                 | createdBy | lotCode | pulled  |
      | AT SKU Inventory 20 | Auto Ngoc Inventory | [blank]       | [blank]     | Dallas Express | Auto Ngoc Distribution TX 01 | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName             | lotCode   | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter           | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 20 | LotCode01 | 10               | 10              | 5        | 0            | Plus1      | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
      | 2     | Auto Ngoc Inventory | AT SKU Inventory 20 | LotCode02 | 10               | 10              | 10       | 0            | Plus10     | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution TX 01 | ngoc vc 1     | DAL    | Admin     |
    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
    And Admin search inventory status
      | anyText | skuName             | productName         | vendorCompany | vendorBrand           | region         |
      | [blank] | AT SKU Inventory 20 | Auto Ngoc Inventory | ngoc vc 1     | AT Brand Inventory 01 | Dallas Express |
    Then Verify result inventory status
      | sku                 | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
      | AT SKU Inventory 20 | AT Brand Inventory 01 | Auto Ngoc Inventory | 20               | 0                 | 20              | 5               | 0                    | 15          | 15 cases in inventory |
    And NGOC_ADMIN_03 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product             | vendorCompany | vendorBrand |
      | AT SKU Inventory 20 | Auto Ngoc Inventory | ngoc vc 1     | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter           | vendorCompany | lotCode   | currentQuantity | originalQuantity | received | expiry |
      | 1     | AT SKU Inventory 20 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode01 | 10              | 10               | Plus1    | Plus1  |
      | 2     | AT SKU Inventory 20 | Auto Ngoc Distribution TX 01 | ngoc vc 1     | LotCode02 | 10              | 10               | Plus1    | Plus10 |
    And USER_LP quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 20 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 20 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus1      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 20 | LotCode02 | 10          | Plus10   | 10         | 0         | 10     | Plus7      | [blank]  |
    And Vendor search All Inventory "DAL"
      | skuName             | zeroQuantity | orderBy                   |
      | AT SKU Inventory 20 | No           | Received - Earliest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode   | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 20 | LotCode01 | 10          | Plus1    | 10         | 0         | 5      | Plus1      | [blank]  |
      | Auto Ngoc Inventory | AT SKU Inventory 20 | LotCode02 | 10          | Plus10   | 10         | 0         | 10     | Plus7      | [blank]  |
    And Vendor search Inventory Status "All regions"
      | skuName             | orderBy                     |
      | AT SKU Inventory 20 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty | weekOfSales | lowInventoryThreshold | status  |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 20 | 20               | 0                | 20              | 5               | 0                    | 15     | [blank]     | [blank]               | [blank] |
    And Vendor search Inventory Status "DAL"
      | skuName             | orderBy                     |
      | AT SKU Inventory 20 | Current Qty - Highest first |
    Then Vendor verify result in Inventory Status
      | product             | brand                 | sku                 | receivedQuantity | deductedQuantity | currentQuantity | pendingQuantity | insufficientQuantity | endQty  | weekOfSales | lowInventoryThreshold | status                |
      | Auto Ngoc Inventory | AT Brand Inventory 01 | AT SKU Inventory 20 | 20               | 0                | 20              | 5               | 0                    | [blank] | [blank]     | [blank]               | 15 cases in inventory |
    And VENDOR quit browser

    # Dispose / Donation
  @Inventory29 @Inventory
  Scenario: Vendor Create A Submitted Disposal/Donation Request
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx327@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "59226" by api
    And Admin delete order of sku "59226" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Inventory 29     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Inventory 29" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inventory 29 | 59226              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to create request dispose donate inventory
    And Vendor fill info request dispose donate
      | type                           | region              | comment      |
      | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor add inventory to request dispose
      | index | sku                 | lotCode | quantity |
      | 1     | AT SKU Inventory 29 | random  | 5        |
    And Vendor create request dispose success
    Then Vendor verify information of request dispose detail
      | status    | type                           | region              | comment      |
      | Submitted | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
    And Vendor verify detail inventory of request dispose detail
      | index | brand                 | product             | sku                 | skuID | lotCode | expiryDate | pullDate | ofCase | max |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 29 | 59226 | random  | -          | [blank]  | 5      | 10  |
    And Vendor get number dispose donate request

    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName             | zeroQuantity | orderBy                 |
      | AT SKU Inventory 29 | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | productName         | skuName             | lotCode | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | Auto Ngoc Inventory | AT SKU Inventory 29 | random  | 10          | [blank]  | 10         | 0         | 10     | N/A        | [blank]  |
    And VENDOR quit browser

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx327@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "Disposal/Donation requests" by sidebar
    And Admin search disposal donation requests
      | number | vendorCompany | brand                 | region              | type     | status    | startDate | endDate |
      | random | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express | Disposal | Submitted | [blank]   | [blank] |
    Then Admin verify result dispose donate request
      | number | requestDate | vendorCompany | brand                 | region              | type     | status    |
      | random | currentDate | ngoc vc 1     | AT Brand Inventory 01 | Chicagoland Express | Disposal | Submitted |

    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName             | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | AT SKU Inventory 29 | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName         | skuName             | lotCode | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inventory | AT SKU Inventory 29 | random  | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | [blank]     | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_03 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product | vendorCompany | vendorBrand |
      | AT SKU Inventory 29 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter         | vendorCompany | lotCode | currentQuantity | originalQuantity | received | expiry  |
      | 1     | AT SKU Inventory 29 | Auto Ngoc Distribution CHI | ngoc vc 1     | random  | 10              | 10               | [blank]  | [blank] |
    And USER_LP quit browser

  @Inventory30 @Inventory
  Scenario: Admin Create A Submitted Disposal/Donation Request
    Given NGOCTX03 login web admin by api
      | email                 | password  |
      | ngoctx328@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "59227" by api
    And Admin delete order of sku "59227" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Inventory 30     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Inventory 30" from API
    And Admin delete inventory "all" by API
      # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
      | AT SKU Inventory 31     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
    And Admin get list ID inventory by sku "AT SKU Inventory 31" from API
    And Admin delete inventory "all" by API
    # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inventory 30 | 59227              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      # Create inventory
    And Admin create inventory api1
      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Inventory 31 | 59228              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_03 open web admin
    When login to beta web with email "ngoctx328@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_03 navigate to "Inventories" to "Disposal/Donation requests" by sidebar
    And Admin create inventory requests
      | vendorCompany | region              | type     | note                   |
      | ngoc vc 1     | Chicagoland Express | Disposal | Auto Inventory Request |
    And Admin add inventory to create inventory requests
      | index | vendorBrand | sku                 | product | lotCode | quantity |
      | 1     | [blank]     | AT SKU Inventory 30 | [blank] | random  | 100      |
    And Admin create inventory requests and see message "Inventory request items request case must be in range 0..10"
     # remove lot code
    And  Admin remove inventory to inventory requests detail
      | index | sku                 | lotCode |
      | 1     | AT SKU Inventory 30 | random  |
    And Admin add inventory to create inventory requests
      | index | vendorBrand | sku                 | product | lotCode | quantity |
      | 1     | [blank]     | AT SKU Inventory 30 | [blank] | random  | 5        |
    And Admin create inventory requests success
    Then Admin verify general information of inventory requests detail
      | vendorCompany | requestDate | region              | status    | comment                | requestType |
      | ngoc vc 1     | currentDate | Chicagoland Express | Submitted | Auto Inventory Request | Disposal    |
    And Admin verify pullable inventory of inventory requests detail
      | index | brand                 | product             | sku                 | skuID | lotCode | expiryDate | pullDate | case |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 30 | 59227 | random  | [blank]    | [blank]  | 5    |
    And Admin get inventory requests number in detail
    # add more lot code
    And Admin add inventory to create inventory requests
      | index | vendorBrand | sku                 | product | lotCode | quantity |
      | 1     | [blank]     | AT SKU Inventory 31 | [blank] | random  | 1        |
    And Admin save action in inventory requests
    And Admin verify pullable inventory of inventory requests detail
      | index | brand                 | product             | sku                 | skuID | lotCode | expiryDate | pullDate | case |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 30 | 59227 | random  | [blank]    | [blank]  | 5    |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 31 | 59228 | random  | [blank]    | [blank]  | 1    |
    # remove lot code
    And  Admin remove inventory to inventory requests detail
      | index | sku                 | lotCode |
      | 1     | AT SKU Inventory 31 | random  |
    And Admin save action in inventory requests
    And Admin verify pullable inventory of inventory requests detail
      | index | brand                 | product             | sku                 | skuID | lotCode | expiryDate | pullDate | case |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Inventory | AT SKU Inventory 30 | 59227 | random  | [blank]    | [blank]  | 5    |
    And NGOC_ADMIN_03 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v101@podfoods.co" pass "12345678a" role "vendor"
    Given VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to dispose donate inventory page
    And Vendor go to tab "Submitted" in dispose donate inventory page
    And Vendor verify inventory request
      | number | requestDate | type     | case | status    |
      | random | currentDate | Disposal | 5    | Submitted |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku                 | product | vendorCompany | vendorBrand |
      | AT SKU Inventory 30 | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku                 | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received | expiry  |
      | 1     | AT SKU Inventory 30 | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 10              | 10               | [blank]  | [blank] |
    And USER_LP quit browser

#  @Inventory31 @Inventory
#  Scenario: Admin Create A Submitted Disposal/Donation Request with multi lotcode
#    Given NGOCTX03 login web admin by api
#      | email                | password  |
#      | ngoctx03@podfoods.co | 12345678a |
#    # Delete dispose donate request
#    And Admin search dispose donate request by API
#      | q[number] | q[vendor_company_id] | q[brand_id] | q[region_id] | q[request_type] | q[status] | q[start_date] | q[end_date] | page |
#      | [blank]   | 1847                 | [blank]     | [blank]      | [blank]         | [blank]   | [blank]       | [blank]     | 1    |
#    And Admin delete all inventory request by API
##    # Delete inventory
##    And Admin search inventory by API
##      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
##      | AT SKU Inventory 25     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
##    And Admin get list ID inventory by sku "AT SKU Inventory 25" from API
##    And Admin delete inventory "all" by API
##    # Create inventory
##    And Admin create inventory api1
##      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
##      | 1     | AT SKU Inventory 25 | 31138              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
#
#    Given NGOC_ADMIN_03 open web admin
#    When NGOC_ADMIN_03 login to web with role Admin
#    And NGOC_ADMIN_03 navigate to "Inventories" to "Disposal/Donation requests" by sidebar
#    And Admin create inventory requests
#      | vendorCompany       | region              | type     | note                   |
#      | Auto vendor company | Chicagoland Express | Disposal | Auto Inventory Request |
#    And Admin add inventory to create inventory requests
#      | index | vendorBrand | sku                     | product | lotCode | quantity |
#      | 1     | [blank]     | Auto SKU subtrction     | [blank] | random  | 1        |
#      | 1     | [blank]     | Auto SKU availability 1 | [blank] | random  | 1        |
#    And Admin create inventory requests success
#    Then Admin verify general information of inventory requests detail
#      | vendorCompany       | requestDate | region              | status    | comment                | requestType |
#      | Auto vendor company | currentDate | Chicagoland Express | Submitted | Auto Inventory Request | Disposal    |
#    And Admin verify pullable inventory of inventory requests detail
#      | index | brand                              | product                         | sku                     | skuID | lotCode                          | expiryDate | pullDate | case |
#      | 1     | Auto Brand low quantity thresshold | Auto Product create subtraction | Auto SKU subtrction     | 31138 | Auto SKU subtraction             | [blank]    | [blank]  | 1    |
#      | 1     | Auto Brand check availability      | Auto product check availability | Auto SKU availability 1 | 30901 | Auto product check availability2 | [blank]    | [blank]  | 1    |
#    And Admin get inventory requests number in detail
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+autovendor29@podfoods.co" pass "12345678a" role "vendor"
#    Given VENDOR Navigate to "Inventory" by sidebar
#    And Vendor go to dispose donate inventory page
#    And Vendor go to tab "Submitted" in dispose donate inventory page
#    And Vendor verify inventory request
#      | number | requestDate | type     | case | status    |
#      | random | currentDate | Disposal | 2    | Submitted |
#    And Vendor go to detail inventory request "create by admin"
#    Then Vendor verify information of request dispose detail
#      | status    | type                           | region              | comment      |
#      | Submitted | Dispose of Inventory / Destroy | Chicagoland Express | Auto comment |
#    And Vendor verify detail inventory of request dispose detail
#      | index | brand                              | product                         | sku                     | skuID | lotCode | expiryDate | pullDate | ofCase | max |
#      | 1     | Auto Brand low quantity thresshold | Auto Product create subtraction | Auto SKU subtrction     | 31138 | random  | -          | [blank]  | 1      | 20  |
#      | 1     | Auto Brand check availability      | Auto product check availability | Auto SKU availability 1 | 30901 | random  | -          | [blank]  | 1      | 1   |
#
#    Given USER_LP open web LP
#    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
#    And USER_LP Navigate to "Inventory" by sidebar
#    And LP search "All" inventory
#      | sku                 | product | vendorCompany | vendorBrand |
#      | Auto SKU subtrction | [blank] | [blank]       | [blank]     |
#    And Check search result in All inventory
#      | index | sku                 | distributionCenter         | vendorCompany       | lotCode     | currentQuantity | originalQuantity | received | expiry  |
#      | 1     | Auto SKU subtrction | Auto Ngoc Distribution CHI | Auto vendor company | randomIndex | 20              | 20               | [blank]  | [blank] |
#
#  @Inventory32 @Inventory
#  Scenario: Create new addition item
#    Given NGOCTX03 login web admin by api
#      | email                | password  |
#      | ngoctx03@podfoods.co | 12345678a |
#    When Admin get ID SKU by name "AT SKU Inventory 13" from product id "6059" by API
#    # Delete order
#    When Search order by sku "" by api
#    And Admin delete order of sku "" by api
#    # Delete inventory
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]     | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
#      | AT SKU Inventory 13     | Auto Ngoc Inventory | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
#    And Admin get list ID inventory by sku "AT SKU Inventory 13" from API
#    And Admin delete inventory "all" by API
#     # Create inventory
#    And Admin create inventory api1
#      | index | sku                 | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU Inventory 13 | 31071              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
#
#    Given NGOC_ADMIN_03 open web admin
#    When NGOC_ADMIN_03 login to web with role Admin
#    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
#    And Admin search inventory
#      | skuName             | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
#      | AT SKU Inventory 13 | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
#    And Admin see detail inventory with lotcode
#      | index | skuName             | lotCode |
#      | 1     | AT SKU Inventory 13 | random  |
#    And Admin create addition items
#      | quantity | category    | comment  |
#      | 1        | Cycle count | Autotest |
#    And Verify subtraction item on inventory
#      | quantity | category    | description          | date        | order   | comment  |
#      | 1        | Cycle count | Created by ngoctx03. | currentDate | [blank] | Autotest |
#    Then Verify inventory detail
#      | product             | sku                 | createdBy | region              | distributionCenter            | receiveDate | expireDate | pullDate | lotCode | originalQty | currentQty | endQty |
#      | Auto Ngoc Inventory | AT SKU Inventory 13 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | currentDate | [blank]    | [blank]  | random  | 10          | 11         | 11     |
#    And NGOC_ADMIN_03 navigate to "Inventories" to "All inventory" by sidebar
#    And Admin search inventory
#      | skuName             | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
#      | AT SKU Inventory 13 | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
#    Then Verify result inventory
#      | index | productName         | skuName             | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
#      | 1     | Auto Ngoc Inventory | AT SKU Inventory 13 | randomIndex | 10               | 11              | 11       | 0            | currentDate | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | [blank]       | CHI    | Admin     |
#
#    And NGOC_ADMIN_03 navigate to "Inventories" to "Inventory status" by sidebar
#    And Admin search inventory status
#      | anyText | skuName             | productName | vendorCompany | vendorBrand | region              |
#      | [blank] | AT SKU Inventory 13 | [blank]     | [blank]       | [blank]     | Chicagoland Express |
#    Then Verify result inventory status
#      | sku                 | brand                 | product             | receivedQuantity | fulfilledQuantity | currentquantity | pendingQuantity | insufficientQuantity | endQuantity | status                |
#      | AT SKU Inventory 13 | AT Brand Inventory 01 | Auto Ngoc Inventory | 10               | 1                 | 11              | 0               | 0                    | 11          | 11 cases in inventory |
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Vendor go to "All Inventory" tab
#    And Vendor search All Inventory "All regions"
#      | skuName             | zeroQuantity | orderBy                 |
#      | AT SKU Inventory 13 | No           | Received - Latest first |
#    Then Vendor verify result in All Inventory
#      | productName         | skuName             | lotCode | receivedQty | received    | currentQty | pulledQty | endQty | expiryDate | pullDate |
#      | Auto Ngoc Inventory | AT SKU Inventory 13 | random  | 1           | currentDate | 1          | 0         | 1      | N/A        | N/A      |
#
#    Given LP open web LP
#    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
#    And LP Navigate to "Inventory" by sidebar
#    And Lp go to All inventory tab
#    And LP search "All" inventory
#      | sku    | product | vendorCompany | vendorBrand |
#      | random | [blank] | [blank]       | [blank]     |
#    And Check search result in All inventory
#      | index | sku    | distributionCenter         | vendorCompany       | lotCode | currentQuantity | originalQuantity | received | expiry  |
#      | 1     | random | Auto Ngoc Distribution CHI | Auto vendor company | random  | 1               | 1                | [blank]  | [blank] |
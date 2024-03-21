#mvn clean verify -Dtestsuite="FlowInboundTestSuite" -Dcucumber.options="src/test/resources/features"
@feature=inbound-flow
Feature: Inbound flow

  Narrative:
  Auto test admin inbound

  @Inbound_01 @Inbound
  Scenario: Admin Create An Inbound With Status of SKU 01
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx201@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 01 | 10     |
    And Confirm Create Incoming inventory
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Requested |
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And Vendor go to "Requested"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Requested | Chicagoland Express | [blank]        | [blank]       | 0         | [blank]          | [blank]  | [blank]             | [blank]     | [blank] |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search "" and check No found Inbound inventory
    And USER_LP quit browser

  @Inbound_05 @Inbound
  Scenario: Admin Processes An Approved Inbound Inventory Story - Do not select Warehouse
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx203@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 05 | 10     |
    And Confirm Create Incoming inventory

    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | [blank]       | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 05 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "don't choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin process incoming inventory error
    And NGOC_ADMIN_02 quit browser

  @Inbound_04 @Inbound
  Scenario: Admin Processes An Approved Inbound Inventory Story - Select Warehouse
    Given NGOCTX12 login web admin by api
      | email                 | password  |
      | ngoctx202@podfoods.co | 12345678a |
    # Active product and sku
    And Admin change info of regions attributes with sku "active"
      | id    | region_id | product_variant_id | case_price_cents | msrp_cents | availability | state  | inventory_receiving_date |
      | 82978 | 26        | 30976              | 10000            | 10000      | in_stock     | active | [blank]                  |

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx202@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 04 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 04 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | storageShelfLife | temperature | badge   | suggestedCase | damagedCase | excessCase | shortedCase | receivedCase |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 04 | [blank]    | 10        | [blank]       | [blank]          | 1                | 1.0 - 1.0   | [blank] | 10            | 0           | 0          | 0           | [blank]      |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin process incoming inventory
    And NGOC_ADMIN_02 quit browser

  @Inbound_02 @Inbound
  Scenario: Admin Create An Inbound With Status of SKU 02
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx235@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 02 | 10     |
    And Confirm Create Incoming inventory
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Requested |
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And Vendor go to "Requested"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Requested | Chicagoland Express | [blank]        | [blank]       | 0         | [blank]          | [blank]  | [blank]             | [blank]     | [blank] |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search "" and check No found Inbound inventory
    And USER_LP quit browser

  @Inbound_03 @Inbound
  Scenario: Admin Create An Inbound With Status of SKU 03
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx236@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 03 | 10     |
    And Confirm Create Incoming inventory
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Requested |
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And Vendor go to "Requested"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Requested | Chicagoland Express | [blank]        | [blank]       | 0         | [blank]          | [blank]  | [blank]             | [blank]     | [blank] |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search "" and check No found Inbound inventory
    And USER_LP quit browser

  @Inbound_06 @Inbound
  Scenario: Buyer Checkout After Admin Process An Inbound Inventory Story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx204@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 06       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 06" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx204@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 06 | 10     |
    And Confirm Create Incoming inventory
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | [blank]       | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 06 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin verify inbound inventory images
    And Admin update inbound inventory images
      | index | image      | description |
      | 1     | anhPNG.png | Autotest_1  |
      | 2     | anhPNG.png | Autotest_2  |
      | 3     | anhPNG.png | Autotest_3  |
      | 4     | anhPNG.png | Autotest_4  |
      | 5     | anhPNG.png | Autotest_5  |
      | 6     | anhPNG.png | Autotest_6  |
      | 7     | anhPNG.png | Autotest_7  |
      | 8     | anhPNG.png | Autotest_8  |
      | 9     | anhPNG.png | Autotest_9  |
      | 10    | anhPNG.png | Autotest_10 |
    And Admin save inbound inventory images success

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search Inbound inventory
      | number           | brand   | start   | end     | deliveryMethod |
      | create by vendor | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number  | brand                 | eta     | pallets | cases | freightCarrier | status    |
      | [blank] | AutoTest Brand Ngoc01 | [blank] | 1       | 1     | [blank]        | Confirmed |
    And LP go to Inbound inventory detail of number ""
    And LP verify inbound inventory images
      | index | image       |
      | 1     | Autotest_1  |
      | 2     | Autotest_2  |
      | 3     | Autotest_3  |
      | 4     | Autotest_4  |
      | 5     | Autotest_5  |
      | 6     | Autotest_6  |
      | 7     | Autotest_7  |
      | 8     | Autotest_8  |
      | 9     | Autotest_9  |
      | 10    | Autotest_10 |

    And Switch to actor NGOC_ADMIN_02
    And Admin process incoming inventory

    And NGOC_ADMIN_02 refresh browser
    And NGOC_ADMIN_02 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT Sku inbound 06 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName       | skuName           | lotCode       | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inbound | AT Sku inbound 06 | randomInbound | 10               | 10              | 10       | 0            | currentDate | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | [blank]       | CHI    | Admin     |
    And NGOC_ADMIN_02 quit browser
    And USER_LP quit browser

  @Inbound_06a @Inbound
  Scenario: Admin Processes An Received Inbound Inventory Story - Select Lot code, Warehouse
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx205@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 45       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 45" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx205@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 45 | 10     |
    And Confirm Create Incoming inventory
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | [blank]       | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 45 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin wait 2000 mini seconds
    And NGOC_ADMIN_02 refresh browser
    And Admin upload file to inbound
      | bol     | pod     |
      | BOL.pdf | POD.pdf |
    And Admin choose "Cancel" mark inbound as received
    And Admin choose "OK" mark inbound as received
    And Admin process incoming inventory

    And NGOC_ADMIN_02 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT Sku inbound 45 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName       | skuName           | lotCode       | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate  | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inbound | AT Sku inbound 45 | randomInbound | 10               | 10              | 10       | 0            | currentDate | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | [blank]       | CHI    | Admin     |
    And NGOC_ADMIN_02 quit browser

  @Inbound_06b @Inbound
  Scenario: Admin mark as Received for Approved inbound inventory
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx206@podfoods.co | 12345678a |
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name] | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 46       | [blank]         | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 06" from API
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx206@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 46 | 10     |
    And Confirm Create Incoming inventory
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | [blank]       | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 46 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And NGOC_ADMIN_02 wait 2000 mini seconds
    And NGOC_ADMIN_02 refresh browser
    And Admin upload file to inbound
      | bol     | pod     |
      | BOL.pdf | POD.pdf |
    And Admin choose "Cancel" mark inbound as received
    And Admin choose "OK" mark inbound as received
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status   | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | Received | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status   |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Received |

    And NGOC_ADMIN_02 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName           | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | AT Sku inbound 46 | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    Then Admin no found order in result
    And NGOC_ADMIN_02 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to Inbound inventory tab
    And Search Inbound inventory
      | number           | brand   | start   | end     | deliveryMethod |
      | create by vendor | [blank] | [blank] | [blank] | [blank]        |
    And LP Check list of Inbound inventory
      | number  | brand                 | eta     | pallets | cases | freightCarrier | status   |
      | [blank] | AutoTest Brand Ngoc01 | [blank] | 1       | 10    | [blank]        | Received |
    And LP go to Inbound inventory detail of number ""
    And LP verify error inbound inventory images
    And LP upload inbound inventory images
      | index | image      | description |
      | 1     | anhPNG.png | Autotest_1  |
    And USER_LP quit browser

#  @Inbound_07 @Inbound
#  Scenario: The Stock Availability Of Sku Will Be In Stock If Admin Process Inbound Story - Processed 1 Lot code
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
#      | Brand Self Delivery | 05/05/23             | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
#    And Add SKU to inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 07 | 10        | random         | 05/05/23   |
#    And Confirm create inbound inventory
#
#    Given NGOC_ADMIN_02 open web admin
#    When NGOC_ADMIN_02 login to web with role Admin
#    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
#    And Admin search incoming inventory
#      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
#      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
#    And Go to detail of incoming inventory number ""
#    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
#    And Admin process incoming inventory

#  @Inbound_08 @Inbound
#  Scenario: The Stock Availability Of Sku Will Be In Stock If Admin Process Inbound Story - Processed 2 Lot code with the same SKU
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
#      | Brand Self Delivery | 05/05/23             | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
#    And Add SKU to inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 07 | 10        | random         | 05/05/23   |
#      | 2     | AT Sku inbound 07 | 20        | random         | 06/05/23   |
#    And Confirm create inbound inventory
#
#    Given NGOC_ADMIN_02 open web admin
#    When NGOC_ADMIN_02 login to web with role Admin
#    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
#    And Admin search incoming inventory
#      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
#      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
#    And Go to detail of incoming inventory number ""
#    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
#    And Admin process incoming inventory

#  @Inbound_09 @Inbound_10 @Inbound_11 @Inbound
#  Scenario Outline: Vendor Create An Inbound Inventory For A Coming Soon Sku Story
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod      | estimatedDateArrival | ofPallets   | ofSellableRetail   | ofMasterCarton   | ofSellableRetailPerCarton   | trackingNumber | totalWeight   | zipCode |
#      | Brand Self Delivery | 05/05/23             | <ofPallets> | <ofSellableRetail> | <ofMasterCarton> | <ofSellableRetailPerCarton> | [blank]        | <totalWeight> | 11111   |
#    And Vendor input info optional of inbound inventory
#      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL     | transportName     | transportPhone |
#      | 1             | 1              | [blank]        | 1               | 1             | 1    | Yes           | Yes             | anhJPEG.jpg | AT Transport Name | 0123456789     |
#    And Add SKU to inbound inventory
#      | index | sku   | caseOfSku | productLotCode | expiryDate |
#      | 1     | <sku> | 10        | random         | 06/30/23   |
#    And Confirm create inbound inventory
#
#    Given NGOC_ADMIN_02 open web admin
#    When NGOC_ADMIN_02 login to web with role Admin
#    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
#    And Admin search incoming inventory
#      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
#      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
#    And Verify table result Incoming inventory
#      | number  | vendorCompany | brand                 | region              | eta      | status    |
#      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | 05/05/23 | Confirmed |
#    And Go to detail of incoming inventory number ""
#    And Admin check General Information of Incoming inventory
#      | region              | deliveryMethod      | vendorCompany | status    | warehouse | eta      | ofPallet    | ofMasterCarton     | ofSellableRetail | ofSellableRetailPerCarton   | zipCode | trackingNumber |
#      | Chicagoland Express | Brand Self Delivery | ngoc vc 1     | Confirmed | N/A       | 05/05/23 | <ofPallets> | <ofSellableRetail> | <ofMasterCarton> | <ofSellableRetailPerCarton> | 11111   | [blank]        |
#    And Check SKUs Information of Incoming inventory
#      | index | brandSKU              | productSKU        | nameSKU | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   | storageShelfLife | temperature |
#      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | <sku>   | randomInbound | 10        | 06/30/23      | 05/05/23         | [blank] | 1                | 1.0 - 1.0   |
#
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And VENDOR Search and check Send Inventory
#      | reference | region              | eta      | status    |
#      | [blank]   | Chicagoland Express | 05/05/23 | Confirmed |
#    And Vendor go to "Confirmed"
#    And VENDOR Search and check Send Inventory
#      | reference | region              | eta      | status    |
#      | [blank]   | Chicagoland Express | 05/05/23 | Confirmed |
#    And Vendor check detail of Inbound inventory
#      | status    | region              | deliveryMethod      | estimatedDate | ofPallets   | ofSellableRetail   | ofMaster         | ofSellableRetailPer         | totalWeight   | zipcode |
#      | Confirmed | Chicagoland Express | Brand Self Delivery | 05/05/23      | <ofPallets> | <ofSellableRetail> | <ofMasterCarton> | <ofSellableRetailPerCarton> | <totalWeight> | 11111   |
#
#    Given USER_LP open web LP
#    When login to beta web with email "ngoctx+autolpwarehousing@podfoods.co" pass "12345678a" role "LP"
#    And USER_LP Navigate to "Inventory" by sidebar
#    And Lp go to Inbound inventory tab
#    And Search "" and check No found Inbound inventory
#    And LP log out
#    Examples:
#      | sku               | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | totalWeight |
#      | AT Sku inbound 09 | 1         | 1                | 1              | 1                         | 1           |
#      | AT Sku inbound 10 | 0         | 0                | 0              | 0                         | 1           |
#      | AT Sku inbound 11 | 1         | 1                | 1              | 1                         | 1           |

  @Inbound_12 @Inbound
  Scenario: Vendor Review Inbound Inventory And Make A Counter Suggestion Story
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx207@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 12 | 10     |
    And Confirm Create Incoming inventory

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Requested"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And VENDOR Go to detail of inbound inventory have number: ""
    And Vendor input info of inbound inventory
      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
      | Brand Self Delivery | 05/05/23             | 1         | 1                | 1              | 1                         | [blank]        | 1           | 11111   |
#    And Add SKU to inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 12 | 10        | random         | 06/30/23   |
#    And Edit info SKU of inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 12 | 10        | random         | 06/29/23   |
#      | 2     | AT Sku inbound 12 | 20        | random         | 06/30/23   |
#    And Vendor update request inbound inventory
#    And Vendor save lotcode of inbound inventory
#      | index | sku               |
#      | 1     | AT Sku inbound 12 |
#      | 2     | AT Sku inbound 12 |
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And VENDOR Search and check Send Inventory
#      | reference | region              | eta      | status    |
#      | [blank]   | Chicagoland Express | 05/05/23 | Confirmed |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

#  @Inbound_13 @Inbound
#  Scenario: Vendor create/edit an inbound inventory with invalid value
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Vendor verify form create inbound inventory empty
#    And VENDOR quit browser

  @Inbound_14 @Inbound
  Scenario: Admin Create A Confirmed Inbound Inventory Story - With Expiration Date is more than or equal 75% Total shelf life
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx208@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note          | adminNote           |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 8        | 5             | Autotest note | Autotest admin note |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 14 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 14 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus75          | currentDate   | 10     | [blank] |
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod      | vendorCompany | status    | warehouse                     | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode |
      | Chicagoland Express | Brand Self Delivery | ngoc vc 1     | Confirmed | Auto Ngoc Distribution CHI 01 | currentDate | 1        | N/A            | 10               | 1                         | 60005   |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 14 | randomInbound | 10        | Plus75        | currentDate      | [blank] |
    And NGOC_ADMIN_02 quit browser

  @Inbound_15 @Inbound
  Scenario: Admin Create A Confirmed Inbound Inventory Story - With Expiration Date is less than 75% Total shelf life
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx209@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note          | adminNote           |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 8        | 5             | Autotest note | Autotest admin note |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 15 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 15 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod      | vendorCompany | status    | warehouse                     | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode |
      | Chicagoland Express | Brand Self Delivery | ngoc vc 1     | Confirmed | Auto Ngoc Distribution CHI 01 | currentDate | 1        | N/A            | 10               | 1                         | 60005   |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge     |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 15 | randomInbound | 10        | Plus1         | currentDate      | Below 75% |
    And NGOC_ADMIN_02 quit browser

  @Inbound_16 @Inbound
  Scenario: Admin Add More A SKU For A Confirmed Inbound Inventory Story (add multiple different SKUs)
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx210@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note          | adminNote           |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | 1             | Autotest note | Autotest admin note |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 16 | 10     |
    And Confirm Create Incoming inventory
    And Admin add sku into incoming inventory then update request
      | index | sku                 | ofCase |
      | 1     | AT Sku inbound 16.1 | 10     |
    And Click on button "Update Request"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany | status    | warehouse                     | eta     | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode | trackingNumber |
      | Chicagoland Express | [blank]        | ngoc vc 1     | Requested | Auto Ngoc Distribution CHI 01 | [blank] | 1        | N/A            | 20               | -                         | -       | -              |
    And NGOC_ADMIN_02 wait 2000 mini seconds
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU             | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 16   | [blank]    | 10        | [blank]       | [blank]          | [blank] |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 16.1 | [blank]    | 10        | [blank]       | [blank]          | [blank] |
    And NGOC_ADMIN_02 quit browser

  @Inbound_17 @Inbound
  Scenario: Admin Add More A SKU For A Confirmed Inbound Inventory Story (add the same SKU more than once)
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx211@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note          | adminNote           |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | 1             | Autotest note | Autotest admin note |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 17 | 10     |
    And Confirm Create Incoming inventory
    And Admin add sku into incoming inventory then update request
      | index | sku               | ofCase |
      | 2     | AT Sku inbound 17 | 10     |
    And Click on button "Update Request"
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany | status    | warehouse                     | eta     | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode | trackingNumber |
      | Chicagoland Express | [blank]        | ngoc vc 1     | Requested | Auto Ngoc Distribution CHI 01 | [blank] | 1        | N/A            | 20               | -                         | -       | -              |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 17 | [blank]    | 10        | [blank]       | [blank]          | [blank] |
      | 2     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 17 | [blank]    | 10        | [blank]       | [blank]          | [blank] |
    And NGOC_ADMIN_02 quit browser

  @Inbound_18 @Inbound
  Scenario: Admin Approve A Confirmed Inbound Inventory Story
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx212@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 18 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 18 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Brand Self Delivery | currentDate   | 1         | 1                | [blank]  | 1                   | 1           | 60005   |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                 | product           | sku               | ofCases | lotCode | expiryDate  |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 18 | 10      | random  | currentDate |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And LP search "All" inventory
      | sku               | product | vendorCompany | vendorBrand |
      | AT Sku inbound 18 | [blank] | [blank]       | [blank]     |
    And LP check no found inventory
    And USER_LP quit browser

  @Inbound_19 @Inbound
  Scenario: Admin Create An Inbound Inventory With Multiple SKU Story (multiple diffirent SKU)
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx213@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku                 | ofCase |
      | AT Sku inbound 19   | 10     |
      | AT Sku inbound 19.1 | 10     |
    And Confirm Create Incoming inventory

    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Requested |
    And Go to detail of incoming inventory number ""
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany | status    | warehouse                     | eta     | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode |
      | Chicagoland Express | [blank]        | ngoc vc 1     | Requested | Auto Ngoc Distribution CHI 01 | [blank] | 1        | N/A            | 20               | -                         | [blank] |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU             | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 19.1 | [blank]    | 10        | [blank]       | [blank]          | [blank] |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 19   | [blank]    | 10        | [blank]       | [blank]          | [blank] |
    And NGOC_ADMIN_02 quit browser

  @Inbound_20 @Inbound
  Scenario: Admin Create An Inbound Inventory With Multiple SKU Story (the same SKU more than once)
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx214@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory

    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Requested |
    And Go to detail of incoming inventory number ""
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod | vendorCompany | status    | warehouse                     | eta     | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode |
      | Chicagoland Express | [blank]        | ngoc vc 1     | Requested | Auto Ngoc Distribution CHI 01 | [blank] | 1        | N/A            | 20               | -                         | [blank] |
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 20 | [blank]    | 10        | [blank]       | [blank]          | [blank] |
      | 2     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 20 | [blank]    | 10        | [blank]       | [blank]          | [blank] |
    And NGOC_ADMIN_02 quit browser

  @Inbound_21 @Inbound
  Scenario: Admin Delete A Requested Inbound Inventory Story - On Incoming inventoriest list page
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx215@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory

    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Requested |
    And Admin cancel incoming inventory in result
      | order   | note     |
      | [blank] | AutoTest |
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status   |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Canceled |
    And NGOC_ADMIN_02 quit browser

  @Inbound_22 @Inbound
  Scenario: Admin Delete A Requested Inbound Inventory Story - On Incoming inventoriest detail page
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx216@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory
    And Admin cancel incoming inventory in detail with note ""
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status   |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Canceled |
    And NGOC_ADMIN_02 quit browser

  @Inbound_23 @Inbound
  Scenario: Admin Delete A Confirmed Inbound Inventory Story - On Incoming inventoriest list page
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx217@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 20 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Confirmed |
    And Admin cancel incoming inventory in result
      | order   | note     |
      | [blank] | AutoTest |
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status   |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Canceled |
    And NGOC_ADMIN_02 quit browser

  @Inbound_24 @Inbound
  Scenario: Admin Delete A Confirmed Inbound Inventory Story - On Incoming inventoriest detail page
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx218@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 20 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin cancel incoming inventory in detail with note ""
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status   |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Canceled |
    And NGOC_ADMIN_02 quit browser

  @Inbound_25 @Inbound
  Scenario: Admin Delete An Approved Inbound Inventory Story - On Incoming inventoriest list page
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx219@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 20 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status    |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Confirmed |
    And Admin cancel incoming inventory in result
      | order   | note     |
      | [blank] | AutoTest |
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Verify table result Incoming inventory
      | number  | vendorCompany | brand                 | region              | eta     | status   |
      | [blank] | ngoc vc 1     | AutoTest Brand Ngoc01 | Chicagoland Express | [blank] | Canceled |
    And NGOC_ADMIN_02 quit browser

  @Inbound_26 @Inbound
  Scenario: Admin Delete An Approved Inbound Inventory Story - On Incoming inventoriest detail page
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx220@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 20 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin cancel incoming inventory in detail with note ""
    And NGOC_ADMIN_02 quit browser

  @Inbound_27 @Inbound
  Scenario: Admin Edit General Information Of A Confirmed Inbound Inventory Story
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx221@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 20 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin edit general information of incoming inventory
      | region           | deliveryMethod      | estimatedDate | estimatedWeek | ofPallets | ofSellable | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol         |
      | New York Express | Brand Self Delivery | Minus1        | 1             | 20        | 50         | 0              | 0          | Yes     | Yes       | 2           | 11111   | ABC  | XYZ       | 8789564 | 24235   | 5243524  | 09678           | Strange       | 0948374658     | anhJPEG.jpg |
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region           | eta    | status    |
      | [blank]   | New York Express | Minus1 | Confirmed |
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region           | eta    | status    |
      | [blank]   | New York Express | Minus1 | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region           | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | New York Express | Brand Self Delivery | Minus1        | 20        | 0                | [blank]  | 0                   | 2           | 1111    |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note |
      | 8789564 | 24235   | 09678     | 1             | ABC  |
    And VENDOR quit browser

  @Inbound_28 @Inbound
  Scenario: Admin Edit General Information Of An Approved Inbound Inventory Story
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx222@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 20 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 20 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | currentDate     | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin edit general information of incoming inventory
      | region           | deliveryMethod      | estimatedDate | estimatedWeek | ofPallets | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol         |
      | New York Express | Brand Self Delivery | Minus1        | 1             | 20        | 0              | 0          | Yes     | Yes       | 2           | 11111   | ABC  | XYZ       | 8789564 | 24235   | 5243524  | 09678           | Strange       | 0948374658     | anhJPEG.jpg |
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And VENDOR Search and check Send Inventory
      | reference | region           | eta    | status    |
      | [blank]   | New York Express | Minus1 | Confirmed |
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region           | eta    | status    |
      | [blank]   | New York Express | Minus1 | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region           | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | New York Express | Brand Self Delivery | Minus1        | 20        | 0                | [blank]  | 0                   | 2           | 1111    |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note |
      | 8789564 | 24235   | 09678     | 1             | ABC  |
    And VENDOR quit browser

  @Inbound_29 @Inbound
  Scenario: Admin Edit Information Of SKU In A Confirmed Inbound Inventory Story: - Edit to Expiration date is less than 75% total shelf life
    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx223@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 29 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 29 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus75          | currentDate   | 10     | [blank] |
    And Admin edit sku information
      | index | skuName           | lotcode       | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note    |
      | 1     | AT Sku inbound 29 | randomInbound | tomorrow    | 20      | tomorrow      | [blank]       | [blank]     | [blank]    | [blank]     | [blank]      | [blank] |
    And Admin save record Confirmed after change
    Then Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge     |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 29 | randomInbound | 20        | tomorrow      | tomorrow         | Below 75% |
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Brand Self Delivery | currentDate   | 1         | 1                | [blank]  | 20                  | 1           | 60005   |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                 | product           | sku               | ofCases | lotCode | expiryDate |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 29 | 20      | random  | tomorrow   |
    And VENDOR quit browser

  @Inbound_30 @Inbound
  Scenario: Admin Edit SKU Information Of An Approved Inbound Lot Story - Edit to Expiration date is more than or equal 75% total shelf life
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx224@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 30" from product id "6335" by API
    # Delete order
    When Search order by sku "31003" by api
    And Admin delete order of sku "31003" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 30       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 30" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx224@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 30 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 30 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin edit sku information
      | index | skuName           | lotcode       | expiredDate | ofCases | receivingDate | suggestedCase | damagedCase | excessCase | shortedCase | caseReceived | note    |
      | 1     | AT Sku inbound 30 | randomInbound | Plus75      | 20      | tomorrow      | [blank]       | [blank]     | [blank]    | [blank]     | [blank]      | [blank] |
    And Admin save record Confirmed after change
    Then Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 30 | randomInbound | 20        | Plus75        | tomorrow         | [blank] |
    And NGOC_ADMIN_02 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region              | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Chicagoland Express | Brand Self Delivery | currentDate   | 1         | 1                | [blank]  | 20                  | 1           | 60005   |
    And Vendor check detail of SKU in Inbound inventory
      | index | brand                 | product           | sku               | ofCases | lotCode | expiryDate |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 30 | 20      | random  | Plus75     |
    And VENDOR quit browser

  @Inbound_31 @Inbound
  Scenario: Admin Edit Some Values Of A Lot Story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx224@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 31" from product id "6335" by API
    # Delete order
    When Search order by sku "31016" by api
    And Admin delete order of sku "31016" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 31       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 31" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx224@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 31 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 31 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin process incoming inventory
    And NGOC_ADMIN_02 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName           | productName       | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT Sku inbound 31 | Auto Ngoc Inbound | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName       | skuName           | lotCode       | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Inbound | AT Sku inbound 31 | randomInbound | 10               | 10              | 10       | 0            | Plus1      | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName           | lotCode       |
      | 1     | AT Sku inbound 31 | randomInbound |
    And Admin edit general information of inventory
      | index | skuName           | receiveDate | expireDate | lotCode       |
      | 1     | AT Sku inbound 31 | Plus1       | Plus1      | randomInbound |
    And Admin create subtraction items
      | quantity | category | subCategory | comment  |
      | 1        | Donated  | [blank]     | AutoTest |
    And Verify subtraction item on inventory
      | quantity | category | description           | date        | order   | comment  |
      | 1        | Donated  | Created by ngoctx224. | currentDate | [blank] | AutoTest |
    And Verify inventory detail
      | index | product           | sku               | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode       | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Inbound | AT Sku inbound 31 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | Plus1       | Plus1      | [blank]  | randomInbound | 10          | 9          | 9      |
    And NGOC_ADMIN_02 quit browser

  @Inbound_32 @Inbound
  Scenario: Admin Edit Confirmed Inbound Which Reviewed By Vendor Story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx225@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 32" from product id "6335" by API
    # Delete order
    When Search order by sku "31031" by api
    And Admin delete order of sku "31031" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 32       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 32" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx225@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 32 | 10     |
    And Confirm Create Incoming inventory

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Requested"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta | status    |
      | [blank]   | Chicagoland Express | -   | Requested |
    And VENDOR Go to detail of inbound inventory have number: ""
    And Vendor input info of inbound inventory
      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
    And Edit info SKU of inbound inventory
      | index | sku               | caseOfSku | productLotCode | expiryDate |
      | 1     | AT Sku inbound 32 | 10        | random         | Plus1      |
    And Vendor update request inbound inventory
    And Vendor save lotcode of inbound inventory
      | index | sku               |
      | 1     | AT Sku inbound 32 |

    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin edit general information of incoming inventory
      | region           | deliveryMethod      | estimatedDate | estimatedWeek | ofPallets | ofMasterCarton | ofSellAble | transit | warehouse | totalWeight | zipcode | note | adminNote | other   | freight | tracking | referenceNumber | transportName | transportPhone | bol     |
      | New York Express | Brand Self Delivery | [blank]       | 1             | 20        | [blank]        | [blank]    | [blank] | [blank]   | [blank]     | [blank] | ABC  | XYZ       | 8789564 | 24235   | [blank]  | 09678           | [blank]       | [blank]        | BOL.pdf |


    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region           | eta         | status    |
      | [blank]   | New York Express | currentDate | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region           | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | New York Express | Brand Self Delivery | currentDate   | 20        | 1                | [blank]  | 0                   | 1           | 1111    |
    And Vendor check detail info optional of Inbound inventory
      | other   | freight | reference | estimatedWeek | note | fileBOL |
      | 8789564 | 24235   | 09678     | 1             | ABC  | BOL.pdf |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  @Inbound_33 @Inbound
  Scenario: Admin edit vendor company in an inbound inventory story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx226@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 32" from product id "6335" by API
    # Delete order
    When Search order by sku "31031" by api
    And Admin delete order of sku "31031" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 32       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 32" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx226@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 32 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 32 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And Admin change "vendor company" to "ngoc vc2" of incoming inventory
    Then Admin verify no sku in sku information of incoming inventory

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR search inbound inventory
      | region              | startDate | endDate |
      | Chicagoland Express | [blank]   | [blank] |
    Then Vendor verify no found inbound inventory ""
    Given VENDOR open web user
    When login to beta web with email "ngoctx+v21@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  @Inbound_34 @Inbound
  Scenario: Admin edit region in an inbound inventory story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx227@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 32" from product id "6335" by API
    # Delete order
    When Search order by sku "31031" by api
    And Admin delete order of sku "31031" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 32       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 32" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx227@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 32 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 32 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And Admin change "region" to "New York Express" of incoming inventory
    Then Admin verify no sku in sku information of incoming inventory

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region           | eta         | status    |
      | [blank]   | New York Express | currentDate | Confirmed |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  @Inbound_35 @Inbound
  Scenario: Admin edit warehouse of an approved inbound lot story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx228@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 32" from product id "6335" by API
    # Delete order
    When Search order by sku "31031" by api
    And Admin delete order of sku "31031" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 32       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 32" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx228@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 32 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 32 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
#    And Admin change region to "Texas Express" of incoming inventory
    And Admin change region to "Dallas Express" of incoming inventory
    And Admin change "warehouse" to "Auto Ngoc Distribution TX 01" of incoming inventory

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region         | eta         | status    |
      | [blank]   | Dallas Express | currentDate | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region         | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Dallas Express | Brand Self Delivery | currentDate   | 1         | 1                | [blank]  | 0                   | 1           | 60005   |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  @Inbound_36 @Inbound
  Scenario: Admin edit warehouse of an approved inbound lot story 1
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx229@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 32" from product id "6335" by API
    # Delete order
    When Search order by sku "31031" by api
    And Admin delete order of sku "31031" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 32       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 32" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx229@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 32 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 32 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"
    And Admin change region to "Dallas Express" of incoming inventory
    And Admin change "warehouse" to "Auto Ngoc Distribution TX 01" of incoming inventory

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region         | eta         | status    |
      | [blank]   | Dallas Express | currentDate | Confirmed |
    And Vendor go to detail of inbound inventory ""
    And Vendor check detail of Inbound inventory
      | status    | region         | deliveryMethod      | estimatedDate | ofPallets | ofSellableRetail | ofMaster | ofSellableRetailPer | totalWeight | zipcode |
      | Confirmed | Dallas Express | Brand Self Delivery | currentDate   | 1         | 1                | [blank]  | 0                   | 1           | 60005   |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  # vendor không cho nhập of case cho sku add
  @Inbound_37 @Inbound
  Scenario: Vendor Add New An SKU Into An Exist Inbound Inventory Story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx230@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 37" from product id "6335" by API
    # Delete order
    When Search order by sku "31043" by api
    And Admin delete order of sku "31043" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 37       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 37" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx230@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 37 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 37 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | currentDate   | 10     | [blank] |
    And NGOC_ADMIN_02 quit browser

#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to "Confirmed"
#    And VENDOR Search and check Send Inventory
#      | reference | region              | eta         | status    |
#      | [blank]   | Chicagoland Express | currentDate | Confirmed |
#    And VENDOR Go to detail of inbound inventory have number: ""
#    And Add SKU to inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 32 | 10        | random         | Plus1      |
#    And Edit info SKU of inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 37 | 10        | random         | Plus1      |
#      | 1     | AT Sku inbound 32 | 10        | random         | Plus2      |
#    And Vendor update request inbound inventory
#    And Vendor save lotcode of inbound inventory
#      | index | sku               |
#      | 1     | AT Sku inbound 32 |
#      | 1     | AT Sku inbound 37 |
#    And Vendor check detail of SKU in Inbound inventory
#      | index | brand                 | product           | sku               | ofCases | lotCode | expiryDate |
#      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 32 | 10      | random  | Plus2      |
#      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 37 | 10      | random  | Plus1      |

#  @Inbound_38 @Inbound
#  Scenario: Vendor Add An Exist SKU Into An Exist Inbound Inventory Story (the same SKU more than once)
#    Given NGOCTX02 login web admin by api
#      | email                | password  |
#      | ngoctx02@podfoods.co | 12345678a |
#    When Admin get ID SKU by name "AT Sku inbound 38" from product id "6335" by API
#    # Delete order
#    When Search order by sku "31046" by api
#    And Admin delete order of sku "31046" by api
#    # Delete inventory
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | AT Sku inbound 38       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get list ID inventory by sku "AT Sku inbound 38" from API
#    And Admin delete all subtraction of list inventory
#    And Admin delete inventory "all" by API
#
#    Given NGOC_ADMIN_02 open web admin
#    When NGOC_ADMIN_02 login to web with role Admin
#    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
#    And Admin create new incoming inventory
#      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
#      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 1                | 1        | [blank]       | [blank] | [blank]   |
#    And With SKUs
#      | sku               | ofCase |
#      | AT Sku inbound 38 | 10     |
#    And Confirm Create Incoming inventory
#    And Admin submit incoming inventory
#      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
#      | 1     | AT Sku inbound 38 | Brand Self Delivery | currentDate | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1          | currentDate   | 10     | [blank] |
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to "Confirmed"
#    And VENDOR Search and check Send Inventory
#      | reference | region              | eta         | status    |
#      | [blank]   | Chicagoland Express | currentDate | Confirmed |
#    And VENDOR Go to detail of inbound inventory have number: ""
#    And Add SKU to inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 38 | 10        | random         | Plus1      |
#    And Edit info SKU of inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 38 | 10        | random         | Plus1      |
#      | 2     | AT Sku inbound 38 | 10        | random         | Plus2      |
#    And Vendor update request inbound inventory
#    And Vendor save lotcode of inbound inventory
#      | index | sku               |
#      | 1     | AT Sku inbound 38 |
#      | 2     | AT Sku inbound 38 |
#    And Vendor check detail of SKU in Inbound inventory
#      | index | brand                 | product           | sku               | ofCases | lotCode | expiryDate |
#      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 38 | 10      | [blank] | Plus2      |
#      | 2     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 38 | 10      | [blank] | Plus1      |

#  @Inbound_39 @Inbound
#  Scenario: Vendor create new inbound inventory for multiple sku in the same time story (multiple diffirent SKU)
#    Given NGOCTX02 login web admin by api
#      | email                | password  |
#      | ngoctx02@podfoods.co | 12345678a |
#    When Admin get ID SKU by name "AT Sku inbound 39" from product id "6335" by API
#    # Delete order
#    When Search order by sku "31047" by api
#    And Admin delete order of sku "31047" by api
#    # Delete inventory
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | AT Sku inbound 39       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get list ID inventory by sku "AT Sku inbound 39" from API
#    And Admin delete all subtraction of list inventory
#    And Admin delete inventory "all" by API
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
#      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
#    And Add SKU to inbound inventory
#      | index | sku                 | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 39   | 10        | random         | Plus1      |
#      | 1     | AT Sku inbound 39.1 | 10        | random         | Plus2      |
#    And Edit info SKU of inbound inventory
#      | index | sku                 | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 39   | 10        | random         | Plus1      |
#      | 1     | AT Sku inbound 39.1 | 10        | random         | Plus2      |
#    And Confirm create inbound inventory
#    And Vendor save lotcode of inbound inventory
#      | index | sku                 |
#      | 1     | AT Sku inbound 39   |
#      | 1     | AT Sku inbound 39.1 |

#  @Inbound_40 @Inbound
#  Scenario: Vendor create new inbound inventory for multiple sku in the same time story (multiple diffirent SKU)
#    Given NGOCTX02 login web admin by api
#      | email                | password  |
#      | ngoctx02@podfoods.co | 12345678a |
#    When Admin get ID SKU by name "AT Sku inbound 40" from product id "6335" by API
#    # Delete order
#    When Search order by sku "31048" by api
#    And Admin delete order of sku "31048" by api
#    # Delete inventory
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
#      | AT Sku inbound 40       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
#    And Admin get list ID inventory by sku "AT Sku inbound 40" from API
#    And Admin delete all subtraction of list inventory
#    And Admin delete inventory "all" by API
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod      | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
#      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
#    And Add SKU to inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 40 | 10        | random         | Plus1      |
#      | 2     | AT Sku inbound 40 | 10        | random         | Plus2      |
#    And Edit info SKU of inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 40 | 10        | random         | Plus2      |
#      | 2     | AT Sku inbound 40 | 10        | random         | Plus1      |
#    And Confirm create inbound inventory
#    And Vendor save lotcode of inbound inventory
#      | index | sku               |
#      | 1     | AT Sku inbound 40 |
#      | 2     | AT Sku inbound 40 |

  @Inbound_41 @Inbound
  Scenario: Vendor edit general information of an approved inbound lot story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx231@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 41" from product id "6335" by API
    # Delete order
    When Search order by sku "31050" by api
    And Admin delete order of sku "31050" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 41       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 41" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx231@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 41 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 41 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | Plus1         | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And VENDOR Go to detail of inbound inventory have number: ""
    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL     | transportName     | transportPhone |
      | 1             | 1              | [blank]        | 1               | [blank]       | 1    | Yes           | Yes             | anhJPEG.jpg | AT Transport Name | 0123456789     |
    And Vendor update request inbound inventory

    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod      | vendorCompany | status    | warehouse                  | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode |
      | Chicagoland Express | Brand Self Delivery | ngoc vc 1     | Confirmed | Auto Ngoc Distribution CHI | currentDate | 1        | N/A            | 10               | 1                         | 60005   |
    And Admin check general information optional of Incoming inventory
      | palletTransit | palletWarehouse | transportName     | transportPhone | bol         |
      | Yes           | Yes             | AT Transport Name | 0123456789     | anhJPEG.jpg |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  @Inbound_42 @Inbound
  Scenario: Vendor edit general information of an (Confirmed) inbound inventory story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx232@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "31051" by api
    And Admin delete order of sku "31051" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 42       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 42" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx232@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 42 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 42 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | Plus1         | 10     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And VENDOR Go to detail of inbound inventory have number: ""
    And Vendor input info optional of inbound inventory
      | otherShipping | freightCarrier | trackingNumber | referenceNumber | estimatedWeek | note | palletTransit | palletWarehouse | fileBOL     | transportName     | transportPhone |
      | 1             | 1              | [blank]        | 1               | [blank]       | 1    | Yes           | Yes             | anhJPEG.jpg | AT Transport Name | 0123456789     |
    And Vendor update request inbound inventory

    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin search incoming inventory
      | number          | vendorCompany | vendorBrand | region              | initiatedBy | status  | startDate | endDate |
      | create by admin | ngoc vc 1     | [blank]     | Chicagoland Express | [blank]     | [blank] | [blank]   | [blank] |
    And Go to detail of incoming inventory number ""
    And Admin check General Information of Incoming inventory
      | region              | deliveryMethod      | vendorCompany | status    | warehouse                     | eta         | ofPallet | ofMasterCarton | ofSellableRetail | ofSellableRetailPerCarton | zipCode |
      | Chicagoland Express | Brand Self Delivery | ngoc vc 1     | Confirmed | Auto Ngoc Distribution CHI 01 | currentDate | 1        | N/A            | 10               | 1                         | 60005   |
    And Admin check general information optional of Incoming inventory
      | palletTransit | palletWarehouse | transportName     | transportPhone | bol         |
      | Yes           | Yes             | AT Transport Name | 0123456789     | anhJPEG.jpg |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  @Inbound_43 @Inbound
  Scenario: Vendor edit information of an sku in an inbound inventory story (Confirmed inbound inventory)
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx233@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 43" from product id "6335" by API
    # Delete order
    When Search order by sku "31049" by api
    And Admin delete order of sku "31049" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 43       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 43" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx233@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 43 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 43 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | Plus1         | 10     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And VENDOR Go to detail of inbound inventory have number: ""
    And Edit info SKU of inbound inventory
      | index | sku               | productLotCode | expiryDate |
      | 1     | AT Sku inbound 43 | random         | Plus1      |
    And Vendor update request inbound inventory

    And NGOC_ADMIN_02 refresh browser
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 43 | randomInbound | 10        | Plus1         | Plus1            | [blank] |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

  @Inbound_44 @Inbound
  Scenario: Vendor edit sku information in an approved inbound inventory story
    Given NGOCTX02 login web admin by api
      | email                 | password  |
      | ngoctx234@podfoods.co | 12345678a |
    When Admin get ID SKU by name "AT Sku inbound 44" from product id "6335" by API
    # Delete order
    When Search order by sku "31058" by api
    And Admin delete order of sku "31058" by api
    # Delete inventory
    And Admin search inventory by API
      | q[product_variant_name] | q[product_name]   | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page |
      | AT Sku inbound 44       | Auto Ngoc Inbound | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | 1    |
    And Admin get list ID inventory by sku "AT Sku inbound 44" from API
    And Admin delete all subtraction of list inventory
    And Admin delete inventory "all" by API

    Given NGOC_ADMIN_02 open web admin
    When login to beta web with email "ngoctx234@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
    And Admin create new incoming inventory
      | vendorCompany | region              | warehouse                     | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
      | ngoc vc 1     | Chicagoland Express | Auto Ngoc Distribution CHI 01 | 0                | 0        | [blank]       | [blank] | [blank]   |
    And With SKUs
      | sku               | ofCase |
      | AT Sku inbound 44 | 10     |
    And Confirm Create Incoming inventory
    And Admin submit incoming inventory
      | index | skuName           | deliveryMethod      | estimateDate | ofPallets | ofSellable | ofMasterCarton | ofSellAble | totalWeight | zipCode | lotCode | estimateDateSKU | receivingDate | ofCase | note    |
      | 1     | AT Sku inbound 44 | Brand Self Delivery | currentDate  | 1         | [blank]    | 1              | 1          | 1           | 60005   | random  | Plus1           | Plus1         | 10     | [blank] |
    And Admin "choose" warehouse is "Auto Ngoc Distribution CHI"

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Go to Send inventory page
    And Vendor go to "Confirmed"
    And VENDOR Search and check Send Inventory
      | reference | region              | eta         | status    |
      | [blank]   | Chicagoland Express | currentDate | Confirmed |
    And VENDOR Go to detail of inbound inventory have number: ""
    And Edit info SKU of inbound inventory
      | index | sku               | caseOfSku | productLotCode | expiryDate |
      | 1     | AT Sku inbound 44 | [blank]   | random         | [blank]    |
    And Vendor update request inbound inventory

    And NGOC_ADMIN_02 refresh browser
    And Check SKUs Information of Incoming inventory
      | index | brandSKU              | productSKU        | nameSKU           | lotCodeSKU    | ofCaseSKU | expiryDateSKU | receivingDateSKU | badge   |
      | 1     | AutoTest Brand Ngoc01 | Auto Ngoc Inbound | AT Sku inbound 44 | randomInbound | 10        | Plus1         | Plus1            | [blank] |
    And VENDOR quit browser
    And NGOC_ADMIN_02 quit browser

#  # New warehouse
#  @Inbound_new @Inbound
#  Scenario Outline: Admin Create An Inbound With Status of SKU
#    Given NGOC_ADMIN_02 open web admin
#    When NGOC_ADMIN_02 login to web with role Admin
#    And NGOC_ADMIN_02 navigate to "Inventories" to "Incoming Inventory" by sidebar
#    And Admin create new incoming inventory
#      | vendorCompany | region   | warehouse   | ofSellableRetail | ofPallet | estimatedWeek | note    | adminNote |
#      | ngoc vc 1     | <region> | <warehouse> | 0                | 0        | [blank]       | [blank] | [blank]   |
#    And With SKUs
#      | sku               | ofCase |
#      | AT Sku inbound 50 | 10     |
#    And Confirm Create Incoming inventory
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And VENDOR Search and check Send Inventory
#      | reference | region   | eta | status      |
#      | [blank]   | <region> | -   | Requested |
#    And VENDOR Go to detail of inbound inventory have number: ""
#    And Vendor verify instructions of region "<warehouse>" in Inbound detail
#    Examples:
#      | region                   | warehouse                |
#      | Chicagoland Express      | Fox Valley Farms         |
#      | North California Express | Saroni Food Service      |
#      | South California Express | LA - Jacmar              |
#      | South California Express | SCAL -- One World Direct |
#      | New York Express         | Polar Crossing           |
#      | Dallas Express            | TX -- Frozen Logistics   |
#      | Texas Express            | TX -- Fresh One          |
#      | Mid Atlantic Express     | Chad's Cold Transport    |
#      | Florida Express          | FL - Flowspace           |
#


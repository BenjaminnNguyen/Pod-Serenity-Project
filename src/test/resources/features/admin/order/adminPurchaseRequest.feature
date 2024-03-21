@feature=AdminPurchaseRequestOrder
Feature: Admin Purchase Request Order

  @PurchaseRequestOrder_01
  Scenario: Admin verify filter purchase request order
    Given NGOCTX27 login web admin by api
      | email                  | password  |
      | ngoctx2700@podfoods.co | 12345678a |
     # Reset search filter full textbox
    And Admin filter visibility with id "36" by api
      | q[number]   |
      | q[email]    |
      | q[admin_id] |
      | q[status]   |

    Given BUYER open web user
    And Buyer go to "Catalog" from menu bar
    And Guest search product in catalog
      | typeSort                    | typeSearch | valueSearch       |
      | Order by Brand name — A > Z | product    | AT Brand Claim 01 |
    And Go to product detail "AT Brand Claim 01" from product list of Brand
    And Guest fill info wholesale pricing of product detail
      | firstName | lastName | email  | storeName           | comment  | partner |
      | Auto      | Test     | random | Auto Store Chicago1 | AutoTest | Yes     |
    And Guest choose sku in wholesale pricing of product detail
      | sku             |
      | AT SKU Claim 01 |
    And Guest create wholesale pricing success
    And BUYER quit browser

    Given NGOC_ADMIN_27 open web admin
    When login to beta web with email "ngoctx2700@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_27 navigate to "Orders" to "Purchase requests" by sidebar
     # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | purchaseRequestNumber | email   | adminUser | status  |
      | [blank]               | [blank] | [blank]   | [blank] |
    Then Admin verify field search uncheck all in edit visibility
      | orderNumber | email   | adminUser | status  |
      | [blank]     | [blank] | [blank]   | [blank] |
    And Admin delete filter preset is "AutoTest1"
    # Verify uncheck all field search
    And Admin uncheck field of edit visibility in search
      | purchaseRequestNumber | email   | adminUser | status  |
      | [blank]               | [blank] | [blank]   | [blank] |
    Then Admin verify field search in edit visibility
      | orderNumber | email   | adminUser | status  |
      | [blank]     | [blank] | [blank]   | [blank] |
    # Verify save new filter
    And Admin search the purchase orders by info
      | purchaseNumber | email            | adminUser  | status |
      | 231010228      | 123123@gmail.com | ngoctx2700 | Open   |
    And Admin save filter by info
      | filterName | type               |
      | AutoTest1  | Save as new preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | number    | email            | adminUser  | status |
      | 231010228 | 123123@gmail.com | ngoctx2700 | Open   |
    # Verify save as filter
    And Admin search the purchase orders by info
      | purchaseNumber | email            | adminUser  | status |
      | 123123123      | 123123@gmail.com | ngoctx2700 | Open   |
    And Admin save filter by info
      | filterName | type                  |
      | AutoTest1  | Reset existing preset |
    And Admin choose filter preset is "AutoTest1"
    Then Admin verify search field after choose filter
      | number    | email            | adminUser  | status |
      | 123123123 | 123123@gmail.com | ngoctx2700 | Open   |
     # Verify search by email
    And Admin search the purchase orders by info
      | purchaseNumber | email            | adminUser | status  |
      | [blank]        | 124123@gmail.com | [blank]   | [blank] |
    And Admin no found data in result
    And Admin search the purchase orders by info
      | purchaseNumber | email  | adminUser | status  |
      | [blank]        | random | [blank]   | [blank] |
    Then Admin verify result purchase requests
      | retailPartner | buyer     | email  | store               | status |
      | Yes           | Auto Test | random | Auto Store Chicago1 | Open   |
    And Admin get ID of purchase requests in result
     # Verify search by purchase number
    And Admin search the purchase orders by info
      | purchaseNumber | email   | adminUser | status  |
      | 12312412       | [blank] | [blank]   | [blank] |
    And Admin no found data in result
    And Admin search the purchase orders by info
      | purchaseNumber | email   | adminUser | status  |
      | random         | [blank] | [blank]   | [blank] |
    Then Admin verify result purchase requests
      | retailPartner | buyer     | email  | store               | status |
      | Yes           | Auto Test | random | Auto Store Chicago1 | Open   |
    When Admin go to detail of purchase requests "create by vendor"
    Then Admin verify general information of purchase requests in detail
      | store               | purchaseNumber | adminNote | adminUser | buyer     | email  | retailPartner | status |
      | Auto Store Chicago1 | random         | [blank]   | [blank]   | Auto Test | random | Yes           | Open   |
    And Admin verify requested items of purchase requests in detail
      | brand             | product           | sku             | skuID |
      | AT Brand Claim 01 | AT Brand Claim 01 | AT SKU Claim 01 | 33816 |
    And Admin edit info of purchase requests in detail
      | adminNote | adminUser  |
      | AutoTest  | ngoctx2700 |
    And Admin change status of purchase requests in detail to "Closed"
    Then Admin verify general information of purchase requests in detail
      | store               | purchaseNumber | adminNote | adminUser  | buyer     | email  | retailPartner | status |
      | Auto Store Chicago1 | random         | AutoTest  | ngoctx2700 | Auto Test | random | Yes           | Close  |
    And Admin verify history status of purchase request
      | state       | updateBy          | updateOn    |
      | Open→Closed | Admin: ngoctx2700 | currentDate |
    # Navigate brand link
#    And Admin navigate brand "AT Brand Claim 01" link of sku ID "33816" in purchase detail
#    And Admin navigate product "AT Brand Claim 01" link of sku ID "33816" in purchase detail
    # Delete purchase order
    When Admin delete of purchase request in detail
    # Verify search after delete purchase request
    And Admin search the purchase orders by info
      | purchaseNumber | email   | adminUser | status  |
      | random         | [blank] | [blank]   | [blank] |
    And Admin no found data in result

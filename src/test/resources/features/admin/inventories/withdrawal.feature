#mvn clean test -Dtestsuite="FlowWithDrawalTestSuite" -Dcucumber.feature="src/test/resources/features/admin/inventories"

@feature=Withdrawal-flow
Feature: Withdrawal flow

  @Withdrawal_01 @Withdrawal_07 @Withdrawal_41 @Withdrawal_45 @Withdrawal_70 @Withdrawal
  Scenario: Admin Create A Submitted Request Withdrawal: - Select 1 Lot code
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx400@podfoods.co | 12345678a |
    # Create SKU
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "29415"
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx400@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        | buttonWPL |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 10     | 5    |
    And Admin get withdrawal request number
    # verify delete inventory
    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region  | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | [blank] | [blank]      | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName | lotCode |
      | 1     | random  | random  |
#    And Admin verify delete inventory button on detail is disabled
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 5    | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 5    | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        | endQuantity  |
      | Submitted | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png | End Quantity |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 5        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 5        | [blank]    | 10     | comment |
    And USER_LP quit browser

  @Withdrawal_02 @Withdrawal
  Scenario: Admin Create A Submitted Request Withdrawal: - Select multiple Lot code
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx401@podfoods.co | 12345678a |
    # Create SKU
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "29415"
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
      | 2     | random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx401@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 5    |
      | 2     | [blank]     | random  | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 10     | 5    |
    And Admin get withdrawal request number
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 10   | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 10   | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Submitted | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 5        |
      | 2     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 5        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 5        | [blank]    | 10     | comment |
      | 2     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 5        | [blank]    | 10     | comment |
    And USER_LP quit browser

  @Withdrawal_03 @Withdrawal
  Scenario: Admin create new Withdrawal request with the same Lot code more than once
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx402@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 03 | 31262              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx402@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 03 | [blank]     | random  | 5    |
    And Admin add same lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 03 | [blank]     | random  | 5    |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_04 @Withdrawal
  Scenario: Admin create new withdrawal request with blank value - Select Self pickup
    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx403@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin go to create withdrawal request
    And Admin create withdrawal request "Self pickup" with blank value
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_05 @Withdrawal
  Scenario: Admin create new withdrawal request with blank value - Select Carrier pickup
    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx404@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin go to create withdrawal request
    And Admin create withdrawal request "Carrier pickup" with blank value
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_06 @Withdrawal
  Scenario: Admin create new Withdrawal request with invalid value
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx405@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code  | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 04 | 32349              | 10       | Lotcode01 | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx405@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin input invalid vendor company
      | vendorCompany         | result  |
      | ngoc vc invalid       | No data |
      | NGOCTX_04 vc inactive | No data |
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode   | case |
      | 1     | [blank]     | AT SKU Withdrawal 04 | [blank]     | Lotcode01 | 5    |
    And Admin verify # of case of lotcode
      | case | result                  |
      | -1   | Please enter valid case |
      | 0.1  | Please enter valid case |
      | 0    | Please enter valid case |
      | 1    | [blank]                 |
    And Admin verify pallet weight
      | palletWeight | result                  |
      | -1           | Please enter valid case |
    And Admin verify upload BOL
      | bol               | result                      |
      | samplepdf10mb.pdf | Maximum file size exceeded. |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_08 @Withdrawal
  Scenario: Admin Add Lot Code For Submitted Withdrawal Request
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx406@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 08 | 31266              | 1        | random   | 90           | Plus1        | [blank]     | [blank] |
      | 2     | AT SKU Withdrawal 08 | 31266              | 1        | random   | 90           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx406@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 08 | [blank]     | random  | 1    |
    And Admin create withdraw request success
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 2     | [blank]     | AT SKU Withdrawal 08 | [blank]     | random  | 1    |
    And Admin save withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku                  | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 08 | random  | 1      | 1    |
      | 2     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 08 | random  | 1      | 1    |
    And Admin get withdrawal request number
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 2    | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 2    | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Submitted | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku                  | skuID   | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 08 | # 31266 | random  | 1        |
      | 2     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 08 | # 31266 | random  | 1        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku                  | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 08 | random  | 1        | [blank]    | 10     | comment |
      | 2     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 08 | random  | 1        | [blank]    | 10     | comment |
    And USER_LP quit browser

  @Withdrawal_09 @Withdrawal
  Scenario: Admin Remove Lot Code For Submitted Withdrawal Request
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx406@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 09 | 31287              | 1        | random   | 90           | Plus1        | [blank]     | [blank] |
      | 2     | AT SKU Withdrawal 09 | 31287              | 1        | random   | 90           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx406@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 09 | [blank]     | random  | 1    |
    And Admin create withdraw request success
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 2     | [blank]     | AT SKU Withdrawal 09 | [blank]     | random  | 1    |
    And Admin save withdraw request success
    And Admin remove lot cote in withdraw request success
      | index | skuName              | lotCode |
      | 2     | AT SKU Withdrawal 09 | random  |
    And Admin save withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku                  | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 09 | random  | 1      | 1    |
    And Admin get withdrawal request number
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 1    | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 1    | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Submitted | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku                  | skuID   | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 09 | # 31287 | random  | 1        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku                  | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 09 | random  | 1        | [blank]    | 10     | comment |
    And USER_LP quit browser

  @Withdrawal_10 @Withdrawal
  Scenario: Admin Approve A Withdrawal Request Story - End quantity after approved is more than Low quantity threshold
    #Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx407@podfoods.co | 12345678a |
    And Info of Region
      | region          | id | state  | availability | casePrice | msrp |
      | Atlanta Express | 64 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "sku random" of product "29415"

    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 159          | currentDate  | [blank]     | [blank] |

    # Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                         | password  |
      | ngoctx+bstoreatl1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 29415     | [blank] | 3        |
    And Checkout cart with payment by "invoice" by API

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"
    And ADMIN_OLD quit browser

    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx407@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 159          | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx407@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region          | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Atlanta Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 1    |
    And Admin create withdraw request success
    And Admin approve withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region          | pickupType  | partner         | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Atlanta Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Approved | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 9      | 1    |
    And Admin get withdrawal request number

    Given NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region          | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Atlanta Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter     | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 10               | 9               | 9        | 0            | [blank]    | [blank]  | [blank]          | Plus1       | AT Distribution ATL 01 | ngoc vc 1     | ATL    | Admin     |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 1    | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 1    | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate  | pickupFrom | pickupTo | region          | type        | name            | palletWeight | comment | bol        |
      | Approved | currentDate | 00:30      | 01:00    | Atlanta Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 1        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region          | request |
      | random | [blank]       | AT Brand Inventory 01 | Atlanta Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region          | request |
      | random | [blank]       | AT Brand Inventory 01 | Atlanta Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate  | startTime | endTime | region          | useFreight  | nameContact     | bol        |
      | random | Approved | currentDate | 00:30     | 01:00   | Atlanta Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 1        | [blank]    | 10     | comment |
    And USER_LP quit browser

  @Withdrawal_11 @Withdrawal
  Scenario: Admin Approve A Withdrawal Request Story - End quantity after approved is less than Low quantity threshold
    #Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx408@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal11 random" of product "29415"

    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 29415     | [blank] | 20       |
    And Checkout cart with payment by "invoice" by API

    #Run creon job to update low quantity threshold
    Given ADMIN_OLD open web admin old
    When login to admin old web with email "admin@beta.podfoods.co" pass "Abc@12345678"
    And Admin go to Sidekiq
    And Admin run cron job "update_inventoty_quantity_threshold"
    And ADMIN_OLD quit browser

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 20       | random   | 90           | Plus1        | [blank]     | [blank] |

    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 5        | random   | 90           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx408@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 1    |
    And Admin create withdraw request success
    And Admin approve withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Approved | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 4      | 1    |
    And Admin get withdrawal request number

    Given NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 5                | 4               | 4        | 0            | [blank]    | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName | lotCode     |
      | 1     | random  | randomIndex |
    Then Verify inventory detail
      | index | product                 | sku    | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode     | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Withdrawal 02 | random | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | Plus1       | [blank]    | [blank]  | randomIndex | 5           | 4          | 4      |
    And Verify subtraction item after ordered
      | date        | qty | category  | description                 | action  | order |
      | currentDate | 1   | Will call | Created by withdraw request | [blank] | No    |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 1    | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 1    | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Approved | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 1        |
    And Vendor go to "All Inventory" tab
    And Vendor search All Inventory "All regions"
      | skuName | zeroQuantity | orderBy                 |
      | random  | No           | Received - Latest first |
    Then Vendor verify result in All Inventory
      | index | productName             | skuName | lotCode     | receivedQty | received | currentQty | pulledQty | endQty | expiryDate | pullDate |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 5           | Plus1    | 4          | 0         | 4      | N/A        | N/A      |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 1        | [blank]    | 10     | comment |
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 4               | 5                | Plus1    | [blank] |
    And USER_LP quit browser

  @Withdrawal_12 @Withdrawal_13 @Withdrawal
  Scenario: Admin Approved A Withdrawal Request But SKU Has Been Deactivated Story
    # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx409@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal12 random" of product "29415"
    # Create inventory
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx409@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx409@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        | buttonWPL |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 10     | 5    |

    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    And Change state of SKU id: "Withdrawal12 random" to "inactive"

    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status    | startDate   | endDate |
      | [blank] | ngoc vc 1     | [blank] | [blank] | Submitted | currentDate | [blank] |
    And Admin go to detail withdraw request number ""
    And Admin approve withdraw request success
    And Admin check general information "approved" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Approved | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 5      | 5    |
    And Admin get withdrawal request number
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 5    | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 5    | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Approved | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 5        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 5        | [blank]    | 10     | comment |
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 5               | 10               | currentDate | [blank] |
    And USER_LP quit browser

  @Withdrawal_14 @Withdrawal
  Scenario: Admin Edit Case Of Line Item Of Submitted Withdrawal Request Story
  # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx410@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal14 random" of product "29415"

    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx410@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | Plus1        | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx410@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 1    |
    And Admin create withdraw request success
    And Admin change case of lotcode
      | index | skuName | lotCode | case |
      | 1     | random  | random  | 3    |
    And Admin approve withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Approved | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 7      | 3    |
    And Admin get withdrawal request number

    Given NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 10               | 7               | 7        | 0            | [blank]    | [blank]  | [blank]          | Plus1       | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 3    | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 3    | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Approved | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 3        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 3        | [blank]    | 10     | comment |
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 7               | 10               | Plus1    | [blank] |
    And USER_LP quit browser

  @Withdrawal_15 @Withdrawal_16 @Withdrawal_17 @Withdrawal_18 @Withdrawal_19 @Withdrawal_20 @Withdrawal_21 @Withdrawal_22 @Withdrawal
  Scenario: Admin Edit Field Of Submitted Withdrawal Request Story
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx411@podfoods.co | 12345678a |
    # Delete order
    When Search order by sku "31339" by api
    And Admin delete order of sku "31339" by api
    # Create inventory
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx411@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 14 | 31339              | 10       | random   | 90           | Plus1        | [blank]     | [blank] |

    # Create withdrawal request
    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx411@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 14 | [blank]     | random  | 1    |
    And Admin create withdraw request success

    And Admin change info of general information in withdrawal request
      | vendorCompany | pickupDate | startTime | endTime | region              | pickupType     | partner      | palletWeight | comment | bol        |
      | ngoc vc 1     | Plus1      | 01:00     | 01:30   | Chicagoland Express | Carrier pickup | Ngoc Carrier | 1 lbs        | comment | anhPNG.png |
    And Admin change info of "pallet weight" field of withdrawal and see message
      | value | value1  | message                                          |
      | -30   | [blank] | Pallet weight must be greater than or equal to 0 |
    And Admin change info of "pickup date" field of withdrawal and see message
      | value   | value1  | message                    |
      | [blank] | [blank] | Pickup date can't be blank |
#    And Admin change info of "pickup time" field of withdrawal and see message
#      | value   | value1  | message                   |
#      | [blank] | [blank] | Start time can't be blank |
    And Admin change info of "bol" field of withdrawal and see message
      | value             | value1  | message                     |
      | samplepdf10mb.pdf | [blank] | Maximum file size exceeded. |
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate | startTime | endTime  | region              | pickupType     | partner      | palletWeight | status    | comment | bol        |
      | ngoc vc 1     | Plus1      | 01:00 am  | 01:30 am | Chicagoland Express | Carrier pickup | Ngoc Carrier | 1 lbs        | Submitted | comment | anhPNG.png |
    And Admin change info of general information in withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime | region              | pickupType  | partner         | palletWeight | comment | bol        |
      | ngoc vc 1     | currentDate | 00:30     | 01:00   | Chicagoland Express | Self pickup | Ngoc Withdrawal | 1 lbs        | comment | anhPNG.png |
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 1 lbs        | Submitted | comment | anhPNG.png |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_23 @Withdrawal_24 @Withdrawal_25 @Withdrawal_26 @Withdrawal_27 @Withdrawal_28 @Withdrawal
  Scenario: Admin Edit Field Of Approved Withdrawal Request Story
    # Create inventory
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx412@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 15 | 31347              | 10       | random   | 90           | Plus1        | [blank]     | [blank] |

    # Create withdrawal request
    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx412@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 15 | [blank]     | random  | 1    |
    And Admin create withdraw request success
    And Admin approve withdraw request success

    And Admin change info of general information in withdrawal request
      | vendorCompany | pickupDate | startTime | endTime | region  | pickupType     | partner      | palletWeight | comment | bol        |
      | [blank]       | Plus1      | 01:00     | 01:30   | [blank] | Carrier pickup | Ngoc Carrier | 1 lbs        | comment | anhPNG.png |
    And Admin change info of "pallet weight" field of withdrawal and see message
      | value | value1  | message                                          |
      | -30   | [blank] | Pallet weight must be greater than or equal to 0 |
    And Admin change info of "pickup date" field of withdrawal and see message
      | value   | value1  | message                    |
      | [blank] | [blank] | Pickup date can't be blank |
    And Admin change info of "pickup time" field of withdrawal and see message
      | value   | value1  | message                   |
      | [blank] | [blank] | Start time can't be blank |
    And Admin change info of "bol" field of withdrawal and see message
      | value             | value1  | message                     |
      | samplepdf10mb.pdf | [blank] | Maximum file size exceeded. |
    And Admin check general information "approved" withdrawal request
      | vendorCompany | pickupDate | startTime | endTime  | region              | pickupType     | partner      | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | Plus1      | 01:00 am  | 01:30 am | Chicagoland Express | Carrier pickup | Ngoc Carrier | 1 lbs        | Approved | comment | anhPNG.png |
    And Admin change info of general information in withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime | region  | pickupType  | partner         | palletWeight | comment | bol        |
      | [blank]       | currentDate | 00:30     | 01:00   | [blank] | Self pickup | Ngoc Withdrawal | 1 lbs        | comment | anhPNG.png |
    And Admin check general information "approved" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 1 lbs        | Approved | comment | anhPNG.png |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_30 @Withdrawal_31 @Withdrawal_57 @Withdrawal
  Scenario: Admin Mask As Completed For A Withdrawal Request - But SKU Has Been Deactivated Story
   # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx413@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal14 random" of product "29415"

    # Create inventory
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx413@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx413@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin approve withdraw request success
    And Admin check general information "approved" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Approved | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 5      | 5    |
    And Admin get withdrawal request number

    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx413@podfoods.co | 12345678a |
    And Change state of SKU id: "random" to "inactive"

    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status   | startDate   | endDate |
      | [blank] | ngoc vc 1     | [blank] | [blank] | Approved | currentDate | [blank] |
    And Admin go to detail withdraw request number ""
    And Admin Complete withdraw request
    And Admin check general information "complete" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Completed | comment | anhPNG.png |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 5    | Completed |
    And Vendor check withdrawal request just created on tab "Completed"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 5    | Completed |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Completed | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 5        |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Completed |
    And LP search "Completed" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Completed |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Completed | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 5        | [blank]    | 10     | comment |
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 5               | 10               | currentDate | [blank] |
    And USER_LP quit browser

  @Withdrawal_32 @Withdrawal
  Scenario: Admin Remove Submitted Withdrawal request
    # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx414@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal32 random" of product "29415"

    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx414@podfoods.co | 12345678a |
    # Create new inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx414@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin cancel withdraw request in detail success
      | number          | note      |
      | create by admin | Auto note |

    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Withdrawal 02 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request "" on tab "All" no found
    And Vendor check withdrawal request "" on tab "Submitted" no found
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify no found result withdrawal requests after search
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify no found result withdrawal requests after search
    And USER_LP quit browser

  @Withdrawal_33 @Withdrawal
  Scenario: Admin Remove Approved Withdrawal request
    # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx415@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal33 random" of product "29415"
    # Create inventory
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx415@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx415@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin approve withdraw request success
    And Admin cancel withdraw request in detail success
      | number          | note      |
      | create by admin | Auto note |

    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Withdrawal 02 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request "" on tab "All" no found
    And Vendor check withdrawal request "" on tab "Approved" no found
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify no found result withdrawal requests after search
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify no found result withdrawal requests after search
    And USER_LP quit browser

  @Withdrawal_34 @Withdrawal
  Scenario: Admin Check Embedded Link Of Lot Code on Withdrawal Request Detail Page
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx416@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 34 | 31369              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx416@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 34 | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin click to lotcode in withdrawal detail
      | index | skuName              | lotCode |
      | 1     | AT SKU Withdrawal 34 | random  |
    And Verify inventory detail
      | index | product                 | sku                  | createdBy | region              | distributionCenter         | receiveDate | expireDate | pullDate | lotCode     | originalQty | currentQty | endQty |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 34 | Admin     | Chicagoland Express | Auto Ngoc Distribution CHI | currentDate | [blank]    | [blank]  | randomIndex | 10          | 10         | 10     |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_35 @Withdrawal
  Scenario: Admin Check Embedded Link Of Lot Code on Withdrawal Request Detail Page
   # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx417@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal35 random" of product "29415"

    # Create inventory
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx417@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx417@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin approve withdraw request success

    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Withdrawal 02 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Admin see detail inventory with lotcode
      | index | skuName | lotCode     |
      | 1     | random  | randomIndex |
    And Admin go to withdrawal request "" from inventory detail
    And Admin check general information "approved" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Approved | comment | anhPNG.png |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_37 @Withdrawal
  Scenario: Check trạng thái của SKU từ Out of stock -> In stock
    # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx418@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 1000      | 1200 |
    And Admin create SKU from admin with name "Withdrawal37 random" of product "29415"
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 20       | random   | 90           | currentDate  | [blank]     | [blank] |

    #Add cart this SKU and checkout
    Given Buyer login web with by api
      | email                   | password  |
      | ngoctx+chi1@podfoods.co | 12345678a |
    And Clear cart to empty in cart before by API
    And Add an item to cart by API
      | productId | skuId   | quantity |
      | 29415     | [blank] | 12       |
    And Checkout cart with payment by "invoice" by API
    # Fulfill 1 line item in order
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    Then Admin update line item in order by api
      | index | skuName | skuId  | order_id        | fulfilled |
      | 1     | random  | random | create by buyer | true      |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx418@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Withdrawal 02 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 20               | 8               | 8        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |

    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 8    |
    And Admin create withdraw request success
    And Admin approve withdraw request success

    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Withdrawal 02 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 20               | 0               | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |

    And NGOC_ADMIN_04 go to product "29415" with sku "" by link
    And Admin go to region-specific of SKU then verify
      | regionName          | casePrice | msrpunit | availability |
      | Chicagoland Express | 10        | 12       | Out of stock |
    And NGOC_ADMIN_04 navigate to "Orders" to "All orders" by sidebar
    And Admin search the orders "create by api"
    And Admin go to order detail number "create by api"
    And Admin remove pod consignment deliverable of sku "random" in line item

    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | random  | Auto Ngoc Withdrawal 02 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 20               | 12              | 12       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |

    And NGOC_ADMIN_04 go to product "29415" with sku "" by link
    And Admin go to region-specific of SKU then verify
      | regionName          | casePrice | msrpunit | availability |
      | Chicagoland Express | 10        | 12       | In stock     |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_38 @Withdrawal
  Scenario: Vendor Add Line Item For A Submitted Withdrawal Request Story
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx419@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 38 | 31372              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      | 2     | AT SKU Withdrawal 38 | 31372              | 20       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx419@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail | palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]      | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 38 | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin get withdrawal request number

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 5    | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        | endQuantity  |
      | Submitted | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png | End Quantity |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku                  | lotCode | lotQuantity | max |
      | 2     | AT SKU Withdrawal 38 | random  | 2           | Yes |
    And Vendor update withdrawal request success

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 25   | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 25   | Submitted |

    And NGOC_ADMIN_04 refresh page admin
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        | buttonWPL |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 25 lbs       | Submitted | comment | anhPNG.png | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku                  | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 38 | random  | 10     | 5    |
      | 2     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 38 | random  | 20     | 20   |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku                  | lotCode | quantity | expiryDate | pallet  | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 38 | random  | 5        | [blank]    | 25      | comment |
      | 2     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 38 | random  | 20       | [blank]    | [blank] | [blank] |
    And NGOC_ADMIN_04 quit browser
    And USER_LP quit browser
    And VENDOR quit browser

  @Withdrawal_39 @Withdrawal
  Scenario: Vendor Remove Line Item For A Submitted Withdrawal Request Story
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx420@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 39 | 31373              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |
      | 2     | AT SKU Withdrawal 39 | 31373              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx420@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail| palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]     | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 39 | [blank]     | random  | 5    |
      | 2     | [blank]     | AT SKU Withdrawal 39 | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin get withdrawal request number

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 10   | Submitted |
    And Vendor go to detail of withdrawal request ""
      | status    | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        | endQuantity  |
      | Submitted | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png | End Quantity |
    And Vendor remove sku with lot code to withdrawal request
      | index | sku                  | lotCode |
      | 2     | AT SKU Withdrawal 39 | random  |
    And Vendor update withdrawal request success

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 5    | Submitted |
    And Vendor check withdrawal request just created on tab "Submitted"
      | number | requestDate | pickupDate  | case | status    |
      | random | currentDate | currentDate | 5    | Submitted |

    And NGOC_ADMIN_04 refresh page admin
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 5 lbs        | Submitted | comment | anhPNG.png |
    And Admin check lot code in withdrawal request
      | index | product                 | sku                  | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 39 | random  | 10     | 5    |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku                  | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 39 | random  | 5        | [blank]    | 5      | comment |
    And NGOC_ADMIN_04 quit browser
    And USER_LP quit browser
    And VENDOR quit browser

  @Withdrawal_40 @Withdrawal
  Scenario: Vendor Create A Submitted Request Withdrawal Story - Vendor edit Pallet weight in total
    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor verify field in create withdrawal
      | pickupDate | pickupFrom | pickupTo | region           | carrier     | nameContact | palletWeight | comment | bol        |
      | Plus6      | 09:00      | 09:30    | New York Express | Self Pickup | Bao         | 10           | comment | anhPNG.png |
    And VENDOR quit browser

  @Withdrawal_42 @Withdrawal
  Scenario: Vendor Check Request Withdrawal Form With Blank Values Story
    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor verify blank value in create withdrawal with carrier is "Self Pickup"
    And VENDOR quit browser

  @Withdrawal_43 @Withdrawal
  Scenario: Vendor Check Request Withdrawal Form With Blank Values Story
    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor verify blank value in create withdrawal with carrier is "Carrier Pickup"
    And VENDOR quit browser

  @Withdrawal_44 @Withdrawal
  Scenario: Vendor Create Submitted Withdrawal With Invalid Case
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx421@podfoods.co | 12345678a |
     # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 44 | 31380              | 10       | random   | 90           | Plus1        | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact | palletWeight | comment | bol                    |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Bao         | 10           | comment | data/samplepdf10mb.pdf |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku                  | lotCode | lotQuantity | max     |
      | 1     | AT SKU Withdrawal 44 | random  | 10          | [blank] |
    And Vendor click create withdrawal request and see error "Attachment File size should be less than 10 MB"
    And VENDOR quit browser

  @Withdrawal_46 @Withdrawal
  Scenario: Vendor Edit Cases Of Submitted Request Withdrawal Story
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx422@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 46 | 31385              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact     | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | data/BOL.pdf |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku                  | lotCode | lotQuantity | max     |
      | 1     | AT SKU Withdrawal 46 | random  | 2           | [blank] |
    And Vendor click create withdrawal request
    And Vendor edit sku with lot code to withdrawal request
      | index | sku                  | lotCode | lotQuantity | max |
      | 1     | AT SKU Withdrawal 46 | random  | 2           | Yes |
    And Vendor update withdrawal request success

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx422@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status    | startDate   | endDate |
      | [blank] | ngoc vc 1     | [blank] | [blank] | Submitted | currentDate | [blank] |
    And Admin go to detail withdraw request number ""
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol     | buttonWPL |
      | ngoc vc 1     | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | BOL.pdf | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku                  | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 46 | random  | 10     | 10   |

    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName              | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Withdrawal 46 | Auto Ngoc Withdrawal 01 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName             | skuName              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 46 | randomIndex | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate | status    |
      | random | AT Brand Inventory 01 | Plus7      | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate | status    |
      | random | AT Brand Inventory 01 | Plus7      | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate | startTime | endTime | region              | useFreight  | nameContact     | bol     |
      | random | Submitted | Plus7      | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku                  | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 46 | random  | 10       | [blank]    | 10     | comment |
    And NGOC_ADMIN_04 quit browser
    And USER_LP quit browser
    And VENDOR quit browser

  @Withdrawal_48 @Withdrawal_47 @Withdrawal_49 @Withdrawal_50 @Withdrawal_51 @Withdrawal_52 @Withdrawal_53 @Withdrawal_54 @Withdrawal
  Scenario: Vendor Edit Comment Of Submitted Withdrawal Request Story
    Given NGOCTX_04 login web admin by api
      | email                | password  |
      | ngoctx04@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 47 | 31397              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact     | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | data/BOL.pdf |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku                  | lotCode | lotQuantity | max     |
      | 1     | AT SKU Withdrawal 47 | random  | 5           | [blank] |
    And Vendor click create withdrawal request
    And Vendor update withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact     | palletWeight | comment      | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 6            | comment edit | data/BOL.pdf |
    And Vendor edit sku with lot code to withdrawal request
      | index | sku                  | lotCode | lotQuantity | max     |
      | 1     | AT SKU Withdrawal 47 | random  | 6           | [blank] |
    And Vendor update withdrawal request success
    And VENDOR quit browser

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx423@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status    | startDate   | endDate |
      | [blank] | ngoc vc 1     | [blank] | [blank] | Submitted | currentDate | [blank] |
    And Admin go to detail withdraw request number ""
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment      | bol     | buttonWPL |
      | ngoc vc 1     | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 6 lbs        | Submitted | comment edit | BOL.pdf | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku                  | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 47 | random  | 10     | 6    |

    And NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName              | productName             | vendorCompany | vendorBrand | region              | distribution               | createdBy | lotCode | pulled  |
      | AT SKU Withdrawal 47 | Auto Ngoc Withdrawal 01 | [blank]       | [blank]     | Chicagoland Express | Auto Ngoc Distribution CHI | [blank]   | [blank] | [blank] |
    And Verify result inventory
      | index | productName             | skuName              | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 47 | randomIndex | 10               | 10              | 10       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And NGOC_ADMIN_04 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate | status    |
      | random | AT Brand Inventory 01 | Plus7      | Submitted |
    And LP search "Submitted" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate | status    |
      | random | AT Brand Inventory 01 | Plus7      | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate | startTime | endTime | region              | useFreight  | nameContact     | bol     |
      | random | Submitted | Plus7      | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | BOL.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku                  | lotCode | quantity | expiryDate | pallet | comment      |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 47 | random  | 6        | [blank]    | 6      | comment edit |
    And USER_LP quit browser

  @Withdrawal_55 @Withdrawal_56 @Withdrawal
  Scenario: Check display of Approved Withdrawal request on Vendor
     # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx424@podfoods.co | 12345678a |

    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create a "active" SKU from admin with name "Withdrawaltest random" of product "29415"

    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 20       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor create withdrawal request
      | pickupDate | pickupFrom | pickupTo | region              | carrier     | nameContact     | palletWeight | comment | bol          |
      | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | data/BOL.pdf |
    And Vendor add new sku with lot code to withdrawal request
      | index | sku    | lotCode | lotQuantity | max     |
      | 1     | random | random  | 5           | [blank] |
    And Vendor click create withdrawal request

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx424@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin search withdraw request
      | number  | vendorCompany | brand   | region  | status    | startDate   | endDate |
      | [blank] | ngoc vc 1     | [blank] | [blank] | Submitted | currentDate | [blank] |
    And Admin go to detail withdraw request number ""
    And Admin approve withdraw request success
    And Admin check general information "approved" withdrawal request
      | vendorCompany | pickupDate | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status   | comment | bol     |
      | ngoc vc 1     | Plus7      | 09:30 am  | 10:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 5 lbs        | Approved | comment | BOL.pdf |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 5      | 5    |
    And Admin get withdrawal request number
    And NGOC_ADMIN_04 quit browser

    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate | case | status   |
      | random | currentDate | Plus7      | 5    | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol     | endQuantity |
      | Approved | Plus7      | 09:30      | 10:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 5            | comment | BOL.pdf | 5           |
    And Vendor update BOL is "data/BOL1.pdf"
    And Vendor update withdrawal request success
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate | status   |
      | random | AT Brand Inventory 01 | Plus7      | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate | status   |
      | random | AT Brand Inventory 01 | Plus7      | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate | startTime | endTime | region              | useFreight  | nameContact     | bol      |
      | random | Approved | Plus7      | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | BOL1.pdf |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 5        | [blank]    | 5      | comment |
    And USER_LP quit browser

  @Withdrawal_71 @Withdrawal_72 @Withdrawal_73 @Withdrawal
  Scenario: Check display of Submitted Withdrawal request on LP
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx425@podfoods.co | 12345678a |
    # Create inventory
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 71 | 31417              | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx425@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail| palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]     | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 71 | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And NGOC_ADMIN_04 quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status    |
      | random | AT Brand Inventory 01 | currentDate | Submitted |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    And LP edit field in withdrawal requests detail
      | number | pickupDate  | startTime | endTime |
      | random | currentDate | 09:30     | 10:00   |
    And LP update success withdrawal request
    Then LP verify pickup information in withdrawal requests detail
      | number | status    | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Submitted | currentDate | 09:30     | 10:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku                  | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 71 | random  | 5        | [blank]    | 10     | comment |
    And USER_LP quit browser

  @Withdrawal_11a
  Scenario: Admin create new Withdrawal request with: - Request to withdrawal qty < pullable PDR qty
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx426@podfoods.co | 12345678a |
    And Admin create inventory api1
      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | AT SKU Withdrawal 78 | 61746              | 10       | random   | 90           | Plus1        | [blank]     | [blank] |
#    Create pull qty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 1        | Autotest |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx426@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail| palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]     | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName              | productName | lotCode | case |
      | 1     | [blank]     | AT SKU Withdrawal 78 | [blank]     | random  | 5    |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        | buttonWPL |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku                  | lotCode | endQty | case | expiryDate | pullQty |
      | 1     | Auto Ngoc Withdrawal 01 | AT SKU Withdrawal 78 | random  | 9      | 5    | [blank]    | [blank] |
    And NGOC_ADMIN_04 quit browser

  @WithDrawal_11b
  Scenario: Admin create new Withdrawal request with:  - Request to withdrawal qty > pullable qty
    # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx427@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal11b random" of product "29415"
    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 10       | random   | 90           | currentDate  | [blank]     | [blank] |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx427@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail| palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]     | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 15   |
    And Click on button "Create"
    And Admin check alert message
      | Withdraw items withdraw case must be in range 0..10 |
    And NGOC_ADMIN_04 quit browser

  @Withdrawal_16a @Withdrawal
  Scenario: Admin Approve A Withdrawal Request Story - Request to withdrawal qty = pullable PDR qty
   # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx428@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal16a random" of product "29415"

    # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 30       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create pull qty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 10       | Autotest |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx428@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail| palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]     | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 10   |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        | buttonWPL |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | pullQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 20     | 10      | 10   |
    And Admin get withdrawal request number
    And Admin approve withdraw request success

    Given NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 30               | 20              | 20       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName | lotCode     |
      | 1     | random  | randomIndex |
    And Verify subtraction item on inventory
      | quantity | category  | description                 | date        | order   |
      | 10       | Will call | Created by withdraw request | currentDate | [blank] |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 10   | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 10   | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Approved | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 10       |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 10       | [blank]    | 10     | comment |
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 20              | 30               | currentDate | [blank] |
    And USER_LP quit browser

  @Withdrawal_16b @Withdrawal
  Scenario: Admin Approve A Withdrawal Request Story - pullable PDR qty <= request-to-withdraw qty <= pullable qty
    # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx429@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal16b random" of product "29415"
   # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 30       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create pull qty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 10       | Autotest |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx429@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail| palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]     | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 15   |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        | buttonWPL |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | pullQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 20     | 0       | 15   |
    And Admin get withdrawal request number
    And Admin approve withdraw request success

    Given NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 30               | 15              | 15       | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName | lotCode     |
      | 1     | random  | randomIndex |
    And Verify subtraction item on inventory
      | quantity | category  | description                 | date        | order   |
      | 5        | Will call | Created by withdraw request | currentDate | [blank] |
      | 10       | Will call | Created by withdraw request | currentDate | [blank] |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 15   | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 15   | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Approved | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 15       |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 15       | [blank]    | 10     | comment |

    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 15              | 30               | currentDate | [blank] |
    And USER_LP quit browser

  @Withdrawal_16c @Withdrawal
  Scenario: Admin Approve A Withdrawal Request Story - Request to withdrawal qty = pullable PDR qty
    # Create SKU
    Given NGOCTX_04 login web admin by api
      | email                 | password  |
      | ngoctx430@podfoods.co | 12345678a |
    And Info of Region
      | region              | id | state  | availability | casePrice | msrp |
      | Chicagoland Express | 26 | active | in_stock     | 10        | 12   |
    And Admin create SKU from admin with name "Withdrawal16c random" of product "29415"
   # Create inventory
    And Admin create inventory api1
      | index | sku    | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
      | 1     | random | random             | 30       | random   | 90           | currentDate  | [blank]     | [blank] |
    # Create pull qty
    And Admin create Subtraction of inventory "create by api" by API
      | subtraction_category_id | quantity | comment  |
      | 1                       | 10       | Autotest |

    Given NGOC_ADMIN_04 open web admin
    When login to beta web with email "ngoctx430@podfoods.co" pass "12345678a" role "Admin"
    And NGOC_ADMIN_04 navigate to "Inventories" to "Withdrawal Requests" by sidebar
    And Admin create withdrawal request
      | vendorCompany | pickerDate  | pickerFrom | pickerTo | region              | pickupType  | pickupPartner   | contactEmail| palletWeight | bol        | comment |
      | ngoc vc 1     | currentDate | 00:30      | 01:00    | Chicagoland Express | Self pickup | Ngoc Withdrawal | [blank]     | 10           | anhPNG.png | comment |
    And Admin add lot codes to withdrawal request
      | index | vendorBrand | skuName | productName | lotCode | case |
      | 1     | [blank]     | random  | [blank]     | random  | 30   |
    And Admin create withdraw request success
    And Admin check general information "submitted" withdrawal request
      | vendorCompany | pickupDate  | startTime | endTime  | region              | pickupType  | partner         | palletWeight | status    | comment | bol        | buttonWPL |
      | ngoc vc 1     | currentDate | 12:30 am  | 01:00 am | Chicagoland Express | Self pickup | Ngoc Withdrawal | 10 lbs       | Submitted | comment | anhPNG.png | [blank]   |
    And Admin check lot code in withdrawal request
      | index | product                 | sku    | lotCode | endQty | pullQty | case |
      | 1     | Auto Ngoc Withdrawal 02 | random | random  | 0      | 0       | 30   |
    And Admin get withdrawal request number
    And Admin approve withdraw request success

    Given NGOC_ADMIN_04 navigate to "Inventories" to "All inventory" by sidebar
    And Admin search inventory
      | skuName | productName | vendorCompany | vendorBrand | region              | distribution | createdBy | lotCode | pulled  |
      | random  | [blank]     | [blank]       | [blank]     | Chicagoland Express | [blank]      | [blank]   | [blank] | [blank] |
    Then Verify result inventory
      | index | productName             | skuName | lotCode     | originalQuantity | currentQuantity | quantity | pullQuantity | expiryDate | pullDate | dayUntilPullDate | receiveDate | distributionCenter         | vendorCompany | region | createdBy |
      | 1     | Auto Ngoc Withdrawal 02 | random  | randomIndex | 30               | 0               | 0        | 0            | [blank]    | [blank]  | [blank]          | currentDate | Auto Ngoc Distribution CHI | ngoc vc 1     | CHI    | Admin     |
    And Admin see detail inventory with lotcode
      | index | skuName | lotCode     |
      | 1     | random  | randomIndex |
    And Verify subtraction item on inventory
      | quantity | category  | description                 | date        | order   |
      | 20       | Will call | Created by withdraw request | currentDate | [blank] |
      | 10       | Will call | Created by withdraw request | currentDate | [blank] |
    And NGOC_ADMIN_04 quit browser

    Given VENDOR open web user
    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
    And VENDOR Navigate to "Inventory" by sidebar
    And Vendor go to "Withdraw Inventory" tab
    And Vendor check withdrawal request just created on tab "All"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 30   | Approved |
    And Vendor check withdrawal request just created on tab "Approved"
      | number | requestDate | pickupDate  | case | status   |
      | random | currentDate | currentDate | 30   | Approved |
    And Vendor go to detail of withdrawal request ""
      | status   | pickupDate  | pickupFrom | pickupTo | region              | type        | name            | palletWeight | comment | bol        |
      | Approved | currentDate | 00:30      | 01:00    | Chicagoland Express | Self Pickup | Ngoc Withdrawal | 10           | comment | anhPNG.png |
    And Vendor check lots in detail of withdrawal request
      | index | brand                 | product                 | sku    | skuID | lotCode | quantity |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | #     | random  | 30       |
    And VENDOR quit browser

    Given USER_LP open web LP
    When login to beta web with email "ngoctx+lp1@podfoods.co" pass "12345678a" role "LP"
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to "Withdraw Inventory" tab
    And LP search "All" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP search "Approved" withdrawal requests
      | number | vendorCompany | brand                 | region              | request |
      | random | [blank]       | AT Brand Inventory 01 | Chicagoland Express | [blank] |
    Then LP verify result withdrawal requests after search
      | number | brand                 | pickupDate  | status   |
      | random | AT Brand Inventory 01 | currentDate | Approved |
    And LP go to details withdrawal requests ""
    Then LP verify pickup information in withdrawal requests detail
      | number | status   | pickupDate  | startTime | endTime | region              | useFreight  | nameContact     | bol        |
      | random | Approved | currentDate | 00:30     | 01:00   | Chicagoland Express | Self Pickup | Ngoc Withdrawal | anhPNG.png |
    Then LP verify withdrawal details in withdrawal requests detail
      | index | brand                 | product                 | sku    | lotCode | quantity | expiryDate | pallet | comment |
      | 1     | AT Brand Inventory 01 | Auto Ngoc Withdrawal 02 | random | random  | 1        | [blank]    | 10     | comment |
    And USER_LP Navigate to "Inventory" by sidebar
    And Lp go to All inventory tab
    And LP search "All" inventory
      | sku    | product | vendorCompany | vendorBrand |
      | random | [blank] | [blank]       | [blank]     |
    And Check search result in All inventory
      | index | sku    | distributionCenter         | vendorCompany | lotCode     | currentQuantity | originalQuantity | received    | expiry  |
      | 1     | random | Auto Ngoc Distribution CHI | ngoc vc 1     | randomIndex | 0               | 30               | currentDate | [blank] |
    And USER_LP quit browser

#  @Withdrawal_16d @Withdrawal
#  Scenario: Vendor Create A Submitted Request Withdrawal Story - pullable PDR qty <= request-to-withdraw qty <= pullable qty
#    Given NGOCTX_04 login web admin by api
#      | email                | password  |
#      | ngoctx04@podfoods.co | 12345678a |
#    When Admin get ID SKU by name "AT SKU Withdrawal 12" from product id "6400" by API
#    # Delete inventory
#    And Admin search inventory by API
#      | q[product_variant_name] | q[product_name]      | q[warehouse_id] | q[region_id] | q[creator_type] | q[brand_id] | q[vendor_company_id] | q[pull_quantity_lteq] | page    |
#      | AT SKU Withdrawal 12    | Auto Ngoc Withdrawal 01 | [blank]         | [blank]      | [blank]         | [blank]     | [blank]              | [blank]               | [blank] |
#    And Admin get list ID inventory by sku "AT SKU Withdrawal 12" from API
#    And Admin delete inventory "all" by API
#   # Create inventory
#    And Admin create inventory api1
#      | index | sku                  | product_variant_id | quantity | lot_code | warehouse_id | receive_date | expiry_date | comment |
#      | 1     | AT SKU Withdrawal 12 | 31335              | 30       | random   | 90           | currentDate  | [blank]     | [blank] |
#    # Create pull qty
#    And Admin create Subtraction of inventory "create by api" by API
#      | subtraction_category_id | quantity | comment  |
#      | 1                       | 10       | Autotest |
#
#    Given VENDOR open web user
#    When login to beta web with email "ngoctx+v1@podfoods.co" pass "12345678a" role "vendor"
#    And VENDOR Navigate to "Inventory" by sidebar
#    And Go to Send inventory page
#    And Vendor go to create inbound page by url
#    And Choose Region "Chicagoland Express" and check Instructions
#    And Vendor input info of inbound inventory
#      | deliveryMethod        | estimatedDateArrival | ofPallets | ofSellableRetail | ofMasterCarton | ofSellableRetailPerCarton | trackingNumber | totalWeight | zipCode |
#      | Brand Self Delivery | currentDate          | 1         | 1                | 1              | 1                         | 1              | 1           | 11111   |
#    And Add SKU to inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 39 | 10        | random         | Plus1      |
#
#    And Edit info SKU of inbound inventory
#      | index | sku               | caseOfSku | productLotCode | expiryDate |
#      | 1     | AT Sku inbound 39 | 10        | random         | Plus1      |
#    And Confirm create inbound inventory
#    And Vendor save lotcode of inbound inventory
#      | index | sku               |
#      | 1     | AT Sku inbound 39 |